import { z } from 'zod';

export enum OrderStatus {
  PENDING = 'pending',
  PROCESSING = 'processing',
  SHIPPED = 'shipped',
  DELIVERED = 'delivered',
  CANCELLED = 'cancelled',
}

/**
 * Schema for order items
 */
const orderItemSchema = z.object({
  productId: z.string().min(1, 'Product ID is required'),
  quantity: z.number().int().positive('Quantity must be positive'),
  price: z.number().positive('Price must be positive'),
});

/**
 * Schema for creating a new order
 */
export const createOrderSchema = z.object({
  userId: z.string().min(1, 'User ID is required'),
  items: z
    .array(orderItemSchema)
    .min(1, 'At least one item is required'),
  shippingAddress: z.object({
    street: z.string().min(1),
    city: z.string().min(1),
    state: z.string().min(1),
    zipCode: z.string().min(1),
    country: z.string().min(1),
  }),
});

/**
 * Schema for updating an existing order
 */
export const updateOrderSchema = z.object({
  status: z.nativeEnum(OrderStatus).optional(),
  shippingAddress: z
    .object({
      street: z.string().min(1),
      city: z.string().min(1),
      state: z.string().min(1),
      zipCode: z.string().min(1),
      country: z.string().min(1),
    })
    .optional(),
});

export type CreateOrderInput = z.infer<typeof createOrderSchema>;
export type UpdateOrderInput = z.infer<typeof updateOrderSchema>;
export type OrderItem = z.infer<typeof orderItemSchema>;
