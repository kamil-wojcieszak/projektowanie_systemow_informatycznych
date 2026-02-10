package user

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

const defaultJWTSecret = "your-secret-key-change-in-production"

// Router handles user-related routes
type Router struct {
	service *Service
}

// NewRouter creates a new Router instance
func NewRouter() *Router {
	service := NewService(defaultJWTSecret)

	return &Router{
		service: service,
	}
}

// SetupRoutes configures all user routes
func (r *Router) SetupRoutes(router *gin.Engine) {
	// Routes without prefix (for API Gateway proxy+ integration)
	router.GET("/users/health", r.healthCheck)
	router.POST("/users/login", r.login)
	router.GET("/users/list", r.getUsers)
}

// healthCheck returns the health status of the service
func (r *Router) healthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "Users service is healthy",
		"status":  "ok",
	})
}

// login authenticates a user and returns a JWT token in a cookie
func (r *Router) login(c *gin.Context) {
	var loginReq LoginRequest
	if err := c.ShouldBindJSON(&loginReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   "validation_error",
			"message": "Invalid request body",
		})
		return
	}

	// Authenticate user
	user, err := r.service.Authenticate(loginReq.Username, loginReq.Password)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"error":   "authentication_failed",
			"message": err.Error(),
		})
		return
	}

	// Generate JWT token
	tokenString, err := r.service.GenerateToken(user)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "token_generation_failed",
			"message": err.Error(),
		})
		return
	}

	// Set cookie with token
	r.setAuthCookie(c, tokenString)

	c.JSON(http.StatusOK, gin.H{
		"message": "Login successful",
		"data": gin.H{
			"user":  user.ToResponse(),
			"token": tokenString,
		},
	})
}

// getUsers returns the list of users (without passwords)
func (r *Router) getUsers(c *gin.Context) {
	users := r.service.GetAll()

	c.JSON(http.StatusOK, gin.H{
		"message": "Users retrieved successfully",
		"data": gin.H{
			"users": users,
		},
	})
}

// setAuthCookie sets the authentication token as an HTTP-only cookie
func (r *Router) setAuthCookie(c *gin.Context, token string) {
	c.SetCookie(
		"auth_token",
		token,
		int(24*time.Hour.Seconds()),
		"/",
		"",
		false,
		true,
	)
}
