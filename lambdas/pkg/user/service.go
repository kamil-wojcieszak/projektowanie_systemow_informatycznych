package user

import (
	"errors"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

var (
	ErrInvalidCredentials = errors.New("invalid username or password")
	ErrTokenGeneration    = errors.New("failed to generate authentication token")
)

// Service handles authentication logic
type Service struct {
	jwtSecret []byte
	users     []User
}

// Claims represents JWT claims
type Claims struct {
	UserID   int    `json:"user_id"`
	Username string `json:"username"`
	jwt.RegisteredClaims
}

// NewService creates a new Service with hardcoded users
func NewService(jwtSecret string) *Service {
	return &Service{
		jwtSecret: []byte(jwtSecret),
		users: []User{
			{ID: 1, Username: "admin", Password: "admin123", Email: "admin@example.com"},
			{ID: 2, Username: "user1", Password: "password1", Email: "user1@example.com"},
			{ID: 3, Username: "user2", Password: "password2", Email: "user2@example.com"},
		},
	}
}

// Authenticate validates user credentials and returns the user if valid
func (s *Service) Authenticate(username, password string) (*User, error) {
	for i := range s.users {
		if s.users[i].Username == username && s.users[i].Password == password {
			return &s.users[i], nil
		}
	}
	return nil, ErrInvalidCredentials
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
func (s *Service) GetAll() []UserResponse {
	userResponses := make([]UserResponse, len(s.users))
	for i, user := range s.users {
		userResponses[i] = user.ToResponse()
	}
	return userResponses
}
