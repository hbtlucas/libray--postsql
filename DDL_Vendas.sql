
CREATE TABLE public.estados (
	idestado numeric(3) NOT NULL,
	nomeestado varchar(50) NULL,
	sigla varchar(2) NULL,
	CONSTRAINT estados_pk PRIMARY KEY (idestado)
);

CREATE TABLE public.cidades (
	idcidade numeric(4) NOT NULL,
	idestado numeric(3) NOT NULL,
	nomecidade varchar(70) NULL,
	CONSTRAINT cidades_pk PRIMARY KEY (idcidade)
);

ALTER TABLE public.cidades ADD CONSTRAINT cidades_estados_fk FOREIGN KEY (idestado) REFERENCES public.estados(idestado);

CREATE TABLE public.vendedores (
	idvendedor numeric(3) NOT NULL,
	idcidade numeric(4) NOT NULL,
	nomevendedor varchar(70) NULL,
	nascimento date NULL,
	CONSTRAINT vendedores_pk PRIMARY KEY (idvendedor)
);

ALTER TABLE public.vendedores ADD CONSTRAINT vendedores_cidades_fk FOREIGN KEY (idcidade) REFERENCES public.cidades(idcidade);

CREATE TABLE public.profissoes (
	idprofissao numeric(4) NOT NULL,
	descricaoprofissao varchar(40) NULL,
	CONSTRAINT profissoes_pk PRIMARY KEY (idprofissao)
);

CREATE TABLE public.clientes (
	idcliente numeric(8) NOT NULL,
	idprofissao numeric(4) NOT NULL,
	idcidade numeric(4) NOT NULL,
	nomecliente varchar(60) NULL,
	nascimento date NULL,
	bairro varchar(50) NULL,
	rua varchar(80) NULL,
	rendamensal numeric(12, 3) NULL,
	CONSTRAINT clientes_pk PRIMARY KEY (idcliente)
);

ALTER TABLE public.clientes ADD CONSTRAINT clientes_cidades_fk FOREIGN KEY (idcidade) REFERENCES public.cidades(idcidade);
ALTER TABLE public.clientes ADD CONSTRAINT clientes_profissoes_fk FOREIGN KEY (idprofissao) REFERENCES public.profissoes(idprofissao);

CREATE TABLE public.livros (
	idlivro numeric(12) NOT NULL,
	ideditora numeric(5) NOT NULL,
	titulo varchar(200) NULL,
	autor varchar(80) NULL,
	anopublicacao numeric(4) NULL,
	CONSTRAINT livros_pk PRIMARY KEY (idlivro)
);

CREATE TABLE public.emprestimos (
	datasaida date NOT NULL,
	datadevolucao date NOT NULL,
	datadevolvido date NOT NULL,
	idcliente numeric(8) NOT NULL,
	idlivro numeric(12) NOT NULL,
	CONSTRAINT emprestimos_pk PRIMARY KEY (datasaida, datadevolucao, datadevolvido, idcliente, idlivro)
);

ALTER TABLE public.emprestimos ADD CONSTRAINT emprestimos_clientes_fk FOREIGN KEY (idcliente) REFERENCES public.clientes(idcliente);
ALTER TABLE public.emprestimos ADD CONSTRAINT emprestimos_livros_fk FOREIGN KEY (idlivro) REFERENCES public.livros(idlivro);

CREATE TABLE public.editoras (
	ideditora numeric(5) NOT NULL,
	idcidade numeric(4) NOT NULL,
	nomeeditora varchar(50) NULL,
	CONSTRAINT editoras_pk PRIMARY KEY (ideditora)
);

ALTER TABLE public.editoras ADD CONSTRAINT editoras_cidades_fk FOREIGN KEY (idcidade) REFERENCES public.cidades(idcidade);

ALTER TABLE public.livros ADD CONSTRAINT livros_editoras_fk FOREIGN KEY (ideditora) REFERENCES public.editoras(ideditora);

CREATE TABLE public.produtos (
	idproduto numeric(8) NOT NULL,
	descricaoproduto varchar(80) NULL,
	valorproduto numeric(12, 3) NULL,
	CONSTRAINT produtos_pk PRIMARY KEY (idproduto)
);


CREATE TABLE public.vendas (
	idvenda numeric(12) NOT NULL,
	idproduto numeric(8) NOT NULL,
	idcliente numeric(8) NOT NULL,
	idvendedor numeric(3) NOT NULL,
	quantidade numeric(8, 2) NULL,
	datavenda date NULL,
	CONSTRAINT vendas_pk PRIMARY KEY (idvenda)
);

ALTER TABLE public.vendas ADD CONSTRAINT vendas_clientes_fk FOREIGN KEY (idcliente) REFERENCES public.clientes(idcliente);
ALTER TABLE public.vendas ADD CONSTRAINT vendas_produtos_fk FOREIGN KEY (idproduto) REFERENCES public.produtos(idproduto);
ALTER TABLE public.vendas ADD CONSTRAINT vendas_vendedores_fk FOREIGN KEY (idvendedor) REFERENCES public.vendedores(idvendedor);