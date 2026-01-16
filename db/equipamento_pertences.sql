SELECT  
 e.id, e.nome, e.descricao,e.valor 
FROM equipamento e
WHERE 
	e.arma = 0 
	AND e.defesa =0 
	AND e.armadura =0 
	AND e.escudo =0 
	AND e.capacete = 0 
order by e.nome;
