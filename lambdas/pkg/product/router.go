package product

import (
	"database/sql"
	"net/http"
	"psi/pkg/middleware"
	"strconv"

	"github.com/gin-gonic/gin"
)

// Router handles product-related routes
type Router struct {
	service *Service
}

// NewRouter creates a new Router instance
func NewRouter(db *sql.DB) *Router {
	service := NewService(db)

	return &Router{
		service: service,
	}
}

// SetupRoutes configures all product routes
func (r *Router) SetupRoutes(router *gin.Engine) {
	router.Use(middleware.CORS())
	router.GET("/products/health", r.healthCheck)
	router.GET("/products/list", r.getProducts)
	router.GET("/products/:id", r.getProduct)

}

// healthCheck returns the health status of the service
func (r *Router) healthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"message": "Products service is healthy",
		"status":  "ok",
	})
}

// getProducts returns a list of products with filtering and pagination
func (r *Router) getProducts(c *gin.Context) {
	var filter ProductFilter
	if err := c.ShouldBindQuery(&filter); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   "validation_error",
			"message": "Invalid query parameters",
		})
		return
	}

	response, err := r.service.GetAll(filter)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "database_error",
			"message": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Products retrieved successfully",
		"data":    response,
	})
}

// getProduct returns a single product by ID
func (r *Router) getProduct(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   "validation_error",
			"message": "Invalid product ID",
		})
		return
	}

	product, err := r.service.GetByID(id)
	if err != nil {
		if err.Error() == "product not found" {
			c.JSON(http.StatusNotFound, gin.H{
				"error":   "not_found",
				"message": "Product not found",
			})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "database_error",
			"message": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Product retrieved successfully",
		"data":    product,
	})
}
