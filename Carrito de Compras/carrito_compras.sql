-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-07-2024 a las 05:49:48
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldetalleventa`
--

CREATE TABLE `tbldetalleventa` (
  `id` int(11) NOT NULL,
  `idVenta` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `precioUnitario` decimal(20,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descargado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_general_ci;

--
-- Volcado de datos para la tabla `tbldetalleventa`
--

INSERT INTO `tbldetalleventa` (`id`, `idVenta`, `idProducto`, `precioUnitario`, `cantidad`, `descargado`) VALUES
(1, 2, 2, 18.00, 1, 0),
(2, 3, 1, 18.00, 1, 0),
(3, 3, 2, 18.00, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproductos`
--

CREATE TABLE `tblproductos` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Precio` decimal(20,0) NOT NULL,
  `Descripcion` text NOT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_general_ci;

--
-- Volcado de datos para la tabla `tblproductos`
--

INSERT INTO `tblproductos` (`id`, `Nombre`, `Precio`, `Descripcion`, `imagen`) VALUES
(1, 'Basta de Amores de Mierda I', 18, 'Este documento es un libro titulado \"#Bastadeamoresdemierda\" escrito por Gonzalo Romero. Contiene varios poemas y reflexiones cortas sobre temas como el amor, las relaciones, y la búsqueda de una pareja. El libro parece enfocarse en animar a la gente a no conformarse con relaciones poco satisfactorias y a perseguir el amor verdadero. \r\n', 'https://image.slidesharecdn.com/basta-de-amores-de-mierda-el-pela-gonzalo-romero-211031232031/75/Basta-de-amores-de-mierda-I-1-2048.jpg'),
(2, 'Basta de Amores de Mierda II', 18, 'Este documento presenta un extracto del libro \"#Basta de amores de mierda II: un grito de amor propio\" de Gonzalo Romero. En él, el autor dedica el libro a su familia, editor y lectores, y comparte varios consejos y reflexiones sobre el amor propio y las relaciones tóxicas en 3 o menos oraciones cada uno.', 'https://image.slidesharecdn.com/basta-de-amores-de-mierda-ii-diciendole-adios-a-las-relaciones-toxicas-basta-de-amores-de-mierda-el--211031232302/75/Basta-de-amores-de-mierda-II-1-2048.jpg'),
(3, 'Basta de Amores de Mierda III', 18, 'El libro propone una charla en la que «se pueda afrontar la problemática del amor desde el humor y la emoción» y estimula «la búsqueda de herramientas más sanas para relacionarnos con el otro».\r\n', 'https://html.scribdassets.com/9s7qx10hhcbeaxe4/images/1-23d46b5c20.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblventas`
--

CREATE TABLE `tblventas` (
  `id` int(11) NOT NULL,
  `claveTransaccion` varchar(255) NOT NULL,
  `PaypalDatos` text NOT NULL,
  `Fecha` datetime NOT NULL,
  `Correo` varchar(5000) NOT NULL,
  `Total` decimal(60,0) NOT NULL,
  `status` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_general_ci;

--
-- Volcado de datos para la tabla `tblventas`
--

INSERT INTO `tblventas` (`id`, `claveTransaccion`, `PaypalDatos`, `Fecha`, `Correo`, `Total`, `status`) VALUES
(1, '12345678910', '', '2024-07-01 21:07:16', 'cynthia.inca@gmail.com', 36, 'pendiente'),
(2, 'budsh5lb6uhrsrr5e972khd6l4', '', '2024-07-01 21:15:01', 'cynthia.inca@gmail.com', 36, 'pendiente'),
(3, 'budsh5lb6uhrsrr5e972khd6l4', '', '2024-07-01 21:32:47', 'cynthia.inca2003@gmail.com', 36, 'pendiente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbldetalleventa`
--
ALTER TABLE `tbldetalleventa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idVenta` (`idVenta`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblventas`
--
ALTER TABLE `tblventas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbldetalleventa`
--
ALTER TABLE `tbldetalleventa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblventas`
--
ALTER TABLE `tblventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbldetalleventa`
--
ALTER TABLE `tbldetalleventa`
  ADD CONSTRAINT `tbldetalleventa_ibfk_1` FOREIGN KEY (`idVenta`) REFERENCES `tblventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbldetalleventa_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tblproductos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
