-- Caracterizações de Fé (Tipo 1)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
(1, 1, 'Ateu', 'Não crê nos deuses e rejeita milagres. Deuses impedem que qualquer magia divina beneficie o personagem (curas, bênçãos, etc). Impede qualquer outra caracterização de fé.', 'Socialmente perigoso: pode ser confundido com demonista e perseguido em reinos como Levânia e Verrogar.'),
(1, 1, 'Fiel', 'Dedicação profunda a uma divindade. Recupera +1 EF em magias de cura de sacerdotes da mesma divindade. Em curas de EH, recupera +1 ponto por nível da magia.', 'Exige seguir rigorosamente as doutrinas do deus escolhido. Pode ser comprado mais de uma vez para deuses diferentes.'),
-- GRUPO: RELAÇÃO COM OS DEUSES
(1, 2, 'Deus Patrono/Deusa Matrona', '+4 em testes de Primeira Impressão contra sacerdotes do patrono. 1x por aventura, o Mestre pode conceder uma graça divina simples em situação difícil.', 'O custo é por divindade. Exige viver as doutrinas como um sacerdote. Perda de benefícios exige missão sagrada para perdão.'),
(1, 2, 'Perseguição Divina', 'Um Deus tem antipatia pelo personagem. 1x por sessão (em momento crítico), o personagem falha automaticamente em algo ligado à área do deus ou sofre um revés ambiental.', 'Sacerdotes desta divindade sentem animosidade instintiva contra o personagem.'),
(1, 2, 'Proteção dos Deuses', 'Intervenção salvadora quando a vida está em risco (EF abaixo de zero ou Crítico). Permite usar EH para absorver 100% do dano de críticos sem sofrer efeito especial.', 'Funciona 1x ao dia. Requer que o personagem tenha EH maior que 0 no momento do uso.');

-- Caracterizações Físicas (Tipo 2)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- ESTATURA (Grupo 2)
(2, 2, 'Estatura: Nanico {-3}', 'Restrições severas de armas: humanos/meio-elfos usam como elfos; elfos como anões; anões como pequeninos. Pequeninos não usam armas de 2 mãos.', 'Inclui todas as penalidades de Baixo.'),
(2, 2, 'Estatura: Gigante {4}', 'Pode usar armas de categorias superiores com uma mão. Humanos usam armas de 2 mãos com apenas uma.', '+1 nível de dificuldade em testes de Esconder-se.'),
-- ESTRUTURA CORPORAL
(2, 2, 'Estrutura: Atlético {2}', 'Agilidade 2 (Req). +1/4 VB básica. +2 colunas em Furtividade, Acrobacia, Montar e Escapar (flexibilidade).', NULL),
(2, 2, 'Estrutura: Obeso {-2}', 'VB reduzida para 3/4 do padrão. +1 nível de dificuldade em todas as habilidades de Manobra.', NULL),
(2, 2, 'Estrutura: Robusto {2}', 'Força e Físico 1 (Req). +1/4 de Energia Física (EF) básica da raça.', NULL),
-- BELEZA
(2, 2, 'Beleza: Deslumbrante {3}', '-1 nível de dificuldade em testes de Impressão (inclusive contra outras raças). +2 colunas em Persuasão e Empatia.', 'Pode causar paixão à primeira vista ou distrações em multidões.'),
(2, 2, 'Beleza: Horroroso {-3}', '-1 nível de dificuldade em testes de Impressão (inclusive contra outras raças). -2 colunas em Persuasão e Empatia.', 'Abominação física; causa medo, desprezo ou pena profunda.');
-- DEFICIÊNCIAS
(2, 2, 'Deficiência: Caolho {-2}', '-3 colunas em ataques à distância e percepção visual do lado cego. Dificuldade com profundidade.', NULL),
(2, 2, 'Deficiência: Míope {-2}', '-6 colunas em ações combativas e testes visuais à longa distância.', NULL),
(2, 2, 'Deficiência: Perneta {-4}', 'VB máxima reduzida à metade. +1 nível de dificuldade em corridas, saltos e ações que dependam das duas pernas.', 'Uso obrigatório de perna de pau.'),
(2, 2, 'Deficiência: Problemas na fala {-2}', '+1 nível de dificuldade em testes que envolvam fala e itens mágicos. Incapaz de lançar magias rituais.', 'Exige teste de Línguas para ser compreendido por outros.'),
-- CARACTERÍSTICAS ÚNICAS
(2, 2, 'Aspecto Inofensivo {1}', 'Vence iniciativa automaticamente na 1ª rodada (se avisar o mestre). +2 colunas em Persuasão quando explorado.', 'Efeito de surpresa funciona apenas uma vez por inimigo.'),
(2, 2, 'Pele Cadavérica {-1}', 'Pele não regenera esteticamente (mantém cortes e cicatrizes). Recuperação pode ser 2x mais lenta.', NULL);
-- SAÚDE E DOR
(2, 2, 'Saúde: Corpo Fechado {3}', 'RF = Estágio + Físico + 10. Morte ocorre apenas com -12 EF.', NULL),
(2, 2, 'Resistência à Dor: Extrema {2}', 'Imunidade a efeitos de dor descritos em acertos críticos ou magias.', 'O dano do crítico ocorre, mas a penalidade de dor não.'),
(2, 2, 'Hiperalgesia {-2}', 'Proibido comprar técnica Resistência à Dor. +1 nível de dificuldade em testes para resistir à dor.', NULL),
-- SONO
(2, 2, 'Sono: Consciente {6}', 'Consciência superficial enquanto dorme. Desperta sem testes. Testes de sentidos com +2 níveis se não acordar.', NULL),
(2, 2, 'Sono: Sonolento {-4}', 'Dificuldade de sono pesado. +1 nível de dificuldade em testes perceptivos por 10 min após acordar.', 'Risco de dormir em pé após 1h de calmaria (Teste de Físico).'),
-- VENENOS (Exemplo de Fraqueza/Imunidade)
(2, 2, 'Sensibilidade: Fraqueza I {-8}', 'Venenos Tipo I a V agem com +8 na Força de Ataque (FA).', 'Sensibilidade extrema a qualquer toxina.'),
(2, 2, 'Sensibilidade: Imunidade III {4}', 'Imunidade total a venenos dos Tipos I, II e III.', 'Venenos Tipos IV e V agem normalmente.'),
-- ALERGIA E DEPENDÊNCIA
(2, 2, 'Alergia: Comum {-3}', 'Contato causa -3 colunas em tarefas físicas e RF por 4h. Ingestão pode incapacitar por 4 rodadas.', 'Aparece em quase todas as sessões.'),
(2, 2, 'Dependência Pesada {-3}', 'Viciado em drogas Tipo 3 ou 4 (FA 16). Sofre abstinência se não cumprir o ciclo.', NULL);
(2, 2, 'Potencial: Primazia {6}', 'Inicia com 17 pontos de atributo. Um atributo pode ter Limite Racial +5.', 'Representa a elite genética/física da raça.'),
(2, 2, 'Potencial: Mediocridade {-4}', 'Inicia com apenas 13 pontos de atributo. Limite Racial é reduzido (Modificador +3).', 'Personagem limitado em suas capacidades naturais.');

-- Histórico (Tipo 3, Grupo 3)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- DEPENDENTE DE HABITAT
(3, 3, 'Dependente de Habitat: Comum {-1}','Ambiente de conforto comum (Ex: Longe de aglomerações). Pode ficar afastado por dias iguais à Resistência Física. Após isso, perde 1 EF por dia. Recupera 1 EF por hora ao retornar.', 'O Mestre deve aprovar o ambiente específico.'),
(3, 3, 'Dependente de Habitat: Amplo {-2}', 'Ambiente de conforto amplo (Ex: Florestas). Pode ficar afastado por dias iguais à Resistência Física. Após isso, perde 1 EF por dia. Recupera 1 EF por hora ao retornar.', 'O Mestre deve aprovar o ambiente específico.'),
(3, 3, 'Dependente de Habitat: Restrito {-3}', 'Ambiente de conforto restrito (Ex: Dentro d’água). Pode ficar afastado por dias iguais à Resistência Física. Após isso, perde 1 EF por dia. Recupera 1 EF por hora ao retornar.', 'O Mestre deve aprovar o ambiente específico.'),
(3, 3, 'Dependente de Habitat: Endêmico {-5}', 'Ambiente de conforto específico/único (Ex: Rio Odem). Pode ficar afastado por dias iguais à Resistência Física. Após isso, perde 1 EF por dia. Recupera 1 EF por hora ao retornar.', 'O Mestre deve aprovar o ambiente específico.'),
-- HERANÇA
(3, 3, 'Herança: Mínima {1}', 'Item ou propriedade no valor máximo de 4 m.o. ou 2 moedas de ouro em espécie.', 'Valor sentimental envolvido.'),
(3, 3, 'Herança: Pequena {2}', 'Item ou propriedade no valor máximo de 12 m.o. ou 6 moedas de ouro em espécie.', 'Valor sentimental envolvido.'),
(3, 3, 'Herança: Média {3}', 'Item ou propriedade no valor máximo de 50 m.o. ou 25 moedas de ouro em espécie.', 'Valor sentimental envolvido.'),
(3, 3, 'Herança: Grande {4}', 'Propriedades no valor máximo de 100 m.o. ou 50 moedas de ouro em espécie.', 'Valor sentimental envolvido.'),
(3, 3, 'Herança: Enorme {5}', 'Propriedades no valor máximo de 200 m.o., mais 50 moedas de ouro em espécie.', 'Valor sentimental envolvido.'),
(3, 3, 'Herança: Item Mágico Menor {3}', 'Objeto com bônus de até +2 (arma), +3 absorção/+1 defesa (proteção) ou magia nível 2 (1x/dia).', 'Requer justificativa histórica.'),
(3, 3, 'Herança: Item Mágico Maior {5}', 'Objeto com bônus de até +3 (arma), +9 absorção/+2 defesa (proteção) ou magia nível 5 (1x/dia).', 'Requer justificativa histórica.'),
-- MEMÓRIA
(3, 3, 'Memória: Eidética {1}', 'Lembra detalhes de tudo que viu. 1x por sessão: sucesso automático para lembrar algo.', NULL),
(3, 3, 'Memória: Fraca {-1}', '-2 colunas em testes de Intelecto/Memória e habilidades baseadas em Intelecto.', NULL),
(3, 3, 'Memória: Senil {-3}', '-4 colunas em Intelecto/Memória, -4 em habilidades de Intelecto, -2 em Iniciativa. Esquece nomes facilmente.', NULL),
-- OBJETO AMALDIÇOADO
(3, 3, 'Objeto Amaldiçoado: Inoportuno {-1}', 'Traz benefícios leves, mas prejuízo a cada 4 sessões. Não consegue se desfazer do item.', 'Compulsão por recuperar se tirado à força.'),
(3, 3, 'Objeto Amaldiçoado: Prejudicial {-2}', 'Traz benefícios leves, mas prejuízo a cada 2 sessões. Não consegue se desfazer do item.', 'Compulsão por recuperar se tirado à força.'),
(3, 3, 'Objeto Amaldiçoado: Dominante {-3}', 'Traz benefícios leves, mas prejuízo em todas as sessões. Não consegue se desfazer do item.', 'Compulsão por recuperar se tirado à força.'),
-- RESSONÂNCIA E SEXTO SENTIDO
(3, 3, 'Ressonância Energética {5}', '1x por sessão: dobra o tempo de um encanto se empregar o dobro de karma.', NULL),
(3, 3, 'Sexto Sentido {5}', 'Intuição sobrenatural contra hostilidade. Evita surpresa completa (surpresa parcial). Não permite avisar outros a tempo.', 'Não funciona para ações impulsivas do jogador.'),
-- SORTE / AZAR
(3, 3, 'Sorte: Azarado {-1}', 'Dobro de chance de ser vítima de eventos ruins (1 ou 2 em 1d10). Azar cotidiano constante.', NULL),
(3, 3, 'Sorte: Extremamente Azarado {-3}', '50% de chance de ser o alvo de algo ruim no grupo. Azar cotidiano espetacular e desastroso.', NULL),
(3, 3, 'Sorte: Sortudo {3}', '1x por sessão: pedir evento de sorte (excluir de sorteio ou mudar alvo de ataque).', NULL),
-- TALENTO
(3, 3, 'Talento: Combate {5}', 'Ganha 1 ponto em Grupos de Armas por nível.', NULL),
(3, 3, 'Talento: Habilidade {3}', 'Ganha 2 pontos de Habilidade por nível.', NULL),
(3, 3, 'Talento: Magia {4}', 'Ganha 1 ponto de aquisição de Magia por nível (Apenas Místicos).', NULL),
(3, 3, 'Talento: Técnicas de Combate {4}', 'Ganha 1 ponto de aquisição de Técnicas de Combate por nível.', NULL),
-- TREINAMENTO
(3, 3, 'Treinamento pouco ortodoxo {2}', 'Possui uma habilidade aprimorada diferente da indicada na tabela da profissão.', 'Não pode ser de grupo penalizado.');

-- ABADOM
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
(4, 22, 'Conhecedor de Dragões', 'Conhecimento extra sobre o comportamento e poderes de dragões.', 'Custo: 1. +2 colunas em Sabedoria/Seguir Trilhas contra dragões.'),
(4, 22, 'Escambista', 'Talento para trocas comerciais diretas sem uso de moeda.', 'Custo: 1. +2 colunas em tarefas de troca de mercadorias.'),
(4, 22, 'Sobrevivente', 'Hábito diário de lutar pela vida em ambientes hostis.', 'Custo: 1. +2 colunas em todos os testes de Sobrevivência.'),
(4, 22, 'Trauma de Dragões', 'Medo ancestral enraizado que prejudica o combate.', 'Custo: -1. -2 colunas em ataques contra dragões.'),
--ACORDO
(4, 22, 'Carrancudo', 'Trabalhador incansável, porém desconfiado e pouco sociável.', 'Custo: -1. +1 coluna em testes Profissionais; -2 colunas em Empatia/Etiqueta.'),
(4, 22, 'Duro de Negócio', 'Desconfiança nata que protege contra golpes comerciais.', 'Custo: 1. +4 colunas em Negociação (compra/venda).'),
(4, 22, 'Minerador Nato', 'Conhecimento profundo de lapidação, jóias e metais.', 'Custo: 1. +2 colunas em Trabalho em Metais e Sabedoria (Metais).'),
(4, 22, 'Muito Desconfiado', 'Desconfiança patológica que limita o trato social.', 'Custo: -1. Carisma máximo 2. Não confia em estranhos.'),
--ÂMIEM
(4, 22, 'Bênção de Palier', 'Aura ampliada que favorece a realização de magias.', 'Custo: 2. +1 ponto de Karma a cada estágio ímpar.'),
(4, 22, 'Mateiro', 'Profundo conhecimento das florestas élficas.', 'Custo: 1. +2 colunas em Navegação/Sobrevivência em florestas.'),
(4, 22, 'Pouco Adaptável', 'Dificuldade em aceitar ou elogiar culturas não élficas.', 'Custo: -1. Teste de Persuasão difícil para esconder desdém por cidades estrangeiras.'),
(4, 22, 'Prestígio em Âmiem', 'Reconhecimento oficial que permite trânsito livre no reino.', 'Custo: 1. Pode entrar com convidados no reino sem autorização prévia.');
--AZANTI
(4, 22, 'Inconformado', 'Rebelde contra o protetorado de Filanti.', 'Custo: -1. -1 grau em testes de 1ª impressão com autoridades azantianas.'),
(4, 22, 'Preparado para a Guerra', 'Treinamento militar obrigatório na reserva.', 'Custo: 1. +1 ponto em grupos de armas. Sujeito a convocação (pena de morte se negar).'),
(4, 22, 'Simpatias contra Magias', 'Rituais populares para afastar a "bruxaria".', 'Custo: 2. +1 ponto em RM (Resistência Mística).'),
-- CALCO
(4, 22, 'Educação Refinada', 'Conceitos de etiqueta e cultura superior.', 'Custo: 1. +1 coluna em testes do subgrupo Conhecimento.'),
(4, 22, 'Multicultural', 'Costume em lidar com diversas raças e nações.', 'Custo: 1. +4 colunas em testes de Etiqueta.'),
(4, 22, 'Teórico', 'Falta de experiência prática em conflitos reais.', 'Custo: -1. -4 colunas em Operações de Cerco e Liderança Militar.'),
-- CIDADES-ESTADO
(4, 22, 'Bravo Piense', 'Cultura belicosa e militarista.', 'Custo: 2. +2 colunas em Operações de Cerco. +1 no Ataque com arma treinada.'),
(4, 22, 'Carpintaria Torbelina', 'Tradição em construção naval e madeira.', 'Custo: 1. +2 colunas em Carpintaria e Arte (Desenhos de barcos).'),
(4, 22, 'Enderiano Abastado', 'Cidadão de cidade próspera.', 'Custo: 2. +1/4 de dinheiro inicial e possui abrigo em Ender.'),
(4, 22, 'Estrangeirismos', 'Influência de marinheiros e idiomas exóticos.', 'Custo: 1. +4 colunas em Idiomas (compreensão).'),
(4, 22, 'Mercador Quizano', 'Talento para comércio e artesanato.', 'Custo: 1. +2 colunas em Negociação e Trabalhos Manuais.'),
(4, 22, 'Revoltoso Estepano', 'Sobrevivência sob opressão oligárquica.', 'Custo: 1. +1 coluna em Ações Furtivas.'),
-- CONTI
(4, 22, 'Homem do Mar', 'Tradição marinheira contêsa.', 'Custo: 1. +2 colunas em Náutica e Sabedoria de Águas.'),
(4, 22, 'Malandragem Mulina', 'Vivência em tavernas e portos populosos.', 'Custo: 1. +1 coluna em Jogatina, Enganação e Furtar Objetos.'),
(4, 22, 'Mateiro', 'Familiaridade com as florestas do sul.', 'Custo: 1. +2 colunas em Navegação e Sobrevivência em Florestas.'),
(4, 22, 'Mesquinho', 'Prioriza o lucro sobre a honra.', 'Custo: -1. -1 grau em 1ª impressão se o temperamento for conhecido.'),
-- DANTSEM
(4, 22, 'Cavaleiro de Criaturas', 'Domínio de montarias místicas.', 'Custo: 1. +4 colunas em Montar Animais (monstros/místicos).'),
(4, 22, 'Desapropriado', 'Perdeu o lar para Verrogar.', 'Custo: -1. -1 grau de penalidade social contra verrogaris.'),
(4, 22, 'Mestre das Feras', 'Treinamento militar com feras de guerra.', 'Custo: 1. +4 colunas em Lidar com Animais.'),
(4, 22, 'Treinamento Precário', 'Falta de academias estruturadas antes da guerra.', 'Custo: -1. -1 ponto em Técnicas de Combate.'),
-- EREDRA
(4, 22, 'Experiente em Apostas', 'Familiaridade com lutas de arenas e gladiadores.', 'Custo: 1. +4 colunas em Jogatina (arenas) e +2 para identificar estado de lutadores.'),
(4, 22, 'Ligado à Terra', 'Conhecimento de agricultura e animais domésticos.', 'Custo: 1. +4 colunas em Agricultura e +2 em Lidar com Animais.'),
(4, 22, 'Povo de Fé', 'Profunda religiosidade eredri.', 'Custo: 1. +4 colunas em Religião (exceto demônios).'),
(4, 22, 'Rebelde', 'Informante contra a ocupação Volim.', 'Custo: 1. +2 colunas em Enganação e Códigos.'),
(4, 22, 'Supersticioso', 'Medo excessivo da fúria divina.', 'Custo: -1. Deve cumprir rituais diários para evitar fúria dos deuses.'),
-- FILANTI
(4, 22, 'Formalidade Filantiana', 'Etiqueta rigorosa e conhecimento de heráldica.', 'Custo: 1. +2 colunas em Etiqueta (+4 para nobreza/heráldica).'),
(4, 22, 'Histórias de Gironde', 'Folclore sobre criaturas da floresta.', 'Custo: 1. +2 colunas em Carpintaria/Sabedoria (madeiras/criaturas).'),
(4, 22, 'Simpatias contra Magias', 'Repúdio cultural à magia arcana.', 'Custo: 2. +1 ponto em RM (Resistência Mística).'),
-- LEVÂNIA
(4, 22, 'Artesão Brual', 'Talento herdado do clã Brual.', 'Custo: 1. +2 colunas em Trabalhos Manuais e Artes Visuais.'),
(4, 22, 'Beduíno', 'Sobrevivência em desertos extremos.', 'Custo: 1. +4 colunas em Sobrevivência (Deserto).'),
(4, 22, 'Justiça Implacável', 'Costume com confissões e punições severas.', 'Custo: 1. +4 colunas em Extrair Informação.'),
(4, 22, 'Mácula Bankdi', 'Traços do clã demonista Bankdi.', 'Custo: -1. -1 grau em 1ª impressão. Risco de morte se reconhecido fora de Levânia.'),
-- LUDGRIM
(4, 22, 'Bilíngue', 'Domínio de idiomas humanos e élficos.', 'Custo: 1. Idiomas iniciais: Malês, Lud e Élfico.'),
(4, 22, 'Sempre Alerta', 'Vigilância constante típica do reino.', 'Custo: 1. +2 em Usar os Sentidos e Navegação.'),
(4, 22, 'Tolerância', 'Valorização das individualidades raciais.', 'Custo: 1. +4 colunas em Empatia.'),
-- LUNA
(4, 22, 'Artista Lunense', 'Herança artística de entretenimento e acrobacia.', 'Custo: 2. +2 colunas em Arte, Acrobacia e Malabarismo.'),
(4, 22, 'Assolado pela Peste', 'Sequelas físicas da peste do reino.', 'Custo: -1. -1 em Resistência Física (RF).'),
(4, 22, 'Medicina Lunense', 'Avanço médico forçado pelas pragas.', 'Custo: 1. +4 colunas em Medicina (Cura).'),
(4, 22, 'Sob a Lâmina da Navalha', 'Mineração e sobrevivência em montanhas hostis.', 'Custo: 1. +2 colunas em Trabalhos em Metais e Sobrevivência (Montanha).');
-- MARANA
(4, 22, 'Culinária Pequenina', 'Tradição gastronômica dos pequeninos.', 'Custo: 1. +2 em Culinária; +4 colunas em 1ª impressão com quem provar a comida.'),
(4, 22, 'Desiludido', 'Tristeza pela militarização sob o Tirano.', 'Custo: -1. -2 colunas em Liderança e Sabedoria.'),
(4, 22, 'Retórica Maranense', 'Diplomacia e paciência de Selimon/Palier.', 'Custo: 1. +2 colunas em Persuasão e Liderança (eloquência).'),
-- PLANA
(4, 22, 'Comerciante Nato', 'Aprendizado comercial de Cambu.', 'Custo: 1. +4 colunas em Negociação.'),
(4, 22, 'Defensor Representante', 'Habilidade em convencer e defender pessoas.', 'Custo: 1. +4 colunas em Persuasão.'),
(4, 22, 'Negociante sem Fronteiras', 'Viajou com caravanas por muitos reinos.', 'Custo: 2. Conhece 4 idiomas humanos extras além do Malês.'),
(4, 22, 'Trapaceiro', 'Aprendeu com os comerciantes desonestos.', 'Custo: 1. +4 colunas em Enganação.'),
-- PORTIS
(4, 22, 'Conhecimento Histórico', 'Familiaridade com artefatos de 2º Ciclo.', 'Custo: 1. +4 colunas em Sabedoria (Runa).'),
(4, 22, 'Magia Runense', 'Influência da capital mística Runa.', 'Custo: 1. +2 colunas em Misticismo e Sensitividade.'),
(4, 22, 'Supervaloriza Magos', 'Criado para ver magos como seres superiores.', 'Custo: -1. Acredita em magos; -4 colunas em Empatia contra mentiras de magos.'),
(4, 22, 'Tradição Portiana', 'Respeito e admiração pela magia.', 'Custo: 2. +2 colunas em reconhecer magias/lendas. 1 em 20 chance de achar pergaminho perdido.'),
-- PORTO LIVRE
(4, 22, 'Bandidagem no Sangue', 'Técnicas de rua para furtos.', 'Custo: 1. +2 em Furtar Objetos e Destrancar Fechaduras.'),
(4, 22, 'Boêmia Bandida', 'Filosofia de pirataria e briga de taverna.', 'Custo: 1. +2 colunas em Jogatina; +1 em Combate Desarmado.'),
(4, 22, 'Pirataria', 'Conhecimento básico naval e natação.', 'Custo: 1. +2 colunas em Natação e Náutica.'),
(4, 22, 'Procurado', 'Criminoso com recompensa em todos os reinos.', 'Custo: -2. Reconhecido em tavernas portuárias; recompensa pela cabeça.'),
-- VERROGAR
(4, 22, 'Mentalidade de Soldado', 'Disciplina cega e obediência extrema.', 'Custo: -1. -2 colunas em Liderança. Teste de Carisma difícil para questionar ordens.'),
(4, 22, 'Preparo para Servir', 'Exercício físico rigoroso visando o exército.', 'Custo: 1. +2 colunas em Corrida e Aplicar Esforço.'),
(4, 22, 'Tradição Belicosa', 'Discussão constante de táticas de guerra.', 'Custo: 1. +4 colunas em Operações de Cerco.'),
(4, 22, 'Treinamento Militar', 'Treinamento de elite com armas.', 'Custo: 2. +1 ponto em Técnicas de Combate.');

-- Personalidade (Tipo 5)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- ATENÇÃO (Grupo 5)
(5, 42, 'Distraído','O personagem devaneia constantemente, perdendo detalhes importantes ao seu redor.','Custo: -1. -1 coluna em Percepção. 1x por aventura: falha automática em Usar os Sentidos (escolha do Mestre).'),
(5, 42, 'Vigilante','O personagem mantém um estado de alerta constante, notando o que outros ignoram.','Custo: 1. +2 colunas de resolução em qualquer teste baseado no atributo Percepção.');
-- AUTO-REPRESENTAÇÃO
(5, 42, 'Fanfarrão','O personagem exagera suas conquistas, atraindo atenção e desafios indesejados.','Custo: -1. -4 colunas em Persuasão com quem conhece sua fama. Difícil recusar desafios.'),
(5, 42, 'Modesto','O personagem minimiza suas habilidades, deixando que seus atos falem por si.','Custo: 1. +4 colunas em testes de Impressão ao surpreender outros ou por recomendação de aliados.');
-- Código de Conduta
(5, 42, 'Honrado','Adesão rígida a princípios que influenciam sua interação social.','Custo: -2. Segue o código sempre, mesmo com pequenos prejuízos.'),
(5, 42, 'Palavra de Valor','O personagem segue princípios morais na maioria das situações.','Custo: -1. O descumprimento pode gerar remorso ou perda de XP.'),
(5, 42, 'Penitente','O código é restritivo e frequentemente coloca o personagem em desvantagem.','Custo: -3. Sempre adere e sofre influência negativa constante.'),
(5, 42, 'Vida pela Honra','O código é a razão de viver do personagem e dita todas as suas ações.','Custo: -4. Adesão absoluta com influência muito negativa na vida prática.');
-- COMPULSÕES
(5, 43, 'Alcoólatra','Dependência de álcool. Bebe até a inconsciência.','Custo: -2. Teste de RF contra FA 6 para resistir. Ressaca: -2 colunas por 1 hora.'),
(5, 43, 'Arrogante','Incapaz de admitir erros ou ser humilde.','Custo: -2. -1 grau na escala de impressões. Trata inferiores com desprezo.'),
(5, 43, 'Cleptomaníaco','Impulso de roubar pelo prazer do ato, sem foco no valor.','Custo: -2. O Mestre determina quando o impulso ocorre.'),
(5, 43, 'Ganancioso','Amor excessivo ao dinheiro acima da lógica.','Custo: -1. Teste Difícil de Intelecto para recusar propinas ou dinheiro fácil.'),
(5, 43, 'Guloso','Incapaz de resistir a banquetes ou comidas requintadas.','Custo: -1. Gasta além da conta e come mesmo sob risco (ex: veneno suspeito).'),
(5, 43, 'Mentiroso','Mente compulsivamente, mesmo sem necessidade.','Custo: -1. Dificuldade em ser honesto. Verossimilhança depende de Enganação.'),
(5, 43, 'Mitomaníaco','Mente e passa a acreditar na própria mentira para compensar frustrações.','Custo: -2. Diferente do mentiroso, ele perde a noção da verdade.'),
(5, 43, 'Preguiçoso','Evita qualquer esforço ou trabalho que não seja vital.','Custo: -1. -1 coluna em todos os testes do Grupo Profissional.'),
(5, 43, 'Superconfiante','Opinião exagerada sobre as próprias habilidades.','Custo: -2. Coloca-se em enrascadas por acreditar que é melhor do que realmente é.'),
(5, 43, 'Vingativo','Nunca deixa um insulto ou agressão sem resposta.','Custo: -1. Penalidades de -1 a -4 em tudo se não perseguir a vingança.');
-- CORAGEM / COVARDIA
(5, 42, 'Bravura 1', 'Personagem audacioso.', 'Custo: 1. +1 na Força de Defesa (FD) ou +3 colunas contra medo.'),
(5, 42, 'Bravura 2', 'Grande resistência a abalos morais.', 'Custo: 2. +3 na Força de Defesa (FD) ou +6 colunas contra medo.'),
(5, 42, 'Bravura 3', 'Audácia heróica e inabalável.', 'Custo: 3. 1x por sessão: Sucesso automático em resistência a medo. Permanente: +3 FD ou +6 colunas.'),
(5, 42, 'Covardia 1', 'Pessimismo defensivo e temor pela vida.', 'Custo: -1. -3 na Força de Defesa (FD) em testes contra medo.'),
(5, 42, 'Covardia 2', 'Pânico frequente em situações de risco.', 'Custo: -2. 1x por sessão: o Mestre pode impor falha automática contra medo.'),
(5, 42, 'Covardia 3', 'Incapaz de enfrentar situações assustadoras.', 'Custo: -3. Personagem sempre fracassa automaticamente em testes contra medo.');
-- FOBIA
(5, 42, 'Comum','Medo terrível que surge quase toda sessão de jogo.','Custo: -3. Teste Médio de Carisma. Sucesso: -3 em ações. Falha: Pânico/Fuga. Recuperação: -1 por 5 min.'),
(5, 42, 'Incomun','Medo terrível que surge raramente (uma vez a cada quatro sessões).','Custo: -1. Teste Médio de Carisma. Sucesso: -3 em ações. Falha: Pânico/Fuga. Recuperação: -1 por 5 min.');
(5, 42, 'Ocasional','Medo terrível que surge em média a cada duas sessões.','Custo: -2. Teste Médio de Carisma. Sucesso: -3 em ações. Falha: Pânico/Fuga. Recuperação: -1 por 5 min.'),
-- HUMOR
(5, 42, 'Bem-humorado','Sempre disposto a ouvir e com facilidade para alegrar os outros.','Custo: 1. +4 colunas de resolução em todos os testes que busquem divertir.'),
(5, 42, 'Contagiante','Emana uma aura de alegria que afeta a todos ao redor.','Custo: 2. +4 colunas para divertir (inclusive para distrair). Aliados próximos recebem o mesmo bônus para divertir.');
(5, 42, 'Mal-humorado','Reclama de tudo e tem dificuldade em expressar alegria ou humor.','Custo: -1. +1 nível de dificuldade em testes dos subgrupos Influência/Subterfúgio que busquem divertir.'),
(5, 42, 'Ranzinza','Sempre reclamando e de cara amarrada, estraga o clima de qualquer ambiente.','Custo: -2. +1 nível dificuldade para divertir. -4 colunas 1ª Impressão. Aliados na cena sofrem -2 colunas para divertir.'),
-- MENTALIDADE
(5, 42, 'Inconstante','O personagem desanima facilmente após um fracasso inicial.','Custo: -1. Penalidade de +3 níveis de dificuldade para cada nova tentativa em tarefas nas quais já tenha falhado.'),
(5, 42, 'Persistente','O personagem possui grande capacidade de insistência e foco apesar das frustrações.','Custo: 1. Penalidade reduzida: apenas +1 nível de dificuldade para cada nova tentativa em tarefas nas quais já tenha falhado.');
-- NOÇÃO
(5, 42, 'Bom Senso','Capacidade de avaliar riscos antes de agir de forma estúpida.','Custo: 1. Permite teste de Intelecto para o Mestre advertir o jogador sobre consequências de ações imprudentes.'),
(5, 42, 'Imprudência','Propensão a agir sem pensar nas consequências.','Custo: -1. O Mestre pode assumir o controle do personagem para uma ação impulsiva uma vez por sessão de jogo.');
-- ODIO
(5, 42, 'Comum','Ódio profundo por algo frequente ou um grupo grande (ex: Sacerdotes ou uma raça inteira).','Custo: -2. Teste Difícil de Carisma para manter o controle. Falha: -2 colunas em ações contra o alvo.');
(5, 42, 'Incomum','Desejo de prejudicar ou humilhar um alvo ou grupo específico e pequeno (ex: Magos Elementalistas).','Custo: -1. Teste Difícil de Carisma para manter o controle. Falha: -2 colunas em ações contra o alvo.'),
-- OUTRAS
(5, 42, 'Crédulo','Falta de senso crítico, acredita facilmente no que lhe dizem.','Custo: -2. Acredita em mentiras razoáveis. Mentiras absurdas exigem teste de Empatia com -8 colunas.'),
(5, 42, 'Curioso','Necessidade irracional de investigar e tocar em tudo que é misterioso.','Custo: -2. Coloca o grupo em risco. Exige teste de Carisma para não manipular objetos perigosos.'),
(5, 42, 'Fanático','Obsessão por uma causa, religião ou objetivo único.','Custo: -2. -4 colunas em Impressão com testemunhas. Torna-se previsível e hostil se provocado.'),
(5, 42, 'Galanteador','Incapaz de resistir ao impulso de sedução.','Custo: -2. Tenta seduzir alvos atraentes independente do risco (casados, poderosos ou inimigos).'),
(5, 42, 'Impaciente','Incapaz de esperar ou seguir planos lentos.','Custo: -1. Intromete-se em tarefas alheias. Teste de Intelecto para não quebrar disfarces ou tocaias.');
(5, 42, 'Maluco','O personagem possui pensamentos confusos e não lineares, sugerindo soluções bizarras.','Custo: -1. -4 colunas em testes de 1ª Impressão se já tiver agido na cena. Exige interpretação de ideias excêntricas.');
-- PERFECCIONISTA
(5, 42, 'Chato','Não entrega serviços incompletos ou com imperfeições.','Custo Base: -2. Pode atrasar prazos do grupo.'),
(5, 42, 'Exigente','Nunca ignora imperfeições, mesmo que essenciais para o sucesso.','Modificador: -3 ao custo total.');
(5, 42, 'Insuportável','Aponta defeitos alheios e tenta corrigir tudo, mesmo ofendendo outros.','Custo Base: -4. Gera hostilidade social frequente.');
(5, 42, 'Requintado','Consegue ignorar a mania sob pressão ou necessidade extrema.','Modificador: +1 ao custo total.'),
(5, 42, 'Seletivo','Não aceita adquirir objetos ou serviços que considere imperfeitos.','Custo Base: -1. Exige o melhor material e execução.'),
-- TEMPERAMENTO
(5, 42, 'Coração de Pedra','Indiferente ao sofrimento alheio, agindo com crueldade ou apatia.','Custo: 2. +4 colunas em testes de resistência contra provocações, sedução ou manipulação emocional.'),
(5, 42, 'Coração Mole','Incapaz de suportar o sofrimento de outros, inclusive inimigos.','Custo: -2. Jamais aceita agressão gratuita ou tortura. Oferece ajuda sempre que possível.'),
(5, 42, 'Esquentado','Reage impulsivamente a qualquer provocação ou insulto.','Custo: -3. Teste Difícil de Intelecto para não perder o controle. Reação deve ser na mesma intensidade da ofensa.'),
(5, 42, 'Frieza Lógica','Controle absoluto sobre as emoções, agindo apenas pela razão.','Custo: 3. Toma decisões extremas sem testes. +4 colunas em Enganação, Jogatina e Persuasão (blefes/resistência).');
-- VISÃO DE MUNDO
(5, 42, 'Otimista','Encara a vida de forma positiva, vendo o lado bom em tudo.','Custo: 1. +4 colunas em 1ª Impressão. 1x/sessão: concede +1 coluna para teste de qualquer personagem na cena.'),
(5, 42, 'Pessimista','Encara a vida de forma negativa e duvida de si e dos outros.','Custo: -3. -4 colunas em Liderança. 1x/aventura: pode perder 1 ação por dúvida. -2 colunas se houver falha prévia na tarefa.');



INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- ALIANÇAS
(6, 56, 'Aliado','Personagem com ficha completa e motivações próprias.','Custo: 2. Evolui com o grupo. Exige ajuda mútua e respeito; pode abandonar o PJ se maltratado.');
(6, 56, 'Arqui-Inimigo', 'O inimigo busca a morte física do personagem.', 'Custo Base: -4.'),
(6, 56, 'Inimigo', 'O inimigo busca destruir a reputação ou posição social.', 'Custo Base: -3.'),
(6, 56, 'Inimigo Invejoso', 'O inimigo possui recursos e nível similares ao personagem.', 'Modificador: -1.'),
(6, 56, 'Inimigo Rival', 'O inimigo é uma figura de grande influência ou poder superior.', 'Modificador: -2.'),
(6, 56, 'Seguidor: Mundano','NPC leal voltado para combate/serviços físicos.ou com conhecimentos mágicos básicos.','Custo: 1. 10 pts atributos; 3 pts armas ou magias/estágio; 10 pts hab/estágio. Sem EH.'),
-- CLASSES SOCIAIS
(6, 57, 'Escravo','O personagem pertence a um dono e é marcado como propriedade.','Custo: -2. -1 nível dificuldade em Impressão. Sem direito a posses ou propriedades.'),
(6, 57, 'Ex-Escravo','Liberto, mas ainda possui marcas ou tatuagens de sua condição anterior.','Custo: -1. -1 nível dificuldade em Impressão. Considerado livre por lei.'),
(6, 57, 'Pequeno Comerciante','Possui estoque inicial de 1 m.o. e um fornecedor NPC.','Custo: 1. +1 coluna em negociações da mercadoria escolhida.'),
(6, 57, 'Artífice','Especialista com acesso a oficinas e ferramentas complexas.','Custo: 1. +1 coluna em testes de fabricação ou restauro na especialidade.'),
(6, 57, 'Grande Comerciante','Influente em guildas, possui tenda e renda fixa.','Custo: 2. Renda: 6 MP/semana. 10% desconto em itens mundanos regionais. +4 colunas Impressão com comerciantes.'),
(6, 57, 'Baixa Nobreza','Cavaleiro, Barão ou Visconde com brasão e vassalos.','Custo: 3. Renda: 12 MP/semana. +1 nível em Impressão contra plebeus e nobres menores. Autoridade local.'),
(6, 57, 'Classe Social: Alta Nobreza','Conde, Marquês ou Duque com vasta influência política.','Custo: 5. Renda: 25 MP/semana. +1 nível em Impressão (Geral). Autoridade máxima na cidade e influência no reino.'),
-- CONTATOS (Exemplos baseados em "Pessoa Livre")
(6, 58, 'Comerciais','Rede de mercadores e lojistas em uma região ou grandes cidades.','Custo: Variavel (0 a 4). Fornece acesso a rotas, preços, rumores de rua e mercado negro. Serviços exigem pagamento.'),
(6, 58, 'Criminosos','Conexões com o submundo: ladrões, contrabandistas e mendigos.','Custo: Variavel (0 a 7). Acesso a esconderijos e informações ilícitas. Cuidado: Risco de traição se vantajoso para o contato.'),
(6, 58, 'Nobreza','Relações diplomáticas em um Ducado ou Condado.','Custo: Variavel (0 a 7). Facilita acolhida, problemas legais e reuniões de alto nível. Favores exigem troca de serviços (missões).'),
-- DÍVIDAS 
(6, 59, 'Curta','Favor pontual e específico (ex: fiança paga por um estranho).','Custo: -1. O credor aparecerá no futuro para cobrar o favor inicial.'),
(6, 59, 'Honra','O personagem salvou a honra ou prestou grande favor a alguém.','Custo: 1. O devedor ajudará no que for possível, respeitando sua própria índole.'),
(6, 59, 'Vida','O personagem salvou a vida de um indivíduo.','Custo: 2. O devedor está disposto a riscos extremos para ajudar o personagem.'),
(6, 59, 'Eterna','Vínculo de favor extremo (ex: evitar execução da família).','Custo: -3. Cobranças não negociáveis. Recusa gera um Inimigo equivalente.'),
(6, 59, 'Longa','Favores acumulados ou de média complexidade (ex: proteção sistemática).','Custo: -2. O Mestre decide quando e como a dívida será cobrada em serviços/bens.'),
-- FAMA
(6, 60, 'Boa Fama','O personagem é reconhecido por feitos heróicos ou talentos admiráveis.','Custo: 1 (por região). +1 nível de facilidade em testes de primeira impressão com quem o reconhece.'),
(6, 60, 'Má Fama','O personagem tem má reputação, sendo visto como vilão ou indigno de confiança.','Custo: -1 (por região). -1 nível de dificuldade em testes de primeira impressão com quem o reconhece.'),
-- HONRA
(6, 61, 'Clã ou mestre desonrado','O clã/mestre cometeu um crime famoso. O PJ é reconhecido 50% das vezes em qualquer lugar.','Custo: -2. -4 colunas em 1ª Impressão. Não pode esconder a herança voluntariamente.'),
(6, 61, 'Mentor','Discípulo de um mestre estágio 20+ com conhecimentos raros.','Custo: 5. Permite aprender até 5 Conhecimentos Extraordinários. Fornece prestígio social e conselhos.'),
(6, 61, 'Mestre/Clã Famoso','Herdeiro de uma linhagem nobre ou discípulo de um herói admirado.','Custo: 2. +1 nível em testes de Impressão. +4 colunas em Etiqueta/Sabedoria ligada ao clã.'),
-- Patrono
(6, 62, 'Comercial','Mercador influente que garante preços baixos e escoamento de tesouros/itens mágicos.','Custo: Variável (0 a 4). Exige serviços de escolta, eliminação de concorrência ou proteção.'),
(6, 62, 'Guerra','Nobre ou militar que fornece os melhores equipamentos mundanos e manutenção.','Custo: Variável (0 a 6). Exige serviços marciais (duelos, treinos ou defesa do patrono).'),
(6, 62, 'Político','Aristocrata que oferece proteção jurídica e informações privilegiadas da corte.','Custo: Variável (0 a 6). Exige espionagem, coleta de segredos e favores políticos.');
