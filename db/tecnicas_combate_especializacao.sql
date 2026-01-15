SELECT 
c.id, 
c.nome as nome_combate,
c.atributo,
c.efeito,
c.obs,
c.requisitos,
c.quadro_rolagem,
c.aprimoramento,
cg.nome as nome_grupo,
ctg.nome as nome_categoria,
cgc.custo,
c.bonus,
cgc.reducao
FROM combate_grupo_custo cgc
inner join combate c on c.id = cgc.id_combate
inner join combate_grupo cg on cg.id = cgc.id_combate_grupo
inner join categoria ctg on ctg.id = c.id_categoria
where cg.id_pai in(2,3) and cg.id = 4;