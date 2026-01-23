-- magia profissao
SELECT 
m.id AS id_magia,
mg.id_pai AS id_prof_esp, 
m.nome as nome_magia,
mg.id AS id_magia_grupo,
mg.nome as nome_grupo,
m.descricao,
m.evocacao,
m.alcance,
m.duracao,
m.niveis,
mgc.custo
FROM magia_grupo_custo mgc
inner join magia m on m.id = mgc.id_magia
inner join magia_grupo mg on mg.id = mgc.id_magia_grupo
where mg.profissao =1 
ORDER BY mg.id;