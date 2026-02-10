package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"psi/pkg/product"

	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

var (
	router    *gin.Engine
	ginLambda *ginadapter.GinLambda
)

func init() {
	// Initialize database connection
	db, err := connectDB()
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	router = setupRouter(db)
	ginLambda = ginadapter.New(router)
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

	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=require",
		host, port, user, password, dbname)

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, fmt.Errorf("failed to open database: %w", err)
	}

	if err = db.Ping(); err != nil {
		return nil, fmt.Errorf("failed to ping database: %w", err)
	}

	// Set connection pool settings
	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(5)

	return db, nil
}

func setupRouter(db *sql.DB) *gin.Engine {
	router := gin.Default()

	// Setup product routes
	productRouter := product.NewRouter(db)
	productRouter.SetupRoutes(router)

	return router
}

func main() {
	lambda.Start(ginLambda.ProxyWithContext)
}
