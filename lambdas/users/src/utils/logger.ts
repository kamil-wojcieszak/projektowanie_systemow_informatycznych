/**
 * Simple logger utility
 * In production, consider using a structured logging library
 */
class Logger {
  private context: Record<string, unknown> = {};

  info(message: string, meta?: Record<string, unknown>): void {
    this.log('INFO', message, meta);
  }

  error(message: string, meta?: Record<string, unknown>): void {
    this.log('ERROR', message, meta);
  }

  warn(message: string, meta?: Record<string, unknown>): void {
    this.log('WARN', message, meta);
  }

  private log(
    level: string,
    message: string,
    meta?: Record<string, unknown>
  ): void {
    const logEntry = {
      level,
      message,
      timestamp: new Date().toISOString(),
      ...this.context,
      ...meta,
    };

    console.log(JSON.stringify(logEntry));
  }
}

export const logger = new Logger();
