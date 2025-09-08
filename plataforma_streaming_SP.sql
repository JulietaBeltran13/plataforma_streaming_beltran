USE plataforma_streaming;

-- SP: sp_crear_usuario_y_perfil
DELIMITER $$

CREATE PROCEDURE sp_crear_usuario_y_perfil(
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_contraseña VARCHAR(100),
    IN p_pais VARCHAR(50),
    IN p_nombre_perfil VARCHAR(50),
    IN p_tipo_perfil VARCHAR(20),
    OUT p_id_usuario INT,
    OUT p_id_perfil INT
)
BEGIN
    -- Insertar usuario
    INSERT INTO usuarios (nombre, email, contraseña, pais, fecha_registro)
    VALUES (p_nombre, p_email, p_contraseña, p_pais, CURDATE());

    SET p_id_usuario = LAST_INSERT_ID();
    DELIMITER $$

-- SP: sp_registrar_visualizacion
DELIMITER $$

CREATE PROCEDURE sp_registrar_visualizacion(
    IN p_id_perfil INT,
    IN p_id_contenido INT,
    IN p_progreso_minutos INT
)
BEGIN
    -- Validación
    IF p_progreso_minutos < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El progreso no puede ser negativo';
    END IF;
    DELIMITER $$
    
    -- SP: sp_calificar_contenido
    DELIMITER $$

CREATE PROCEDURE sp_calificar_contenido(
    IN p_id_perfil INT,
    IN p_id_contenido INT,
    IN p_puntaje INT,
    IN p_comentario TEXT,
    OUT p_id_rating_out INT
)
BEGIN
    -- Validación de rango de puntaje
    IF p_puntaje < 1 OR p_puntaje > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El puntaje debe estar entre 1 y 5';
    END IF;

    -- Verificar si ya existe un rating para ese perfil/contenido
    IF EXISTS (SELECT 1 FROM ratings WHERE id_perfil = p_id_perfil AND id_contenido = p_id_contenido) THEN
        -- Actualizar
        UPDATE ratings
        SET puntaje = p_puntaje,
            comentario = p_comentario,
            fecha_rating = CURDATE()
        WHERE id_perfil = p_id_perfil AND id_contenido = p_id_contenido;

        SELECT id_rating INTO p_id_rating_out
        FROM ratings
        WHERE id_perfil = p_id_perfil AND id_contenido = p_id_contenido;
    ELSE
        -- Insertar
        INSERT INTO ratings (id_perfil, id_contenido, puntaje, comentario, fecha_rating)
        VALUES (p_id_perfil, p_id_contenido, p_puntaje, p_comentario, CURDATE());

        SET p_id_rating_out = LAST_INSERT_ID();
    END IF;
END $$

DELIMITER ;

-- SP: sp_cambiar_plan_usuario
DELIMITER $$

CREATE PROCEDURE sp_cambiar_plan_usuario(
    IN p_id_usuario INT,
    IN p_id_plan INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Cancelar suscripción activa actual
    UPDATE suscripciones
    SET estado = 'Cancelada'
    WHERE id_usuario = p_id_usuario
      AND estado = 'Activa';

    -- Crear nueva suscripción
    INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin, estado)
    VALUES (p_id_usuario, p_id_plan, p_fecha_inicio, p_fecha_fin, 'Activa');
END $$

DELIMITER ;
    
