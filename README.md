# plataforma_streaming_beltran
##Trabajo final para Coderhouse SQL
---
##Introducción: 
Este proyecto consiste en el diseño y desarrollo de una base de datos relacional para una plataforma de streaming de contenido audiovisual, similar a Disney+, Netflix o Amazon Prime. La solución permite administrar de forma estructurada a los usuarios, sus perfiles de visualización, los planes de suscripción disponibles, el catálogo de contenido (películas, series, géneros), y la interacción del usuario con el sistema (historial de visualización y reseñas).
---
##Objetivo:
El objetivo principal del proyecto es simular el backend de una plataforma de streaming, brindando una solución estructurada para gestionar los recursos clave del sistema: usuarios, contenido multimedia, consumo, calificaciones y suscripciones.
Este modelo permite realizar cruces de datos útiles para:
Análisis de consumo: comportamiento por perfil, género más visto, horas visualizadas.
Informes analíticos: calificaciones promedio por contenido, contenidos más vistos, perfiles activos.
Control contable y comercial: identificación de usuarios por tipo de plan y segmentación para estrategias de marketing.
Gestión operativa: estructura escalable para implementar funcionalidades futuras como recomendaciones personalizadas o segmentación por edad.
---
##Situación problemática:
Las plataformas de streaming manejan grandes volúmenes de datos sobre contenido y usuarios. La falta de una base de datos bien estructurada puede traer problemas como:
Redundancia de datos y pérdida de integridad.
Dificultad para obtener información clave de consumo.
Limitaciones para segmentar usuarios o analizar rendimiento de contenido.
Ineficiencia al gestionar múltiples perfiles en una misma cuenta o tipo de suscripción.
Este proyecto propone una solución integral para almacenar, relacionar y consultar todos los componentes esenciales de una plataforma de este tipo, mejorando la administración de datos, la personalización del servicio y la toma de decisiones comerciales y operativas.
---
##Modelo de negocio:
La organización simulada es una empresa tecnológica de entretenimiento por streaming que ofrece suscripciones mensuales a usuarios para acceder a un catálogo audiovisual de películas, series y documentales.
Características de esta organización:
Ofrece planes escalables (básico, estándar, premium) con distintos beneficios.
Cada cuenta puede tener múltiples perfiles, por ejemplo para distintos miembros de una familia.
Mantiene un catálogo multimedia clasificado por género y tipo de contenido.
Recolecta información sobre el historial de visualización y las reseñas de los usuarios para mejorar su servicio.
Puede utilizar esta base para generar reportes de uso, preferencia, engagement y retención.
---
##Descripción Base de Datos
La base de datos "plataforma_streaming" es un esquema que almacena información relacionada con una plataforma de entretenimiento por streaming. A continuación, se describe cada una de las tablas que conforman esta base de datos:

##Tabla "usuarios"
Almacena la información de los usuarios registrados en la plataforma (datos de acceso y datos básicos).
id_usuario — ID usuario — INT AUTO_INCREMENT — Clave primaria (PK).
nombre — Nombre — VARCHAR(100) — NOT NULL.
email — Correo electrónico — VARCHAR(150) — NOT NULL — UNIQUE
contraseña — Contraseña — VARCHAR(100) — NOT NULL.
pais — País — VARCHAR(50) — NULLABLE.
fecha_registro — Fecha de registro — DATE — NULLABLE.

##Tabla "planes"
Define los distintos planes de suscripción disponibles (precio, resolución, cantidad máxima de dispositivos, etc.).
Campos
id_plan — ID plan — INT AUTO_INCREMENT — PK.
nombre_plan — Nombre del plan — VARCHAR(50) — NOT NULL.
precio — Precio — DECIMAL(10,2) — NOT NULL.
resolucion — Resolución — VARCHAR(20)
dispositivos_max — Dispositivos máximos — INT 

##Tabla "suscripciones"
Registra las suscripciones de usuarios a planes. Relaciona usuarios con planes.
Campos
id_suscripcion — ID suscripción — INT AUTO_INCREMENT — PK.
id_usuario — ID usuario (FK) — INT — referencia a usuarios(id_usuario) — Clave foránea (FK).
id_plan — ID plan (FK) — INT — referencia a planes(id_plan) — FK.
fecha_inicio — Fecha inicio — DATE.
fecha_fin — Fecha fin — DATE.
estado — Estado — VARCHAR(20)

##Tabla "perfiles"
Perfiles vinculados a un usuario (cuentas compartidas por usuario, perfiles para niños/adultos, etc.).
Campos
id_perfil — ID perfil — INT AUTO_INCREMENT — PK.
id_usuario — ID usuario (FK) — INT — referencia a usuarios(id_usuario) — FK.
nombre_perfil — Nombre del perfil — VARCHAR(50)
tipo_perfil — Tipo de perfil — VARCHAR(20)

##Tabla "categorias"
Categorías o géneros de contenido (ej. comedia, drama, documental).
Campos
id_categoria — ID categoría — INT AUTO_INCREMENT — PK.
nombre_categoria — Nombre categoría — VARCHAR(50)

##Tabla "contenido"
Contenido disponible en la plataforma: películas y series (registro maestro con su categoría y metadatos).
Campos
id_contenido — ID contenido — INT AUTO_INCREMENT — PK.
titulo — Título — VARCHAR(150) 
descripcion — Descripción — TEXT 
tipo_contenido — Tipo de contenido — VARCHAR(20) — NULLABLE (ej. "pelicula", "serie").
año — Año — INT 
clasificacion_edad — Clasificación por edad — VARCHAR(10) 
id_categoria — ID categoría (FK) — INT — referencia a categorias(id_categoria) — FK.

##Tabla "temporadas"
Temporadas asociadas a contenidos de tipo serie. (Cada registro = una temporada de una serie).
Campos
id_temporada — ID temporada — INT AUTO_INCREMENT — PK.
id_contenido — ID contenido (FK) — INT — referencia a contenido(id_contenido) — FK.
numero_temporada — Número de temporada — INT.
cantidad_episodios — Cantidad episodios — INT

##Tabla "episodios"
Episodios pertenecientes a una temporada (sólo aplicable si el contenido es serie).
Campos
id_episodio — ID episodio — INT AUTO_INCREMENT — PK.
id_temporada — ID temporada (FK) — INT — referencia a temporadas(id_temporada) — FK.
titulos_episodio — Título episodio — VARCHAR(150)
numero_episodio — Número episodio — INT.
duracion — Duración (minutos) — INT

##Tabla "historial_visualizacion"
Historial de reproducción por perfil (qué contenido se vio, cuándo y progreso).
Campos
id_historial — ID historial — INT AUTO_INCREMENT — PK.
id_perfil — ID perfil (FK) — INT — referencia a perfiles(id_perfil) — FK.
id_contenido — ID contenido (FK) — INT — referencia a contenido(id_contenido) — FK.
fecha_visualizacion — Fecha y hora de visualización — DATETIME.
progreso_minutos — Progreso (minutos) — INT 

##Tabla "ratings"
Valoraciones y comentarios que dejan los perfiles sobre un contenido (puntuación, comentario y fecha).
Campos
id_rating — ID rating — INT AUTO_INCREMENT — PK.
id_perfil — ID perfil (FK) — INT — referencia a perfiles(id_perfil) — FK.
id_contenido — ID contenido (FK) — INT — referencia a contenido(id_contenido) — FK.
puntaje — Puntaje — INT — CHECK (puntaje BETWEEN 1 AND 5) (restricción).
comentario — Comentario — TEXT
fecha_rating — Fecha rating — DATE.
