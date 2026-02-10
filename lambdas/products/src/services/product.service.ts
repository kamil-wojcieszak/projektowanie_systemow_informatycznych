import {
  CreateProductInput,
  UpdateProductInput,
} from '../schemas/product.schema';
import { Product } from '../types/product.types';
import { AppError } from '../utils/errors';
import { logger } from '../utils/logger';

/**
 * Service layer for product operations
 */
export class ProductService {
  private products: Map<string, Product> = new Map();

  constructor() {
    this.seedData();
  }

  /**
   * List all products
   */
  async listProducts(): Promise<Product[]> {
    logger.info('Listing all products');
    return Array.from(this.products.values());
  }

  /**
   * Get product by ID
   */
  async getProductById(id: string): Promise<Product> {
    logger.info('Getting product by ID', { productId: id });

    const product = this.products.get(id);
    if (!product) {
      throw new AppError('Product not found', 404, 'PRODUCT_NOT_FOUND');
    }

    return product;
  }

  /**
   * Create a new product
   */
  async createProduct(input: CreateProductInput): Promise<Product> {
    logger.info('Creating new product', { name: input.name });

    const id = this.generateId();
    const now = new Date().toISOString();

    const product: Product = {
      id,
      name: input.name,
      description: input.description,
      price: input.price,
      category: input.category,
      inStock: input.inStock ?? true,
      createdAt: now,
      updatedAt: now,
    };

    this.products.set(id, product);
    return product;
  }

  /**
   * Update an existing product
   */
  async updateProduct(
    id: string,
    input: UpdateProductInput
  ): Promise<Product> {
    logger.info('Updating product', { productId: id });

    const product = await this.getProductById(id);

    const updatedProduct: Product = {
      ...product,
      ...input,
      updatedAt: new Date().toISOString(),
    };

    this.products.set(id, updatedProduct);
    return updatedProduct;
  }

  /**
   * Delete a product
   */
  async deleteProduct(id: string): Promise<void> {
    logger.info('Deleting product', { productId: id });

    const product = this.products.get(id);
    if (!product) {
      throw new AppError('Product not found', 404, 'PRODUCT_NOT_FOUND');
    }

    this.products.delete(id);
  }

  /**
   * Generate a unique ID
   */
  private generateId(): string {
    return `prod_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  /**
   * Seed initial data
   */
  private seedData(): void {
    const mockProducts: Product[] = [
      {
        id: 'prod_1',
        name: 'Laptop',
        description: 'High-performance laptop for professionals',
        price: 1299.99,
        category: 'Electronics',
        inStock: true,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      },
      {
        id: 'prod_2',
        name: 'Desk Chair',
        description: 'Ergonomic office chair',
        price: 299.99,
        category: 'Furniture',
        inStock: true,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      },
    ];

    mockProducts.forEach((product) => this.products.set(product.id, product));
  }
}
