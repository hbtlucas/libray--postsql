1)
select es.nomeestado,avg((current_date - cl.nascimento)/365)
from clientes cl,cidades ci,estados es
where cl.idcidade=ci.idcidade
and ci.idestado=es.idestado
group by es.nomeestado

2)
select ve.nomevendedor,avg((current_date - ve.nascimento)/365) idade,
sum(vd.quantidade*pr.valorproduto) ValorTotal
from vendedores ve,vendas vd,produtos pr
where ve.idvendedor=vd.idvendedor
and vd.idproduto=pr.idproduto
group by ve.nomevendedor

3)
select es.nomeestado,count(*) total
from editoras ed,cidades ci,estados es
where ed.idcidade=ci.idcidade
and ci.idestado=es.idestado
group by es.nomeestado

4)
select es.nomeestado,count(*) TotalEmprestimos
from emprestimos em,cidades ci,clientes cl, estados es
where em.idcliente=cl.idcliente
and cl.idcidade=ci.idcidade
and ci.idestado=es.idestado
group by es.nomeestado

5)
select es.nomeestado,count(*) TotalVendas
from vendas vd,clientes cl,cidades ci,estados es
where vd.idcliente=cl.idcliente
and cl.idcidade=ci.idcidade
and ci.idestado=es.idestado
group by es.nomeestado

6)
select ct.nomecliente,ct.nascimento
from clientes ct
where ct.nascimento=
(select min(cl.nascimento)
from clientes cl)

7)
select 'Autor:'||l.autor 
from livros l
union
select 'Cliente:'||c.nomecliente
from clientes c
union
select 'Vendedor:'||v.nomevendedor
from vendedores v

8)
select cl.nomecliente,count(*) 
from emprestimos em,clientes cl
where em.idcliente=cl.idcliente
group by cl.nomecliente

9)
select l.anopublicacao,count(*) total
from livros l,emprestimos e
where l.idlivro=e.idlivro
group by l.anopublicacao

10)
select l.*
from livros l
where l.idlivro not in(
select e.idlivro
from emprestimos e)

11)
select p.descricaoprofissao,count(*) totalemprestimos
from emprestimos e, clientes c, profissoes p
where e.idcliente=c.idcliente
and c.idprofissao=p.idprofissao
group by p.descricaoprofissao

12)
select ps.descricaoproduto,(ve.quantidade*ps.valorproduto) total
from vendas ve,produtos ps
where ve.idproduto=ps.idproduto
and (ve.quantidade*ps.valorproduto)=
(select max(vd.quantidade*pr.valorproduto) 
from vendas vd,produtos pr
where vd.idproduto=pr.idproduto)

13)
select substring(c.bairro,1,position(' ' in c.bairro)) tipo,count(*)
from clientes c
group by substring(c.bairro,1,position(' ' in c.bairro))

14)
select e.nomeeditora,count(*) totalivros
from livros l,editoras e
where l.ideditora=e.ideditora
group by e.nomeeditora

15)
select l.autor,count(*) total
from livros l
group by l.autor
having count(*)>5

16)
select to_char(c.nascimento,'YYYY') ano,count(*) total
from clientes c
group by to_char(c.nascimento,'YYYY')

17/18)
select ci.nomecidade,count(*) total
from cidades ci,clientes cs
where ci.idcidade=cs.idcidade
group by ci.nomecidade
having count(*)=  
(select max(resultado.total) from
(select cl.idcidade,count(*) total 
from clientes cl
group by cl.idcidade) resultado)

19)
select ve.nomevendedor,(current_date - ve.nascimento)/365 idade,
sum(vd.quantidade*pr.valorproduto) valor
from vendas vd,vendedores ve,produtos pr
where vd.idvendedor=ve.idvendedor
and ve.nascimento=(select max(v.nascimento) from vendedores v)
group by ve.nomevendedor,(current_date - ve.nascimento)/365

20)
select ed.nomeeditora,count(*) total
from emprestimos em,editoras ed,livros li
where li.ideditora=ed.ideditora
and em.idlivro=li.idlivro
group by ed.nomeeditora
having count(*)=(
select max(tabela.total) from
(select li.ideditora,count(*) total
from emprestimos em,livros li
where em.idlivro=li.idlivro
group by li.ideditora) tabela)

21)
select pr.descricaoproduto,sum(vd.quantidade)
from vendas vd,produtos pr
where vd.idproduto=pr.idproduto
group by pr.descricaoproduto
having sum(vd.quantidade)>4000
