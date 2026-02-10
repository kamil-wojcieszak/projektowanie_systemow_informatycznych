/**
 * User entity type
 */
export interface User {
  id: string;
  email: string;
  name: string;
  age?: number;
  createdAt: string;
  updatedAt: string;
}
