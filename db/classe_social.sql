-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-server
-- Tempo de geração: 06/01/2026 às 04:51
-- Versão do servidor: 8.0.44
-- Versão do PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `tagperson`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `classe_social`
--

CREATE TABLE `classe_social` (
  `id` bigint UNSIGNED NOT NULL,
  `nome` varchar(80) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `classe_social`
--

INSERT INTO `classe_social` (`id`, `nome`, `is_default`) VALUES
(1, 'Alta nobreza', 0),
(2, 'Artífice', 0),
(3, 'Baixa nobreza', 0),
(4, 'Ex-escravo', 0),
(5, 'Ex-servo', 0),
(6, 'Grande comerciante', 0),
(7, 'Livre', 1),
(8, 'Pequeno comerciante', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `classe_social`
--
ALTER TABLE `classe_social`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_classe_nome` (`nome`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `classe_social`
--
ALTER TABLE `classe_social`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
