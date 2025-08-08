-- creación de base de datos 
CREATE DATABASE plataforma_streaming;

-- creacion de tabla usuarios
USE plataforma_streaming;
CREATE TABLE usuarios(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL, 
email VARCHAR(150) UNIQUE NOT NULL, 
contraseña VARCHAR(100) NOT NULL, 
pais VARCHAR(50),
fecha_registro DATE 
);

-- creación de tabla planes de suscripción
CREATE TABLE planes(
id_plan INT PRIMARY KEY AUTO_INCREMENT, 
nombre_plan VARCHAR(50)NOT NULL, 
precio DECIMAL(10,2) NOT NULL, 
resolucion VARCHAR(20), 
dispositivos_max INT
);
-- creación tabla suscripciones
USE plataforma_streaming;
CREATE TABLE suscripciones (
id_suscripcion INT PRIMARY KEY AUTO_INCREMENT, 
id_usuario INT, 
id_plan INT, 
fecha_inicio DATE,
fecha_fin DATE, 
estado VARCHAR(20),
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
FOREIGN KEY (id_plan) REFERENCES planes(id_plan)
);

-- creación tabla perfiles
CREATE TABLE perfiles(
id_perfil INT PRIMARY KEY AUTO_INCREMENT, 
id_usuario INT, 
nombre_perfil VARCHAR(50),
tipo_perfil VARCHAR(20), -- ej. "niños", "adultos"
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- creación tabla categorias de contenido
CREATE TABLE categorias(
id_categoria INT PRIMARY KEY AUTO_INCREMENT, 
nombre_categoria VARCHAR(50)
);

-- creacion tabla contenido
CREATE TABLE contenido(
id_contenido INT PRIMARY KEY AUTO_INCREMENT, 
titulo VARCHAR(150), 
descripcion TEXT,
tipo_contenido VARCHAR(20), -- "pelicula","serie"
año INT, 
clasificacion_edad VARCHAR(10),
id_categoria INT,
FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- creación tabla temporadas (solo para series)
CREATE TABLE temporadas(
id_temporada INT PRIMARY KEY AUTO_INCREMENT,
id_contenido INT,
numero_temporada INT, 
cantidad_episodios INT,
FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);

-- creación tabla episodios
CREATE TABLE episodios(
id_episodio INT PRIMARY KEY AUTO_INCREMENT,
id_temporada INT,
titulos_episodio VARCHAR(150),
numero_episodio INT,
duracion INT, -- en minutos
FOREIGN KEY (id_temporada) REFERENCES temporadas(id_temporada)
);

-- creación tabla historial de visualización
CREATE TABLE historial_visualizacion(
id_historial INT PRIMARY KEY AUTO_INCREMENT,
id_perfil INT, 
id_contenido INT, 
fecha_visualizacion DATETIME, 
progreso_minutos INT,
FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil),
FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);

-- creacion tabla ratings
CREATE TABLE ratings(
id_rating INT PRIMARY KEY AUTO_INCREMENT,
id_perfil INT,
id_contenido INT, 
puntaje INT CHECK (puntaje BETWEEN 1 AND 5),
comentario TEXT,
fecha_rating DATE, 
FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil),
FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);
