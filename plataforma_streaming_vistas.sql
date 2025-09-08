USE plataforma_streaming;
-- insertamos planes disponibles 
INSERT INTO planes (nombre_plan, precio, resolucion, dispositivos_max)
VALUES('Básico',   2999.00, 'HD',     1),
('Estándar', 4999.00, 'FullHD', 2),
('Premium',  7999.00, '4K',     4);

-- Guardamos IDs por nombre de plan (por si existen otros planes en la BD)
SELECT id_plan INTO @plan_basico  FROM planes WHERE nombre_plan = 'Básico'  LIMIT 1;
SELECT id_plan INTO @plan_estandar FROM planes WHERE nombre_plan = 'Estándar' LIMIT 1;
SELECT id_plan INTO @plan_premium FROM planes WHERE nombre_plan = 'Premium' LIMIT 1;

-- insertar usuarios
INSERT INTO usuarios (nombre, email, contraseña, pais, fecha_registro)
VALUES 
('Julieta Beltrán', 'julieta@example.com', 'hash_seguro_juli', 'Argentina', CURDATE()),
('Marcos Díaz',     'marcos@example.com',  'hash_seguro_marc', 'Argentina', CURDATE()),
('Lucía Gómez',     'lucia@example.com',   'hash_seguro_luci', 'Chile',     CURDATE()),
('Pedro Álvarez',   'pedro@example.com',   'hash_seguro_ped',  'Uruguay',   CURDATE()),
('Ana Torres',      'ana@example.com',     'hash_seguro_ana',  'Argentina', CURDATE()),
('Sofía Morales',   'sofia@example.com',   'hash_seguro_sof',  'México',    CURDATE());

-- Capturamos sus IDs (buscando por email para ser robustos)
SELECT id_usuario INTO @id_julieta FROM usuarios WHERE email = 'julieta@example.com' LIMIT 1;
SELECT id_usuario INTO @id_marcos  FROM usuarios WHERE email = 'marcos@example.com'  LIMIT 1;
SELECT id_usuario INTO @id_lucia   FROM usuarios WHERE email = 'lucia@example.com'   LIMIT 1;
SELECT id_usuario INTO @id_pedro   FROM usuarios WHERE email = 'pedro@example.com'   LIMIT 1;
SELECT id_usuario INTO @id_ana     FROM usuarios WHERE email = 'ana@example.com'     LIMIT 1;
SELECT id_usuario INTO @id_sofia   FROM usuarios WHERE email = 'sofia@example.com'   LIMIT 1;

-- isertar suscripciones 
INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin, estado)
VALUES 
(@id_julieta, @plan_premium, DATE_SUB(CURDATE(), INTERVAL 60 DAY), NULL, 'activa'),
(@id_marcos,  @plan_estandar, DATE_SUB(CURDATE(), INTERVAL 30 DAY), NULL, 'activa'),
(@id_lucia,   @plan_basico,   DATE_SUB(CURDATE(), INTERVAL 120 DAY), DATE_SUB(CURDATE(), INTERVAL 31 DAY), 'cancelada'),
(@id_pedro,   @plan_basico,   DATE_SUB(CURDATE(), INTERVAL 15 DAY), NULL, 'activa'),
(@id_ana,     @plan_estandar, DATE_SUB(CURDATE(), INTERVAL 10 DAY), NULL, 'activa');

-- Cambio: nueva suscripción activa para Lucía (upgrade)
INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin, estado) 
VALUES (@id_lucia, @plan_premium, DATE_SUB(CURDATE(), INTERVAL 30 DAY), NULL, 'activa');

-- creamos perfiles para cada usuario
INSERT INTO perfiles (id_usuario, nombre_perfil, tipo_perfil) VALUES
(@id_julieta, 'Juli', 'adultos'),
(@id_julieta, 'Teen', 'niños'),
(@id_marcos,  'Marcos', 'adultos'),
(@id_lucia,   'Lu',     'adultos'),
(@id_lucia,   'Peques', 'niños'),
(@id_pedro,   'Pedro',  'adultos'),
(@id_ana,     'Ana',    'adultos'),
(@id_ana,     'Hermanita', 'niños'),
(@id_sofia,   'Sofi',   'adultos');

-- Capturamos algunos ids de perfiles para usarlos después
SELECT id_perfil INTO @perfil_juli  FROM perfiles WHERE id_usuario = @id_julieta AND nombre_perfil = 'Juli' LIMIT 1;
SELECT id_perfil INTO @perfil_teen  FROM perfiles WHERE id_usuario = @id_julieta AND nombre_perfil = 'Teen' LIMIT 1;
SELECT id_perfil INTO @perfil_marcos FROM perfiles WHERE id_usuario = @id_marcos  AND nombre_perfil = 'Marcos' LIMIT 1;
SELECT id_perfil INTO @perfil_lu    FROM perfiles WHERE id_usuario = @id_lucia  AND nombre_perfil = 'Lu' LIMIT 1;
SELECT id_perfil INTO @perfil_peques FROM perfiles WHERE id_usuario = @id_lucia AND nombre_perfil = 'Peques' LIMIT 1;
SELECT id_perfil INTO @perfil_pedro FROM perfiles WHERE id_usuario = @id_pedro AND nombre_perfil = 'Pedro' LIMIT 1;
SELECT id_perfil INTO @perfil_ana   FROM perfiles WHERE id_usuario = @id_ana AND nombre_perfil = 'Ana' LIMIT 1;
SELECT id_perfil INTO @perfil_heman FROM perfiles WHERE id_usuario = @id_ana AND nombre_perfil = 'Hermanita' LIMIT 1;
SELECT id_perfil INTO @perfil_sofi  FROM perfiles WHERE id_usuario = @id_sofia AND nombre_perfil = 'Sofi' LIMIT 1;

-- insertar categorias
INSERT INTO categorias (nombre_categoria)
VALUES
('Acción'),
('Drama'),
('Comedia'),
('Documental'),
('Animación'),
('Ciencia ficción');

-- Capturamos IDs de categorías
SELECT id_categoria INTO @cat_accion FROM categorias WHERE nombre_categoria = 'Acción' LIMIT 1;
SELECT id_categoria INTO @cat_drama  FROM categorias WHERE nombre_categoria = 'Drama' LIMIT 1;
SELECT id_categoria INTO @cat_comedia FROM categorias WHERE nombre_categoria = 'Comedia' LIMIT 1;
SELECT id_categoria INTO @cat_documental FROM categorias WHERE nombre_categoria = 'Documental' LIMIT 1;
SELECT id_categoria INTO @cat_animacion FROM categorias WHERE nombre_categoria = 'Animación' LIMIT 1;
SELECT id_categoria INTO @cat_scifi FROM categorias WHERE nombre_categoria = 'Ciencia ficción' LIMIT 1;

-- insertar contenido (peliculas y series)
-- Películas
INSERT INTO contenido (titulo, descripcion, tipo_contenido, `año`, clasificacion_edad, id_categoria) 
VALUES
('Café de Medianoche', 'Un barista descubre historias en la noche porteña.', 'pelicula', 2022, '13+', @cat_drama),
('Risas sin Fronteras', 'Comedia sobre un grupo de amigos y su gira por América Latina.', 'pelicula', 2020, 'ATP', @cat_comedia),
('Planeta Tierra', 'Documental sobre la biodiversidad del planeta.', 'pelicula', 2019, 'ATP', @cat_documental);

-- Series
INSERT INTO contenido (titulo, descripcion, tipo_contenido, `año`, clasificacion_edad, id_categoria)
 VALUES
('Galaxia 9', 'Tripulación explora los límites de la galaxia.', 'serie', 2021, '16+', @cat_accion),
('Mini Animados', 'Serie de cortos animados para niños.', 'serie', 2018, 'ATP', @cat_animacion),
('Ciencia en 10', 'Mini capítulos que explican ciencia en 10 minutos.', 'serie', 2020, 'ATP', @cat_documental);

-- Capturamos IDs de contenido por título
SELECT id_contenido INTO @cont_cafe FROM contenido WHERE titulo = 'Café de Medianoche' LIMIT 1;
SELECT id_contenido INTO @cont_risas FROM contenido WHERE titulo = 'Risas sin Fronteras' LIMIT 1;
SELECT id_contenido INTO @cont_planeta FROM contenido WHERE titulo = 'Planeta Tierra' LIMIT 1;
SELECT id_contenido INTO @cont_galaxia FROM contenido WHERE titulo = 'Galaxia 9' LIMIT 1;
SELECT id_contenido INTO @cont_mini FROM contenido WHERE titulo = 'Mini Animados' LIMIT 1;
SELECT id_contenido INTO @cont_ciencia FROM contenido WHERE titulo = 'Ciencia en 10' LIMIT 1;

-- insertar temporadas (solo para series)
-- Galaxia 9 (2 temporadas)
INSERT INTO temporadas (id_contenido, numero_temporada, cantidad_episodios)
VALUES 
(@cont_galaxia, 1, 3),
(@cont_galaxia, 2, 3);

-- Mini Animados (1 temporada)
INSERT INTO temporadas (id_contenido, numero_temporada, cantidad_episodios) VALUES
(@cont_mini, 1, 5);

-- Ciencia en 10 (mini episodios como serie)
INSERT INTO temporadas (id_contenido, numero_temporada, cantidad_episodios) VALUES
(@cont_ciencia, 1, 4);

-- Capturamos IDs de temporadas
SELECT id_temporada INTO @temp_galaxia_s1 FROM temporadas WHERE id_contenido = @cont_galaxia AND numero_temporada = 1 LIMIT 1;
SELECT id_temporada INTO @temp_galaxia_s2 FROM temporadas WHERE id_contenido = @cont_galaxia AND numero_temporada = 2 LIMIT 1;
SELECT id_temporada INTO @temp_mini_s1 FROM temporadas WHERE id_contenido = @cont_mini AND numero_temporada = 1 LIMIT 1;
SELECT id_temporada INTO @temp_ciencia_s1 FROM temporadas WHERE id_contenido = @cont_ciencia AND numero_temporada = 1 LIMIT 1;

-- episodios 
-- Galaxia 9 - temporada 1 
INSERT INTO episodios (id_temporada, titulos_episodio, numero_episodio, duracion) 
VALUES
(@temp_galaxia_s1, 'Despertar Estelar', 1, 48),
(@temp_galaxia_s1, 'Eco de Neón',       2, 52),
(@temp_galaxia_s1, 'Órbita Inestable',  3, 50);

-- Galaxia 9 - Temporada 2
INSERT INTO episodios (id_temporada, titulos_episodio, numero_episodio, duracion) VALUES
(@temp_galaxia_s2, 'Nueva Frontera',    1, 55),
(@temp_galaxia_s2, 'Sombra de Pulsar',  2, 53),
(@temp_galaxia_s2, 'Regreso a Ícaro',   3, 57);

-- Mini Animados - Temporada 1 (5 episodios cortos)
INSERT INTO episodios (id_temporada, titulos_episodio, numero_episodio, duracion) VALUES
(@temp_mini_s1, 'La Gota Feliz', 1, 5),
(@temp_mini_s1, 'Brincos y Colores', 2, 6),
(@temp_mini_s1, 'El Globo', 3, 4),
(@temp_mini_s1, 'Sombras Bailarinas', 4, 5),
(@temp_mini_s1, 'Estrella de Papel', 5, 6);

-- Ciencia en 10 - Temporada 1 (4 mini capítulos)
INSERT INTO episodios (id_temporada, titulos_episodio, numero_episodio, duracion) VALUES
(@temp_ciencia_s1, 'La Gravedad en 10', 1, 10),
(@temp_ciencia_s1, 'Átomos Rápidos',    2, 9),
(@temp_ciencia_s1, 'Energía a Prueba',  3, 11),
(@temp_ciencia_s1, 'El Sonido',         4, 10);

-- historial de visualizacion 
-- Registramos eventos de visualización (perfil, contenido, tiempo visto)
INSERT INTO historial_visualizacion (id_perfil, id_contenido, fecha_visualizacion, progreso_minutos) VALUES
(@perfil_juli, @cont_cafe, NOW(), 120),   -- Julieta vio la peli 120 min (completa)
(@perfil_teen, @cont_galaxia, NOW(), 30),
(@perfil_marcos, @cont_risas, NOW(), 90),
(@perfil_lu, @cont_galaxia, NOW(), 200),
(@perfil_peques, @cont_mini, NOW(), 15),
(@perfil_pedro, @cont_planeta, NOW(), 60),
(@perfil_ana, @cont_planeta, NOW(), 10),
(@perfil_sofi, @cont_ciencia, NOW(), 20);

-- insertar rating 
INSERT INTO ratings (id_perfil, id_contenido, puntaje, comentario, fecha_rating) VALUES
(@perfil_juli, @cont_cafe, 5, 'Hermosa historia y fotografía.', CURDATE()),
(@perfil_juli, @cont_galaxia, 4, 'Buena sci-fi, mejora en la T2.', CURDATE()),
(@perfil_marcos, @cont_risas, 4, 'Muy divertida.', CURDATE()),
(@perfil_lu, @cont_galaxia, 5, 'Mi serie favorita este año.', CURDATE()),
(@perfil_peques, @cont_mini, 5, 'A mis hijos les encanta.', CURDATE()),
(@perfil_pedro, @cont_planeta, 5, 'Docu imperdible.', CURDATE()),
(@perfil_ana, @cont_planeta, 4, 'Muy informativo.', CURDATE()),
(@perfil_sofi, @cont_ciencia, 4, 'Breves y claros.', CURDATE());

SELECT * FROM planes;

-- VISTA: vw_contenido_con_categoria
-- Objetivo: catálogo con su categoría
CREATE OR REPLACE VIEW vw_contenido_con_categoria AS
SELECT 
    c.id_contenido,
    c.titulo,
    c.tipo_contenido,
    c.año,
    c.clasificacion_edad,
    c.id_categoria,
    cat.nombre_categoria
FROM contenido c
JOIN categorias cat ON c.id_categoria = cat.id_categoria;

-- VISTA: vw_historial_detallado
-- Objetivo: histórico de reproducciones con contexto
CREATE OR REPLACE VIEW vw_historial_detallado AS
SELECT 
    hv.id_historial,
    hv.fecha_visualizacion,
    hv.progreso_minutos,
    p.nombre_perfil AS perfil,
    u.nombre AS usuario,
    c.titulo AS titulo_contenido,
    c.tipo_contenido
FROM historial_visualizacion hv
JOIN perfiles p   ON hv.id_perfil = p.id_perfil
JOIN usuarios u   ON p.id_usuario = u.id_usuario
JOIN contenido c  ON hv.id_contenido = c.id_contenido;

-- VISTA: vw_ratings_promedio
-- Objetivo: promedio y cantidad de ratings por contenido
CREATE OR REPLACE VIEW vw_ratings_promedio AS
SELECT 
    c.id_contenido,
    c.titulo,
    ROUND(AVG(r.puntaje),2) AS promedio_puntaje,
    COUNT(r.id_rating) AS cantidad_ratings
FROM contenido c
LEFT JOIN ratings r ON c.id_contenido = r.id_contenido
GROUP BY c.id_contenido, c.titulo;

-- VISTA: vw_suscripciones_detalle
-- Objetivo: monitorear planes, precios y estado de suscripción
CREATE OR REPLACE VIEW vw_suscripciones_detalle AS
SELECT 
    s.id_suscripcion,
    u.nombre AS usuario,
    u.email,
    p.nombre_plan,
    p.precio,
    p.resolucion,
    p.dispositivos_max,
    s.fecha_inicio,
    s.fecha_fin,
    s.estado
FROM suscripciones s
JOIN usuarios u ON s.id_usuario = u.id_usuario
JOIN planes p   ON s.id_plan = p.id_plan;

-- VISTA: vw_series_episodios_resumen
-- Objetivo: resumen de series con temporadas, episodios y minutos totales
CREATE OR REPLACE VIEW vw_series_episodios_resumen AS
SELECT 
    c.id_contenido,
    c.titulo,
    COUNT(DISTINCT t.id_temporada) AS total_temporadas,
    COUNT(e.id_episodio) AS total_episodios,
    IFNULL(SUM(e.duracion),0) AS total_minutos
FROM contenido c
LEFT JOIN temporadas t ON c.id_contenido = t.id_contenido
LEFT JOIN episodios e  ON t.id_temporada = e.id_temporada
WHERE c.tipo_contenido = 'serie'
GROUP BY c.id_contenido, c.titulo;










