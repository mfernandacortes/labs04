-- -----------------------------------------------------------------------------
-- PROYECTO: Sistema de Gestión de Biblioteca / Tickets
-- DESCRIPCIÓN: Estructura de datos con automatización mediante Triggers y Procedures.
-- FECHA ORIGINAL: 2019 | ACTUALIZADO: 2026
-- AUTOR: María Fernanda Cortés
-- -----------------------------------------------------------------------------

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- 1. PROCEDIMIENTOS ALMACENADOS (Stored Procedures)
-- --------------------------------------------------------
DELIMITER $$

-- Procedimiento para estandarizar la inserción de autores
-- Ventaja: Encapsula la lógica de inserción y protege el ID autoincremental.
CREATE PROCEDURE `insertar_autor` (IN NomyAp VARCHAR(200))
BEGIN
    INSERT INTO `autores`(`ApellidoyNomAutor`) VALUES (NomyAp);
END$$

DELIMITER ;

-- --------------------------------------------------------
-- 2. ESTRUCTURA DE TABLAS
-- --------------------------------------------------------

-- Tabla de Autores
CREATE TABLE `autores` (
  `IdAutor` int(11) NOT NULL AUTO_INCREMENT,
  `ApellidoyNomAutor` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdAutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Tabla de Géneros
CREATE TABLE `generos` (
  `IdGenero` int(11) NOT NULL AUTO_INCREMENT,
  `DetalleGenero` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`IdGenero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Tabla de Libros (Entidad Principal)
CREATE TABLE `libros` (
  `IdLibro` int(11) NOT NULL AUTO_INCREMENT,
  `AutorId` int(11) NOT NULL,
  `GeneroId` int(11) NOT NULL,
  `Titulo` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `Disponible` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_prestamo` date DEFAULT NULL,
  PRIMARY KEY (`IdLibro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Tabla de Socios
CREATE TABLE `socios` (
  `DniSocio` int(11) NOT NULL,
  `NomyApSocio` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `Telefono` varchar(20) NOT NULL, -- Cambiado a varchar para compatibilidad con prefijos
  PRIMARY KEY (`DniSocio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Tabla de Préstamos (Relacional)
CREATE TABLE `prestamos` (
  `IdPrestamo` int(11) NOT NULL AUTO_INCREMENT,
  `SocioDni` int(11) NOT NULL,
  `LibroId` int(11) NOT NULL,
  `FechaPrestamo` date NOT NULL,
  `FechaDevolucion` date DEFAULT NULL,
  PRIMARY KEY (`IdPrestamo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------
-- 3. AUTOMATIZACIÓN MEDIANTE DISPARADORES (Triggers)
-- --------------------------------------------------------
DELIMITER $$

-- Trigger: modif_libro
-- Objetivo: Garantizar la integridad de los datos. 
-- Al registrar un préstamo, automáticamente se marca el libro como NO disponible 
-- y se actualiza su fecha de salida sin necesidad de código extra en el backend.
CREATE TRIGGER `modif_libro` 
AFTER INSERT ON `prestamos` 
FOR EACH ROW 
BEGIN
    UPDATE libros 
    SET Disponible = 0, 
        fecha_prestamo = NEW.FechaPrestamo 
    WHERE IdLibro = NEW.LibroId;
END$$

DELIMITER ;

-- --------------------------------------------------------
-- 4. VOLCADO DE DATOS (Seeders)
-- --------------------------------------------------------

INSERT INTO `autores` (`ApellidoyNomAutor`) VALUES
('Cortazar Julio'),
('Borges Jorge Luis'),
('García Marquez Gabriel');

INSERT INTO `generos` (`DetalleGenero`) VALUES
('Poesía'),
('Novelas');

INSERT INTO `socios` (`DniSocio`, `NomyApSocio`, `Telefono`) VALUES
(11111111, 'Arana Facundo', '34156565'),
(54454556, 'Pitt Brad', '341589889');

INSERT INTO `libros` (`AutorId`, `GeneroId`, `Titulo`, `Disponible`) VALUES
(1, 2, 'Rayuela', 1),
(3, 2, 'Cien años de soledad', 1),
(2, 1, 'El hacedor', 1);

-- --------------------------------------------------------
-- 5. FINALIZACIÓN
-- --------------------------------------------------------
COMMIT;
