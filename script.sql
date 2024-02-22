2
select ve.nomevendedor, avg((current_date - ve.nascimento)/365) idade, sum(vd.quantidade*pr.valorproduto) Valortotal
from vendedores ve, vendas vd, produtos pr 
where ve.idvendedor = vd.idvendedor
and vd.idproduto = pr.idproduto
group by ve.nomevendedor

3
select es.sigla, count(*) total
from editoras ed, cidades ci, estados es
where ed.idcidade = ci.idcidade
and ci.idestado = es.idestado
group by es.sigla

4
select es.sigla, count (*) total

from emprestimos em, clientes cl, cidades ci, estados es

where em.idcliente=cl.idcliente
and cl.idcidade = ci.idcidade
and ci.idestado = es.idestado
group by es.sigla

5
select es.nomeestado, count(*) totalvendas
from vendas vd,clientes cl, cidades ci, estados es
where vd.idcliente = cl.idcliente
and cl.idcidade = ci.idcidade
and ci.idestado = es.idestado
group by es.nomeestado