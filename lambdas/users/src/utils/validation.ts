import { z } from 'zod';
import { AppError } from './errors';

/**
 * Validate request body against a Zod schema
 */
export function validateRequest<T>(
  body: string | undefined,
  schema: z.ZodSchema<T>
): T {
  if (!body) {
    throw new AppError('Request body is required', 400, 'INVALID_REQUEST');
  }

  try {
    const parsed = JSON.parse(body);
    return schema.parse(parsed);
  } catch (error) {
    if (error instanceof z.ZodError) {
      const errorMessage = error.errors
        .map((err) => `${err.path.join('.')}: ${err.message}`)
        .join(', ');
      throw new AppError(
        `Validation error: ${errorMessage}`,
        400,
        'VALIDATION_ERROR'
      );
    }
    throw new AppError('Invalid JSON body', 400, 'INVALID_JSON');
  }
}
