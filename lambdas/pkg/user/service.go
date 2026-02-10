package user

import (
	"database/sql"
	"errors"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

var (
	ErrInvalidCredentials = errors.New("invalid username or password")
	ErrTokenGeneration    = errors.New("failed to generate authentication token")
)

// Service handles authentication logic
type Service struct {
	jwtSecret []byte
	db        *sql.DB
}

// Claims represents JWT claims
type Claims struct {
	UserID   int    `json:"user_id"`
	Username string `json:"username"`
	jwt.RegisteredClaims
}

// NewService creates a new Service with database connection
func NewService(jwtSecret string, db *sql.DB) *Service {
	return &Service{
		jwtSecret: []byte(jwtSecret),
		db:        db,
	}
}

// Authenticate validates user credentials and returns the user if valid
func (s *Service) Authenticate(username, password string) (*User, error) {
	var user User
	var passwordHash string
	
	query := "SELECT id, username, password_hash, email FROM users WHERE username = $1"
	err := s.db.QueryRow(query, username).Scan(&user.ID, &user.Username, &passwordHash, &user.Email)
	
	if err == sql.ErrNoRows {
		return nil, ErrInvalidCredentials
	}
	if err != nil {
		return nil, fmt.Errorf("database error: %w", err)
	}
	
	// Verify password using bcrypt
	err = bcrypt.CompareHashAndPassword([]byte(passwordHash), []byte(password))
	if err != nil {
		return nil, ErrInvalidCredentials
	}
	
	return &user, nil
}

// GenerateToken creates a JWT token for the given user
func (s *Service) GenerateToken(user *User) (string, error) {
	expirationTime := time.Now().Add(24 * time.Hour)
	claims := &Claims{
		UserID:   user.ID,
		Username: user.Username,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(expirationTime),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(s.jwtSecret)
	if err != nil {
		return "", ErrTokenGeneration
	}

	return tokenString, nil
}

// GetAll returns all users (without passwords)
func (s *Service) GetAll() ([]UserResponse, error) {
	query := "SELECT id, username, email FROM users ORDER BY id"
	rows, err := s.db.Query(query)
	if err != nil {
		return nil, fmt.Errorf("failed to query users: %w", err)
	}
	defer rows.Close()
	
	var users []UserResponse
	for rows.Next() {
		var user UserResponse
		if err := rows.Scan(&user.ID, &user.Username, &user.Email); err != nil {
			return nil, fmt.Errorf("failed to scan user: %w", err)
		}
		users = append(users, user)
	}
	
	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating users: %w", err)
	}
	
	return users, nil
}
