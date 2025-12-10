CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

CREATE USER 'lector'@'localhost' IDENTIFIED BY 'lector123';
GRANT SELECT ON *.* TO 'lector'@'localhost';

CREATE USER 'escritor'@'localhost' IDENTIFIED BY 'escritor123';
GRANT SELECT, INSERT, UPDATE ON *.* TO 'escritor'@'localhost';

CREATE USER 'desarrollador'@'localhost' IDENTIFIED BY 'dev123';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON *.* TO 'desarrollador'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'admin'@'localhost';
SHOW GRANTS FOR 'lector'@'localhost';
SHOW GRANTS FOR 'escritor'@'localhost';
SHOW GRANTS FOR 'desarrollador'@'localhost';
