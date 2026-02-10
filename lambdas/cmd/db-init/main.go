package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal("Usage: go run main.go <path-to-sql-file>")
	}

	sqlFilePath := os.Args[1]

	// Read SQL file
	sqlContent, err := os.ReadFile(sqlFilePath)
	if err != nil {
		log.Fatalf("Failed to read SQL file: %v", err)
	}

	// Connect to database
	db, err := connectDB()
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	// Execute SQL
	log.Printf("Executing SQL from %s...\n", sqlFilePath)
	_, err = db.Exec(string(sqlContent))
	if err != nil {
		log.Fatalf("Failed to execute SQL: %v", err)
	}

	log.Println("SQL executed successfully!")
}

func connectDB() (*sql.DB, error) {
	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	user := os.Getenv("DB_USER")
	password := os.Getenv("DB_PASSWORD")
	dbname := os.Getenv("DB_NAME")

	if host == "" {
		return nil, fmt.Errorf("DB_HOST environment variable is required")
	}
	if port == "" {
		port = "5432"
	}
	if user == "" {
		return nil, fmt.Errorf("DB_USER environment variable is required")
	}
	if password == "" {
		return nil, fmt.Errorf("DB_PASSWORD environment variable is required")
	}
	if dbname == "" {
		return nil, fmt.Errorf("DB_NAME environment variable is required")
	}

	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=require",
		host, port, user, password, dbname)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, fmt.Errorf("failed to open database: %w", err)
	}

	if err = db.Ping(); err != nil {
		return nil, fmt.Errorf("failed to ping database: %w", err)
	}

	log.Println("Connected to database successfully")
	return db, nil
}
