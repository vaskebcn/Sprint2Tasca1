SELECT COUNT(cp.categoria_productes_id) AS cantitat_begudes FROM categoria_productes cp 
JOIN productes pr ON cp.categoria_productes_id=pr.categoria_productes_categoria_productes_id 
JOIN comanda_has_productes chp ON pr.productes_id=chp.productes_productes_id 
JOIN comanda c ON chp.comanda_comanda_id=c.comanda_id 
JOIN clients cl ON c.clients_clients_id=cl.clients_id
JOIN provincia p ON cl.localitat_provincia_provincia_id=p.provincia_id
WHERE provincia_id = 3 AND cp.categoria_productes_id = 5;
SELECT COUNT(c.comanda_id) AS cantitat_comandas FROM comanda c JOIN empleats e ON c.empleats_empleats_id=e.empleats_id;