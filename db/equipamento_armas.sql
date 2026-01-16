SELECT 
    e.id, e.nome, e.valor, 
    ea.tipo, ea.custo, ea.alcance, ea.forca_minima, ea.bonus, ea.l, ea.m, ea.p, 
    [ea.25], [ea.50], [ea.75], [ea.100], ea.Pq, ea.an, ea.El, ea.me, ea.Hu 
FROM equipamento e 
inner join equipamento_armas ea on ea.id_equipamento = e.id;


SELECT 
	e.id, e.nome, e.descricao,
    e.valor, ea.tipo, ea.custo,
    ea.alcance, ea.forca_minima, ea.bonus,
    ea.l, ea.m, ea.p,
    [ea.25], [ea.50], [ea.75], [ea.100],
    ea.Pq,ea.An,ea.El,ea.Me,ea.Hu
FROM equipamento e
inner join equipamento_armas ea on ea.id_equipamento = e.id
where e.arma = 1
order by e.nome;