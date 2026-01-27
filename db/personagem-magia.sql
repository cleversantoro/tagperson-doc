SELECT 
	m.id,
	m.nome,
	m.descricao,
	m.evocacao,
	m.alcance,
	m.duracao,
	m.niveis,
	mgc.custo,
	pm.nivel,
	mg.profissao,
	mg.especializacao
FROM personagem_magia pm
inner join magia m on m.id = pm.id_magia
inner join magia_grupo_custo mgc on m.id = mgc.id_magia
inner join magia_grupo mg on mg.id = mgc.id_magia_grupo
where pm.id_personagem = 9 
AND pm.id_magia_grupo = mg.id 
ORDER BY m.nome;

