-- ============================================================
-- CineLog — Scripts Varios
-- RDBMS:   MySQL 8.0
-- Autor:   Equipo CineLog — Universidad El Bosque
-- Desc:    Índices, vistas y consultas de utilidad.
-- ============================================================

USE cinelog_db;

-- ============================================================
-- SECCIÓN 1: ÍNDICES
-- Mejoran el rendimiento de las consultas más frecuentes.
-- ============================================================

-- Búsqueda de contenidos por título
CREATE INDEX IDX_CONTENIDO_TITULO
    ON CONTENIDO(titulo);

-- Búsqueda de contenidos por tipo (Película/Serie)
CREATE INDEX IDX_CONTENIDO_TIPO
    ON CONTENIDO(tipo);

-- Búsqueda de contenidos por año de estreno
CREATE INDEX IDX_CONTENIDO_ANIO
    ON CONTENIDO(anio_estreno);

-- Búsqueda de calificaciones por contenido
CREATE INDEX IDX_CALIFICACION_CONT
    ON CALIFICACION(id_contenido);

-- Búsqueda de episodios por temporada
CREATE INDEX IDX_EPISODIO_TEMP
    ON EPISODIO(id_temporada);

-- Búsqueda de listas por usuario
CREATE INDEX IDX_LISTA_USR
    ON LISTA(id_usuario);

-- Búsqueda de personas por apellido
CREATE INDEX IDX_PERSONA_APELLIDO
    ON PERSONA(primer_apellido);

-- ============================================================
-- SECCIÓN 2: VISTAS
-- Simplifican las consultas más frecuentes de la aplicación.
-- ============================================================

-- ------------------------------------------------------------
-- Vista: V_CATALOGO_COMPLETO
-- Muestra el catálogo con su puntuación promedio calculada.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW V_CATALOGO_COMPLETO AS
SELECT
    c.id_contenido,
    c.titulo,
    c.tipo,
    c.anio_estreno,
    c.idioma,
    c.url_portada,
    ROUND(AVG(cal.puntuacion), 1)   AS puntuacion_promedio,
    COUNT(cal.id_usuario)           AS total_calificaciones
FROM CONTENIDO c
LEFT JOIN CALIFICACION cal ON c.id_contenido = cal.id_contenido
GROUP BY
    c.id_contenido,
    c.titulo,
    c.tipo,
    c.anio_estreno,
    c.idioma,
    c.url_portada;

-- ------------------------------------------------------------
-- Vista: V_PELICULAS
-- Solo películas con su duración.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW V_PELICULAS AS
SELECT
    c.id_contenido,
    c.titulo,
    c.anio_estreno,
    c.sinopsis,
    c.idioma,
    c.url_portada,
    p.duracion_minutos
FROM CONTENIDO c
INNER JOIN PELICULA p ON c.id_contenido = p.id_contenido
WHERE c.tipo = 'Película';

-- ------------------------------------------------------------
-- Vista: V_SERIES
-- Solo series con información de emisión.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW V_SERIES AS
SELECT
    c.id_contenido,
    c.titulo,
    c.anio_estreno,
    c.sinopsis,
    c.idioma,
    c.url_portada,
    s.en_emision,
    s.num_temporadas
FROM CONTENIDO c
INNER JOIN SERIE s ON c.id_contenido = s.id_contenido
WHERE c.tipo = 'Serie';

-- ------------------------------------------------------------
-- Vista: V_CALIFICACIONES_DETALLE
-- Calificaciones con nombre de usuario y título del contenido.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW V_CALIFICACIONES_DETALLE AS
SELECT
    u.nombre_usuario,
    c.titulo,
    c.tipo,
    cal.puntuacion,
    cal.resenia,
    cal.fecha_calificacion
FROM CALIFICACION cal
INNER JOIN USUARIO   u ON cal.id_usuario   = u.id_usuario
INNER JOIN CONTENIDO c ON cal.id_contenido = c.id_contenido
ORDER BY cal.fecha_calificacion DESC;

-- ------------------------------------------------------------
-- Vista: V_REPARTO_COMPLETO
-- Muestra el reparto de cada contenido con su rol.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW V_REPARTO_COMPLETO AS
SELECT
    c.titulo                                        AS contenido,
    c.tipo,
    CONCAT(p.primer_nombre, ' ', p.primer_apellido) AS persona,
    cp.rol
FROM CONTENIDO_PERSONA cp
INNER JOIN CONTENIDO c ON cp.id_contenido = c.id_contenido
INNER JOIN PERSONA   p ON cp.id_persona   = p.id_persona
ORDER BY c.titulo, cp.rol;

-- ------------------------------------------------------------
-- Vista: V_LISTAS_DETALLE
-- Muestra las listas con sus contenidos ordenados por posición.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW V_LISTAS_DETALLE AS
SELECT
    u.nombre_usuario,
    l.nombre                AS nombre_lista,
    lc.posicion,
    c.titulo                AS contenido,
    c.tipo
FROM LISTA l
INNER JOIN USUARIO        u  ON l.id_usuario   = u.id_usuario
INNER JOIN LISTACONTENIDO lc ON l.id_lista      = lc.id_lista
INNER JOIN CONTENIDO      c  ON lc.id_contenido = c.id_contenido
ORDER BY l.id_lista, lc.posicion;

-- ============================================================
-- SECCIÓN 3: CONSULTAS DE UTILIDAD
-- Consultas frecuentes documentadas para referencia.
-- ============================================================

-- ------------------------------------------------------------
-- Consulta 1: Top 10 contenidos mejor calificados
-- ------------------------------------------------------------
SELECT
    c.titulo,
    c.tipo,
    ROUND(AVG(cal.puntuacion), 2) AS promedio,
    COUNT(*)                       AS votos
FROM CONTENIDO c
INNER JOIN CALIFICACION cal ON c.id_contenido = cal.id_contenido
GROUP BY c.id_contenido, c.titulo, c.tipo
ORDER BY promedio DESC, votos DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Consulta 2: Películas de un género específico (Ciencia Ficción)
-- ------------------------------------------------------------
SELECT
    c.titulo,
    c.anio_estreno,
    p.duracion_minutos
FROM CONTENIDO c
INNER JOIN PELICULA         p   ON c.id_contenido = p.id_contenido
INNER JOIN CONTENIDO_GENERO cg  ON c.id_contenido = cg.id_contenido
INNER JOIN GENERO           g   ON cg.id_genero   = g.id_genero
WHERE g.nombre = 'Ciencia Ficción'
ORDER BY c.anio_estreno DESC;

-- ------------------------------------------------------------
-- Consulta 3: Todas las obras de una persona (Pedro Pascal)
-- ------------------------------------------------------------
SELECT
    c.titulo,
    c.tipo,
    c.anio_estreno,
    cp.rol
FROM CONTENIDO_PERSONA cp
INNER JOIN CONTENIDO c ON cp.id_contenido = c.id_contenido
INNER JOIN PERSONA   p ON cp.id_persona   = p.id_persona
WHERE p.primer_nombre = 'Pedro'
  AND p.primer_apellido = 'Pascal'
ORDER BY c.anio_estreno;

-- ------------------------------------------------------------
-- Consulta 4: Lista de un usuario ordenada por posición
-- ------------------------------------------------------------
SELECT
    lc.posicion,
    c.titulo,
    c.tipo,
    c.anio_estreno
FROM LISTACONTENIDO lc
INNER JOIN LISTA     l  ON lc.id_lista     = l.id_lista
INNER JOIN CONTENIDO c  ON lc.id_contenido = c.id_contenido
INNER JOIN USUARIO   u  ON l.id_usuario    = u.id_usuario
WHERE u.nombre_usuario = 'danielletto'
  AND l.nombre = 'Mi Top de Películas'
ORDER BY lc.posicion;

-- ------------------------------------------------------------
-- Consulta 5: Episodios de una serie (The Last of Us T1)
-- ------------------------------------------------------------
SELECT
    e.numero_episodio,
    e.titulo,
    e.duracion_minutos,
    e.fecha_emision
FROM EPISODIO e
INNER JOIN TEMPORADA  t ON e.id_temporada  = t.id_temporada
INNER JOIN CONTENIDO  c ON t.id_contenido  = c.id_contenido
WHERE c.titulo = 'The Last of Us'
  AND t.numero_temporada = 1
ORDER BY e.numero_episodio;

-- ------------------------------------------------------------
-- Consulta 6: Contenidos que pertenecen a una saga
-- ------------------------------------------------------------
SELECT
    s.nombre  AS saga,
    u.nombre  AS universo,
    c.titulo,
    c.tipo,
    c.anio_estreno
FROM SAGA_CONTENIDO sc
INNER JOIN SAGA      s ON sc.id_saga       = s.id_saga
INNER JOIN UNIVERSO  u ON s.id_universo    = u.id_universo
INNER JOIN CONTENIDO c ON sc.id_contenido  = c.id_contenido
ORDER BY s.nombre, c.anio_estreno;

-- ------------------------------------------------------------
-- Consulta 7: Finales alternativos con autor y contenido
-- ------------------------------------------------------------
SELECT
    u.nombre_usuario,
    c.titulo,
    fa.fecha_escritura,
    LEFT(fa.texto_final, 100) AS resumen_final
FROM FINALALTERNATIVO fa
INNER JOIN USUARIO   u ON fa.id_usuario   = u.id_usuario
INNER JOIN CONTENIDO c ON fa.id_contenido = c.id_contenido
ORDER BY fa.fecha_escritura DESC;

-- ------------------------------------------------------------
-- Consulta 8: Usuarios que no han calificado ningún contenido
-- ------------------------------------------------------------
SELECT
    u.nombre_usuario,
    u.correo_electronico
FROM USUARIO u
LEFT JOIN CALIFICACION cal ON u.id_usuario = cal.id_usuario
WHERE cal.id_usuario IS NULL;

-- ============================================================
-- FIN DEL SCRIPT DE SCRIPTS VARIOS
-- Índices creados: 7
-- Vistas creadas: 6
-- Consultas documentadas: 8
-- ============================================================


-- ============================================================
-- SECCIÓN 4: RESTRICCIONES ANTI-DUPLICADOS
-- Ejecutar después de limpiar registros duplicados.
-- Estas restricciones evitan que se repitan contenidos,
-- temporadas, episodios y posiciones dentro de listas.
-- ============================================================

DELIMITER $$

DROP PROCEDURE IF EXISTS agregar_restricciones_antiduplicados $$
CREATE PROCEDURE agregar_restricciones_antiduplicados()
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'CONTENIDO'
          AND INDEX_NAME = 'UK_CONTENIDO_TIT_TIP_ANIO'
    ) THEN
        ALTER TABLE CONTENIDO
        ADD CONSTRAINT UK_CONTENIDO_TIT_TIP_ANIO
        UNIQUE (titulo, tipo, anio_estreno);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'TEMPORADA'
          AND INDEX_NAME = 'UK_TEMPORADA_CONT_NUM'
    ) THEN
        ALTER TABLE TEMPORADA
        ADD CONSTRAINT UK_TEMPORADA_CONT_NUM
        UNIQUE (id_contenido, numero_temporada);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'EPISODIO'
          AND INDEX_NAME = 'UK_EP_TEMP_NUM_TIT'
    ) THEN
        ALTER TABLE EPISODIO
        ADD CONSTRAINT UK_EP_TEMP_NUM_TIT
        UNIQUE (id_temporada, numero_episodio, titulo);
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'LISTACONTENIDO'
          AND INDEX_NAME = 'UK_LISTACONT_POS'
    ) THEN
        ALTER TABLE LISTACONTENIDO
        ADD CONSTRAINT UK_LISTACONT_POS
        UNIQUE (id_lista, posicion);
    END IF;

END $$

DELIMITER ;

CALL agregar_restricciones_antiduplicados();

DROP PROCEDURE IF EXISTS agregar_restricciones_antiduplicados;

-- ============================================================
-- CONSULTAS DE VERIFICACIÓN DE DUPLICADOS
-- Estas consultas deben devolver 0 filas.
-- ============================================================

SELECT titulo, tipo, anio_estreno, COUNT(*) AS veces
FROM CONTENIDO
GROUP BY titulo, tipo, anio_estreno
HAVING COUNT(*) > 1;

SELECT id_contenido, numero_temporada, COUNT(*) AS veces
FROM TEMPORADA
GROUP BY id_contenido, numero_temporada
HAVING COUNT(*) > 1;

SELECT id_temporada, numero_episodio, titulo, COUNT(*) AS veces
FROM EPISODIO
GROUP BY id_temporada, numero_episodio, titulo
HAVING COUNT(*) > 1;

SELECT id_lista, posicion, COUNT(*) AS veces
FROM LISTACONTENIDO
GROUP BY id_lista, posicion
HAVING COUNT(*) > 1;
