package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
	"golang.org/x/crypto/bcrypt"
)

const (
	// Database connection details from Lambda products configuration
	dbHost     = "pisw-products-dev.c5saa2i20nt6.eu-west-1.rds.amazonaws.com"
	dbPort     = "5432"
	dbUser     = "dbadmin"
	dbPassword = "SuperSecretPassword123!"
	dbName     = "products"
)

type User struct {
	Username string
	Password string
	Email    string
}

func main() {
	log.Println("Starting users database seeding...")

	// Connect to database
	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=require",
		dbHost, dbPort, dbUser, dbPassword, dbName)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	// Test connection
	if err = db.Ping(); err != nil {
		log.Fatalf("Failed to ping database: %v", err)
	}
	log.Println("✓ Connected to database successfully")

	// Define users to seed
	users := []User{
		{Username: "admin", Password: "admin123", Email: "admin@example.com"},
		{Username: "user1", Password: "password1", Email: "user1@example.com"},
		{Username: "user2", Password: "password2", Email: "user2@example.com"},
	}

	// Seed users
	for _, user := range users {
		// Hash password with bcrypt
		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
		if err != nil {
			log.Fatalf("Failed to hash password for user %s: %v", user.Username, err)
		}

		// Insert user
		query := `
			INSERT INTO users (username, password_hash, email) 
			VALUES ($1, $2, $3)
			ON CONFLICT (username) DO UPDATE 
			SET password_hash = EXCLUDED.password_hash, 
			    email = EXCLUDED.email,
			    updated_at = CURRENT_TIMESTAMP
		`
		
		_, err = db.Exec(query, user.Username, string(hashedPassword), user.Email)
		if err != nil {
			log.Fatalf("Failed to insert user %s: %v", user.Username, err)
		}

		log.Printf("✓ Seeded user: %s (%s)", user.Username, user.Email)
	}

	log.Println("✓ Users database seeded successfully!")
}
