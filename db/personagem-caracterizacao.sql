SELECT 
	c.id, 
	c.nome, 

	c.id_caracterizacao_tipo, 
	ct.nome nome_tipo,
	c.id_caracterizacao_grupo, 
	cg.nome nome_grupo,

	c.descricao, 
	c.observacoes  , 
	
	cgc.id_localidade, 
	cgc.custo, 
	cgc.is_inicial, 
	cgc.is_muito_rara, 
	cgc.permite_durante_jogo,
	pc.nivel
	
FROM personagem_caracterizacao pc
	INNER JOIN caracterizacao AS c ON c.id = pc.id_caracterizacao
	INNER JOIN caracterizacao_tipo AS ct ON ct.id = c.id_caracterizacao_tipo
	INNER JOIN caracterizacao_grupo  AS cg ON cg.id_caracterizacao_tipo = ct.id
	INNER JOIN caracterizacao_grupo_custo AS cgc ON cgc.id_caracterizacao_grupo = cg.id AND cgc.id_caracterizacao = c.id
WHERE (pc.id_personagem = 6)  

ORDER BY c.nome