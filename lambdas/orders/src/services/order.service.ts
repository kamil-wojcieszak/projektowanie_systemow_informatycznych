import {
  CreateOrderInput,
  OrderStatus,
  UpdateOrderInput,
} from '../schemas/order.schema';
import { Order } from '../types/order.types';
import { AppError } from '../utils/errors';
import { logger } from '../utils/logger';

/**
 * Service layer for order operations
 */
export class OrderService {
  private orders: Map<string, Order> = new Map();

  constructor() {
    this.seedData();
  }

  /**
   * List all orders
   */
  async listOrders(): Promise<Order[]> {
    logger.info('Listing all orders');
    return Array.from(this.orders.values());
  }

  /**
   * Get order by ID
   */
  async getOrderById(id: string): Promise<Order> {
    logger.info('Getting order by ID', { orderId: id });

    const order = this.orders.get(id);
    if (!order) {
      throw new AppError('Order not found', 404, 'ORDER_NOT_FOUND');
    }

    return order;
  }

  /**
   * Create a new order
   */
  async createOrder(input: CreateOrderInput): Promise<Order> {
    logger.info('Creating new order', { userId: input.userId });

    const id = this.generateId();
    const now = new Date().toISOString();

    const totalAmount = input.items.reduce(
      (sum, item) => sum + item.price * item.quantity,
      0
    );

    const order: Order = {
      id,
      userId: input.userId,
      items: input.items,
      totalAmount,
      status: OrderStatus.PENDING,
      shippingAddress: input.shippingAddress,
      createdAt: now,
      updatedAt: now,
    };

    this.orders.set(id, order);
    return order;
  }

  /**
   * Update an existing order
   */
  async updateOrder(id: string, input: UpdateOrderInput): Promise<Order> {
    logger.info('Updating order', { orderId: id });

    const order = await this.getOrderById(id);

    const updatedOrder: Order = {
      ...order,
      ...input,
      updatedAt: new Date().toISOString(),
    };

    this.orders.set(id, updatedOrder);
    return updatedOrder;
  }

  /**
   * Delete an order
   */
  async deleteOrder(id: string): Promise<void> {
    logger.info('Deleting order', { orderId: id });

    const order = this.orders.get(id);
    if (!order) {
      throw new AppError('Order not found', 404, 'ORDER_NOT_FOUND');
    }

    this.orders.delete(id);
  }

  /**
   * Generate a unique ID
   */
  private generateId(): string {
    return `order_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  /**
   * Seed initial data
   */
  private seedData(): void {
    const mockOrders: Order[] = [
      {
        id: 'order_1',
        userId: 'user_1',
        items: [
          {
            productId: 'prod_1',
            quantity: 1,
            price: 1299.99,
          },
        ],
        totalAmount: 1299.99,
        status: OrderStatus.DELIVERED,
        shippingAddress: {
          street: '123 Main St',
          city: 'New York',
          state: 'NY',
          zipCode: '10001',
          country: 'USA',
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      },
      {
        id: 'order_2',
        userId: 'user_2',
        items: [
          {
            productId: 'prod_2',
            quantity: 2,
            price: 299.99,
          },
        ],
        totalAmount: 599.98,
        status: OrderStatus.PROCESSING,
        shippingAddress: {
          street: '456 Oak Ave',
          city: 'Los Angeles',
          state: 'CA',
          zipCode: '90001',
          country: 'USA',
        },
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      },
    ];

    mockOrders.forEach((order) => this.orders.set(order.id, order));
  }
}
