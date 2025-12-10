CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

START TRANSACTION;

INSERT INTO productos (nombre, precio) VALUES ('Laptop', 1200.50);
INSERT INTO productos (nombre, precio) VALUES ('Mouse', 25.99);
INSERT INTO productos (nombre, precio) VALUES ('Teclado', 75.00);

COMMIT;

-- En caso de error, se haría ROLLBACK
-- ROLLBACK;

-- Verificar los datos insertados
SELECT * FROM productos;