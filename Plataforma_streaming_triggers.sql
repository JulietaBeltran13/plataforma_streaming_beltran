USE plataforma_streaming; 

DELIMITER $$

CREATE TRIGGER trg_before_insert_temporadas_check_serie
BEFORE INSERT ON temporadas
FOR EACH ROW
BEGIN
    DECLARE v_tipo VARCHAR(20);

    -- Traer el tipo de contenido relacionado
    SELECT tipo_contenido
    INTO v_tipo
    FROM contenidos
    WHERE id_contenido = NEW.id_contenido;

    -- Validar que exista y que sea 'Serie'
    IF v_tipo IS NULL OR v_tipo <> 'Serie' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Solo se pueden crear temporadas para contenidos de tipo Serie';
    END IF;

    -- Validar que el número de temporada sea válido
    IF NEW.numero_temporada <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El número de temporada debe ser mayor a 0';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

-- Antes de insertar
CREATE TRIGGER trg_before_insert_ratings_validate
BEFORE INSERT ON ratings
FOR EACH ROW
BEGIN
    IF NEW.puntaje < 1 OR NEW.puntaje > 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El puntaje debe estar entre 1 y 5';
    END IF;
END $$

-- Antes de actualizar
CREATE TRIGGER trg_before_update_ratings_validate
BEFORE UPDATE ON ratings
FOR EACH ROW
BEGIN
    IF NEW.puntaje < 1 OR NEW.puntaje > 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El puntaje debe estar entre 1 y 5';
    END IF;
END $$

DELIMITER ;
