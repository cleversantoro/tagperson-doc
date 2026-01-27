-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-server
-- Tempo de geração: 16/01/2026 às 01:03
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

INSERT INTO `profissao` (`id`, `nome`, `image_file`, `descricao`, `equipamentos_iniciais`, `moedas_cobre`, `moedas_prata`, `moedas_ouro`, `energia_heroica`, `pontos_habilidade`, `pontos_arma`, `pontos_combate`, `penalidade_habilidade_grupo`, `especialidade_habilidade`, `atributo_magia`, `id_magia_grupo`, `defesa_base`, `arma_dano_maximo`, `absorcao`) VALUES
(1, 'Guerreiro', 'guerreiro.png', 'Tanto na realidade quanto na fantasia, muitos homens e mulheres viveram de sua capacidade de\r\ncombate. Exemplos destas pessoas são: Hércules, o rei Arthur, Conan, Roland, Siegfried, um legionário\r\nromano, um Guerreiro grego, um cavaleiro teutônico, e muitos outros que lutavam como membros de\r\num exército.', 'Armadura de couro rígido|escudo pequeno|elmo aberto|roupa comum|botas|mochila de couro|cantil|cinto', 5, 1, 0, 18, 14, 10, 12, 7, -1, -1, -1, 'L3', 16, '+18'),
(2, 'Ladino', 'ladino.png', 'Ladinos são aventureiros que se desenvolveram como os melhores no uso de Habilidades. Isso,\r\ncombinado com seu considerável poder de combate, os fazem úteis em praticamente qualquer situação.\r\nEmbora os Ladinos possam ser muito diferentes entre si eles compartilham de duas características em\r\ncomum: versatilidade e grande capacidade de sobreviver a todo tipo de perigo.', 'Armadura de couro rígido|escudo pequeno|roupa comum|calçado comum|mochila de couro|navalha|10 pítons para alpinismo|manto com capuz|20 metros de corda', 5, 3, 0, 12, 22, 7, 12, -1, -1, -1, -1, 'L3', 12, '+16'),
(3, 'Sacerdote', 'sacerdote.png', 'Estes Sacerdotes são parecidos com os clérigos medievais. Treinados na fé e nas armas, eles levam a\r\npalavra dos deuses a todos e lutam pela causa desses quando necessário.', 'Armadura de couro rígido|escudo pequeno|elmo aberto|roupa comum|calçado comum ou botas|mochila de couro|símbolo sagrado de ferro|água abençoada|manto com capuz|cinto|pederneiras', 5, 1, 0, 12, 12, 5, 9, 5, -1, 2, 3, 'L3', 16, '+18'),
(4, 'Mago', 'mago.png', 'Os Magos são indivíduos voltados para o estudo de passagens e escrituras místicas. Eles se consagram\r\nintegralmente ao aprendizado de formas arcanas de conhecimento. Isso os afasta de outras atividades,\r\nprejudicando de certa forma suas habilidades em outras áreas (por exemplo, mesmo podendo usar\r\narmas, eles têm um conhecimento militar mínimo).', 'Roupa comum|calçado comum|mochila de couro|manto com capuz|cinto|pederneiras|mochila de couro|pena e tinta|pergaminho', 5, 15, 0, 6, 12, 1, 3, 6, -1, 0, 4, 'L0', 8, '0'),
(5, 'Rastreador', 'rastreador.png', 'Estes são guerreiros que se adaptaram em viver e lutar nas florestas. Eles são de certa forma ligados às\r\nmatas e desta comunhão ganham um presente único: magias ligadas ao meio em que vivem.', 'Armadura de couro rígido|roupa comum|botas|mochila de couro|cinto|pederneiras|capa|par de luvas', 5, 5, 0, 15, 14, 5, 9, 4, -1, 6, 1, 'L2', 16, '+12'),
(6, 'Bardo', 'bardo.png', 'Com espírito livre e fala amistosa, os Bardos se tornaram os principais veículos de informação no\r\nMundo Conhecido. Tendo na Arte o seu maior poder, eles conseguem cativar pessoas facilmente,\r\nsendo muito bem recebidos na maior parte dos reinos. Sua habilidade de lidar com pessoas é tal que os\r\nBardos se fazem muito úteis na grande maioria dos acontecimentos, desde os mais corriqueiros aos\r\nmais estrondosos.', 'Armadura de couro rígido|roupa comum|calçado comum|cinto|mochila de couro|cantil|lamparina a óleo|capa|chapéu|instrumento musical', 5, 5, 0, 9, 16, 3, 6, -1, -1, 2, 2, 'L2', 16, '+12');

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
