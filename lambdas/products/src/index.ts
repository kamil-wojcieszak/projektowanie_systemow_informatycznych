import {
  APIGatewayProxyEventV2,
  APIGatewayProxyResultV2,
  Context,
} from 'aws-lambda';
import { ProductService } from './services/product.service';
import { ApiResponse } from './types/api.types';
import { AppError } from './utils/errors';
import { logger } from './utils/logger';
import { validateRequest } from './utils/validation';
import {
  createProductSchema,
  updateProductSchema,
} from './schemas/product.schema';

const productService = new ProductService();

/**
 * Main Lambda handler for product-related operations
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
    if (method === 'GET' && path.match(/^\/products$/)) {
      // GET /products - List all products
      const products = await productService.listProducts();
      return createSuccessResponse(products);
    }

    if (method === 'GET' && path.match(/^\/products\/[^\/]+$/)) {
      // GET /products/{id} - Get product by ID
      const productId = path.split('/')[2];
      const product = await productService.getProductById(productId);
      return createSuccessResponse(product);
    }

    if (method === 'POST' && path.match(/^\/products$/)) {
      // POST /products - Create new product
      const body = validateRequest(event.body, createProductSchema);
      const product = await productService.createProduct(body);
      return createSuccessResponse(product, 201);
    }

    if (method === 'PUT' && path.match(/^\/products\/[^\/]+$/)) {
      // PUT /products/{id} - Update product
      const productId = path.split('/')[2];
      const body = validateRequest(event.body, updateProductSchema);
      const product = await productService.updateProduct(productId, body);
      return createSuccessResponse(product);
    }

    if (method === 'DELETE' && path.match(/^\/products\/[^\/]+$/)) {
      // DELETE /products/{id} - Delete product
      const productId = path.split('/')[2];
      await productService.deleteProduct(productId);
      return createSuccessResponse({
        message: 'Product deleted successfully',
      });
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
