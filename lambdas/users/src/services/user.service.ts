import { CreateUserInput, UpdateUserInput } from '../schemas/user.schema';
import { User } from '../types/user.types';
import { AppError } from '../utils/errors';
import { logger } from '../utils/logger';

/**
 * Service layer for user operations
 * In a real application, this would interact with a database (DynamoDB, RDS, etc.)
 */
export class UserService {
  private users: Map<string, User> = new Map();

  constructor() {
    // Initialize with some mock data
    this.seedData();
  }

  /**
   * List all users
   */
  async listUsers(): Promise<User[]> {
    logger.info('Listing all users');
    return Array.from(this.users.values());
  }

  /**
   * Get user by ID
   */
  async getUserById(id: string): Promise<User> {
    logger.info('Getting user by ID', { userId: id });

    const user = this.users.get(id);
    if (!user) {
      throw new AppError('User not found', 404, 'USER_NOT_FOUND');
    }

    return user;
  }

  /**
   * Create a new user
   */
  async createUser(input: CreateUserInput): Promise<User> {
    logger.info('Creating new user', { email: input.email });

    const id = this.generateId();
    const now = new Date().toISOString();

    const user: User = {
      id,
      email: input.email,
      name: input.name,
      age: input.age,
      createdAt: now,
      updatedAt: now,
    };

    this.users.set(id, user);
    return user;
  }

  /**
   * Update an existing user
   */
  async updateUser(id: string, input: UpdateUserInput): Promise<User> {
    logger.info('Updating user', { userId: id });

    const user = await this.getUserById(id);

    const updatedUser: User = {
      ...user,
      ...input,
      updatedAt: new Date().toISOString(),
    };

    this.users.set(id, updatedUser);
    return updatedUser;
  }

  /**
   * Delete a user
   */
  async deleteUser(id: string): Promise<void> {
    logger.info('Deleting user', { userId: id });

    const user = this.users.get(id);
    if (!user) {
      throw new AppError('User not found', 404, 'USER_NOT_FOUND');
    }

    this.users.delete(id);
  }

  /**
   * Generate a unique ID
   */
  private generateId(): string {
    return `user_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  /**
   * Seed initial data
   */
  private seedData(): void {
    const mockUsers: User[] = [
      {
        id: 'user_1',
        email: 'john@example.com',
        name: 'John Doe',
        age: 30,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      },
      {
        id: 'user_2',
        email: 'jane@example.com',
        name: 'Jane Smith',
        age: 25,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      },
    ];

    mockUsers.forEach((user) => this.users.set(user.id, user));
  }
}
