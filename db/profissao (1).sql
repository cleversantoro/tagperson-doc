-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-server
-- Tempo de geração: 16/01/2026 às 01:04
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
-- Estrutura para tabela `profissao`
--

CREATE TABLE `profissao` (
  `id` int NOT NULL,
  `nome` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image_file` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descricao` text COLLATE utf8mb4_general_ci,
  `equipamentos_iniciais` text COLLATE utf8mb4_general_ci,
  `moedas_cobre` int DEFAULT NULL,
  `moedas_prata` int DEFAULT NULL,
  `moedas_ouro` int DEFAULT NULL,
  `energia_heroica` int DEFAULT NULL,
  `pontos_habilidade` int DEFAULT NULL,
  `pontos_arma` int DEFAULT NULL,
  `pontos_combate` int DEFAULT NULL,
  `penalidade_habilidade_grupo` int DEFAULT NULL,
  `especialidade_habilidade` int DEFAULT NULL,
  `atributo_magia` int DEFAULT NULL,
  `id_magia_grupo` int DEFAULT NULL,
  `defesa_base` varchar(2) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `arma_dano_maximo` int DEFAULT NULL,
  `absorcao` varchar(4) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profissao`
--

INSERT INTO `profissao` (`equipamentos_iniciais`) VALUES
('Armadura de couro rígido|escudo pequeno|elmo aberto|roupa comum|botas|mochila de couro|cantil|cinto'),
('Armadura de couro rígido|escudo pequeno|roupa comum|calçado comum|mochila de couro|navalha|10 pítons para alpinismo|manto com capuz|20 metros de corda'),
('Armadura de couro rígido|escudo pequeno|elmo aberto|roupa comum|calçado comum ou botas|mochila de couro|símbolo sagrado de ferro|água abençoada|manto com capuz|cinto|pederneiras'),
('Roupa comum|calçado comum|mochila de couro|manto com capuz|cinto|pederneiras|mochila de couro|pena e tinta|pergaminho'),
('Armadura de couro rígido|roupa comum|botas|mochila de couro|cinto|pederneiras|capa|par de luvas'),
('Armadura de couro rígido|roupa comum|calçado comum|cinto|mochila de couro|cantil|lamparina a óleo|capa|chapéu|instrumento musical');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `profissao`
--
ALTER TABLE `profissao`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
