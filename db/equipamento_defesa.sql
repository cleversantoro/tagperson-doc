SELECT 
	e.id, e.nome, e.valor, 
    ed.defesa_base,ed.absorcao,
    ed.fisico_minimo,ed.forca_minima,
    ed.P,ed.A,ed.E,ed.M,ed.H
FROM equipamento e
inner join equipamento_defesa ed on ed.id_equipamento = e.id;