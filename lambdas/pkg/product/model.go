package product

// Product represents a product in the system
type Product struct {
	GroupID     int     `json:"group_id" db:"group_id"`
	Name        string  `json:"name" db:"name"`
	Description string  `json:"description" db:"description"`
	Price       float64 `json:"price" db:"price"`
	Mark        string  `json:"mark" db:"mark"`
	Rate        float64 `json:"rate" db:"rate"`
	StockStatus int     `json:"stock_status" db:"stock_status"`
	ImageURL    string  `json:"image_url" db:"image_url"`
}

// ProductsResponse represents a paginated list of products
type ProductsResponse struct {
	Products   []Product `json:"products"`
	TotalCount int       `json:"total_count"`
	Page       int       `json:"page"`
	PageSize   int       `json:"page_size"`
}

// ProductFilter represents query parameters for filtering products
type ProductFilter struct {
	Mark      string  `form:"mark"`
	MinPrice  float64 `form:"min_price"`
	MaxPrice  float64 `form:"max_price"`
	Search    string  `form:"search"`
	Page      int     `form:"page" binding:"min=1"`
	PageSize  int     `form:"page_size" binding:"min=1,max=100"`
}
