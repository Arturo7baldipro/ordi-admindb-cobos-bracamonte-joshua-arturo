CREATE DATABASE IF NOT EXISTS SoundStream;
USE SoundStream;

CREATE TABLE IF NOT EXISTS artistas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS generos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS paises (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS canciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  duracion FLOAT NOT NULL,
  artista_id INT NOT NULL,
  genero_id INT NOT NULL,
  FOREIGN KEY (artista_id) REFERENCES artistas(id) ON DELETE CASCADE,
  FOREIGN KEY (genero_id) REFERENCES generos(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS suscripciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tier VARCHAR(50) NOT NULL,
  expiration DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  edad INT NOT NULL,
  pais_id INT NOT NULL,
  registro DATE NOT NULL,
  correo VARCHAR(255) NOT NULL UNIQUE,
  suscripciones_id INT,
  FOREIGN KEY (pais_id) REFERENCES paises(id) ON DELETE RESTRICT,
  FOREIGN KEY (suscripciones_id) REFERENCES suscripciones(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS playlist (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  usuario_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS playlist_canciones (
  playlist_id INT NOT NULL,
  cancion_id INT NOT NULL,
  orden INT NOT NULL,
  fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_id, cancion_id),
  FOREIGN KEY (playlist_id) REFERENCES playlist(id) ON DELETE CASCADE,
  FOREIGN KEY (cancion_id) REFERENCES canciones(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS distribuidor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS catalogo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  distribuidor_id INT NOT NULL,
  cancion_id INT NOT NULL,
  fecha_agregado DATE NOT NULL,
  FOREIGN KEY (distribuidor_id) REFERENCES distribuidor(id) ON DELETE CASCADE,
  FOREIGN KEY (cancion_id) REFERENCES canciones(id) ON DELETE CASCADE,
  UNIQUE KEY (distribuidor_id, cancion_id)
);

CREATE TABLE IF NOT EXISTS registros (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cancion_id INT NOT NULL,
  fecha DATE NOT NULL,
  views INT DEFAULT 0,
  FOREIGN KEY (cancion_id) REFERENCES canciones(id) ON DELETE CASCADE,
  UNIQUE KEY (cancion_id, fecha)
);

START TRANSACTION;

INSERT INTO generos (nombre) VALUES
('Pop'),
('R&B'),
('Rock');

INSERT INTO artistas (nombre) VALUES
('Ed Sheeran'),
('The Weeknd'),
('Queen');

INSERT INTO paises (nombre) VALUES
('México'),
('España'),
('Argentina');

INSERT INTO canciones (nombre, duracion, artista_id, genero_id) VALUES
('Shape of You', 3.53, 1, 1),
('Blinding Lights', 3.20, 2, 2),
('Bohemian Rhapsody', 5.55, 3, 3);

INSERT INTO suscripciones (tier, expiration) VALUES
('Premium', '2026-12-31'),
('Free', '2025-12-31'),
('Family', '2026-06-30');

INSERT INTO usuarios (nombre, edad, pais_id, registro, correo, suscripciones_id) VALUES
('Juan Pérez', 25, 1, '2025-01-15', 'juan@email.com', 1),
('María López', 30, 2, '2025-03-20', 'maria@email.com', 3),
('Carlos Ruiz', 22, 3, '2025-06-10', 'carlos@email.com', 2);

INSERT INTO playlist (nombre, usuario_id) VALUES
('Mis Favoritas', 1),
('Rock Clásico', 2),
('Éxitos 2024', 3);

INSERT INTO playlist_canciones (playlist_id, cancion_id, orden) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 2, 1),
(3, 1, 2);

INSERT INTO distribuidor (nombre) VALUES
('Universal Music'),
('Sony Music'),
('Warner Music');

INSERT INTO catalogo (distribuidor_id, cancion_id, fecha_agregado) VALUES
(1, 1, '2025-01-01'),
(2, 2, '2025-02-01'),
(3, 3, '2025-03-01');

INSERT INTO registros (cancion_id, fecha, views) VALUES
(1, '2025-12-01', 15000),
(2, '2025-12-05', 23000),
(3, '2025-12-09', 18500);

COMMIT;

SELECT * FROM canciones;
SELECT * FROM usuarios;
SELECT * FROM playlist_canciones;