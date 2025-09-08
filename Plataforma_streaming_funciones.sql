USE plataforma_streaming;

-- FUNCIÓN: fn_promedio_rating_contenido
DELIMITER $$

CREATE FUNCTION fn_promedio_rating_contenido(p_id_contenido INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE v_promedio DECIMAL(4,2);

    SELECT ROUND(AVG(r.puntaje),2)
    INTO v_promedio
    FROM ratings r
    WHERE r.id_contenido = p_id_contenido;

    RETURN IFNULL(v_promedio, 0.00);
END $$

DELIMITER ;

-- FUNCIÓN: fn_total_minutos_vistos_perfil
DELIMITER //
CREATE FUNCTION fn_total_minutos_vistos_perfil(p_id_perfil INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total INT;

    SELECT SUM(hv.progreso_minutos)
    INTO v_total
    FROM historial_visualizacion hv
    WHERE hv.id_perfil = p_id_perfil;

    RETURN IFNULL(v_total, 0);
END //
DELIMITER ;

-- FUNCIÓN: fn_perfiles_por_usuario
DELIMITER //
CREATE FUNCTION fn_perfiles_por_usuario(p_id_usuario INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(p.id_perfil)
    INTO v_count
    FROM perfiles p
    WHERE p.id_usuario = p_id_usuario;

    RETURN v_count;
END //
DELIMITER ;
    
