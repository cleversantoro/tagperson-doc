CREATE TABLE IF NOT EXISTS personagem_caracterizacao (
  id_personagem           INT UNSIGNED NOT NULL,
  id_caracterizacao  INT UNSIGNED NOT NULL,
  nivel                   INT NULL,
  PRIMARY KEY (id_personagem, id_caracterizacao_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS caracterizacao_tipo (
  id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome            VARCHAR(80) NOT NULL,
  descricao       TEXT NULL,
  ordem_exibicao  INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE caracterizacao_grupo (
  id                      int NOT NULL AUTO_INCREMENT,
  id_caracterizacao_tipo  INt NOT NULL,
  nome                    varchar(100) NOT NULL,
  ordem_exibicao          INT NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS caracterizacao (
  id                      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_caracterizacao_tipo  INT UNSIGNED NOT NULL,
  id_caracterizacao_grupo INT UNSIGNED NOT NULL,
  nome                    VARCHAR(140) NOT NULL,   
  descricao               LONGTEXT NULL,
  observacoes             LONGTEXT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS caracterizacao_grupo_custo(
  id                      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_caracterizacao  INT UNSIGNED NOT NULL,
  id_caracterizacao_grupo INT UNSIGNED NOT NULL,
  id_localidade           INT UNSIGNED NULL,
  custo                   INT NOT NULL,
  
  is_inicial              TINYINT(1) NOT NULL DEFAULT 0,   
  is_muito_rara           TINYINT(1) NOT NULL DEFAULT 0,   
  permite_durante_jogo    TINYINT(1) NOT NULL DEFAULT 1,   

  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO caracterizacao_tipo (nome, descricao, ordem_exibicao) VALUES
('Caracterizações de Fé', 'A fé é o combustível que move o mundo de Tagmar. A crença nos 13 deuses do panteão tagmariano é hoje difundida em todo o continente. A crença e as evidências sobre a presença divina no mundo é alicerçada nos milagres sacerdotais e nos objetos mágicos abastecidos pelo poder dos deuses.', 1),
('Caracterizações Físicas', 'A estrutura corporal, a saúde, o tempo de reação e a resistência são fatores afetados pelas caracterizações físicas, bem como alguns dons místicos que afetam o corpo do personagem.', 2),
('Caracterizações de Histórico', 'Englobam fatores externos ao personagem, que ele adquiriu de outras pessoas ou herdou por razões desconhecidas. Cabem aqui também algumas caracterizações de cunho sobrenatural.', 3),
('Caracterizações de Origem', 'A divisão política atual de Tagmar começou a ser traçada há séculos atrás, após o grande cataclismo. As misturas dos povos invasores com os povos que já habitavam as regiões conferiram características únicas a cada um dos reinos de Tagmar.', 4),
('Caracterizações de Personalidade', 'A personalidade de um personagem é definida por comportamentos complexos que tem influência de sua vida pregressa, de sua índole e de sua saúde física e mental.', 5),
('Caracterizações Sociais', 'As caracterizações sociais afetam não apenas como outros indivíduos veem o personagem, mas também qual o lugar dele no mundo. Este grupo apresenta caracterizações como patrono e contatos.', 6);


-- Caracterizações de Fé (ID 1)
INSERT INTO caracterizacao_grupo (id_caracterizacao_tipo, nome, ordem_exibicao) VALUES
(1, 'Fé', 1),
(1, 'Relação com os deuses', 2);
-- Caracterizações Físicas (ID 2)
INSERT INTO caracterizacao_grupo (id_caracterizacao_tipo, nome, ordem_exibicao) VALUES
(2, 'Alergia', 1),
(2, 'Beleza', 2),
(2, 'Característica única', 3),
(2, 'Deficiência', 4),
(2, 'Dependência', 5),
(2, 'Estatura', 6),
(2, 'Estrutura corporal', 7),
(2, 'Potencial', 8),
(2, 'Resistência à dor', 9),
(2, 'Saúde', 10),
(2, 'Sensibilidade a venenos', 11),
(2, 'Sono', 12);
-- Caracterizações de Histórico (ID 3)
INSERT INTO caracterizacao_grupo (id_caracterizacao_tipo, nome, ordem_exibicao) VALUES
(3, 'Dependente de Habitat', 1),
(3, 'Herança', 2),
(3, 'Memória', 3),
(3, 'Objeto Amaldiçoado', 4),
(3, 'Ressonância Energética', 5),
(3, 'Sexto Sentido', 6),
(3, 'Sorte', 7),
(3, 'Talento', 8),
(3, 'Treinamento', 9);
-- Caracterizações de Origem (ID 4)
INSERT INTO caracterizacao_grupo (id_caracterizacao_tipo, nome, ordem_exibicao) VALUES
(4, 'Abadom', 1),
(4, 'Acordo', 2),
(4, 'Âmien', 3),
(4, 'Azanti', 4),
(4, 'Calco', 5),
(4, 'Cidades-Estado', 6),
(4, 'Conti', 7),
(4, 'Dantsem', 8),
(4, 'Eredra', 9),
(4, 'Filanti', 10),
(4, 'Levânia', 11),
(4, 'Ludgrim', 12),
(4, 'Luna', 13),
(4, 'Marana', 14),
(4, 'Plana', 15),
(4, 'Portis', 16),
(4, 'Porto Livre', 17),
(4, 'Verrogar', 18);
-- Caracterizações de Personalidade (ID 5)
INSERT INTO caracterizacao_grupo (id_caracterizacao_tipo, nome, ordem_exibicao) VALUES
(5, 'Atenção', 1),
(5, 'Auto-representação', 2),
(5, 'Código de conduta', 3),
(5, 'Compulsão', 4),
(5, 'Coragem', 5),
(5, 'Fobia', 6),
(5, 'Humor', 7),
(5, 'Mentalidade', 8),
(5, 'Noção', 9),
(5, 'Ódio', 10),
(5, 'Outras caracterizações', 11),
(5, 'Perfeccionista', 12),
(5, 'Temperamento', 13),
(5, 'Visão de mundo', 14);
-- Caracterizações Sociais (ID 6)
INSERT INTO caracterizacao_grupo (id_caracterizacao_tipo, nome, ordem_exibicao) VALUES
(6, 'Aliança', 1),
(6, 'Classe social', 2),
(6, 'Contatos', 3),
(6, 'Dívida', 4),
(6, 'Fama', 5),
(6, 'Honra do clã/mestre', 6),
(6, 'Patrono', 7);


-- Caracterizações de Fé (Tipo 1)
-- GRUPO: FÈ
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
(1, 1, 'Ateu','Não crê nos deuses e rejeita milagres. Deuses impedem que qualquer magia divina beneficie o personagem (curas, bênçãos, etc). Impede qualquer outra caracterização de fé.', 'Socialmente perigoso: pode ser confundido com demonista e perseguido em reinos como Levânia e Verrogar.'),
(1, 1, 'Fiel', 'Dedicação profunda a uma divindade. Recupera +1 EF em magias de cura de sacerdotes da mesma divindade. Em curas de EH, recupera +1 ponto por nível da magia.', 'Exige seguir rigorosamente as doutrinas do deus escolhido. Pode ser comprado mais de uma vez para deuses diferentes.'),
-- GRUPO: RELAÇÃO COM OS DEUSES
(1, 2, 'Ateu','Não crê nos deuses e rejeita milagres. Deuses impedem que qualquer magia divina beneficie o personagem (curas, bênçãos, etc). Impede qualquer outra caracterização de fé.', 'Socialmente perigoso: pode ser confundido com demonista e perseguido em reinos como Levânia e Verrogar.'),
(1, 2, 'Deus Patrono/Deusa Matrona','+4 em testes de Primeira Impressão contra sacerdotes do patrono. 1x por aventura, o Mestre pode conceder uma graça divina simples em situação difícil.', 'O custo é por divindade. Exige viver as doutrinas como um sacerdote. Perda de benefícios exige missão sagrada para perdão.'),
(1, 2, 'Perseguição Divina','Um Deus tem antipatia pelo personagem. 1x por sessão (em momento crítico), o personagem falha automaticamente em algo ligado à área do deus ou sofre um revés ambiental.', 'Sacerdotes desta divindade sentem animosidade instintiva contra o personagem.'),
(1, 2, 'Proteção dos Deuses','Intervenção salvadora quando a vida está em risco (EF abaixo de zero ou Crítico). Permite usar EH para absorver 100% do dano de críticos sem sofrer efeito especial.', 'Funciona 1x ao dia. Requer que o personagem tenha EH maior que 0 no momento do uso.');

-- Caracterizações Físicas (Tipo 2)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- ALERGIA
(2, 3, 'Comum', 'Contato causa -3 colunas em tarefas físicas e RF por 4h. Ingestão pode incapacitar por 4 rodadas.', 'Aparece em quase todas as sessões.'),
(2, 3, 'Incomum', 'Contato causa -2 colunas em tarefas físicas e RF por 4h. Ingestão pode incapacitar por 4 rodadas.', 'Aparece em 2 sessões.'),
(2, 3, 'raro', 'Contato causa -1 colunas em tarefas físicas e RF por 4h. Ingestão pode incapacitar por 4 rodadas.', 'Aparece em 4 sessões.'),
-- BELEZA
(2, 4, 'Deslumbrante', 'O personagem não é apenas belo, ele é um modelo de beleza exemplar para sua espécie. Outras pessoas o percebem com destaque na multidão e podem acabar se distraindo por prestar atenção nele. Pessoas atraídas de mesma raça ou raça parecida podem acabar se apaixonando à primeira vista.', 'Ele recebe -1 nível de dificuldade em testes de impressão até mesmo contra indivíduos de raças muito diferentes, como um dragão analisando um humano. Ele também testa persuasão e empatia com +2 colunas.'),
(2, 4, 'Horroroso', 'O personagem não é apenas feio, ele é uma abominação que em nada se parece com os outros de sua espécie. Outras pessoas o percebem com destaque na multidão e podem acabar se assustando e se afastando. É inevitável que surjam conversas paralelas sobre o quanto ele é horroroso, desprezível e seria melhor que não tivesse nascido. A pena será um sentimento comum.', 'Ele recebe -1 nível de dificuldade em testes de impressão até mesmo contra indivíduos de raças muito diferentes, como um dragão analisando um humano. Ele também testa persuasão e empatia com -2 colunas.'),
(2, 4, 'Muito Belo', 'A beleza do personagem chama a atenção e o destaca em meio a grupos de ambos os sexos.', 'O personagem recebe um bônus de +1 nível de dificuldade em testes de impressão contra indivíduos de raças que conseguem compreender a beleza na raça do personagem. Elfos, anões, humanos, pequeninos e orcos conseguem compreender a beleza e a feiura entre suas raças.'),
(2, 4, 'Muito Feio', 'A feiura do personagem chama a atenção e o destaca em meio a grupos de ambos os sexos.', 'O personagem recebe uma penalidade de -1 nível de dificuldade em testes de impressão contra indivíduos de raças que conseguem compreender a beleza na raça do personagem. Elfos, anões, humanos, pequeninos e orcos conseguem compreender a beleza e a feiura entre suas raças.'),
-- CARACTERÍSTICAS ÚNICAS
(2, 5, 'Aspecto Inofensivo','O personagem não aparenta ser uma ameaça física ou hostil.','Custo: 1. +2 colunas em Persuasão. Iniciativa automática no 1º turno se atacar por surpresa (1x por inimigo).'),
(2, 5, 'Marca Exótica','Traço físico raro (cabelo exótico, olhos de cores diferentes, seis dedos, etc).','Custo: 1. Concede notoriedade, mas torna o personagem extremamente fácil de identificar.'),
(2, 5, 'Pele Cadavérica','A pele não se regenera esteticamente, mantendo marcas de todos os ferimentos passados.','Custo: -1. Recuperação de EF pode ser até 2x mais lenta conforme a natureza do dano.'),
-- DEFICIÊNCIAS
(2, 6, 'Caolho', 'O personagem tem dificuldade de determinar profundidade e recebe -3 colunas de penalidades em ataques a distância.', 'Ele também sofre -3 colunas de resolução de penalidade em tarefas de percepção ou habilidades vinculadas a este atributo relacionadas a visão que ocorram do lado de seu olho cego.'),
(2, 6, 'Hipermetropia', 'O personagem vê de forma desfocada a curta distância e por isso recebe ajustes negativos', '-6 colunas em ações combativas e testes visuais à longa distância.'),
(2, 6, 'Maneta', 'O personagem não tem uma das mãos. Ele não tem como usar escudos no braço sem a mão e não pode usar armas que para ele estejam restringidas ao uso de duas mãos.', 'É possível se adaptar um gancho ou um punhal no que restou do braço ferido, mas nenhuma outra arma pode ser adaptada.'),
(2, 6, 'Míope', 'O personagem vê de forma desfocada a longa distância e por isso recebe ajustes negativos', '-6 colunas em ações combativas e testes visuais à longa distância.'),
(2, 6, 'Perneta', 'O personagem perdeu parte da perna, abaixo do joelho, sendo obrigado a usar uma “perna de pau” para andar. A sua VB máxima é reduzida à metade.', 'Além disso, ele recebe um ajuste de +1 nível de dificuldade de dificuldade para qualquer ação que dependa das duas pernas, como corridas, saltos, etc.'),
(2, 6, 'Problemas na fala', 'O personagem tem uma deficiência grave na fala devido ao corte de sua língua, ou a um problema nas cordas vocais.', '+1 nível de dificuldade em testes que envolvam fala e itens mágicos. Incapaz de lançar magias rituais. Exige teste de Línguas para ser compreendido por outros.'),
-- DEPENDENCIA
(2, 7, 'Leve','Vício físico em substâncias de baixa intensidade (Tipo 1 ou 2).','Custo: -2. Força de Ataque da droga: 8. Sujeito a regras de abstinência.'),
(2, 7, 'Pesada','Vício físico em substâncias potentes (Tipo 3 ou 4).','Custo: -3. Força de Ataque da droga: 16. Sujeito a regras de abstinência.'),
-- ESTATURA 
(2, 8, 'Baixo', 'Pode usar armas de categorias superiores com uma mão. Humanos usam armas de 2 mãos com apenas uma.', '+1 nível de dificuldade em testes de Esconder-se.'),
(2, 8, 'Gigante', 'Pode usar armas de categorias superiores com uma mão. Humanos usam armas de 2 mãos com apenas uma.', '+1 nível de dificuldade em testes de Esconder-se.'),
(2, 8, 'Grande', 'Pode usar armas de categorias superiores com uma mão. Humanos usam armas de 2 mãos com apenas uma.', '+1 nível de dificuldade em testes de Esconder-se.'),
(2, 8, 'Nanico', 'Restrições severas de armas: humanos/meio-elfos usam como elfos; elfos como anões; anões como pequeninos. Pequeninos não usam armas de 2 mãos.', 'Inclui todas as penalidades de Baixo.'),
-- ESTRUTURA CORPORAL
(2, 9, 'Atlético', 'Personagens atléticos são esguios, rápidos e flexíveis. Possui Agilidade 2 como pré requisito.', 'Agilidade 2 (Req). +1/4 VB básica. +2 colunas em Furtividade, Acrobacia, Montar e Escapar (flexibilidade).'),
(2, 9, 'Magro', 'O personagem é muito magro e leve para os padrões de sua raça, não importa o quanto coma (embora o natural é que seja menos do que o normal).', 'Força e Físico 1 (Req). +1/4 de Energia Física (EF) básica da raça.'),
(2, 9, 'Obeso', 'O personagem é muito gordo. Sua VB básica é apenas ¾ do padrão para sua raça.', 'VB reduzida para 3/4 do padrão. +1 nível de dificuldade em todas as habilidades de Manobra.'),
(2, 9, 'Robusto', 'Personagens robustos são grandes e musculosos.', 'Força e Físico 1 (Req). +1/4 de Energia Física (EF) básica da raça.'),
-- POTENCIAL
(2, 10, 'Hábil', 'O personagem realiza façanhas com facilidade e possui maior aptidão natural.', 'Custo: 3. Atributos: 16 pts. Limite racial: Modificador +4.'),
(2, 10, 'Inábil', 'O personagem tem uma aptidão levemente abaixo da média.', 'Custo: -2. Atributos: 14 pts. Limite racial: Modificador +4.'),
(2, 10, 'Primazia', 'O personagem possui um potencial extraordinário, rompendo limites naturais.', 'Custo: 6. Atributos: 17 pts. Um atributo pode ter Limite Racial +5.'),
(2, 10, 'Mediocridade', 'O personagem possui um potencial limitado, exigindo mais esforço para alcançar objetivos.', 'Custo: -4. Atributos: 13 pts. Limite racial: Modificador +3.'),
-- Resistência à Dor
(2, 11, 'Hiperalgesia', 'O personagem tem uma alta sensibilidade à dor. Ele não é capaz de comprar níveis na técnica de combate Resistência à Dor e todos os testes para resistir a qualquer tipo de dor tem +1 nível de dificuldade.', 'Proibido comprar técnica Resistência à Dor. +1 nível de dificuldade em testes para resistir à dor.'),
(2, 11, 'Resistência Extrema', 'Imunidade a efeitos de dor descritos em acertos críticos ou magias.', 'O dano do crítico ocorre, mas a penalidade de dor não.'),
-- SAÚDE
(2, 12, 'Corpo Fechado', 'Resistência física lendária. Quase imune aos efeitos comuns de doenças e debilidades.', 'Custo: 3. RF = (Estágio + Físico) + 10.'),
(2, 12, 'Saúde deficiente', 'Resistência abaixo da média contra enfermidades e toxinas.', 'Custo: -1. RF = (Estágio + Físico) - 4.'),
(2, 12, 'Saúde muito deficiente', 'Constituição extremamente frágil. O personagem perde EF ao falhar em testes de RF por doenças.', 'Custo: -3. RF = (Estágio + Físico) - 5. Morte ocorre com -12 de EF.'),
(2, 12, 'Saúde de ferro', 'O personagem raramente adoece e possui uma recuperação impressionante.', 'Custo: 1. RF = (Estágio + Físico) + 4.'),
-- VENENOS (Exemplo de Fraqueza/Imunidade)
(2, 13, 'Fraqueza I', 'Qualquer tipo de veneno age com +8 de Força de Ataque.', 'Custo: -8.'),
(2, 13, 'Fraqueza II', 'Venenos de Tipo II a V agem com +8 de Força de Ataque.', 'Custo: -6.'),
(2, 13, 'Fraqueza III', 'Venenos Tipos III, IV e V agem com +8 de Força de Ataque.', 'Custo: -4.'),
(2, 13, 'Fraqueza IV', 'Venenos Tipos IV e V agem com +8 de Força de Ataque.', 'Custo: -2.'),
(2, 13, 'Fraqueza V', 'Venenos Tipo V agem com +8 de Força de Ataque.', 'Custo: -1.'),
(2, 13, 'Imunidade I', 'Imunidade total a venenos do Tipo I.', 'Custo: 1.'),
(2, 13, 'Imunidade II', 'Imunidade total a venenos dos Tipos I e II.', 'Custo: 2.'),
(2, 13, 'Imunidade III', 'Imunidade total a venenos dos Tipos I, II e III.', 'Custo: 4.'),
(2, 13, 'Imunidade IV', 'Imunidade total a venenos dos Tipos I, II, III e IV.', 'Custo: 6.'),
(2, 13, 'Imunidade V', 'Imunidade total a todos os tipos de venenos (I a V).', 'Custo: 8.'),
-- SONO
(2, 14, 'Sono Consciente','Percepção sobrenatural durante o repouso. O jogador escolhe quando acordar.',  'Custo: 6. Teste desnecessário para despertar. Mantém consciência de cheiros, sons e toques enquanto dorme.'),
(2, 14, 'Sono Leve','O personagem acorda com facilidade, dificultando aproximações furtivas.',  'Custo: 1. -1 Nv. Dif. para acordar. Terceiros recebem +1 Nv. Dif. em Furtividade próximos ao personagem.'),
(2, 14, 'Sono Pesado','Dificuldade em despertar com ruídos ou solavancos.',  'Custo: -2. +1 Nv. Dif. para acordar. +1 Nv. Dif. em testes perceptivos por 1 rodada após despertar.'),
(2, 14, 'Sonolento','Extrema dificuldade em acordar e manter-se alerta após despertar.',  'Custo: -4. +1 Nv. Dif. para acordar. +1 Nv. Dif. em testes perceptivos por 10 min após despertar. Teste de Físico para não dormir em guarda.');

-- Histórico (Tipo 3)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- DEPENDENTE DE HABITAT
(3, 15, 'Comum','Elo com ambientes genéricos e fáceis de encontrar.','Custo: -1. Ex: Longe de cidades. Perda de 1 EF/dia após dias > RF.'),
(3, 15, 'Amplo','Elo com grandes biomas naturais.','Custo: -2. Ex: Florestas. Perda de 1 EF/dia após dias > RF.'),
(3, 15, 'Restrito','Elo com ambientes específicos que limitam a locomoção terrestre.','Custo: -3. Ex: Dentro d água. Perda de 1 EF/dia após dias > RF.'),
(3, 15, 'Endêmico','Elo vital com um local geográfico único e insubstituível.','Custo: -5. Ex: Rio Odem. Perda de 1 EF/dia após dias > RF.'),
-- HERANÇA
(3, 16, 'Herança Mínima','Item ou propriedade de pequeno valor sentimental e financeiro.','Custo: 1. Valor: 4 m.o. ou 2 moedas de ouro em espécie.'),
(3, 16, 'Herança Pequena','Bens ou moedas herdados de parentes ou amigos.','Custo: 2. Valor: 12 m.o. ou 6 moedas de ouro em espécie.'),
(3, 16, 'Herança Média','Patrimônio relevante, como pequenas propriedades ou quantia considerável.','Custo: 3. Valor: 50 m.o. ou 25 moedas de ouro em espécie.'),
(3, 16, 'Herança Grande','Propriedades de valor elevado com documentação autenticada.','Custo: 4. Valor: 100 m.o. ou 50 moedas de ouro em espécie.'),
(3, 16, 'Herança Enorme','Vasta fortuna em propriedades e ouro.','Custo: 5. Valor: 200 m.o. mais 50 moedas de ouro em espécie.'),
(3, 16, 'Item Mágico Menor','Objeto místico de poder iniciante (Arma +2, Defesa +1 ou Magia Nvl 2).','Custo: 3. Requer descrição detalhada da origem do item.'),
(3, 16, 'Item Mágico Maior','Artefato de poder intermediário (Arma +3, Defesa +2 ou Magia Nvl 5).','Custo: 5. Requer descrição detalhada da origem do item.'),
-- MEMÓRIA
(3, 17, 'Memória Senil','Raciocínio e memória severamente debilitados.','Custo: -3. -4 colunas em testes de Intelecto/Memória. -2 em Iniciativa. Esquece nomes com facilidade.'),
(3, 17, 'Memória Fraca','Dificuldade em reter informações que não sejam de interesse imediato.','Custo: -1. -2 colunas em testes de Intelecto/Memória e habilidades baseadas em Intelecto.'),
(3, 17, 'Memória Eidética','Capacidade fotográfica de recordar cenas e detalhes.','Custo: 1. Uma vez por sessão, pode reivindicar sucesso automático para lembrar de algo.'),
-- OBJETO AMALDIÇOADO
(3, 18, 'Objeto Dominante','Item mágico de natureza maligna constante.','Custo: -3. Prejuízos ocorrem em todas as sessões. Vínculo obsessivo com o item.'),
(3, 18, 'Objeto Prejudicial','Item mágico cuja maldição se manifesta com frequência média.','Custo: -2. Prejuízos ocorrem a cada 2 sessões. Vínculo obsessivo com o item.'),
(3, 18, 'Objeto Inoportuno','Item mágico com benefícios pequenos e maldição de baixa frequência.','Custo: -1. Prejuízos ocorrem a cada 4 sessões. Vínculo obsessivo com o item.'),
-- RESSONÂNCIA 
(3, 19, 'Ressonância Energética','Capacidade arcana de prolongar a duração de encantos através de gasto extra de energia.','Custo: 5. 1x por sessão, dobra o tempo de um encanto pelo dobro do custo de Karma.'),
-- SEXTO SENTIDO
(3, 20, 'Reação ao Perigo','Capacidade sobrenatural de antecipar eventos hostis ou perigos iminentes.','Custo: 5. Evita surpresa completa (considera-se surpresa parcial). Não protege contra atos impulsivos. Não permite avisar aliados a tempo.'),
-- SORTE / AZAR
(3, 21, 'Extremamente Azarado','O personagem atrai infortúnios de forma quase magnética e espetacular.','Custo: -3. 50% de chance de ser alvo em sorteios negativos. 1 evento de azar por aventura definido pelo Mestre.'),
(3, 21, 'Azarado','Pequenos contratempos perseguem o personagem no dia a dia.','Custo: -1. Dobro de chance de ser alvo em sorteios negativos. 1 evento de azar por aventura definido pelo Mestre.'),
(3, 21, 'Sortudo','O destino parece conspirar a favor do personagem nos momentos críticos.','Custo: 3. 1x por sessão: pode evitar sorteio negativo ou redirecionar ataque inicial. Chances de benefícios aleatórios (Mestre).'),
-- TALENTO
(3, 22, 'Mestre de Armas','Aptidão marcial inata que facilita o domínio de novos armamentos.','Custo: 5. Ganha +1 ponto em Grupos de Armas por nível (estágio).'),
(3, 22, 'Especialista Nato','Facilidade em aprender e aprimorar perícias e capacidades diversas.','Custo: 3. Ganha +2 pontos de Habilidade por nível (estágio).'),
(3, 22, 'Genio Arcano','Conexão profunda com o fluxo místico, facilitando o aprendizado arcano.','Custo: 4. Ganha +1 ponto de aquisição de Magia por nível (estágio). Apenas para misticos.'),
(3, 22, 'Genio Militar','Mestre em manobras e táticas avançadas de enfrentamento.','Custo: 4. Ganha +1 ponto de aquisição de Técnicas de Combate por nível (estágio).'),
-- TREINAMENTO
(3, 23, 'Treinamento Pouco Ortodoxo (!!)','Educação fora dos padrões tradicionais da profissão, permitindo uma habilidade aprimorada única.','Custo: 2. Permite trocar uma habilidade padrão por uma nova aprimorada (desde que não seja de um grupo penalizado).');

-- Origem (Tipo 4)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
(4, 24, 'Conhecedor de Dragões', 'Conhecimento extra sobre o comportamento e poderes de dragões.', 'Custo: 1. +2 colunas em Sabedoria/Seguir Trilhas contra dragões.'),
(4, 24, 'Escambista', 'Talento para trocas comerciais diretas sem uso de moeda.', 'Custo: 1. +2 colunas em tarefas de troca de mercadorias.'),
(4, 24, 'Sobrevivente', 'Hábito diário de lutar pela vida em ambientes hostis.', 'Custo: 1. +2 colunas em todos os testes de Sobrevivência.'),
(4, 24, 'Trauma de Dragões', 'Medo ancestral enraizado que prejudica o combate.', 'Custo: -1. -2 colunas em ataques contra dragões.'),
-- ACORDO
(4, 25, 'Carrancudo', 'Trabalhador incansável, porém desconfiado e pouco sociável.', 'Custo: -1. +1 coluna em testes Profissionais; -2 colunas em Empatia/Etiqueta.'),
(4, 25, 'Duro de Negócio', 'Desconfiança nata que protege contra golpes comerciais.', 'Custo: 1. +4 colunas em Negociação (compra/venda).'),
(4, 25, 'Minerador Nato', 'Conhecimento profundo de lapidação, jóias e metais.', 'Custo: 1. +2 colunas em Trabalho em Metais e Sabedoria (Metais).'),
(4, 25, 'Muito Desconfiado', '', 'Custo: -1. Carisma máximo 2. Não confia em estranhos.'),
-- ÂMIEM
(4, 26, 'Bênção de Palier', 'Aura ampliada que favorece a realização de magias.', 'Custo: 2. +1 ponto de Karma a cada estágio ímpar.'),
(4, 26, 'Mateiro', 'Profundo conhecimento das florestas élficas.', 'Custo: 1. +2 colunas em Navegação/Sobrevivência em florestas.'),
(4, 26, 'Pouco Adaptável', 'Dificuldade em aceitar ou elogiar culturas não élficas.', 'Custo: -1. Teste de Persuasão difícil para esconder desdém por cidades estrangeiras.'),
(4, 26, 'Prestígio em Âmiem', 'Reconhecimento oficial que permite trânsito livre no reino.', 'Custo: 1. Pode entrar com convidados no reino sem autorização prévia.'),
(4, 26, 'Tradição Élfica', 'Os amienses são alegres, festivos, orgulhosos de suas conquistas e muito desconfiados de não elfos', 'Custo: 1. + 4 colunas em Teste de Sabedoria élfica.'),
-- AZANTI
(4, 27, 'Inconformado', 'Rebelde contra o protetorado de Filanti.', 'Custo: -1. -1 grau em testes de 1ª impressão com autoridades azantianas.'),
(4, 27, 'Preparado para a Guerra', 'Treinamento militar obrigatório na reserva.', 'Custo: 1. +1 ponto em grupos de armas. Sujeito a convocação (pena de morte se negar).'),
(4, 27, 'Simpatias contra Magias', 'Rituais populares para afastar a "bruxaria".', 'Custo: 2. +1 ponto em RM (Resistência Mística).'),
-- CALCO
(4, 28, 'Educação Refinada', 'Conceitos de etiqueta e cultura superior.', 'Custo: 1. +1 coluna em testes do subgrupo Conhecimento.'),
(4, 28, 'Multicultural', 'Costume em lidar com diversas raças e nações.', 'Custo: 1. +4 colunas em testes de Etiqueta.'),
(4, 28, 'Teórico', 'Falta de experiência prática em conflitos reais.', 'Custo: -1. -4 colunas em Operações de Cerco e Liderança Militar.'),
-- CIDADES-ESTADO
(4, 29, 'Bravo Piense', 'Cultura belicosa e militarista.', 'Custo: 2. +2 colunas em Operações de Cerco. +1 no Ataque com arma treinada.'),
(4, 29, 'Carpintaria Torbelina', 'Tradição em construção naval e madeira.', 'Custo: 1. +2 colunas em Carpintaria e Arte (Desenhos de barcos).'),
(4, 29, 'Enderiano Abastado', 'Cidadão de cidade próspera.', 'Custo: 2. +1/4 de dinheiro inicial e possui abrigo em Ender.'),
(4, 29, 'Estrangeirismos', 'Influência de marinheiros e idiomas exóticos.', 'Custo: 1. +4 colunas em Idiomas (compreensão).'),
(4, 29, 'Mercador Quizano', 'Talento para comércio e artesanato.', 'Custo: 1. +2 colunas em Negociação e Trabalhos Manuais.'),
(4, 29, 'Revoltoso Estepano', 'Sobrevivência sob opressão oligárquica.', 'Custo: 1. +1 coluna em Ações Furtivas.'),
-- CONTI
(4, 30, 'Homem do Mar', 'Tradição marinheira contêsa.', 'Custo: 1. +2 colunas em Náutica e Sabedoria de Águas.'),
(4, 30, 'Malandragem Mulina', 'Vivência em tavernas e portos populosos.', 'Custo: 1. +1 coluna em Jogatina, Enganação e Furtar Objetos.'),
(4, 30, 'Mateiro', 'Familiaridade com as florestas do sul.', 'Custo: 1. +2 colunas em Navegação e Sobrevivência em Florestas.'),
(4, 30, 'Mesquinho', 'Prioriza o lucro sobre a honra.', 'Custo: -1. -1 grau em 1ª impressão se o temperamento for conhecido.'),
-- DANTSEM
(4, 31, 'Cavaleiro de Criaturas', 'Domínio de montarias místicas.', 'Custo: 1. +4 colunas em Montar Animais (monstros/místicos).'),
(4, 31, 'Desapropriado', 'Perdeu o lar para Verrogar.', 'Custo: -1. -1 grau de penalidade social contra verrogaris.'),
(4, 31, 'Mestre das Feras', 'Treinamento militar com feras de guerra.', 'Custo: 1. +4 colunas em Lidar com Animais.'),
(4, 31, 'Multicultural', 'Lida bem com diferentes raças e nacionalidades', 'Custo: 1. +4 colunas em Testes de Etiquetas.'),
(4, 31, 'Treinamento Precário', 'Falta de academias estruturadas antes da guerra.', 'Custo: -1. -1 ponto em Técnicas de Combate.'),
-- EREDRA
(4, 32, 'Experiente em Apostas', 'Familiaridade com lutas de arenas e gladiadores.', 'Custo: 1. +4 colunas em Jogatina (arenas) e +2 para identificar estado de lutadores.'),
(4, 32, 'Ligado à Terra', 'Conhecimento de agricultura e animais domésticos.', 'Custo: 1. +4 colunas em Agricultura e +2 em Lidar com Animais.'),
(4, 32, 'Povo de Fé', 'Profunda religiosidade eredri.', 'Custo: 1. +4 colunas em Religião (exceto demônios).'),
(4, 32, 'Rebelde', 'Informante contra a ocupação Volim.', 'Custo: 1. +2 colunas em Enganação e Códigos.'),
(4, 32, 'Supersticioso', 'Medo excessivo da fúria divina.', 'Custo: -1. Deve cumprir rituais diários para evitar fúria dos deuses.'),
-- FILANTI
(4, 33, 'Formalidade Filantiana', 'Etiqueta rigorosa e conhecimento de heráldica.', 'Custo: 1. +2 colunas em Etiqueta (+4 para nobreza/heráldica).'),
(4, 33, 'Histórias de Gironde', 'Folclore sobre criaturas da floresta.', 'Custo: 1. +2 colunas em Carpintaria/Sabedoria (madeiras/criaturas).'),
(4, 33, 'Simpatias contra Magias', 'Repúdio cultural à magia arcana.', 'Custo: 2. +1 ponto em RM (Resistência Mística).'),
-- LEVÂNIA
(4, 34, 'Artesão Brual', 'Talento herdado do clã Brual.', 'Custo: 1. +2 colunas em Trabalhos Manuais e Artes Visuais.'),
(4, 34, 'Beduíno', 'Sobrevivência em desertos extremos.', 'Custo: 1. +4 colunas em Sobrevivência (Deserto).'),
(4, 34, 'Justiça Implacável', 'Costume com confissões e punições severas.', 'Custo: 1. +4 colunas em Extrair Informação.'),
(4, 34, 'Mácula Bankdi', 'Traços do clã demonista Bankdi.', 'Custo: -1. -1 grau em 1ª impressão. Risco de morte se reconhecido fora de Levânia.'),
-- LUDGRIM
(4, 35, 'Bilíngue', 'Domínio de idiomas humanos e élficos.', 'Custo: 1. Idiomas iniciais: Malês, Lud e Élfico.'),
(4, 35, 'Mateiro', 'Familiaridade com as florestas naturais.', 'Custo: 1. +2 colunas em Navegação e Sobrevivência em Florestas.'),
(4, 35, 'Sempre Alerta', 'Vigilância constante típica do reino.', 'Custo: 1. +2 em Usar os Sentidos e Navegação.'),
(4, 35, 'Tolerância', 'Valorização das individualidades raciais.', 'Custo: 1. +4 colunas em Empatia.'),
-- LUNA
(4, 36, 'Artista Lunense', 'Herança artística de entretenimento e acrobacia.', 'Custo: 2. +2 colunas em Arte, Acrobacia e Malabarismo.'),
(4, 36, 'Assolado pela Peste', 'Sequelas físicas da peste do reino.', 'Custo: -1. -1 em Resistência Física (RF).'),
(4, 36, 'Medicina Lunense', 'Avanço médico forçado pelas pragas.', 'Custo: 1. +4 colunas em Medicina (Cura).'),
(4, 36, 'Sob a Lâmina da Navalha', 'Mineração e sobrevivência em montanhas hostis.', 'Custo: 1. +2 colunas em Trabalhos em Metais e Sobrevivência (Montanha).'),
-- MARANA
(4, 37, 'Culinária Pequenina', 'Tradição gastronômica dos pequeninos.', 'Custo: 1. +2 em Culinária; +4 colunas em 1ª impressão com quem provar a comida.'),
(4, 37, 'Desiludido', 'Tristeza pela militarização sob o Tirano.', 'Custo: -1. -2 colunas em Liderança e Sabedoria.'),
(4, 37, 'Educação Refinada', 'Conceitos de etiqueta e cultura superior.', 'Custo: 1. +1 coluna em testes do subgrupo Conhecimento.'),
(4, 37, 'Retórica Maranense', 'Diplomacia e paciência de Selimon/Palier.', 'Custo: 1. +2 colunas em Persuasão e Liderança (eloquência).'),
-- PLANA
(4, 38, 'Comerciante Nato', 'Aprendizado comercial de Cambu.', 'Custo: 1. +4 colunas em Negociação.'),
(4, 38, 'Defensor Representante', 'Habilidade em convencer e defender pessoas.', 'Custo: 1. +4 colunas em Persuasão.'),
(4, 38, 'Negociante sem Fronteiras', 'Viajou com caravanas por muitos reinos.', 'Custo: 2. Conhece 4 idiomas humanos extras além do Malês.'),
(4, 38, 'Trapaceiro', 'Aprendeu com os comerciantes desonestos.', 'Custo: 1. +4 colunas em Enganação.'),
-- PORTIS
(4, 39, 'Conhecimento Histórico', 'Familiaridade com artefatos de 2º Ciclo.', 'Custo: 1. +4 colunas em Sabedoria (Runa).'),
(4, 39, 'Magia Runense', 'Influência da capital mística Runa.', 'Custo: 1. +2 colunas em Misticismo e Sensitividade.'),
(4, 39, 'Supervaloriza Magos', 'Criado para ver magos como seres superiores.', 'Custo: -1. Acredita em magos; -4 colunas em Empatia contra mentiras de magos.'),
(4, 39, 'Tradição Portiana', 'Respeito e admiração pela magia.', 'Custo: 2. +2 colunas em reconhecer magias/lendas. 1 em 20 chance de achar pergaminho perdido.'),
-- PORTO LIVRE
(4, 40, 'Bandidagem no Sangue', 'Técnicas de rua para furtos.', 'Custo: 1. +2 em Furtar Objetos e Destrancar Fechaduras.'),
(4, 40, 'Boêmia Bandida', 'Filosofia de pirataria e briga de taverna.', 'Custo: 1. +2 colunas em Jogatina; +1 em Combate Desarmado.'),
(4, 40, 'Pirataria', 'Conhecimento básico naval e natação.', 'Custo: 1. +2 colunas em Natação e Náutica.'),
(4, 40, 'Procurado', 'Criminoso com recompensa em todos os reinos.', 'Custo: -2. Reconhecido em tavernas portuárias; recompensa pela cabeça.'),
-- VERROGAR
(4, 41, 'Mentalidade de Soldado', 'Disciplina cega e obediência extrema.', 'Custo: -1. -2 colunas em Liderança. Teste de Carisma difícil para questionar ordens.'),
(4, 41, 'Preparo para Servir', 'Exercício físico rigoroso visando o exército.', 'Custo: 1. +2 colunas em Corrida e Aplicar Esforço.'),
(4, 41, 'Tradição Belicosa', 'Discussão constante de táticas de guerra.', 'Custo: 1. +4 colunas em Operações de Cerco.'),
(4, 41, 'Treinamento Militar', 'Treinamento de elite com armas.', 'Custo: 2. +1 ponto em Técnicas de Combate.');

-- Personalidade (Tipo 5)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- ATENÇÃO (Grupo 5)
(5, 42, 'Distraído','O personagem devaneia constantemente, perdendo detalhes importantes ao seu redor.','Custo: -1. -1 coluna em Percepção. 1x por aventura: falha automática em Usar os Sentidos (escolha do Mestre).'),
(5, 42, 'Vigilante','O personagem mantém um estado de alerta constante, notando o que outros ignoram.','Custo: 1. +2 colunas de resolução em qualquer teste baseado no atributo Percepção.'),
-- AUTO-REPRESENTAÇÃO
(5, 43, 'Fanfarrão','O personagem exagera suas conquistas, atraindo atenção e desafios indesejados.','Custo: -1. -4 colunas em Persuasão com quem conhece sua fama. Difícil recusar desafios.'),
(5, 43, 'Modesto','O personagem minimiza suas habilidades, deixando que seus atos falem por si.','Custo: 1. +4 colunas em testes de Impressão ao surpreender outros ou por recomendação de aliados.'),
-- Código de Conduta
(5, 44, 'Honrado','Adesão rígida a princípios que influenciam sua interação social.','Custo: -2. Segue o código sempre, mesmo com pequenos prejuízos.'),
(5, 44, 'Palavra de Valor','O personagem segue princípios morais na maioria das situações.','Custo: -1. O descumprimento pode gerar remorso ou perda de XP.'),
(5, 44, 'Penitente','O código é restritivo e frequentemente coloca o personagem em desvantagem.','Custo: -3. Sempre adere e sofre influência negativa constante.'),
(5, 44, 'Vida pela Honra','O código é a razão de viver do personagem e dita todas as suas ações.','Custo: -4. Adesão absoluta com influência muito negativa na vida prática.'),
-- COMPULSÕES
(5, 45, 'Alcoólatra','Dependência de álcool. Bebe até a inconsciência.','Custo: -2. Teste de RF contra FA 6 para resistir. Ressaca: -2 colunas por 1 hora.'),
(5, 45, 'Arrogante','Incapaz de admitir erros ou ser humilde.','Custo: -2. -1 grau na escala de impressões. Trata inferiores com desprezo.'),
(5, 45, 'Cleptomaníaco','Impulso de roubar pelo prazer do ato, sem foco no valor.','Custo: -2. O Mestre determina quando o impulso ocorre.'),
(5, 45, 'Ganancioso','Amor excessivo ao dinheiro acima da lógica.','Custo: -1. Teste Difícil de Intelecto para recusar propinas ou dinheiro fácil.'),
(5, 45, 'Guloso','Incapaz de resistir a banquetes ou comidas requintadas.','Custo: -1. Gasta além da conta e come mesmo sob risco (ex: veneno suspeito).'),
(5, 45, 'Mentiroso','Mente compulsivamente, mesmo sem necessidade.','Custo: -1. Dificuldade em ser honesto. Verossimilhança depende de Enganação.'),
(5, 45, 'Mitomaníaco','Mente e passa a acreditar na própria mentira para compensar frustrações.','Custo: -2. Diferente do mentiroso, ele perde a noção da verdade.'),
(5, 45, 'Preguiçoso','Evita qualquer esforço ou trabalho que não seja vital.','Custo: -1. -1 coluna em todos os testes do Grupo Profissional.'),
(5, 45, 'Superconfiante','Opinião exagerada sobre as próprias habilidades.','Custo: -2. Coloca-se em enrascadas por acreditar que é melhor do que realmente é.'),
(5, 45, 'Vingativo','Nunca deixa um insulto ou agressão sem resposta.','Custo: -1. Penalidades de -1 a -4 em tudo se não perseguir a vingança.'),
-- CORAGEM / COVARDIA
(5, 46, 'Bravura 1', 'Personagem audacioso.', 'Custo: 1. +1 na Força de Defesa (FD) ou +3 colunas contra medo.'),
(5, 46, 'Bravura 2', 'Grande resistência a abalos morais.', 'Custo: 2. +3 na Força de Defesa (FD) ou +6 colunas contra medo.'),
(5, 46, 'Bravura 3', 'Audácia heróica e inabalável.', 'Custo: 3. 1x por sessão: Sucesso automático em resistência a medo. Permanente: +3 FD ou +6 colunas.'),
(5, 46, 'Covardia 1', 'Pessimismo defensivo e temor pela vida.', 'Custo: -1. -3 na Força de Defesa (FD) em testes contra medo.'),
(5, 46, 'Covardia 2', 'Pânico frequente em situações de risco.', 'Custo: -2. 1x por sessão: o Mestre pode impor falha automática contra medo.'),
(5, 46, 'Covardia 3', 'Incapaz de enfrentar situações assustadoras.', 'Custo: -3. Personagem sempre fracassa automaticamente em testes contra medo.'),
-- FOBIA
(5, 47, 'Comum','Medo terrível que surge quase toda sessão de jogo.','Custo: -3. Teste Médio de Carisma. Sucesso: -3 em ações. Falha: Pânico/Fuga. Recuperação: -1 por 5 min.'),
(5, 47, 'Incomun','Medo terrível que surge raramente (uma vez a cada quatro sessões).','Custo: -1. Teste Médio de Carisma. Sucesso: -3 em ações. Falha: Pânico/Fuga. Recuperação: -1 por 5 min.'),
(5, 47, 'Ocasional','Medo terrível que surge em média a cada duas sessões.','Custo: -2. Teste Médio de Carisma. Sucesso: -3 em ações. Falha: Pânico/Fuga. Recuperação: -1 por 5 min.'),
-- HUMOR
(5, 48, 'Bem-humorado','Sempre disposto a ouvir e com facilidade para alegrar os outros.','Custo: 1. +4 colunas de resolução em todos os testes que busquem divertir.'),
(5, 48, 'Contagiante','Emana uma aura de alegria que afeta a todos ao redor.','Custo: 2. +4 colunas para divertir (inclusive para distrair). Aliados próximos recebem o mesmo bônus para divertir.'),
(5, 48, 'Mal-humorado','Reclama de tudo e tem dificuldade em expressar alegria ou humor.','Custo: -1. +1 nível de dificuldade em testes dos subgrupos Influência/Subterfúgio que busquem divertir.'),
(5, 48, 'Ranzinza','Sempre reclamando e de cara amarrada, estraga o clima de qualquer ambiente.','Custo: -2. +1 nível dificuldade para divertir. -4 colunas 1ª Impressão. Aliados na cena sofrem -2 colunas para divertir.'),
-- MENTALIDADE
(5, 49, 'Inconstante','O personagem desanima facilmente após um fracasso inicial.','Custo: -1. Penalidade de +3 níveis de dificuldade para cada nova tentativa em tarefas nas quais já tenha falhado.'),
(5, 49, 'Persistente','O personagem possui grande capacidade de insistência e foco apesar das frustrações.','Custo: 1. Penalidade reduzida: apenas +1 nível de dificuldade para cada nova tentativa em tarefas nas quais já tenha falhado.'),
-- NOÇÃO
(5, 50, 'Bom Senso','Capacidade de avaliar riscos antes de agir de forma estúpida.','Custo: 1. Permite teste de Intelecto para o Mestre advertir o jogador sobre consequências de ações imprudentes.'),
(5, 50, 'Imprudência','Propensão a agir sem pensar nas consequências.','Custo: -1. O Mestre pode assumir o controle do personagem para uma ação impulsiva uma vez por sessão de jogo.'),
-- ODIO
(5, 51, 'Comum','Ódio profundo por algo frequente ou um grupo grande (ex: Sacerdotes ou uma raça inteira).','Custo: -2. Teste Difícil de Carisma para manter o controle. Falha: -2 colunas em ações contra o alvo.'),
(5, 51, 'Incomum','Desejo de prejudicar ou humilhar um alvo ou grupo específico e pequeno (ex: Magos Elementalistas).','Custo: -1. Teste Difícil de Carisma para manter o controle. Falha: -2 colunas em ações contra o alvo.'),
-- OUTRAS
(5, 52, 'Crédulo','Falta de senso crítico, acredita facilmente no que lhe dizem.','Custo: -2. Acredita em mentiras razoáveis. Mentiras absurdas exigem teste de Empatia com -8 colunas.'),
(5, 52, 'Curioso','Necessidade irracional de investigar e tocar em tudo que é misterioso.','Custo: -2. Coloca o grupo em risco. Exige teste de Carisma para não manipular objetos perigosos.'),
(5, 52, 'Fanático','Obsessão por uma causa, religião ou objetivo único.','Custo: -2. -4 colunas em Impressão com testemunhas. Torna-se previsível e hostil se provocado.'),
(5, 52, 'Galanteador','Incapaz de resistir ao impulso de sedução.','Custo: -2. Tenta seduzir alvos atraentes independente do risco (casados, poderosos ou inimigos).'),
(5, 52, 'Impaciente','Incapaz de esperar ou seguir planos lentos.','Custo: -1. Intromete-se em tarefas alheias. Teste de Intelecto para não quebrar disfarces ou tocaias.'),
(5, 52, 'Maluco','O personagem possui pensamentos confusos e não lineares, sugerindo soluções bizarras.','Custo: -1. -4 colunas em testes de 1ª Impressão se já tiver agido na cena. Exige interpretação de ideias excêntricas.'),
-- PERFECCIONISTA
(5, 53, 'Chato','Não entrega serviços incompletos ou com imperfeições.','Custo Base: -2. Pode atrasar prazos do grupo.'),
(5, 53, 'Exigente','Nunca ignora imperfeições, mesmo que essenciais para o sucesso.','Modificador: -3 ao custo total.'),
(5, 53, 'Insuportável','Aponta defeitos alheios e tenta corrigir tudo, mesmo ofendendo outros.','Custo Base: -4. Gera hostilidade social frequente.'),
(5, 53, 'Requintado','Consegue ignorar a mania sob pressão ou necessidade extrema.','Modificador: +1 ao custo total.'),
(5, 53, 'Seletivo','Não aceita adquirir objetos ou serviços que considere imperfeitos.','Custo Base: -1. Exige o melhor material e execução.'),
-- TEMPERAMENTO
(5, 54, 'Coração de Pedra','Indiferente ao sofrimento alheio, agindo com crueldade ou apatia.','Custo: 2. +4 colunas em testes de resistência contra provocações, sedução ou manipulação emocional.'),
(5, 54, 'Coração Mole','Incapaz de suportar o sofrimento de outros, inclusive inimigos.','Custo: -2. Jamais aceita agressão gratuita ou tortura. Oferece ajuda sempre que possível.'),
(5, 54, 'Esquentado','Reage impulsivamente a qualquer provocação ou insulto.','Custo: -3. Teste Difícil de Intelecto para não perder o controle. Reação deve ser na mesma intensidade da ofensa.'),
(5, 54, 'Frieza Lógica','Controle absoluto sobre as emoções, agindo apenas pela razão.','Custo: 3. Toma decisões extremas sem testes. +4 colunas em Enganação, Jogatina e Persuasão (blefes/resistência).');,
-- VISÃO DE MUNDO
(5, 55, 'Otimista','Encara a vida de forma positiva, vendo o lado bom em tudo.','Custo: 1. +4 colunas em 1ª Impressão. 1x/sessão: concede +1 coluna para teste de qualquer personagem na cena.'),
(5, 55, 'Pessimista','Encara a vida de forma negativa e duvida de si e dos outros.','Custo: -3. -4 colunas em Liderança. 1x/aventura: pode perder 1 ação por dúvida. -2 colunas se houver falha prévia na tarefa.');

-- Caracterizações Sociais (Tipo 6)
INSERT INTO caracterizacao (id_caracterizacao_tipo, id_caracterizacao_grupo, nome, descricao, observacoes) VALUES
-- ALIANÇAS
(6, 56, 'Aliado','Personagem com ficha completa e motivações próprias.','Custo: 2. Evolui com o grupo. Exige ajuda mútua e respeito; pode abandonar o PJ se maltratado.'),
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


INSERT INTO caracterizacao_grupo_custo (id_caracterizacao, id_caracterizacao_grupo, custo, is_inicial, permite_durante_jogo)
VALUES 
-- GRUPO: (Sem Nome no insert original - ID Grupo 1)
(1, 1, 0, TRUE, FALSE), -- Ateu
(2, 1, 0, TRUE, FALSE), -- Fiel

-- GRUPO: RELAÇÃO COM OS DEUSES (ID Grupo 2)
(3, 2, 0, TRUE, FALSE), -- Ateu
(4, 2, 0, TRUE, FALSE), -- Deus Patrono/Deusa Matrona
(5, 2, 0, TRUE, FALSE), -- Perseguição Divina
(6, 2, 0, TRUE, FALSE); -- Proteção dos Deuses

INSERT INTO caracterizacao_grupo_custo (id_caracterizacao, id_caracterizacao_grupo, custo, is_inicial, permite_durante_jogo)
VALUES 
-- ALERGIA
(6, 3, 0, TRUE, FALSE), -- Comum
(7, 3, 0, TRUE, FALSE), -- Incomum
(8, 3, 0, TRUE, FALSE), -- Raro
-- BELEZA
(9, 4, 0, TRUE, FALSE), -- Deslumbrante
(10, 4, 0, TRUE, FALSE), -- Horroroso
(11, 4, 0, TRUE, FALSE), -- Muito Belo
(12, 4, 0, TRUE, FALSE), -- Muito Feio
-- CARACTERÍSTICAS ÚNICAS
(13, 5, 1, TRUE, FALSE), -- Aspecto Inofensivo
(14, 5, 1, TRUE, FALSE), -- Marca Exótica
(15, 5, -1, TRUE, FALSE), -- Pele Cadavérica
-- DEFICIÊNCIAS
(16, 6, 0, TRUE, FALSE), -- Caolho
(17, 6, 0, TRUE, FALSE), -- Hipermetropia
(18, 6, 0, TRUE, FALSE), -- Maneta
(19, 6, 0, TRUE, FALSE), -- Míope
(20, 6, 0, TRUE, FALSE), -- Perneta
(21, 6, 0, TRUE, FALSE), -- Problemas na fala
-- DEPENDENCIA
(22, 7, -2, TRUE, FALSE), -- Leve
(23, 7, -3, TRUE, FALSE), -- Pesada
-- ESTATURA
(24, 8, 0, TRUE, FALSE), -- Baixo
(25, 8, 0, TRUE, FALSE), -- Gigante
(26, 8, 0, TRUE, FALSE), -- Grande
(27, 8, 0, TRUE, FALSE), -- Nanico
-- ESTRUTURA CORPORAL
(28, 9, 0, TRUE, FALSE), -- Atlético
(29, 9, 0, TRUE, FALSE), -- Magro
(30, 9, 0, TRUE, FALSE), -- Obeso
(31, 9, 0, TRUE, FALSE), -- Robusto
-- POTENCIAL
(32, 10, 3, TRUE, FALSE), -- Hábil
(33, 10, -2, TRUE, FALSE), -- Inábil
(34, 10, 6, TRUE, FALSE), -- Primazia
(35, 10, -4, TRUE, FALSE), -- Mediocridade
-- RESISTÊNCIA À DOR
(36, 11, 0, TRUE, FALSE), -- Hiperalgesia
(37, 11, 0, TRUE, FALSE), -- Resistência Extrema
-- SAÚDE
(38, 12, 3, TRUE, FALSE), -- Corpo Fechado
(39, 12, -1, TRUE, FALSE), -- Saúde deficiente
(40, 12, -3, TRUE, FALSE), -- Saúde muito deficiente
(41, 12, 1, TRUE, FALSE), -- Saúde de ferro
-- VENENOS
(42, 13, -8, TRUE, FALSE), -- Fraqueza I
(43, 13, -6, TRUE, FALSE), -- Fraqueza II
(44, 13, -4, TRUE, FALSE), -- Fraqueza III
(45, 13, -2, TRUE, FALSE), -- Fraqueza IV
(46, 13, -1, TRUE, FALSE), -- Fraqueza V
(47, 13, 1, TRUE, FALSE), -- Imunidade I
(48, 13, 2, TRUE, FALSE), -- Imunidade II
(49, 13, 4, TRUE, FALSE), -- Imunidade III
(50, 13, 6, TRUE, FALSE), -- Imunidade IV
(51, 13, 8, TRUE, FALSE), -- Imunidade V
-- SONO
(52, 14, 6, TRUE, FALSE), -- Sono Consciente
(53, 14, 1, TRUE, FALSE), -- Sono Leve
(54, 14, -2, TRUE, FALSE), -- Sono Pesado
(55, 14, -4, TRUE, FALSE); -- Sonolento

INSERT INTO caracterizacao_grupo_custo (id_caracterizacao, id_caracterizacao_grupo, custo, is_inicial, permite_durante_jogo)
VALUES 
-- DEPENDENTE DE HABITAT
(56, 15, -1, TRUE, FALSE), -- Comum
(57, 15, -2, TRUE, FALSE), -- Amplo
(58, 15, -3, TRUE, FALSE), -- Restrito
(59, 15, -5, TRUE, FALSE), -- Endêmico
-- HERANÇA
(60, 16, 1, TRUE, FALSE),  -- Herança Mínima
(61, 16, 2, TRUE, FALSE),  -- Herança Pequena
(62, 16, 3, TRUE, FALSE),  -- Herança Média
(63, 16, 4, TRUE, FALSE),  -- Herança Grande
(64, 16, 5, TRUE, FALSE),  -- Herança Enorme
(65, 16, 3, TRUE, FALSE),  -- Item Mágico Menor
(66, 16, 5, TRUE, FALSE),  -- Item Mágico Maior
-- MEMÓRIA
(67, 17, -3, TRUE, FALSE), -- Memória Senil
(68, 17, -1, TRUE, FALSE), -- Memória Fraca
(69, 17, 1, TRUE, FALSE),  -- Memória Eidética
-- OBJETO AMALDIÇOADO
(70, 18, -3, TRUE, FALSE), -- Objeto Dominante
(71, 18, -2, TRUE, FALSE), -- Objeto Prejudicial
(72, 18, -1, TRUE, FALSE), -- Objeto Inoportuno
-- RESSONÂNCIA
(73, 19, 5, TRUE, FALSE),  -- Ressonância Energética
-- SEXTO SENTIDO
(74, 20, 5, TRUE, FALSE),  -- Reação ao Perigo
-- SORTE / AZAR
(75, 21, -3, TRUE, FALSE), -- Extremamente Azarado
(76, 21, -1, TRUE, FALSE), -- Azarado
(77, 21, 3, TRUE, FALSE),  -- Sortudo
-- TALENTO
(78, 22, 5, TRUE, FALSE),  -- Mestre de Armas
(79, 22, 3, TRUE, FALSE),  -- Especialista Nato
(80, 22, 4, TRUE, FALSE),  -- Genio Arcano
(81, 22, 4, TRUE, FALSE),  -- Genio Militar
-- TREINAMENTO
(82, 23, 2, TRUE, FALSE);  -- Treinamento Pouco Ortodoxo (!!)

INSERT INTO caracterizacao_grupo_custo (id_caracterizacao, id_caracterizacao_grupo, custo, is_inicial, permite_durante_jogo)
VALUES 
-- ANÕES (Grupo 24)
(83, 24, 1, TRUE, FALSE),  -- Conhecedor de Dragões
(84, 24, 1, TRUE, FALSE),  -- Escambista
(85, 24, 1, TRUE, FALSE),  -- Sobrevivente
(86, 24, -1, TRUE, FALSE), -- Trauma de Dragões
-- ACORDO
(87, 25, -1, TRUE, FALSE), -- Carrancudo
(88, 25, 1, TRUE, FALSE),  -- Duro de Negócio
(89, 25, 1, TRUE, FALSE),  -- Minerador Nato
(90, 25, -1, TRUE, FALSE), -- Muito Desconfiado
-- ÂMIEM
(91, 26, 2, TRUE, FALSE),  -- Bênção de Palier
(92, 26, 1, TRUE, FALSE),  -- Mateiro
(93, 26, -1, TRUE, FALSE), -- Pouco Adaptável
(94, 26, 1, TRUE, FALSE),  -- Prestígio em Âmiem
(95, 26, 1, TRUE, FALSE),  -- Tradição Élfica
-- AZANTI
(96, 27, -1, TRUE, FALSE), -- Inconformado
(97, 27, 1, TRUE, FALSE),  -- Preparado para a Guerra
(98, 27, 2, TRUE, FALSE),  -- Simpatias contra Magias
-- CALCO
(99, 28, 1, TRUE, FALSE),  -- Educação Refinada
(100, 28, 1, TRUE, FALSE), -- Multicultural
(101, 28, -1, TRUE, FALSE),-- Teórico
-- CIDADES-ESTADO
(102, 29, 2, TRUE, FALSE), -- Bravo Piense
(103, 29, 1, TRUE, FALSE), -- Carpintaria Torbelina
(104, 29, 2, TRUE, FALSE), -- Enderiano Abastado
(105, 29, 1, TRUE, FALSE), -- Estrangeirismos
(106, 29, 1, TRUE, FALSE), -- Mercador Quizano
(107, 29, 1, TRUE, FALSE), -- Revoltoso Estepano
-- CONTI
(108, 30, 1, TRUE, FALSE), -- Homem do Mar
(109, 30, 1, TRUE, FALSE), -- Malandragem Mulina
(110, 30, 1, TRUE, FALSE), -- Mateiro
(111, 30, -1, TRUE, FALSE),-- Mesquinho
-- DANTSEM
(112, 31, 1, TRUE, FALSE), -- Cavaleiro de Criaturas
(113, 31, -1, TRUE, FALSE),-- Desapropriado
(114, 31, 1, TRUE, FALSE), -- Mestre das Feras
(115, 31, 1, TRUE, FALSE), -- Multicultural
(116, 31, -1, TRUE, FALSE),-- Treinamento Precário
-- EREDRA
(117, 32, 1, TRUE, FALSE), -- Experiente em Apostas
(118, 32, 1, TRUE, FALSE), -- Ligado à Terra
(119, 32, 1, TRUE, FALSE), -- Povo de Fé
(120, 32, 1, TRUE, FALSE), -- Rebelde
(121, 32, -1, TRUE, FALSE),-- Supersticioso
-- FILANTI
(122, 33, 1, TRUE, FALSE), -- Formalidade Filantiana
(123, 33, 1, TRUE, FALSE), -- Histórias de Gironde
(124, 33, 2, TRUE, FALSE), -- Simpatias contra Magias
-- LEVÂNIA
(125, 34, 1, TRUE, FALSE), -- Artesão Brual
(126, 34, 1, TRUE, FALSE), -- Beduíno
(127, 34, 1, TRUE, FALSE), -- Justiça Implacável
(128, 34, -1, TRUE, FALSE),-- Mácula Bankdi
-- LUDGRIM
(129, 35, 1, TRUE, FALSE), -- Bilíngue
(130, 35, 1, TRUE, FALSE), -- Mateiro
(131, 35, 1, TRUE, FALSE), -- Sempre Alerta
(132, 35, 1, TRUE, FALSE), -- Tolerância
-- LUNA
(133, 36, 2, TRUE, FALSE), -- Artista Lunense
(134, 36, -1, TRUE, FALSE),-- Assolado pela Peste
(135, 36, 1, TRUE, FALSE), -- Medicina Lunense
(136, 36, 1, TRUE, FALSE), -- Sob a Lâmina da Navalha
-- MARANA
(137, 37, 1, TRUE, FALSE), -- Culinária Pequenina
(138, 37, -1, TRUE, FALSE),-- Desiludido
(139, 37, 1, TRUE, FALSE), -- Educação Refinada
(140, 37, 1, TRUE, FALSE), -- Retórica Maranense
-- PLANA
(141, 38, 1, TRUE, FALSE), -- Comerciante Nato
(142, 38, 1, TRUE, FALSE), -- Defensor Representante
(143, 38, 2, TRUE, FALSE), -- Negociante sem Fronteiras
(144, 38, 1, TRUE, FALSE), -- Trapaceiro
-- PORTIS
(145, 39, 1, TRUE, FALSE), -- Conhecimento Histórico
(146, 39, 1, TRUE, FALSE), -- Magia Runense
(147, 39, -1, TRUE, FALSE),-- Supervaloriza Magos
(148, 39, 2, TRUE, FALSE), -- Tradição Portiana
-- PORTO LIVRE
(149, 40, 1, TRUE, FALSE), -- Bandidagem no Sangue
(150, 40, 1, TRUE, FALSE), -- Boêmia Bandida
(151, 40, 1, TRUE, FALSE), -- Pirataria
(152, 40, -2, TRUE, FALSE),-- Procurado
-- VERROGAR
(153, 41, -1, TRUE, FALSE),-- Mentalidade de Soldado
(154, 41, 1, TRUE, FALSE), -- Preparo para Servir
(155, 41, 1, TRUE, FALSE), -- Tradição Belicosa
(156, 41, 2, TRUE, FALSE);  -- Treinamento Militar

INSERT INTO caracterizacao_grupo_custo (id_caracterizacao, id_caracterizacao_grupo, custo, is_inicial, permite_durante_jogo)
VALUES 
-- ATENÇÃO
(157, 42, -1, TRUE, FALSE), -- Distraído
(158, 42, 1, TRUE, FALSE),  -- Vigilante
-- AUTO-REPRESENTAÇÃO
(159, 43, -1, TRUE, FALSE), -- Fanfarrão
(160, 43, 1, TRUE, FALSE),  -- Modesto
-- CÓDIGO DE CONDUTA
(161, 44, -2, TRUE, FALSE), -- Honrado
(162, 44, -1, TRUE, FALSE), -- Palavra de Valor
(163, 44, -3, TRUE, FALSE), -- Penitente
(164, 44, -4, TRUE, FALSE), -- Vida pela Honra
-- COMPULSÕES
(165, 45, -2, TRUE, FALSE), -- Alcoólatra
(166, 45, -2, TRUE, FALSE), -- Arrogante
(167, 45, -2, TRUE, FALSE), -- Cleptomaníaco
(168, 45, -1, TRUE, FALSE), -- Ganancioso
(169, 45, -1, TRUE, FALSE), -- Guloso
(170, 45, -1, TRUE, FALSE), -- Mentiroso
(171, 45, -2, TRUE, FALSE), -- Mitomaníaco
(172, 45, -1, TRUE, FALSE), -- Preguiçoso
(173, 45, -2, TRUE, FALSE), -- Superconfiante
(174, 45, -1, TRUE, FALSE), -- Vingativo
-- CORAGEM / COVARDIA
(175, 46, 1, TRUE, FALSE),  -- Bravura 1
(176, 46, 2, TRUE, FALSE),  -- Bravura 2
(177, 46, 3, TRUE, FALSE),  -- Bravura 3
(178, 46, -1, TRUE, FALSE), -- Covardia 1
(179, 46, -2, TRUE, FALSE), -- Covardia 2
(180, 46, -3, TRUE, FALSE), -- Covardia 3
-- FOBIA
(181, 47, -3, TRUE, FALSE), -- Comum
(182, 47, -1, TRUE, FALSE), -- Incomun
(183, 47, -2, TRUE, FALSE), -- Ocasional
-- HUMOR
(184, 48, 1, TRUE, FALSE),  -- Bem-humorado
(185, 48, 2, TRUE, FALSE),  -- Contagiante
(186, 48, -1, TRUE, FALSE), -- Mal-humorado
(187, 48, -2, TRUE, FALSE), -- Ranzinza
-- MENTALIDADE
(188, 49, -1, TRUE, FALSE), -- Inconstante
(189, 49, 1, TRUE, FALSE),  -- Persistente
-- NOÇÃO
(190, 50, 1, TRUE, FALSE),  -- Bom Senso
(191, 50, -1, TRUE, FALSE), -- Imprudência
-- ODIO
(192, 51, -2, TRUE, FALSE), -- Comum
(193, 51, -1, TRUE, FALSE), -- Incomum
-- OUTRAS
(194, 52, -2, TRUE, FALSE), -- Crédulo
(195, 52, -2, TRUE, FALSE), -- Curioso
(196, 52, -2, TRUE, FALSE), -- Fanático
(197, 52, -2, TRUE, FALSE), -- Galanteador
(198, 52, -1, TRUE, FALSE), -- Impaciente
(199, 52, -1, TRUE, FALSE), -- Maluco
-- PERFECCIONISTA
(200, 53, -2, TRUE, FALSE), -- Chato
(201, 53, -3, TRUE, FALSE), -- Exigente
(202, 53, -4, TRUE, FALSE), -- Insuportável
(203, 53, 1, TRUE, FALSE),  -- Requintado
(204, 53, -1, TRUE, FALSE), -- Seletivo
-- TEMPERAMENTO
(205, 54, 2, TRUE, FALSE),  -- Coração de Pedra
(206, 54, -2, TRUE, FALSE), -- Coração Mole
(207, 54, -3, TRUE, FALSE), -- Esquentado
(208, 54, 3, TRUE, FALSE),  -- Frieza Lógica
-- VISÃO DE MUNDO
(209, 55, 1, TRUE, FALSE),  -- Otimista
(210, 55, -3, TRUE, FALSE); -- Pessimista


INSERT INTO caracterizacao_grupo_custo (id_caracterizacao, id_caracterizacao_grupo, custo, is_inicial, permite_durante_jogo)
VALUES 
-- ALIANÇAS
(211, 56, 2, TRUE, FALSE),  -- Aliado
(212, 56, -4, TRUE, FALSE), -- Arqui-Inimigo (Custo Base)
(213, 56, -3, TRUE, FALSE), -- Inimigo (Custo Base)
(214, 56, -1, TRUE, FALSE), -- Inimigo Invejoso (Modificador)
(215, 56, -2, TRUE, FALSE), -- Inimigo Rival (Modificador)
(216, 56, 1, TRUE, FALSE),  -- Seguidor: Mundano
-- CLASSES SOCIAIS
(217, 57, -2, TRUE, FALSE), -- Escravo
(218, 57, -1, TRUE, FALSE), -- Ex-Escravo
(219, 57, 1, TRUE, FALSE),  -- Pequeno Comerciante
(220, 57, 1, TRUE, FALSE),  -- Artífice
(221, 57, 2, TRUE, FALSE),  -- Grande Comerciante
(222, 57, 3, TRUE, FALSE),  -- Baixa Nobreza
(223, 57, 5, TRUE, FALSE),  -- Alta Nobreza
-- CONTATOS
(224, 58, 0, TRUE, FALSE),  -- Comerciais (Custo Variável min: 0)
(225, 58, 0, TRUE, FALSE),  -- Criminosos (Custo Variável min: 0)
(226, 58, 0, TRUE, FALSE),  -- Nobreza (Custo Variável min: 0)
-- DÍVIDAS
(227, 59, -1, TRUE, FALSE), -- Curta
(228, 59, 1, TRUE, FALSE),  -- Honra
(229, 59, 2, TRUE, FALSE),  -- Vida
(230, 59, -3, TRUE, FALSE), -- Eterna
(231, 59, -2, TRUE, FALSE), -- Longa
-- FAMA
(232, 60, 1, TRUE, FALSE),  -- Boa Fama
(233, 60, -1, TRUE, FALSE), -- Má Fama
-- HONRA
(234, 61, -2, TRUE, FALSE), -- Clã ou mestre desonrado
(235, 61, 5, TRUE, FALSE),  -- Mentor
(236, 61, 2, TRUE, FALSE),  -- Mestre/Clã Famoso
-- PATRONO
(237, 62, 0, TRUE, FALSE),  -- Comercial (Custo Variável min: 0)
(238, 62, 0, TRUE, FALSE),  -- Guerra (Custo Variável min: 0)
(239, 62, 0, TRUE, FALSE);  -- Político (Custo Variável min: 0)

