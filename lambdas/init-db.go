package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

const (
	// Database connection details from Lambda products configuration
	dbHost     = "pisw-products-dev.c5saa2i20nt6.eu-west-1.rds.amazonaws.com" // Update this after deployment
	dbPort     = "5432"
	dbUser     = "dbadmin"
	dbPassword = "SuperSecretPassword123!"
	dbName     = "products"
)

func main() {
	log.Println("Starting database initialization...")
	
	if len(os.Args) != 2 {
		log.Fatal("Usage: go run init-db.go <path-to-sql-file>")
	}

	sqlFilePath := os.Args[1]
	log.Printf("SQL file path: %s", sqlFilePath)

	// Read SQL file
	log.Println("Reading SQL file...")
	sqlContent, err := os.ReadFile(sqlFilePath)
	if err != nil {
		log.Fatalf("Failed to read SQL file: %v", err)
	}
	log.Printf("Successfully read SQL file (%d bytes)", len(sqlContent))

	// Connect to database
	log.Println("Connecting to database...")
	log.Printf("Database host: %s", dbHost)
	log.Printf("Database port: %s", dbPort)
	log.Printf("Database name: %s", dbName)
	log.Printf("Database user: %s", dbUser)
	
	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=require",
		dbHost, dbPort, dbUser, dbPassword, dbName)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()
	log.Println("Database connection opened")

	// Test connection
	log.Println("Testing database connection...")
	if err = db.Ping(); err != nil {
		log.Fatalf("Failed to ping database: %v", err)
	}

	log.Println("✓ Connected to database successfully")

	// Execute SQL
	log.Println("Executing SQL statements...")
	_, err = db.Exec(string(sqlContent))
	if err != nil {
		log.Fatalf("Failed to execute SQL: %v", err)
	}

	log.Println("✓ SQL executed successfully")
	log.Println("Database initialization completed!")
}
