import {
  APIGatewayProxyEventV2,
  APIGatewayProxyResultV2,
  Context,
} from 'aws-lambda';
import { OrderService } from './services/order.service';
import { ApiResponse } from './types/api.types';
import { AppError } from './utils/errors';
import { logger } from './utils/logger';
import { validateRequest } from './utils/validation';
import { createOrderSchema, updateOrderSchema } from './schemas/order.schema';

const orderService = new OrderService();

/**
 * Main Lambda handler for order-related operations
 */
export const handler = async (
  event: APIGatewayProxyEventV2,
  context: Context
): Promise<APIGatewayProxyResultV2> => {
  logger.info('Processing request', {
    requestId: context.awsRequestId,
    httpMethod: event.requestContext.http.method,
    path: event.rawPath,
  });

  try {
    const method = event.requestContext.http.method;
    const path = event.rawPath;

    // Route handling
    if (method === 'GET' && path.match(/^\/orders$/)) {
      // GET /orders - List all orders
      const orders = await orderService.listOrders();
      return createSuccessResponse(orders);
    }

    if (method === 'GET' && path.match(/^\/orders\/[^\/]+$/)) {
      // GET /orders/{id} - Get order by ID
      const orderId = path.split('/')[2];
      const order = await orderService.getOrderById(orderId);
      return createSuccessResponse(order);
    }

    if (method === 'POST' && path.match(/^\/orders$/)) {
      // POST /orders - Create new order
      const body = validateRequest(event.body, createOrderSchema);
      const order = await orderService.createOrder(body);
      return createSuccessResponse(order, 201);
    }

    if (method === 'PUT' && path.match(/^\/orders\/[^\/]+$/)) {
      // PUT /orders/{id} - Update order
      const orderId = path.split('/')[2];
      const body = validateRequest(event.body, updateOrderSchema);
      const order = await orderService.updateOrder(orderId, body);
      return createSuccessResponse(order);
    }

    if (method === 'DELETE' && path.match(/^\/orders\/[^\/]+$/)) {
      // DELETE /orders/{id} - Delete order
      const orderId = path.split('/')[2];
      await orderService.deleteOrder(orderId);
      return createSuccessResponse({ message: 'Order deleted successfully' });
    }

    throw new AppError('Route not found', 404);
  } catch (error) {
    return handleError(error);
  }
};

/**
 * Create a successful API response
 */
function createSuccessResponse<T>(
  data: T,
  statusCode: number = 200
): APIGatewayProxyResultV2 {
  const response: ApiResponse<T> = {
    success: true,
    data,
  };

  return {
    statusCode,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(response),
  };
}

/**
 * Handle errors and create appropriate error responses
 */
function handleError(error: unknown): APIGatewayProxyResultV2 {
  logger.error('Error processing request', { error });

  if (error instanceof AppError) {
    const response: ApiResponse<null> = {
      success: false,
      error: {
        message: error.message,
        code: error.code,
      },
    };

    return {
      statusCode: error.statusCode,
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(response),
    };
  }

  // Generic error
  const response: ApiResponse<null> = {
    success: false,
    error: {
      message: 'Internal server error',
      code: 'INTERNAL_ERROR',
    },
  };

  return {
    statusCode: 500,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(response),
  };
}
