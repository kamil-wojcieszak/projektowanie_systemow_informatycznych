package product

import (
	"database/sql"
	"fmt"
	"strings"
)

// Service handles product business logic
type Service struct {
	db *sql.DB
}

// NewService creates a new product Service
func NewService(db *sql.DB) *Service {
	return &Service{
		db: db,
	}
}

// GetAll retrieves products with optional filtering and pagination
func (s *Service) GetAll(filter ProductFilter) (*ProductsResponse, error) {
	// Set defaults
	if filter.Page == 0 {
		filter.Page = 1
	}
	if filter.PageSize == 0 {
		filter.PageSize = 20
	}

	// Build query with filters
	query := "SELECT group_id, name, description, price, mark, rate, stock_status, image_url FROM products WHERE 1=1"
	countQuery := "SELECT COUNT(*) FROM products WHERE 1=1"
	args := []interface{}{}
	argIndex := 1

	// Add filters
	if filter.Mark != "" {
		query += fmt.Sprintf(" AND mark = $%d", argIndex)
		countQuery += fmt.Sprintf(" AND mark = $%d", argIndex)
		args = append(args, filter.Mark)
		argIndex++
	}

	if filter.MinPrice > 0 {
		query += fmt.Sprintf(" AND price >= $%d", argIndex)
		countQuery += fmt.Sprintf(" AND price >= $%d", argIndex)
		args = append(args, filter.MinPrice)
		argIndex++
	}

	if filter.MaxPrice > 0 {
		query += fmt.Sprintf(" AND price <= $%d", argIndex)
		countQuery += fmt.Sprintf(" AND price <= $%d", argIndex)
		args = append(args, filter.MaxPrice)
		argIndex++
	}

	if filter.Search != "" {
		searchPattern := "%" + strings.ToLower(filter.Search) + "%"
		query += fmt.Sprintf(" AND (LOWER(name) LIKE $%d OR LOWER(description) LIKE $%d)", argIndex, argIndex)
		countQuery += fmt.Sprintf(" AND (LOWER(name) LIKE $%d OR LOWER(description) LIKE $%d)", argIndex, argIndex)
		args = append(args, searchPattern)
		argIndex++
	}

	// Get total count
	var totalCount int
	err := s.db.QueryRow(countQuery, args...).Scan(&totalCount)
	if err != nil {
		return nil, fmt.Errorf("failed to count products: %w", err)
	}
	// Add pagination
	offset := (filter.Page - 1) * filter.PageSize
	query += fmt.Sprintf(" ORDER BY group_id LIMIT $%d OFFSET $%d", argIndex, argIndex+1)
	args = append(args, filter.PageSize, offset)

	// Execute query
	rows, err := s.db.Query(query, args...)
	if err != nil {
		return nil, fmt.Errorf("failed to query products: %w", err)
	}
	defer rows.Close()

	products := []Product{}
	for rows.Next() {
		var p Product
		err := rows.Scan(
			&p.GroupID,
			&p.Name,
			&p.Description,
			&p.Price,
			&p.Mark,
			&p.Rate,
			&p.StockStatus,
			&p.ImageURL,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan product: %w", err)
		}
		products = append(products, p)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating products: %w", err)
	}

	return &ProductsResponse{
		Products:   products,
		TotalCount: totalCount,
		Page:       filter.Page,
		PageSize:   filter.PageSize,
	}, nil
}

// GetByID retrieves a single product by ID
func (s *Service) GetByID(id int) (*Product, error) {
	query := "SELECT group_id, name, description, price, mark, rate, stock_status, image_url FROM products WHERE group_id = $1"
	
	var p Product
	err := s.db.QueryRow(query, id).Scan(
		&p.GroupID,
		&p.Name,
		&p.Description,
		&p.Price,
		&p.Mark,
		&p.Rate,
		&p.StockStatus,
		&p.ImageURL,
	)
	
	if err == sql.ErrNoRows {
		return nil, fmt.Errorf("product not found")
	}
	if err != nil {
		return nil, fmt.Errorf("failed to get product: %w", err)
	}

	return &p, nil
}
