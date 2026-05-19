USE cinelog_db;

SET NAMES utf8mb4;

-- IMPORTANTE:
-- Este script puede ejecutarse varias veces sin duplicar
-- contenidos, temporadas, episodios ni relaciones, siempre que existan
-- las restricciones UNIQUE definidas en el DDL.

START TRANSACTION;

-- =========================================================
-- NUEVAS PELÍCULAS Y SERIES PARA CINELOG
-- Cubre géneros: Acción, Animación, Aventura, Ciencia Ficción,
-- Comedia, Crimen, Documental, Drama, Fantasía, Romance,
-- Suspenso, Terror y Thriller.
-- =========================================================


-- =========================================================
-- 1. MAD MAX: FURY ROAD
-- Géneros: Acción, Aventura, Ciencia Ficción
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Mad Max: Fury Road',
    'Película',
    2015,
    'En un mundo postapocalíptico, Max se une a Furiosa para escapar de un tirano y atravesar el desierto en una persecución extrema.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Mad+Max+Fury+Road',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_mad_max
FROM CONTENIDO
WHERE titulo = 'Mad Max: Fury Road'
  AND tipo = 'Película'
  AND anio_estreno = 2015;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_mad_max, 120);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_mad_max, id_genero
FROM GENERO
WHERE nombre IN ('Acción', 'Aventura', 'Ciencia Ficción');


-- =========================================================
-- 2. SPIDER-MAN: INTO THE SPIDER-VERSE
-- Géneros: Animación, Aventura, Comedia, Acción
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Spider-Man: Into the Spider-Verse',
    'Película',
    2018,
    'Miles Morales descubre sus poderes y conoce a otros Spider-Man de diferentes universos para detener una amenaza multiversal.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Spider-Verse',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_spider_verse
FROM CONTENIDO
WHERE titulo = 'Spider-Man: Into the Spider-Verse'
  AND tipo = 'Película'
  AND anio_estreno = 2018;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_spider_verse, 117);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_spider_verse, id_genero
FROM GENERO
WHERE nombre IN ('Animación', 'Aventura', 'Comedia', 'Acción');


-- =========================================================
-- 3. THE MATRIX
-- Géneros: Ciencia Ficción, Acción, Thriller
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'The Matrix',
    'Película',
    1999,
    'Un programador descubre que la realidad que conoce es una simulación creada por máquinas que controlan a la humanidad.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=The+Matrix',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_matrix
FROM CONTENIDO
WHERE titulo = 'The Matrix'
  AND tipo = 'Película'
  AND anio_estreno = 1999;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_matrix, 136);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_matrix, id_genero
FROM GENERO
WHERE nombre IN ('Ciencia Ficción', 'Acción', 'Thriller');


-- =========================================================
-- 4. THE GODFATHER
-- Géneros: Crimen, Drama
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'The Godfather',
    'Película',
    1972,
    'La familia Corleone enfrenta conflictos internos y externos mientras Michael se transforma en heredero del imperio criminal.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=The+Godfather',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_godfather
FROM CONTENIDO
WHERE titulo = 'The Godfather'
  AND tipo = 'Película'
  AND anio_estreno = 1972;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_godfather, 175);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_godfather, id_genero
FROM GENERO
WHERE nombre IN ('Crimen', 'Drama');


-- =========================================================
-- 5. PARASITE
-- Géneros: Drama, Thriller, Suspenso
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Parasite',
    'Película',
    2019,
    'Una familia de bajos recursos se infiltra poco a poco en la vida de una familia adinerada, desatando consecuencias inesperadas.',
    'Coreano',
    'https://placehold.co/300x450/111827/ffffff?text=Parasite',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_parasite
FROM CONTENIDO
WHERE titulo = 'Parasite'
  AND tipo = 'Película'
  AND anio_estreno = 2019;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_parasite, 132);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_parasite, id_genero
FROM GENERO
WHERE nombre IN ('Drama', 'Thriller', 'Suspenso');


-- =========================================================
-- 6. THE CONJURING
-- Géneros: Terror, Suspenso
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'The Conjuring',
    'Película',
    2013,
    'Dos investigadores paranormales ayudan a una familia aterrorizada por una presencia oscura dentro de su casa.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=The+Conjuring',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_conjuring
FROM CONTENIDO
WHERE titulo = 'The Conjuring'
  AND tipo = 'Película'
  AND anio_estreno = 2013;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_conjuring, 112);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_conjuring, id_genero
FROM GENERO
WHERE nombre IN ('Terror', 'Suspenso');


-- =========================================================
-- 7. LA LA LAND
-- Géneros: Romance, Drama
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'La La Land',
    'Película',
    2016,
    'Una aspirante a actriz y un pianista de jazz se enamoran mientras intentan cumplir sus sueños en Los Ángeles.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=La+La+Land',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_lalaland
FROM CONTENIDO
WHERE titulo = 'La La Land'
  AND tipo = 'Película'
  AND anio_estreno = 2016;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_lalaland, 128);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_lalaland, id_genero
FROM GENERO
WHERE nombre IN ('Romance', 'Drama');


-- =========================================================
-- 8. FREE SOLO
-- Géneros: Documental, Aventura
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Free Solo',
    'Película',
    2018,
    'Documental sobre el escalador Alex Honnold y su intento de escalar El Capitan sin cuerdas ni equipo de seguridad.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Free+Solo',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_free_solo
FROM CONTENIDO
WHERE titulo = 'Free Solo'
  AND tipo = 'Película'
  AND anio_estreno = 2018;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_free_solo, 100);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_free_solo, id_genero
FROM GENERO
WHERE nombre IN ('Documental', 'Aventura');


-- =========================================================
-- 9. HARRY POTTER Y LA PIEDRA FILOSOFAL
-- Géneros: Fantasía, Aventura
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Harry Potter y la Piedra Filosofal',
    'Película',
    2001,
    'Un niño descubre que es mago y comienza sus estudios en Hogwarts, donde se enfrenta a secretos relacionados con su pasado.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Harry+Potter',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_harry_potter
FROM CONTENIDO
WHERE titulo = 'Harry Potter y la Piedra Filosofal'
  AND tipo = 'Película'
  AND anio_estreno = 2001;

INSERT IGNORE INTO PELICULA (id_contenido, duracion_minutos)
VALUES (@id_harry_potter, 152);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_harry_potter, id_genero
FROM GENERO
WHERE nombre IN ('Fantasía', 'Aventura');


-- =========================================================
-- 10. BREAKING BAD
-- Géneros: Crimen, Drama, Thriller
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Breaking Bad',
    'Serie',
    2008,
    'Un profesor de química diagnosticado con cáncer comienza a fabricar metanfetamina junto a un antiguo estudiante.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Breaking+Bad',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_breaking_bad
FROM CONTENIDO
WHERE titulo = 'Breaking Bad'
  AND tipo = 'Serie'
  AND anio_estreno = 2008;

INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas)
VALUES (@id_breaking_bad, 0, 5);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_breaking_bad, id_genero
FROM GENERO
WHERE nombre IN ('Crimen', 'Drama', 'Thriller');

INSERT INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido)
VALUES (1, 2008, @id_breaking_bad)
ON DUPLICATE KEY UPDATE
    anio_estreno = VALUES(anio_estreno);

SELECT id_temporada
INTO @temp_breaking_bad_1
FROM TEMPORADA
WHERE id_contenido = @id_breaking_bad
  AND numero_temporada = 1;

INSERT INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada)
VALUES
(1, 'Pilot', 58, '2008-01-20', @temp_breaking_bad_1),
(2, 'Cat''s in the Bag...', 48, '2008-01-27', @temp_breaking_bad_1),
(3, '...And the Bag''s in the River', 48, '2008-02-10', @temp_breaking_bad_1)
ON DUPLICATE KEY UPDATE
    duracion_minutos = VALUES(duracion_minutos),
    fecha_emision = VALUES(fecha_emision);


-- =========================================================
-- 11. STRANGER THINGS
-- Géneros: Ciencia Ficción, Terror, Suspenso
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Stranger Things',
    'Serie',
    2016,
    'Un grupo de niños descubre fuerzas sobrenaturales y secretos del gobierno tras la desaparición de uno de sus amigos.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Stranger+Things',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_stranger_things
FROM CONTENIDO
WHERE titulo = 'Stranger Things'
  AND tipo = 'Serie'
  AND anio_estreno = 2016;

INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas)
VALUES (@id_stranger_things, 1, 5);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_stranger_things, id_genero
FROM GENERO
WHERE nombre IN ('Ciencia Ficción', 'Terror', 'Suspenso');

INSERT INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido)
VALUES (1, 2016, @id_stranger_things)
ON DUPLICATE KEY UPDATE
    anio_estreno = VALUES(anio_estreno);

SELECT id_temporada
INTO @temp_stranger_1
FROM TEMPORADA
WHERE id_contenido = @id_stranger_things
  AND numero_temporada = 1;

INSERT INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada)
VALUES
(1, 'The Vanishing of Will Byers', 49, '2016-07-15', @temp_stranger_1),
(2, 'The Weirdo on Maple Street', 56, '2016-07-15', @temp_stranger_1),
(3, 'Holly, Jolly', 52, '2016-07-15', @temp_stranger_1)
ON DUPLICATE KEY UPDATE
    duracion_minutos = VALUES(duracion_minutos),
    fecha_emision = VALUES(fecha_emision);


-- =========================================================
-- 12. AVATAR: THE LAST AIRBENDER
-- Géneros: Animación, Aventura, Fantasía
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Avatar: The Last Airbender',
    'Serie',
    2005,
    'Aang, el último maestro aire, debe aprender a dominar los cuatro elementos para detener la guerra de la Nación del Fuego.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Avatar+The+Last+Airbender',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_avatar
FROM CONTENIDO
WHERE titulo = 'Avatar: The Last Airbender'
  AND tipo = 'Serie'
  AND anio_estreno = 2005;

INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas)
VALUES (@id_avatar, 0, 3);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_avatar, id_genero
FROM GENERO
WHERE nombre IN ('Animación', 'Aventura', 'Fantasía');

INSERT INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido)
VALUES (1, 2005, @id_avatar)
ON DUPLICATE KEY UPDATE
    anio_estreno = VALUES(anio_estreno);

SELECT id_temporada
INTO @temp_avatar_1
FROM TEMPORADA
WHERE id_contenido = @id_avatar
  AND numero_temporada = 1;

INSERT INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada)
VALUES
(1, 'The Boy in the Iceberg', 23, '2005-02-21', @temp_avatar_1),
(2, 'The Avatar Returns', 23, '2005-02-21', @temp_avatar_1),
(3, 'The Southern Air Temple', 23, '2005-02-25', @temp_avatar_1)
ON DUPLICATE KEY UPDATE
    duracion_minutos = VALUES(duracion_minutos),
    fecha_emision = VALUES(fecha_emision);


-- =========================================================
-- 13. THE OFFICE
-- Géneros: Comedia
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'The Office',
    'Serie',
    2005,
    'Falso documental sobre la vida diaria de los empleados de una oficina regional de una compañía de papel.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=The+Office',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_office
FROM CONTENIDO
WHERE titulo = 'The Office'
  AND tipo = 'Serie'
  AND anio_estreno = 2005;

INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas)
VALUES (@id_office, 0, 9);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_office, id_genero
FROM GENERO
WHERE nombre IN ('Comedia');

INSERT INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido)
VALUES (1, 2005, @id_office)
ON DUPLICATE KEY UPDATE
    anio_estreno = VALUES(anio_estreno);

SELECT id_temporada
INTO @temp_office_1
FROM TEMPORADA
WHERE id_contenido = @id_office
  AND numero_temporada = 1;

INSERT INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada)
VALUES
(1, 'Pilot', 23, '2005-03-24', @temp_office_1),
(2, 'Diversity Day', 22, '2005-03-29', @temp_office_1),
(3, 'Health Care', 22, '2005-04-05', @temp_office_1)
ON DUPLICATE KEY UPDATE
    duracion_minutos = VALUES(duracion_minutos),
    fecha_emision = VALUES(fecha_emision);


-- =========================================================
-- 14. OUR PLANET
-- Géneros: Documental
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Our Planet',
    'Serie',
    2019,
    'Serie documental que explora la diversidad natural del planeta y los efectos del cambio ambiental en distintos ecosistemas.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Our+Planet',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_our_planet
FROM CONTENIDO
WHERE titulo = 'Our Planet'
  AND tipo = 'Serie'
  AND anio_estreno = 2019;

INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas)
VALUES (@id_our_planet, 0, 2);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_our_planet, id_genero
FROM GENERO
WHERE nombre IN ('Documental');

INSERT INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido)
VALUES (1, 2019, @id_our_planet)
ON DUPLICATE KEY UPDATE
    anio_estreno = VALUES(anio_estreno);

SELECT id_temporada
INTO @temp_our_planet_1
FROM TEMPORADA
WHERE id_contenido = @id_our_planet
  AND numero_temporada = 1;

INSERT INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada)
VALUES
(1, 'One Planet', 50, '2019-04-05', @temp_our_planet_1),
(2, 'Frozen Worlds', 50, '2019-04-05', @temp_our_planet_1),
(3, 'Jungles', 50, '2019-04-05', @temp_our_planet_1)
ON DUPLICATE KEY UPDATE
    duracion_minutos = VALUES(duracion_minutos),
    fecha_emision = VALUES(fecha_emision);


-- =========================================================
-- 15. BRIDGERTON
-- Géneros: Romance, Drama
-- =========================================================

INSERT INTO CONTENIDO (
    titulo,
    tipo,
    anio_estreno,
    sinopsis,
    idioma,
    url_portada,
    fecha_agregado
)
VALUES (
    'Bridgerton',
    'Serie',
    2020,
    'La familia Bridgerton busca amor, prestigio y estabilidad en la alta sociedad londinense durante la época de la Regencia.',
    'Inglés',
    'https://placehold.co/300x450/111827/ffffff?text=Bridgerton',
    CURDATE()
)
ON DUPLICATE KEY UPDATE
    sinopsis = VALUES(sinopsis),
    idioma = VALUES(idioma),
    url_portada = VALUES(url_portada),
    fecha_agregado = VALUES(fecha_agregado);

SELECT id_contenido
INTO @id_bridgerton
FROM CONTENIDO
WHERE titulo = 'Bridgerton'
  AND tipo = 'Serie'
  AND anio_estreno = 2020;

INSERT IGNORE INTO SERIE (id_contenido, en_emision, num_temporadas)
VALUES (@id_bridgerton, 1, 4);

INSERT IGNORE INTO CONTENIDO_GENERO (id_contenido, id_genero)
SELECT @id_bridgerton, id_genero
FROM GENERO
WHERE nombre IN ('Romance', 'Drama');

INSERT INTO TEMPORADA (numero_temporada, anio_estreno, id_contenido)
VALUES (1, 2020, @id_bridgerton)
ON DUPLICATE KEY UPDATE
    anio_estreno = VALUES(anio_estreno);

SELECT id_temporada
INTO @temp_bridgerton_1
FROM TEMPORADA
WHERE id_contenido = @id_bridgerton
  AND numero_temporada = 1;

INSERT INTO EPISODIO (numero_episodio, titulo, duracion_minutos, fecha_emision, id_temporada)
VALUES
(1, 'Diamond of the First Water', 57, '2020-12-25', @temp_bridgerton_1),
(2, 'Shock and Delight', 61, '2020-12-25', @temp_bridgerton_1),
(3, 'Art of the Swoon', 57, '2020-12-25', @temp_bridgerton_1)
ON DUPLICATE KEY UPDATE
    duracion_minutos = VALUES(duracion_minutos),
    fecha_emision = VALUES(fecha_emision);


COMMIT;