-- casos de prueba
USE  plataforma_streaming;

-- ==========================
-- PRUEBAS: fn_promedio_rating_contenido
-- ==========================

-- Caso válido: contenido con ratings cargados
SELECT fn_promedio_rating_contenido(1) AS promedio_rating_contenido1;

-- Caso válido: otro contenido
SELECT fn_promedio_rating_contenido(2) AS promedio_rating_contenido2;

-- PRUEBAS: fn_total_minutos_vistos_perfil

-- Caso válido: perfil con visualizaciones
SELECT fn_total_minutos_vistos_perfil(1) AS minutos_vistos_perfil1;

-- Caso válido: otro perfil
SELECT fn_total_minutos_vistos_perfil(2) AS minutos_vistos_perfil2;


-- PRUEBAS: fn_perfiles_por_usuario
-- ==========================

-- Caso válido: usuario con varios perfiles
SELECT fn_perfiles_por_usuario(1) AS perfiles_usuario1;

-- Caso sin perfiles (debería devolver 0)
SELECT fn_perfiles_por_usuario(999) AS perfiles_usuario_inexistente;



