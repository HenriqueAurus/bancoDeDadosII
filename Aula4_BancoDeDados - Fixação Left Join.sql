DROP DATABASE IF EXISTS loja_aula04;
CREATE DATABASE loja_aula04;
USE loja_aula04;

CREATE TABLE clientes (
    id_cliente    INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente  VARCHAR(100) NOT NULL,
    cidade        VARCHAR(100) NOT NULL
);
CREATE TABLE vendedores (
    id_vendedor    INT AUTO_INCREMENT PRIMARY KEY,
    nome_vendedor  VARCHAR(100) NOT NULL,
    setor          VARCHAR(50)  NOT NULL
);

CREATE TABLE produtos (
    id_produto    INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto  VARCHAR(100)   NOT NULL,
    categoria     VARCHAR(50)    NOT NULL,
    quantidade    INT            NOT NULL DEFAULT 0,   -- estoque
    preco         DECIMAL(10,2)  NOT NULL
);
INSERT INTO clientes (nome_cliente, cidade) VALUES
('Ana Souza',        'Curitiba'),
('Bruno Lima',       'São Paulo'),
('Carla Mendes',     'Curitiba'),
('Diego Fernandes',  'Rio de Janeiro'),
('Rafael Nogueira',  'Curitiba');

INSERT INTO vendedores (nome_vendedor, setor) VALUES
('João Pedro',    'Eletrônicos'),
('Marina Alves',  'Vestuário'),
('Fernanda Dias',  'Alimentos'),
('Paulo Ricardo',  'Eletrônicos');

INSERT INTO produtos (nome_produto, categoria, quantidade, preco) VALUES
('Notebook Gamer',   'Eletrônicos', 15, 4500.00),
('Camiseta Básica',  'Vestuário',   50,   49.90),
('Cafeteira Elétrica','Eletrônicos',20,  199.90),
('Tênis Corrida',    'Vestuário',   30,  299.90),
('Fone Bluetooth',   'Eletrônicos', 40,  159.90);

INSERT INTO vendas (data_venda, id_cliente, id_vendedor, id_produto, quantidade_vendida, valor_total) VALUES
('2026-01-10', 1, 1, 1, 1, 4500.00),
('2026-02-15', 1, 2, 2, 3,  149.70),
('2026-03-02', 2, 1, 3, 1,  199.90),
('2026-03-20', 3, 3, 4, 2,  599.80),
('2026-04-05', 4, 2, 2, 1,   49.90);

CREATE TABLE vendas (
    id_venda            INT AUTO_INCREMENT PRIMARY KEY,
    data_venda          DATE          NOT NULL,
    id_cliente          INT           NOT NULL,
    id_vendedor         INT           NOT NULL,
    id_produto          INT           NOT NULL,
    quantidade_vendida  INT           NOT NULL,
    valor_total          DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_vendas_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    CONSTRAINT fk_vendas_vendedor
        FOREIGN KEY (id_vendedor) REFERENCES vendedores (id_vendedor),
    CONSTRAINT fk_vendas_produto
        FOREIGN KEY (id_produto) REFERENCES produtos (id_produto)
);

-- EXERCÍCIO 01 - Todos os clientes
SELECT
    c.id_cliente,
    c.nome_cliente,
    c.cidade,
    v.id_venda,
    v.data_venda
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente;

-- EXERCÍCIO 02 - Clientes sem compras
SELECT
    c.id_cliente,
    c.nome_cliente,
    c.cidade
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente
WHERE v.id_venda IS NULL;

-- EXERCÍCIO 03 - Todos os vendedores
SELECT
    vd.id_vendedor,
    vd.nome_vendedor,
    vd.setor,
    v.id_venda
FROM vendedores AS vd
LEFT JOIN vendas AS v
    ON v.id_vendedor = vd.id_vendedor;

-- EXERCÍCIO 04 - Vendedores sem vendas
SELECT
    vd.id_vendedor,
    vd.nome_vendedor,
    vd.setor
FROM vendedores AS vd
LEFT JOIN vendas AS v
    ON v.id_vendedor = vd.id_vendedor
WHERE v.id_venda IS NULL;

-- EXERCÍCIO 05 - Todos os produtos
SELECT
    p.id_produto,
    p.nome_produto,
    p.categoria,
    p.quantidade
FROM produtos AS p
LEFT JOIN vendas AS v
    ON v.id_produto = p.id_produto;

-- EXERCÍCIO 06 - Produtos nunca vendidos
SELECT
    p.id_produto,
    p.nome_produto,
    p.categoria
FROM produtos AS p
LEFT JOIN vendas AS v
    ON v.id_produto = p.id_produto
WHERE v.id_venda IS NULL;

-- EXERCÍCIO 07 - Quantidade de vendas por cliente
SELECT
    c.id_cliente,
    c.nome_cliente,
    COUNT(v.id_venda) AS quantidade_vendas
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente;

-- EXERCÍCIO 08 - Valor total comprado por cliente
SELECT
    c.id_cliente,
    c.nome_cliente,
    COALESCE(SUM(v.valor_total), 0) AS total_comprado
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente;

-- EXERCÍCIO 09 - Quantidade vendida por produto
SELECT
    p.id_produto,
    p.nome_produto,
    COALESCE(SUM(v.quantidade_vendida), 0) AS quantidade_total_vendida
FROM produtos AS p
LEFT JOIN vendas AS v
    ON v.id_produto = p.id_produto
GROUP BY
    p.id_produto,
    p.nome_produto;

-- EXERCÍCIO 10 - Produtos sem movimentação
SELECT
    p.id_produto,
    p.nome_produto,
    p.categoria,
    p.preco
FROM produtos AS p
LEFT JOIN vendas AS v
    ON v.id_produto = p.id_produto
WHERE v.id_venda IS NULL;

-- EXERCÍCIO 11 - Relatório completo de clientes
SELECT
    c.nome_cliente,
    c.cidade,
    COUNT(v.id_venda) AS quantidade_vendas,
    COALESCE(SUM(v.valor_total), 0) AS total_comprado
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente,
    c.cidade
ORDER BY
    total_comprado DESC;

-- EXERCÍCIO 12 - Relatório de vendedores
SELECT
    vd.nome_vendedor,
    COUNT(v.id_venda) AS quantidade_vendas,
    COALESCE(SUM(v.valor_total), 0) AS faturamento_total
FROM vendedores AS vd
LEFT JOIN vendas AS v
    ON v.id_vendedor = vd.id_vendedor
GROUP BY
    vd.id_vendedor,
    vd.nome_vendedor;

-- EXERCÍCIO 13 - Produtos e categorias
SELECT
    p.categoria,
    p.nome_produto,
    COALESCE(SUM(v.quantidade_vendida), 0) AS quantidade_vendida
FROM produtos AS p
LEFT JOIN vendas AS v
    ON v.id_produto = p.id_produto
GROUP BY
    p.categoria,
    p.id_produto,
    p.nome_produto
ORDER BY
    p.categoria,
    p.nome_produto;
    
-- EXERCÍCIO 14 - Clientes e última venda
SELECT
    c.nome_cliente,
    MAX(v.data_venda) AS data_da_ultima_venda
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente;

-- EXERCÍCIO 15 - Dashboard Gerencial
SELECT
    c.id_cliente,
    c.nome_cliente,
    c.cidade,
    COUNT(v.id_venda) AS quantidade_vendas,
    COALESCE(SUM(v.valor_total), 0) AS valor_total_comprado,
    MIN(v.data_venda) AS data_primeira_compra,
    MAX(v.data_venda) AS data_ultima_compra
FROM clientes AS c
LEFT JOIN vendas AS v
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente,
    c.cidade
ORDER BY
    valor_total_comprado DESC;