package main

import (
	"context"
	"log/slog"
	"psi/pkg/user"
	"psi/pkg/util"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-gonic/gin"
)

var (
	router    = setupRouter()
	ginLambda = ginadapter.New(router)
)

func setupRouter() *gin.Engine {
	router := gin.Default()
	
	// Setup user routes
	userRouter := user.NewRouter()
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
