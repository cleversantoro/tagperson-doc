SELECT DISTINCT 
	h.id, 
	h.nome, 

	h.id_habilidade_grupo, 
	hg.nome nome_grupo,

	h.descricao, 
	h.atributo,
	h.teste_nivel,
	h.restrita,
	h.penalidades,
	h.tarefas_aperfeicoadas,
	h.niveis,
	h.bonus,
	h.possui_especializacao,

	hgc.custo , 
	ph.nivel
	
FROM personagem_habilidade ph
	INNER JOIN habilidade AS h ON h.id = ph.id_habilidade
	INNER JOIN habilidade_grupo  AS hg ON hg.id = h.id_habilidade_grupo
	INNER JOIN habilidade_grupo_custo AS hgc ON hgc.id_habilidade = h.id 

WHERE (ph.id_personagem = 6)

ORDER BY h.nome