SELECT 
 c.id AS id_combate,
 c.nome as nome_combate,
 c.atributo,
 c.efeito,
 c.obs,
 c.requisitos,
 c.quadro_rolagem,
 c.aprimoramento,
 cg.id_pai AS id_prof_esp, 
 cg.id AS id_combate_grupo,
 cg.nome as nome_grupo,
 ctg.id AS id_categoria,
 ctg.nome as nome_categoria,
 cgc.custo,
 cgc.reducao,
 c.bonus

from personagem_combate pc
 inner join combate c on c.id = pc.id_combate
 inner join combate_grupo_custo cgc ON c.id = cgc.id_combate 
 inner join combate_grupo cg on cg.id = cgc.id_combate_grupo
 inner join categoria ctg on ctg.id = c.id_categoria

where pc.id_personagem = 17
 AND pc.id_combate_grupo = cg.id

-- AND cg.basica = 1
-- AND pc.tipo = 1

ORDER BY c.nome;
