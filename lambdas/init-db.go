package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"psi/pkg/util"
	"strings"

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
	sqlText := strings.TrimSpace(string(sqlContent))
	if strings.HasPrefix(strings.ToLower(sqlText), "select") {
		rows, err := db.Query(sqlText)
		if err != nil {
			log.Fatalf("Failed to execute SQL query: %v", err)
		}
		defer rows.Close()

		columns, err := rows.Columns()
		if err != nil {
			log.Fatalf("Failed to get columns: %v", err)
		}

		log.Printf("Columns: %s", strings.Join(columns, ", "))
		values := make([]interface{}, len(columns))
		valuePtrs := make([]interface{}, len(columns))
		for i := range columns {
			valuePtrs[i] = &values[i]
		}

		rowCount := 0
		for rows.Next() {
			if err := rows.Scan(valuePtrs...); err != nil {
				log.Fatalf("Failed to scan row: %v", err)
			}
			rowCount++

			rowParts := make([]string, len(columns))
			for i, col := range columns {
				var v string
				switch val := values[i].(type) {
				case nil:
					v = "NULL"
				case []byte:
					v = string(val)
				default:
					v = fmt.Sprintf("%v", val)
				}
				rowParts[i] = fmt.Sprintf("%s=%s", col, v)
			}
			fmt.Printf("Row %d: %s", rowCount, strings.Join(rowParts, ", "))
		}

		if err := rows.Err(); err != nil {
			log.Fatalf("Row iteration error: %v", err)
		}
		log.Printf("✓ Query executed successfully (rows: %d)", rowCount)
	} else {
		resp, err := db.Exec(sqlText)
		if err != nil {
			log.Fatalf("Failed to execute SQL: %v", err)
		}

		log.Println("✓ SQL executed successfully")
		log.Printf("Database response %s", util.ToString(resp))
	}

	log.Println("Database initialization completed!")
}
