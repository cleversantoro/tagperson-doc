-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-server
-- Tempo de geração: 06/01/2026 às 19:18
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
-- Estrutura para tabela `personagem`
--

CREATE TABLE `personagem` (
  `id` int NOT NULL,
  `nome` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jogador` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image_file` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `att_intelecto` int DEFAULT NULL,
  `att_aura` int DEFAULT NULL,
  `att_carisma` int DEFAULT NULL,
  `att_forca` int DEFAULT NULL,
  `att_fisico` int DEFAULT NULL,
  `att_agilidade` int DEFAULT NULL,
  `att_percepcao` int DEFAULT NULL,
  `defesa_ativa` int DEFAULT NULL,
  `defesa_passiva` int DEFAULT NULL,
  `energia_heroica_maxima` int DEFAULT NULL,
  `energia_heroica` int DEFAULT NULL,
  `energia_fisica` int DEFAULT NULL,
  `absorcao` int DEFAULT NULL,
  `raca` int DEFAULT NULL,
  `profissao` int DEFAULT NULL,
  `especializacao` int DEFAULT NULL,
  `nivel` int DEFAULT NULL,
  `experiencia` int DEFAULT NULL,
  `pontos_habilidade` int DEFAULT NULL,
  `pontos_combate` int DEFAULT NULL,
  `pontos_arma` int DEFAULT NULL,
  `pontos_magia` int DEFAULT NULL,
  `altura` int DEFAULT NULL,
  `peso` int DEFAULT NULL,
  `idade` int DEFAULT NULL,
  `olhos` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cabelo` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pele` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aparencia` text COLLATE utf8mb4_general_ci,
  `divindade` int DEFAULT NULL,
  `classe_social` int DEFAULT NULL,
  `local_nascimento` int DEFAULT NULL,
  `historia` text COLLATE utf8mb4_general_ci,
  `moedas_cobre` int DEFAULT NULL,
  `moedas_prata` int DEFAULT NULL,
  `moedas_ouro` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `personagem`
--

INSERT INTO `personagem` (`id`, `nome`, `jogador`, `image_file`, `att_intelecto`, `att_aura`, `att_carisma`, `att_forca`, `att_fisico`, `att_agilidade`, `att_percepcao`, `defesa_ativa`, `defesa_passiva`, `energia_heroica_maxima`, `energia_heroica`, `energia_fisica`, `absorcao`, `raca`, `profissao`, `especializacao`, `nivel`, `experiencia`, `pontos_habilidade`, `pontos_combate`, `pontos_arma`, `pontos_magia`, `altura`, `peso`, `idade`, `olhos`, `cabelo`, `pele`, `aparencia`, `divindade`, `classe_social`, `local_nascimento`, `historia`, `moedas_cobre`, `moedas_prata`, `moedas_ouro`) VALUES
(9, 'Timothy', '', NULL, 0, 3, 1, 0, 0, 1, 1, 6, 5, 6, 6, 12, 16, 1, 4, 22, 1, 1, 12, 5, 4, 7, 177, 72, 17, 'pretos', 'preto', 'clara', 'Franzino.', 1, 7, 1, 'Estuda as artes mágicas.', 4, 1, 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `personagem`
--
ALTER TABLE `personagem`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
