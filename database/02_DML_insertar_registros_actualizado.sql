-- ============================================================
-- CineLog — Script de Inserción de Registros (DML)
-- RDBMS:   MySQL 8.0
-- Autor:   Equipo CineLog — Universidad El Bosque
-- Desc:    Datos de prueba realistas para todas las tablas.
-- ============================================================

USE cinelog_db;

-- IMPORTANTE:
-- Se usa INSERT IGNORE para que este script pueda ejecutarse más de una vez
-- sin duplicar datos ni romper las restricciones UNIQUE del DDL actualizado.

-- ============================================================
-- BLOQUE 1: GÉNEROS
-- ============================================================
INSERT IGNORE INTO GENERO (nombre) VALUES
('Acción'),
('Aventura'),
('Ciencia Ficción'),
('Drama'),
('Comedia'),
('Terror'),
('Thriller'),
('Animación'),
('Fantasía'),
('Romance'),
('Crimen'),
('Documental'),
('Suspenso'),
('Religioso');

-- ============================================================
-- BLOQUE 2: UNIVERSOS
-- ============================================================
INSERT IGNORE INTO UNIVERSO (nombre, descripcion) VALUES
('Universo Cinematográfico de Marvel', 'Franquicia de superhéroes de Marvel Studios basada en los cómics de Marvel Comics.'),
('Universo de DC', 'Franquicia de superhéroes de DC Studios basada en los cómics de DC Comics.'),
('Universo de Star Wars', 'Saga galáctica creada por George Lucas ambientada hace mucho tiempo en una galaxia muy, muy lejana.'),
('Universo de El Señor de los Anillos', 'Universo de fantasía épica creado por J.R.R. Tolkien, adaptado al cine por Peter Jackson.');

-- ============================================================
-- BLOQUE 3: SAGAS
-- ============================================================
INSERT IGNORE INTO SAGA (nombre, descripcion, id_universo) VALUES
('Saga del Infinito', 'Arco narrativo del MCU que culmina con Avengers: Infinity War y Endgame.', 1),
('Saga de los Vengadores', 'Historias centradas en el equipo de los Vengadores dentro del MCU.', 1),
('Saga Multiversal', 'Arco narrativo del MCU que explora el multiverso tras los eventos de Endgame.', 1),
('La Trilogía del Anillo', 'Las tres películas principales de la adaptación de Tolkien por Peter Jackson.', 4),
('La Trilogía del Hobbit', 'Precuela de El Señor de los Anillos, también adaptada por Peter Jackson.', 4),
('La Trilogía de la Fuerza', 'Saga Skywalker: episodios VII, VIII y IX de Star Wars.', 3);

-- ============================================================
-- BLOQUE 4: PERSONAS (ACTORES Y DIRECTORES)
-- ============================================================
INSERT IGNORE INTO PERSONA (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, nacionalidad, descripcion) VALUES
('Robert',      NULL,     'Downey',     'Jr.',  '1965-04-04', 'Estadounidense', 'Actor conocido por interpretar a Tony Stark / Iron Man en el MCU.'),
('Scarlett',    NULL,     'Johansson',  NULL,   '1984-11-22', 'Estadounidense', 'Actriz conocida por su papel de Natasha Romanoff / Black Widow en el MCU.'),
('Christopher', NULL,     'Nolan',      NULL,   '1970-07-30', 'Británico',      'Director reconocido por películas como Inception, Interstellar y Oppenheimer.'),
('Anthony',     NULL,     'Russo',      NULL,   '1970-02-03', 'Estadounidense', 'Director junto a su hermano Joe Russo de Avengers: Infinity War y Endgame.'),
('Joe',         NULL,     'Russo',      NULL,   '1971-07-18', 'Estadounidense', 'Director junto a su hermano Anthony Russo de Avengers: Infinity War y Endgame.'),
('Cillian',     NULL,     'Murphy',     NULL,   '1976-05-25', 'Irlandés',       'Actor conocido por Peaky Blinders y su papel de J. Robert Oppenheimer.'),
('Ana',         NULL,     'de Armas',   NULL,   '1988-04-30', 'Cubana',         'Actriz conocida por Knives Out, No Time to Die y Blonde.'),
('Pedro',       NULL,     'Pascal',     NULL,   '1975-04-02', 'Chileno',        'Actor conocido por The Mandalorian y The Last of Us.'),
('Anya',        'Taylor', 'Joy',        NULL,   '1996-04-16', 'Británica',      'Actriz conocida por The Queen''s Gambit y The Menu.'),
('Denis',       NULL,     'Villeneuve', NULL,   '1967-10-03', 'Canadiense',     'Director de Dune, Arrival e Incendies.'),
('Timothée',    NULL,     'Chalamet',   NULL,   '1995-12-27', 'Estadounidense', 'Actor conocido por Call Me by Your Name y Dune.'),
('Zendaya',     NULL,     'Coleman',    NULL,   '1996-09-01', 'Estadounidense', 'Actriz conocida por Euphoria, Dune y Challengers.');

-- ============================================================
-- BLOQUE 5: CONTENIDOS (PELÍCULAS)
-- ============================================================
INSERT IGNORE INTO CONTENIDO (titulo, tipo, anio_estreno, sinopsis, idioma, url_portada, fecha_agregado) VALUES
('Avengers: Endgame',
    'Película', 2019,
    'Los Vengadores sobrevivientes se unen para revertir el chasquido de Thanos y restaurar el universo.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg', '2026-01-01'),
('Avengers: Infinity War',
    'Película', 2018,
    'Los Vengadores y sus aliados deben estar dispuestos a sacrificarlo todo para derrotar al poderoso Thanos.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg', '2026-01-01'),
('Iron Man',
    'Película', 2008,
    'El empresario Tony Stark construye una armadura de alta tecnología y se convierte en el superhéroe Iron Man.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg', '2026-01-01'),
('Oppenheimer',
    'Película', 2023,
    'La historia del físico J. Robert Oppenheimer y su papel en el desarrollo de la bomba atómica durante la Segunda Guerra Mundial.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '2026-01-01'),
('Dune: Parte Uno',
    'Película', 2021,
    'Paul Atreides, un joven brillante, viaja al planeta más peligroso del universo para proteger a su familia.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '2026-01-01'),
('Dune: Parte Dos',
    'Película', 2024,
    'Paul Atreides se une a los Fremen y comienza un viaje espiritual y político para convertirse en Muad''Dib.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg', '2026-01-01'),
('El Señor de los Anillos: La Comunidad del Anillo',
    'Película', 2001,
    'El hobbit Frodo Bolsón hereda el Anillo Único y emprende un viaje para destruirlo.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg', '2026-01-01'),
('El Señor de los Anillos: Las Dos Torres',
    'Película', 2002,
    'La Comunidad del Anillo se divide mientras la guerra de los Reinos de los Hombres avanza.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg', '2026-01-01'),
('El Señor de los Anillos: El Retorno del Rey',
    'Película', 2003,
    'La batalla final por la Tierra Media determina el destino de todos sus habitantes.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', '2026-01-01'),
('Knives Out',
    'Película', 2019,
    'Un detective investiga la muerte de un famoso escritor tras la reunión familiar en su mansión.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg', '2026-01-01');

-- ============================================================
-- BLOQUE 6: ESPECIALIZACIONES (PELICULAS — ids 1 al 10)
-- ============================================================
INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos) VALUES
(1,  181),
(2,  149),
(3,  126),
(4,  180),
(5,  155),
(6,  166),
(7,  178),
(8,  179),
(9,  201),
(10, 130);

-- ============================================================
-- BLOQUE 7: CONTENIDOS (SERIES)
-- ============================================================
INSERT IGNORE INTO CONTENIDO (titulo, tipo, anio_estreno, sinopsis, idioma, url_portada, fecha_agregado) VALUES
('The Last of Us',
    'Serie', 2023,
    'En un mundo post-apocalíptico devastado por una infección fúngica, Joel debe escoltar a Ellie a través de los peligros de los Estados Unidos.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg', '2026-01-01'),
('Euphoria',
    'Serie', 2019,
    'Sigue a un grupo de adolescentes mientras navegan por las drogas, el amor, la identidad y el trauma.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg', '2026-01-01'),
('The Mandalorian',
    'Serie', 2019,
    'Un guerrero mandaloriano viaja por la galaxia protegiendo a un misterioso niño de la especie del Maestro Yoda.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg', '2026-01-01'),
('The Queen''s Gambit',
    'Serie', 2020,
    'Una joven huérfana se convierte en una prodigiosa jugadora de ajedrez mientras lucha contra su adicción a las drogas.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/zU0htwkhNvBQdVSIKB9s6hgVeFK.jpg', '2026-01-01'),
('Severance',
    'Serie', 2022,
    'Los empleados de una corporación se someten a un procedimiento que separa sus recuerdos laborales de los personales.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/lFf6LLrQjYldcZItzOkGmMMigP7.jpg', '2026-01-01');

-- ============================================================
-- BLOQUE 8: ESPECIALIZACIONES (SERIES — ids 11 al 15)
-- ============================================================
INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas) VALUES
(11, 1, 2),
(12, 1, 3),
(13, 1, 3),
(14, 0, 1),
(15, 1, 2);

-- ============================================================
-- BLOQUE 9: CONTENIDOS (PELÍCULAS NUEVAS — agregadas en mayo 2026)
-- ============================================================
INSERT IGNORE INTO CONTENIDO (titulo, tipo, anio_estreno, sinopsis, idioma, url_portada, fecha_agregado) VALUES
('La Pasión de Cristo',
    'Película', 2004,
    'Relata las últimas 12 horas de la vida de Jesucristo, desde su arresto en el jardín de Getsemaní hasta su crucifixión.',
    'Arameo/Latín', 'https://es.web.img2.acsta.net/c_310_420/medias/nmedia/18/67/78/89/20068058.jpg', '2026-05-17'),
('Ben-Hur',
    'Película', 1959,
    'Un príncipe judío traicionado por su amigo romano busca venganza mientras cruza el mundo antiguo en una épica historia de fe y redención.',
    'Inglés', 'https://image.tmdb.org/t/p/w500/m4WQ1dBIrEIHZNCoAjdpxwSKWyH.jpg', '2026-05-17'),
('El Príncipe de Egipto',
    'Película', 1998,
    'La historia de Moisés, desde su vida como príncipe de Egipto hasta su destino como líder del pueblo hebreo.',
    'Inglés', 'https://en.wikipedia.org/wiki/Special:Redirect/file/Prince_of_egypt_ver2.jpg', '2026-05-17'),
('Silencio',
    'Película', 2016,
    'Dos jesuitas portugueses viajan al Japón del siglo XVII en busca de su mentor desaparecido y enfrentan una brutal persecución religiosa.',
    'Inglés', 'https://upload.wikimedia.org/wikipedia/en/3/36/Silence_%282016_film%29.png', '2026-05-17');

-- ============================================================
-- BLOQUE 10: ESPECIALIZACIONES (PELÍCULAS NUEVAS — ids 16 al 19)
-- ============================================================
INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos) VALUES
(16, 127),
(17, 212),
(18, 99),
(19, 161);

-- ============================================================
-- BLOQUE 11: TEMPORADAS
-- ============================================================
INSERT IGNORE INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido) VALUES
(1, 2023, 11),
(2, 2025, 11),
(1, 2019, 12),
(2, 2022, 12),
(1, 2019, 13),
(2, 2020, 13),
(3, 2023, 13),
(1, 2020, 14),
(1, 2022, 15),
(2, 2024, 15);

-- ============================================================
-- BLOQUE 12: EPISODIOS (muestra de temporada 1 de The Last of Us)
-- ============================================================
INSERT IGNORE INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada) VALUES
(1, 'Cuando estás perdido en las tinieblas',  81, '2023-01-15', 1),
(2, 'Infectados',                             55, '2023-01-22', 1),
(3, 'Más allá',                               76, '2023-01-29', 1),
(4, 'Por favor, espérame',                    47, '2023-02-05', 1),
(5, 'Endure and Survive',                     60, '2023-02-10', 1),
(6, 'Kin',                                    58, '2023-02-19', 1),
(7, 'Left Behind',                            51, '2023-02-26', 1),
(8, 'When We Are in Need',                    50, '2023-03-05', 1),
(9, 'Look for the Light',                     43, '2023-03-12', 1);

-- ============================================================
-- BLOQUE 13: USUARIOS
-- ============================================================
INSERT IGNORE INTO USUARIO (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, nombre_usuario, correo_electronico, contrasenia, fecha_nacimiento) VALUES
('Daniel',  NULL,    'Bautista', 'Acosta', 'danielletto',   'daniel.bautista@unbosque.edu.co', '$2b$12$placeholder_hash_1', '2005-03-15'),
('Nicole',  'Diane', 'Cruz',     'Garcia', 'nicoledianecd', 'nicole.cruz@unbosque.edu.co',     '$2b$12$placeholder_hash_2', '2004-11-08'),
('Juan',    'David', 'Alvarez',  NULL,     'juandavid_av',  'juan.alvarez@unbosque.edu.co',    '$2b$12$placeholder_hash_3', '2005-06-22'),
('Maria',   NULL,    'Gonzalez', 'Lopez',  'mariag_films',  'maria.gonzalez@email.com',        '$2b$12$placeholder_hash_4', '1998-07-14'),
('Carlos',  NULL,    'Ramirez',  NULL,     'carlosram99',   'carlos.ramirez@email.com',        '$2b$12$placeholder_hash_5', '1999-02-28'),
('Juan',    NULL,    'Dick',     NULL,     'Juandick',      'jdalfonso75@gmail.com',           '$2b$12$placeholder_hash_6', '2004-06-15'),
('Suaza',   NULL,    'Suaza',    NULL,     'jsuaza',        'esuazam@gmail.com',               '$2b$12$placeholder_hash_7', '2006-02-16'),
('Nicolas', NULL,    'Forero',   NULL,     'Niko',          'nsforero06@gmail.com',            '$2b$12$placeholder_hash_8', '2006-12-13'),
('Nicolas', NULL,    'Suarez',   NULL,     'nisua4',        'nisua4@test.com',                 '$2b$12$placeholder_hash_9', '2000-01-01'),
('Ana',     NULL,    'Martinez', NULL,     'amartin21',     'am.martinez@gmail.com',           '$2b$12$placeholder_hash_10','2001-01-01');

-- ============================================================
-- BLOQUE 14: LISTAS PERSONALIZADAS
-- ============================================================
INSERT IGNORE INTO LISTA (nombre, descripcion, fecha_creacion, id_usuario) VALUES
('Mi Top de Películas',              'Las películas que más me han marcado en la vida',                    '2026-02-01', 1),
('Saga del Infinito en orden',       'Las películas del MCU de la Saga del Infinito en orden cronológico', '2026-02-10', 1),
('Mejores Series del Momento',       'Series que estoy viendo o que recomiedo totalmente',                 '2026-01-15', 2),
('Películas para una noche lluviosa','Películas perfectas para ver en casa cuando llueve',                 '2026-03-05', 3),
('Mi Top de Ciencia Ficción',        'Las mejores películas y series de Sci-Fi según yo',                  '2026-02-20', 4),
('Pa Qliar',                         'Pa Qliar',                                                           '2026-05-08', 6),
('Lista pa follar con medias',       'Lista pa follar con medias',                                          '2026-05-08', 7),
('Mis favoritas',                    'Lista de contenidos favoritos',                                       '2026-05-17', 9),
('Primarias',                        '',                                                                    '2026-05-17', 10);

-- ============================================================
-- BLOQUE 15: LISTACONTENIDO (con posición)
-- ============================================================
INSERT IGNORE INTO LISTACONTENIDO (id_lista, id_contenido, posicion) VALUES
-- Lista 1: Mi Top de Películas (danielletto)
(1, 1,  1),
(1, 4,  2),
(1, 5,  3),
(1, 7,  4),
(1, 10, 5),
-- Lista 2: Saga del Infinito en orden (danielletto)
(2, 3,  1),
(2, 2,  2),
(2, 1,  3),
-- Lista 3: Mejores Series del Momento (nicoledianecd)
(3, 11, 1),
(3, 15, 2),
(3, 14, 3),
-- Lista 4: Películas para una noche lluviosa (juandavid_av)
(4, 9,  1),
(4, 7,  2),
(4, 4,  3),
-- Lista 5: Mi Top de Ciencia Ficción (mariag_films)
(5, 5,  1),
(5, 6,  2),
(5, 11, 3),
-- Lista 7: Pa Qliar (Juandick)
(7, 9,  1),
(7, 5,  2),
-- Lista 8: Lista pa follar con medias (jsuaza)
(8, 2,  1),
(8, 5,  2),
-- Lista 9: Mis favoritas (nisua4)
(9, 11, 1),
(9, 10, 2),
(9, 1,  3),
(9, 2,  4),
(9, 4,  5),
-- Lista 11: Primarias (amartin21)
(11, 3, 1);

-- ============================================================
-- BLOQUE 16: CALIFICACIONES
-- ============================================================
INSERT IGNORE INTO CALIFICACION (id_usuario, id_contenido, puntuacion, resenia, fecha_calificacion) VALUES
(1, 1,  9.5, 'Una de las mejores conclusiones de franquicia que he visto. El final de Tony me rompió el corazón.', '2026-01-10'),
(1, 4,  9.8, 'Nolan en su máxima expresión. La secuencia del Trinity Test es simplemente perfecta.',               '2026-01-15'),
(1, 5,  8.5, 'Visualmente impresionante. Denis Villeneuve construyó un mundo increíble.',                          '2026-02-01'),
(1, 11, 9.0, 'El episodio 3 me hizo llorar como nunca. Pedro Pascal es un actor increíble.',                       '2026-03-01'),
(2, 1,  8.0, 'Muy buena película aunque siento que Infinity War fue mejor.',                                       '2026-01-20'),
(2, 2,  9.2, 'El mejor cliffhanger de la historia del cine.',                                                      '2026-01-20'),
(2, 11, 9.5, 'La mejor serie que he visto en años. El episodio de Bill y Frank es perfecto.',                      '2026-02-10'),
(2, 12, 8.8, 'Zendaya lleva la serie en sus hombros. Visualmente única.',                                          '2026-02-15'),
(3, 7,  9.7, 'Una obra maestra del cine de fantasía. Jackson creó algo único.',                                     '2026-01-05'),
(3, 8,  9.5, 'La batalla del Abismo de Helm es épica. La mejor de la trilogía para mí.',                           '2026-01-06'),
(3, 9,  9.3, 'El fin de una era. Imperfecta pero emotiva.',                                                        '2026-01-07'),
(4, 5,  9.0, NULL,                                                                                                  '2026-02-05'),
(4, 6,  8.7, 'Parte dos mejora todo lo de la primera entrega.',                                                    '2026-02-05'),
(5, 10, 8.5, 'Una película de detectives brillante. Anya Taylor-Joy y Daniel Craig son perfectos.',                '2026-01-30'),
(6, 2,  9.0, 'Severa pelicula',                                                                                     '2026-05-08'),
(6, 4,  10.0,'Severa',                                                                                              '2026-05-08'),
(9, 1,  5.0, 'Muy buena pelicula',                                                                                  '2026-05-17');

-- ============================================================
-- BLOQUE 17: FINALES ALTERNATIVOS
-- ============================================================
INSERT IGNORE INTO FINALALTERNATIVO (id_usuario, id_contenido, texto_final, fecha_escritura) VALUES
(1, 1,  'En mi versión, Tony no muere. Usa el guante y logra sobrevivir gracias a la ayuda de Doctor Strange que proyecta un escudo de energía en el momento justo. Tony se retira con Pepper y Morgan, viviendo en paz mientras los demás Vengadores continúan protegiendo el universo.', '2026-01-12'),
(2, 11, 'En mi final, Joel y Ellie llegan al hospital y Joel no traiciona a la Humanidad. Joel le explica la situación a Ellie honestamente. Ellie decide voluntariamente sacrificarse, pero en el último momento los científicos descubren que pueden sintetizar la cura sin matarla. Joel y Ellie sobreviven y el mundo comienza a sanar.', '2026-02-12'),
(3, 9,  'Frodo decide quedarse en la Tierra Media en lugar de partir a los Puertos Grises. Sam, Merry y Pippin envejecen junto a él en la Comarca. En sus últimos años, Frodo escribe un segundo libro donde narra todo lo que no contó en el primero.', '2026-01-08'),
(4, 5,  'Paul rechaza el rol de Muad''Dib y lidera una revolución pacífica junto a los Fremen para expulsar al Emperador sin convertirse en un mesías de guerra. La paz llega, aunque más lentamente.', '2026-02-06'),
(6, 1,  'Todos van por tacos!!!', '2026-05-08'),
(9, 9,  'El heroe decide destruir el anillo de otra forma.', '2026-05-17');

-- ============================================================
-- BLOQUE 18: CONTENIDO_GENERO (relación N:M)
-- ============================================================
INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero) VALUES
-- Acción (1)
(1, 1), (2, 1), (3, 1), (13, 1),
-- Aventura (2)
(1, 2), (2, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (13, 2), (17, 2), (18, 2),
-- Ciencia Ficción (3)
(1, 3), (2, 3), (3, 3), (5, 3), (6, 3), (11, 3), (13, 3), (15, 3),
-- Drama (4)
(4, 4), (7, 4), (8, 4), (9, 4), (11, 4), (12, 4), (14, 4), (15, 4), (16, 4), (17, 4), (19, 4),
-- Comedia (5)
(12, 5),
-- Thriller (7)
(4, 7), (10, 7), (11, 7), (14, 7), (15, 7), (19, 7),
-- Animación (8)
(18, 8),
-- Fantasía (9)
(5, 9), (6, 9), (7, 9), (8, 9), (9, 9),
-- Crimen (11)
(10, 11),
-- Religioso (14)
(16, 14), (17, 14), (18, 14), (19, 14);

-- ============================================================
-- BLOQUE 19: CONTENIDO_PERSONA (relación N:M con rol)
-- ============================================================
INSERT IGNORE INTO CONTENIDO_PERSONA (id_contenido, id_persona, rol) VALUES
(1,  1,  'Actor'),
(1,  2,  'Actor'),
(1,  4,  'Director'),
(1,  5,  'Director'),
(2,  1,  'Actor'),
(2,  2,  'Actor'),
(2,  4,  'Director'),
(2,  5,  'Director'),
(3,  1,  'Actor'),
(4,  3,  'Director'),
(4,  6,  'Actor'),
(5,  10, 'Director'),
(5,  11, 'Actor'),
(5,  12, 'Actor'),
(6,  10, 'Director'),
(6,  11, 'Actor'),
(6,  12, 'Actor'),
(7,  4,  'Director'),
(8,  4,  'Director'),
(9,  4,  'Director'),
(10, 7,  'Actor'),
(11, 8,  'Actor'),
(12, 12, 'Actor'),
(13, 8,  'Actor'),
(14, 9,  'Actor');

-- ============================================================
-- BLOQUE 20: SAGA_CONTENIDO (relación N:M)
-- ============================================================
INSERT IGNORE INTO SAGA_CONTENIDO (id_saga, id_contenido) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 3),
(4, 7),
(4, 8),
(4, 9),
(6, 13);

-- ============================================================
-- FIN DEL SCRIPT DML
-- Registros insertados por tabla:
--   GENERO: 14 | UNIVERSO: 4 | SAGA: 6
--   PERSONA: 12 | CONTENIDO: 19 | PELICULA: 14 | SERIE: 5
--   TEMPORADA: 10 | EPISODIO: 9 | USUARIO: 10
--   LISTA: 9 | LISTACONTENIDO: 27 | CALIFICACION: 17
--   FINALALTERNATIVO: 6 | CONTENIDO_GENERO: 51
--   CONTENIDO_PERSONA: 25 | SAGA_CONTENIDO: 9
-- ============================================================
