package main

import (
	"context"
	"database/sql"
	"fmt"
	"log/slog"
	"os"
	"psi/pkg/user"
	"psi/pkg/util"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

var (
	router    *gin.Engine
	ginLambda *ginadapter.GinLambda
	db        *sql.DB
)

func init() {
	// Connect to database
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dbUser := os.Getenv("DB_USER")
	dbPassword := os.Getenv("DB_PASSWORD")
	dbName := os.Getenv("DB_NAME")

	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=require",
		dbHost, dbPort, dbUser, dbPassword, dbName)

	var err error
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		panic(fmt.Sprintf("Failed to connect to database: %v", err))
	}

	if err = db.Ping(); err != nil {
		panic(fmt.Sprintf("Failed to ping database: %v", err))
	}

	router = setupRouter()
	ginLambda = ginadapter.New(router)
}

func setupRouter() *gin.Engine {
	router := gin.Default()
	
	// Setup user routes with database connection
	userRouter := user.NewRouter(db)
	userRouter.SetupRoutes(router)

	return router
}



func Handler(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	ginRequest, err := ginLambda.EventToRequestWithContext(ctx, req)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 500,
			Body:       "Failed to convert API Gateway event to HTTP request",
		}, err
	}

	slog.Info("params","path", ginRequest.URL.Path, "method", ginRequest.Method, "headers", ginRequest.Header, "query", ginRequest.URL.Query())
	println("================================")
	println(util.ToString(req))

	return ginLambda.ProxyWithContext(ctx, req)
}


func main() {
	lambda.Start(Handler)
}
