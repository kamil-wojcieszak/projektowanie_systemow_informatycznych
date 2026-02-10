import {
  APIGatewayProxyEventV2,
  APIGatewayProxyResultV2,
  Context,
} from 'aws-lambda';
import { UserService } from './services/user.service';
import { ApiResponse } from './types/api.types';
import { AppError } from './utils/errors';
import { logger } from './utils/logger';
import { validateRequest } from './utils/validation';
import { createUserSchema, updateUserSchema } from './schemas/user.schema';

const userService = new UserService();

/**
 * Main Lambda handler for user-related operations
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
    if (method === 'GET' && path.match(/^\/users$/)) {
      // GET /users - List all users
      const users = await userService.listUsers();
      return createSuccessResponse(users);
    }

    if (method === 'GET' && path.match(/^\/users\/[^\/]+$/)) {
      // GET /users/{id} - Get user by ID
      const userId = path.split('/')[2];
      const user = await userService.getUserById(userId);
      return createSuccessResponse(user);
    }

    if (method === 'POST' && path.match(/^\/users$/)) {
      // POST /users - Create new user
      const body = validateRequest(event.body, createUserSchema);
      const user = await userService.createUser(body);
      return createSuccessResponse(user, 201);
    }

    if (method === 'PUT' && path.match(/^\/users\/[^\/]+$/)) {
      // PUT /users/{id} - Update user
      const userId = path.split('/')[2];
      const body = validateRequest(event.body, updateUserSchema);
      const user = await userService.updateUser(userId, body);
      return createSuccessResponse(user);
    }

    if (method === 'DELETE' && path.match(/^\/users\/[^\/]+$/)) {
      // DELETE /users/{id} - Delete user
      const userId = path.split('/')[2];
      await userService.deleteUser(userId);
      return createSuccessResponse({ message: 'User deleted successfully' });
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
