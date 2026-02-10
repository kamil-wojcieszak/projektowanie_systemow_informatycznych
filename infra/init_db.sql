-- Create products table
CREATE TABLE IF NOT EXISTS products (
    group_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    price NUMERIC(10, 2) NOT NULL,
    mark VARCHAR(255),
    rate NUMERIC(10, 2) DEFAULT 0.0,
    stock_status INTEGER DEFAULT 0,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for faster filtering
CREATE INDEX IF NOT EXISTS idx_products_mark ON products(mark);
CREATE INDEX IF NOT EXISTS idx_products_price ON products(price);
CREATE INDEX IF NOT EXISTS idx_products_rate ON products(rate);

-- Insert sample products
INSERT INTO products (name, description, price, mark, rate, stock_status, image_url) VALUES
('Lampa żarowa', 'Strong lamp, nowy stan', 9.00, 'Strong lamp', 4.5, 50, ''),
('Kierownica K35', 'Soft hold kierownica', 999.00, 'Soft hold', 3.5, 20, ''),
('Hamulec CB', 'Safe&Strong hamulec', 275.99, 'Safe&Strong', 5.0, 30, ''),
('Olej silnikowy 5W-30', 'Syntetyczny olej silnikowy', 45.99, 'Castrol', 4.8, 100, ''),
('Opony letnie 205/55 R16', 'Opony letnie wysokiej jakości', 350.00, 'Michelin', 4.9, 40, ''),
('Akumulator 60Ah', 'Akumulator rozruchowy', 280.00, 'Bosch', 4.7, 25, ''),
('Filtr oleju', 'Filtr oleju uniwersalny', 15.50, 'Mann', 4.3, 150, ''),
('Klocki hamulcowe', 'Klocki hamulcowe przednie', 120.00, 'Brembo', 4.6, 60, ''),
('Żarówka H7', 'Żarówka halogenowa H7', 12.99, 'Philips', 4.4, 200, ''),
('Wycieraczki', 'Wycieraczki uniwersalne 60cm', 35.00, 'Bosch', 4.2, 80, ''),
('Amortyzator przedni', 'Amortyzator gazowy przedni', 189.00, 'KYB', 4.7, 35, ''),
('Tarcze hamulcowe', 'Tarcze hamulcowe przednie 280mm', 220.00, 'Zimmermann', 4.8, 45, ''),
('Świece zapłonowe', 'Świece zapłonowe NGK', 28.00, 'NGK', 4.9, 120, ''),
('Pasek klinowy', 'Pasek klinowy wielorowkowy', 65.00, 'Gates', 4.5, 90, ''),
('Chłodnica', 'Chłodnica wody aluminiowa', 380.00, 'Nissens', 4.6, 18, '')
ON CONFLICT DO NOTHING;
