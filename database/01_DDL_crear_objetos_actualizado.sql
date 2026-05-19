-- ============================================================
-- CineLog — Script de Creación de Objetos (DDL)
-- Archivo: 01_DDL_crear_objetos.sql
-- RDBMS:   MySQL 8.0
-- Autor:   Equipo CineLog — Universidad El Bosque
-- Desc:    Crea la base de datos y todas las tablas del modelo
--          relacional normalizado hasta 3FN.
-- ============================================================

-- ── Seleccionar base de datos ────────────────────────────────
USE cinelog_db;

-- ============================================================
-- BLOQUE 1: ENTIDADES FUERTES INDEPENDIENTES
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: USUARIO
-- Entidad fuerte. Representa a cada persona registrada.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS USUARIO (
    id_usuario            INT            NOT NULL AUTO_INCREMENT,
    primer_nombre         VARCHAR(50)    NOT NULL,
    segundo_nombre        VARCHAR(50)    NULL,
    primer_apellido       VARCHAR(50)    NOT NULL,
    segundo_apellido      VARCHAR(50)    NULL,
    nombre_usuario        VARCHAR(50)    NOT NULL,
    correo_electronico    VARCHAR(100)   NOT NULL,
    contrasenia           VARCHAR(255)   NOT NULL COMMENT 'Almacenada como hash bcrypt',
    fecha_nacimiento      DATE           NOT NULL,
    CONSTRAINT PK_USUARIO    PRIMARY KEY (id_usuario),
    CONSTRAINT UK_USUARIO_NM UNIQUE (nombre_usuario),
    CONSTRAINT UK_USUARIO_CE UNIQUE (correo_electronico)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Usuarios registrados en la plataforma CineLog';

-- ------------------------------------------------------------
-- Tabla: CONTENIDO
-- Entidad fuerte. Unifica películas y series (Supuesto S-01).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTENIDO (
    id_contenido      INT            NOT NULL AUTO_INCREMENT,
    titulo            VARCHAR(255)   NOT NULL,
    tipo              VARCHAR(10)    NOT NULL COMMENT 'Película | Serie',
    anio_estreno      SMALLINT       NULL,
    sinopsis          TEXT           NULL,
    idioma            VARCHAR(50)    NULL,
    url_portada       TEXT           NULL,
    fecha_agregado    DATE           NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT PK_CONTENIDO              PRIMARY KEY (id_contenido),
    CONSTRAINT UK_CONTENIDO_TIT_TIP_ANIO UNIQUE (titulo, tipo, anio_estreno),
    CONSTRAINT CK_TIPO                   CHECK (tipo IN ('Película', 'Serie'))
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Catálogo unificado de películas y series';

-- ------------------------------------------------------------
-- Tabla: GENERO
-- Entidad fuerte. Catálogo de géneros cinematográficos.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GENERO (
    id_genero    INT           NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_GENERO    PRIMARY KEY (id_genero),
    CONSTRAINT UK_GENERO_NM UNIQUE (nombre)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Géneros cinematográficos y televisivos';

-- ------------------------------------------------------------
-- Tabla: PERSONA
-- Entidad fuerte. Actores y directores (Supuesto S-02).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PERSONA (
    id_persona        INT           NOT NULL AUTO_INCREMENT,
    primer_nombre     VARCHAR(50)   NOT NULL,
    segundo_nombre    VARCHAR(50)   NULL,
    primer_apellido   VARCHAR(50)   NOT NULL,
    segundo_apellido  VARCHAR(50)   NULL,
    fecha_nacimiento  DATE          NULL,
    nacionalidad      VARCHAR(50)   NULL,
    descripcion       TEXT          NULL,
    CONSTRAINT PK_PERSONA PRIMARY KEY (id_persona)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Actores y directores del catálogo';

-- ------------------------------------------------------------
-- Tabla: UNIVERSO
-- Entidad fuerte. Agrupa sagas narrativas (Supuesto S-05).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS UNIVERSO (
    id_universo   INT            NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(100)   NOT NULL,
    descripcion   TEXT           NULL,
    CONSTRAINT PK_UNIVERSO    PRIMARY KEY (id_universo),
    CONSTRAINT UK_UNIVERSO_NM UNIQUE (nombre)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Universos narrativos que agrupan sagas';

-- ============================================================
-- BLOQUE 2: ENTIDADES DEPENDIENTES DE UNIVERSO
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: SAGA
-- Entidad fuerte. Agrupa contenidos dentro de un universo.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SAGA (
    id_saga       INT            NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(100)   NOT NULL,
    descripcion   TEXT           NULL,
    id_universo   INT            NOT NULL,
    CONSTRAINT PK_SAGA         PRIMARY KEY (id_saga),
    CONSTRAINT FK_SAGA_UNIV    FOREIGN KEY (id_universo)
        REFERENCES UNIVERSO(id_universo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Sagas narrativas dentro de un universo';

-- ============================================================
-- BLOQUE 3: ESPECIALIZACIONES DEL MERE
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: PELICULA
-- Especialización de CONTENIDO cuando tipo = 'Película'.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PELICULA (
    id_contenido      INT        NOT NULL,
    duracion_minutos  SMALLINT   NOT NULL,
    CONSTRAINT PK_PELICULA      PRIMARY KEY (id_contenido),
    CONSTRAINT FK_PEL_CONT      FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Atributos exclusivos de películas (MERE)';

-- ------------------------------------------------------------
-- Tabla: SERIE
-- Especialización de CONTENIDO cuando tipo = 'Serie'.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SERIE (
    id_contenido    INT        NOT NULL,
    en_emision      TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1=En emisión, 0=Finalizada',
    num_temporadas  SMALLINT   NOT NULL DEFAULT 1,
    CONSTRAINT PK_SERIE    PRIMARY KEY (id_contenido),
    CONSTRAINT FK_SER_CONT FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Atributos exclusivos de series (MERE)';

-- ============================================================
-- BLOQUE 4: ENTIDADES DÉBILES
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: TEMPORADA
-- Entidad débil. Depende de CONTENIDO (series).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TEMPORADA (
    id_temporada      INT        NOT NULL AUTO_INCREMENT,
    numero_temporada  SMALLINT   NOT NULL,
    anio_estreno      SMALLINT   NULL,
    id_contenido      INT        NOT NULL,
    CONSTRAINT PK_TEMPORADA              PRIMARY KEY (id_temporada),
    CONSTRAINT UK_TEMPORADA_CONT_NUM     UNIQUE (id_contenido, numero_temporada),
    CONSTRAINT FK_TEMP_CONT              FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Temporadas de una serie';

-- ------------------------------------------------------------
-- Tabla: EPISODIO
-- Entidad débil. Depende de TEMPORADA.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EPISODIO (
    id_episodio       INT            NOT NULL AUTO_INCREMENT,
    numero_episodio   SMALLINT       NOT NULL,
    titulo            VARCHAR(255)   NOT NULL,
    duracion_minutos  SMALLINT       NULL,
    fecha_emision     DATE           NULL,
    id_temporada      INT            NOT NULL,
    CONSTRAINT PK_EPISODIO                 PRIMARY KEY (id_episodio),
    CONSTRAINT UK_EP_TEMP_NUM_TIT          UNIQUE (id_temporada, numero_episodio, titulo),
    CONSTRAINT FK_EP_TEMP                  FOREIGN KEY (id_temporada)
        REFERENCES TEMPORADA(id_temporada)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Episodios de una temporada';

-- ============================================================
-- BLOQUE 5: ENTIDADES DEPENDIENTES DE USUARIO
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: LISTA
-- Entidad fuerte. Listas personalizadas de un usuario.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LISTA (
    id_lista        INT            NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(100)   NOT NULL,
    descripcion     TEXT           NULL,
    fecha_creacion  DATE           NOT NULL DEFAULT (CURRENT_DATE),
    id_usuario      INT            NOT NULL,
    CONSTRAINT PK_LISTA      PRIMARY KEY (id_lista),
    CONSTRAINT FK_LISTA_USR  FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Listas personalizadas creadas por los usuarios';

-- ============================================================
-- BLOQUE 6: ENTIDADES ASOCIATIVAS
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: CALIFICACION
-- Asociativa USUARIO + CONTENIDO (Supuesto S-03).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CALIFICACION (
    id_usuario          INT             NOT NULL,
    id_contenido        INT             NOT NULL,
    puntuacion          DECIMAL(3,1)    NOT NULL,
    resenia             TEXT            NULL,
    fecha_calificacion  DATE            NOT NULL,
    CONSTRAINT PK_CALIFICACION    PRIMARY KEY (id_usuario, id_contenido),
    CONSTRAINT FK_CAL_USR         FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_CAL_CONT        FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CK_PUNTUACION      CHECK (puntuacion >= 1.0 AND puntuacion <= 10.0)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Calificaciones de usuarios sobre contenidos (1 activa por par)';

-- ------------------------------------------------------------
-- Tabla: LISTACONTENIDO
-- Asociativa LISTA + CONTENIDO con atributo posicion.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LISTACONTENIDO (
    id_lista      INT        NOT NULL,
    id_contenido  INT        NOT NULL,
    posicion      SMALLINT   NOT NULL,
    CONSTRAINT PK_LISTACONT       PRIMARY KEY (id_lista, id_contenido),
    CONSTRAINT UK_LISTACONT_POS   UNIQUE (id_lista, posicion),
    CONSTRAINT FK_LC_LISTA        FOREIGN KEY (id_lista)
        REFERENCES LISTA(id_lista)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_LC_CONT      FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Relación ordenada entre listas y contenidos';

-- ------------------------------------------------------------
-- Tabla: FINALALTERNATIVO
-- Asociativa USUARIO + CONTENIDO (Supuesto S-04).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FINALALTERNATIVO (
    id_usuario      INT    NOT NULL,
    id_contenido    INT    NOT NULL,
    texto_final     TEXT   NOT NULL,
    fecha_escritura DATE   NOT NULL,
    CONSTRAINT PK_FINALALT    PRIMARY KEY (id_usuario, id_contenido),
    CONSTRAINT FK_FA_USR      FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_FA_CONT     FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Finales alternativos escritos por usuarios';

-- ============================================================
-- BLOQUE 7: TABLAS INTERMEDIAS N:M
-- ============================================================

-- ------------------------------------------------------------
-- Tabla: CONTENIDO_GENERO
-- Resuelve N:M entre CONTENIDO y GENERO.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTENIDO_GENERO (
    id_contenido  INT   NOT NULL,
    id_genero     INT   NOT NULL,
    CONSTRAINT PK_CONT_GEN   PRIMARY KEY (id_contenido, id_genero),
    CONSTRAINT FK_CG_CONT    FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_CG_GEN     FOREIGN KEY (id_genero)
        REFERENCES GENERO(id_genero)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Relación N:M entre contenidos y géneros';

-- ------------------------------------------------------------
-- Tabla: CONTENIDO_PERSONA
-- Resuelve N:M entre CONTENIDO y PERSONA con atributo rol.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTENIDO_PERSONA (
    id_contenido  INT           NOT NULL,
    id_persona    INT           NOT NULL,
    rol           VARCHAR(50)   NOT NULL COMMENT 'Actor | Director | Actor y Director',
    CONSTRAINT PK_CONT_PER   PRIMARY KEY (id_contenido, id_persona),
    CONSTRAINT FK_CP_CONT    FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_CP_PER     FOREIGN KEY (id_persona)
        REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Participación de personas en contenidos con su rol';

-- ------------------------------------------------------------
-- Tabla: SAGA_CONTENIDO
-- Resuelve N:M entre SAGA y CONTENIDO (Supuesto S-06).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SAGA_CONTENIDO (
    id_saga       INT   NOT NULL,
    id_contenido  INT   NOT NULL,
    CONSTRAINT PK_SAGA_CONT  PRIMARY KEY (id_saga, id_contenido),
    CONSTRAINT FK_SC_SAGA    FOREIGN KEY (id_saga)
        REFERENCES SAGA(id_saga)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_SC_CONT    FOREIGN KEY (id_contenido)
        REFERENCES CONTENIDO(id_contenido)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Relación N:M entre sagas y contenidos';

-- ============================================================
-- FIN DEL SCRIPT DDL
-- Total de tablas creadas: 17
-- ============================================================
