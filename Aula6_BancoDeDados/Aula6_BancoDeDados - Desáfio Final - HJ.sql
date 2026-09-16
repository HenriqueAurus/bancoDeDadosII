-- ============================================================
-- BANCO DE DADOS II
-- DESAFIO FINAL DO SEMESTRE
-- EMPRESA: SPORTZONE
-- ============================================================

DROP DATABASE IF EXISTS sportzone;
CREATE DATABASE sportzone;
USE sportzone;


-- ============================================================
-- TABELA: CLIENTES
-- ============================================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cidade VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL,
    renda DECIMAL(10,2),
    data_cadastro DATE NOT NULL
);
-- ============================================================
-- TABELA: VENDEDORES
-- ============================================================
CREATE TABLE vendedores (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    cidade VARCHAR(80) NOT NULL,
    data_admissao DATE NOT NULL
);
-- ============================================================
-- TABELA: PRODUTOS
-- ============================================================
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    categoria VARCHAR(60) NOT NULL,
    marca VARCHAR(60) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,

    CHECK (preco >= 0),
    CHECK (estoque >= 0)
);
-- ============================================================
-- TABELA: VENDAS
-- ============================================================
CREATE TABLE vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    data_venda DATE NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,

    CONSTRAINT fk_vendas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_vendas_vendedores
        FOREIGN KEY (id_vendedor)
        REFERENCES vendedores(id_vendedor)
);
-- ============================================================
-- TABELA: ITENS_VENDA
-- ============================================================
CREATE TABLE itens_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_itens_vendas
        FOREIGN KEY (id_venda)
        REFERENCES vendas(id_venda),

    CONSTRAINT fk_itens_produtos
        FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto),

    CHECK (quantidade > 0),
    CHECK (preco_unitario >= 0)
);
-- ============================================================
-- INSERTS: CLIENTES
-- ============================================================
INSERT INTO clientes
(nome, cpf, cidade, estado, renda, data_cadastro)
VALUES
('Lucas Almeida',       '111.111.111-01', 'Curitiba',          'PR', 8500.00,  '2026-01-10'),
('Mariana Costa',       '111.111.111-02', 'Curitiba',          'PR', 6200.00,  '2026-01-15'),
('Rafael Martins',      '111.111.111-03', 'São José dos Pinhais','PR', 4800.00,'2026-01-20'),
('Fernanda Oliveira',   '111.111.111-04', 'Colombo',           'PR', 7300.00,  '2026-02-03'),
('Bruno Souza',         '111.111.111-05', 'Curitiba',          'PR', 3900.00,  '2026-02-12'),
('Camila Rodrigues',    '111.111.111-06', 'Pinhais',           'PR', 9100.00,  '2026-02-18'),
('Gustavo Pereira',     '111.111.111-07', 'Araucária',         'PR', 5200.00,  '2026-03-01'),
('Juliana Santos',      '111.111.111-08', 'Curitiba',          'PR', 6800.00,  '2026-03-08'),
('Felipe Lima',         '111.111.111-09', 'Campo Largo',       'PR', 4400.00,  '2026-03-15'),
('Amanda Ribeiro',      '111.111.111-10', 'Curitiba',          'PR', 12500.00, '2026-03-22'),
('Diego Ferreira',      '111.111.111-11', 'Pinhais',           'PR', 5800.00,  '2026-04-02'),
('Patrícia Gomes',      '111.111.111-12', 'Colombo',           'PR', 7600.00,  '2026-04-11'),
('André Moreira',       '111.111.111-13', 'Curitiba',          'PR', 3300.00,  '2026-04-18'),
('Larissa Alves',       '111.111.111-14', 'Araucária',         'PR', 8700.00,  '2026-05-01'),
('Rodrigo Barbosa',     '111.111.111-15', 'Curitiba',          'PR', 10200.00, '2026-05-09'),
('Beatriz Cardoso',     '111.111.111-16', 'Pinhais',           'PR', 4600.00,  '2026-05-20'),
('Eduardo Nunes',       '111.111.111-17', 'Curitiba',          'PR', 5500.00,  '2026-06-01'),
('Natália Rocha',       '111.111.111-18', 'Campo Largo',       'PR', 6900.00,  '2026-06-10'),
('Henrique Freitas',    '111.111.111-19', 'Colombo',           'PR', 4100.00,  '2026-06-18'),
('Isabela Teixeira',    '111.111.111-20', 'Curitiba',          'PR', 9800.00,  '2026-06-25');
-- ============================================================
-- INSERTS: VENDEDORES
-- ============================================================
INSERT INTO vendedores
(nome, email, cidade, data_admissao)
VALUES
('Carlos Mendes',   'carlos@sportzone.com.br',   'Curitiba', '2024-02-01'),
('Ana Paula Silva', 'ana@sportzone.com.br',      'Curitiba', '2024-05-10'),
('João Ribeiro',    'joao@sportzone.com.br',     'Pinhais',  '2025-01-15'),
('Renata Lopes',    'renata@sportzone.com.br',   'Curitiba', '2025-03-12'),
('Marcelo Torres',  'marcelo@sportzone.com.br',  'Colombo',  '2025-07-20'),
('Bianca Martins',  'bianca@sportzone.com.br',   'Curitiba', '2025-10-05'),
('Paulo Henrique',  'paulo@sportzone.com.br',    'Pinhais',  '2026-01-08'),
('Sabrina Costa',   'sabrina@sportzone.com.br',  'Curitiba', '2026-07-01');
-- Observação:
-- Sabrina Costa propositalmente não possuirá vendas.
-- ============================================================
-- INSERTS: PRODUTOS
-- ============================================================
INSERT INTO produtos
(nome, categoria, marca, preco, estoque, ativo)
VALUES
('Tênis Running Pro',           'Calçados',    'RunFast',   499.90, 18, TRUE),
('Tênis Urban Flex',            'Calçados',    'RunFast',   359.90, 25, TRUE),
('Tênis Trail Adventure',       'Calçados',    'MountainX', 549.90, 12, TRUE),

('Camiseta Dry Fit Masculina',  'Vestuário',   'SportMax',   89.90, 45, TRUE),
('Camiseta Dry Fit Feminina',   'Vestuário',   'SportMax',   89.90, 38, TRUE),
('Shorts Performance',          'Vestuário',   'SportMax',  119.90, 30, TRUE),
('Legging Training',            'Vestuário',   'FitLife',   159.90, 28, TRUE),
('Jaqueta Corta-Vento',         'Vestuário',   'MountainX', 299.90, 14, TRUE),

('Mochila Esportiva 30L',       'Acessórios',  'Adventure', 219.90, 20, TRUE),
('Garrafa Térmica 1L',          'Acessórios',  'HydroFit',  129.90, 40, TRUE),
('Luvas de Academia',           'Acessórios',  'FitLife',    79.90, 35, TRUE),
('Boné Sport Performance',      'Acessórios',  'SportMax',   69.90, 32, TRUE),

('Halter 10kg',                 'Musculação',  'StrongFit', 179.90, 15, TRUE),
('Kit Halteres 20kg',           'Musculação',  'StrongFit', 499.90, 10, TRUE),
('Banco de Musculação',         'Musculação',  'StrongFit', 899.90, 6, TRUE),

('Bola de Futebol Pro',         'Esportes',    'Arena',     149.90, 22, TRUE),
('Bola de Basquete Street',     'Esportes',    'Arena',     169.90, 16, TRUE),
('Raquete de Tênis Carbon',     'Esportes',    'Winner',    649.90, 8, TRUE),

('Corda de Pular Speed',        'Fitness',     'FitLife',    59.90, 50, TRUE),
('Colchonete Premium',          'Fitness',     'FitLife',   139.90, 26, TRUE),

('Step Aeróbico Profissional',  'Fitness',     'FitLife',   259.90, 10, TRUE),
('Kettlebell 16kg',             'Musculação',  'StrongFit', 229.90, 12, TRUE);

-- Observação:
-- Produtos 21 e 22 propositalmente nunca serão vendidos.
-- ============================================================
-- INSERTS: VENDAS
-- ============================================================

INSERT INTO vendas
(id_cliente, id_vendedor, data_venda, forma_pagamento)
VALUES
(1,  1, '2026-01-15', 'Cartão de Crédito'),
(2,  2, '2026-01-20', 'PIX'),
(3,  3, '2026-02-03', 'Cartão de Débito'),
(1,  1, '2026-02-10', 'PIX'),
(4,  4, '2026-02-17', 'Cartão de Crédito'),

(5,  2, '2026-03-02', 'PIX'),
(6,  1, '2026-03-06', 'Cartão de Crédito'),
(2,  3, '2026-03-12', 'Cartão de Crédito'),
(7,  5, '2026-03-18', 'PIX'),
(8,  4, '2026-03-25', 'Cartão de Débito'),

(10, 1, '2026-04-02', 'Cartão de Crédito'),
(3,  3, '2026-04-07', 'PIX'),
(11, 6, '2026-04-13', 'Cartão de Crédito'),
(12, 2, '2026-04-21', 'PIX'),
(1,  1, '2026-04-29', 'Cartão de Crédito'),

(14, 5, '2026-05-05', 'Cartão de Débito'),
(15, 1, '2026-05-10', 'Cartão de Crédito'),
(6,  4, '2026-05-15', 'PIX'),
(8,  2, '2026-05-22', 'Cartão de Crédito'),
(10, 3, '2026-05-30', 'PIX'),

(2,  2, '2026-06-04', 'Cartão de Crédito'),
(11, 6, '2026-06-09', 'PIX'),
(14, 5, '2026-06-14', 'Cartão de Crédito'),
(17, 7, '2026-06-19', 'PIX'),
(1,  1, '2026-06-26', 'Cartão de Crédito'),

(15, 4, '2026-07-03', 'Cartão de Crédito'),
(3,  3, '2026-07-08', 'PIX'),
(10, 1, '2026-07-14', 'Cartão de Crédito'),
(18, 7, '2026-07-21', 'PIX'),
(6,  6, '2026-07-29', 'Cartão de Crédito'),

(8,  2, '2026-08-02', 'PIX'),
(14, 5, '2026-08-08', 'Cartão de Crédito'),
(2,  3, '2026-08-15', 'Cartão de Débito'),
(15, 4, '2026-08-22', 'PIX'),
(10, 1, '2026-08-29', 'Cartão de Crédito'),

(1,  1, '2026-09-02', 'PIX'),
(17, 7, '2026-09-04', 'Cartão de Crédito'),
(6,  6, '2026-09-06', 'Cartão de Crédito'),
(14, 5, '2026-09-07', 'PIX'),
(10, 1, '2026-09-08', 'Cartão de Crédito');


-- Clientes propositalmente sem nenhuma compra:
-- 9  - Felipe Lima
-- 13 - André Moreira
-- 16 - Beatriz Cardoso
-- 19 - Henrique Freitas
-- 20 - Isabela Teixeira
-- ============================================================
-- INSERTS: ITENS_VENDA
-- ============================================================
INSERT INTO itens_venda
(id_venda, id_produto, quantidade, preco_unitario)
VALUES

-- VENDA 01
(1, 1, 1, 469.90),
(1, 4, 2, 84.90),
(1, 10, 1, 119.90),

-- VENDA 02
(2, 2, 1, 349.90),
(2, 5, 2, 89.90),

-- VENDA 03
(3, 16, 1, 139.90),
(3, 12, 1, 69.90),
(3, 19, 1, 59.90),

-- VENDA 04
(4, 13, 2, 169.90),
(4, 11, 1, 79.90),

-- VENDA 05
(5, 7, 1, 149.90),
(5, 5, 2, 84.90),
(5, 10, 1, 129.90),

-- VENDA 06
(6, 4, 3, 79.90),
(6, 6, 1, 109.90),

-- VENDA 07
(7, 14, 1, 479.90),
(7, 20, 2, 129.90),

-- VENDA 08
(8, 1, 1, 499.90),
(8, 9, 1, 209.90),

-- VENDA 09
(9, 3, 1, 529.90),
(9, 8, 1, 289.90),

-- VENDA 10
(10, 5, 2, 89.90),
(10, 7, 1, 159.90),

-- VENDA 11
(11, 15, 1, 849.90),
(11, 14, 1, 489.90),
(11, 11, 2, 74.90),

-- VENDA 12
(12, 16, 2, 144.90),
(12, 4, 1, 89.90),

-- VENDA 13
(13, 2, 1, 359.90),
(13, 10, 2, 124.90),

-- VENDA 14
(14, 17, 1, 159.90),
(14, 12, 2, 64.90),

-- VENDA 15
(15, 18, 1, 619.90),
(15, 3, 1, 519.90),

-- VENDA 16
(16, 6, 2, 119.90),
(16, 7, 1, 149.90),
(16, 19, 2, 54.90),

-- VENDA 17
(17, 1, 2, 479.90),
(17, 10, 1, 129.90),

-- VENDA 18
(18, 4, 2, 84.90),
(18, 5, 2, 84.90),
(18, 20, 1, 139.90),

-- VENDA 19
(19, 9, 1, 219.90),
(19, 12, 1, 69.90),

-- VENDA 20
(20, 13, 1, 179.90),
(20, 14, 1, 499.90),

-- VENDA 21
(21, 2, 1, 349.90),
(21, 6, 2, 114.90),

-- VENDA 22
(22, 11, 2, 79.90),
(22, 20, 1, 134.90),

-- VENDA 23
(23, 3, 1, 549.90),
(23, 8, 1, 299.90),

-- VENDA 24
(24, 16, 2, 149.90),
(24, 4, 2, 89.90),

-- VENDA 25
(25, 1, 1, 489.90),
(25, 18, 1, 629.90),

-- VENDA 26
(26, 15, 1, 899.90),
(26, 13, 2, 174.90),

-- VENDA 27
(27, 17, 1, 169.90),
(27, 12, 2, 69.90),

-- VENDA 28
(28, 14, 2, 489.90),
(28, 10, 2, 129.90),

-- VENDA 29
(29, 19, 3, 59.90),
(29, 20, 2, 139.90),

-- VENDA 30
(30, 7, 2, 154.90),
(30, 5, 1, 89.90),
(30, 11, 1, 79.90),

-- VENDA 31
(31, 4, 2, 89.90),
(31, 6, 1, 119.90),
(31, 10, 1, 129.90),

-- VENDA 32
(32, 3, 1, 539.90),
(32, 9, 1, 219.90),

-- VENDA 33
(33, 16, 2, 144.90),
(33, 17, 1, 164.90),

-- VENDA 34
(34, 1, 1, 499.90),
(34, 8, 1, 299.90),
(34, 12, 1, 69.90),

-- VENDA 35
(35, 15, 1, 879.90),
(35, 14, 1, 499.90),
(35, 20, 1, 139.90),

-- VENDA 36
(36, 18, 1, 649.90),
(36, 11, 2, 79.90),

-- VENDA 37
(37, 2, 1, 359.90),
(37, 10, 2, 129.90),

-- VENDA 38
(38, 7, 2, 159.90),
(38, 4, 2, 89.90),

-- VENDA 39
(39, 3, 1, 549.90),
(39, 9, 1, 219.90),
(39, 19, 2, 59.90),

-- VENDA 40
(40, 15, 1, 899.90),
(40, 1, 1, 499.90),
(40, 10, 1, 129.90);

USE sportzone;

SELECT
    c.nome AS cliente,
    c.cidade,
    c.renda,
    COALESCE(rc.qtd_compras, 0) AS qtd_compras,
    COALESCE(rc.qtd_produtos_adquiridos, 0) AS qtd_produtos_adquiridos,
    COALESCE(rc.valor_total_gasto, 0) AS valor_total_gasto,
    ROUND(
        COALESCE(rc.valor_total_gasto, 0) / NULLIF(rc.qtd_compras, 0),
        2
    ) AS ticket_medio,
    (
        SELECT MAX(v2.data_venda)
        FROM vendas v2
        WHERE v2.id_cliente = c.id_cliente
    ) AS ultima_compra
FROM clientes c
LEFT JOIN (
    SELECT
        v.id_cliente,
        COUNT(DISTINCT v.id_venda) AS qtd_compras,
        SUM(iv.quantidade) AS qtd_produtos_adquiridos,
        SUM(iv.quantidade * iv.preco_unitario) AS valor_total_gasto
    FROM vendas v
    INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
    GROUP BY v.id_cliente
) AS rc ON rc.id_cliente = c.id_cliente
ORDER BY valor_total_gasto DESC;

-- ============================================================================
-- RELATÓRIO 2 — ANÁLISE DE PRODUTOS
-- Objetivo: para cada produto do catálogo, mostrar preço, estoque, unidades
-- vendidas, faturamento gerado e quantidade de clientes diferentes que
-- compraram. Todos os produtos aparecem, inclusive os nunca vendidos.
-- ============================================================================
SELECT
    p.nome AS produto,
    p.categoria,
    p.preco AS preco_atual,
    p.estoque,
    COALESCE(rp.qtd_total_vendida, 0) AS qtd_total_vendida,
    COALESCE(rp.faturamento_total, 0) AS faturamento_gerado,
    COALESCE(cp.qtd_clientes_diferentes, 0) AS qtd_clientes_diferentes
FROM produtos p
LEFT JOIN (
    SELECT
        iv.id_produto,
        SUM(iv.quantidade) AS qtd_total_vendida,
        SUM(iv.quantidade * iv.preco_unitario) AS faturamento_total
    FROM itens_venda iv
    GROUP BY iv.id_produto
) AS rp ON rp.id_produto = p.id_produto
LEFT JOIN (
    SELECT
        iv.id_produto,
        COUNT(DISTINCT v.id_cliente) AS qtd_clientes_diferentes
    FROM itens_venda iv
    INNER JOIN vendas v ON v.id_venda = iv.id_venda
    GROUP BY iv.id_produto
) AS cp ON cp.id_produto = p.id_produto
ORDER BY faturamento_gerado DESC;

-- ============================================================================
-- RELATÓRIO 3 — ANÁLISE DE VENDEDORES
-- Objetivo: para cada vendedor, mostrar quantidade de vendas, clientes
-- diferentes atendidos, produtos vendidos, faturamento total e ticket médio.
-- Todos os vendedores aparecem, inclusive os que ainda não venderam.
-- ============================================================================
SELECT
    vd.nome AS vendedor,
    COALESCE(rv.qtd_vendas, 0) AS qtd_vendas,
    COALESCE(rv.qtd_clientes_diferentes, 0) AS qtd_clientes_diferentes,
    COALESCE(rv.qtd_total_produtos, 0) AS qtd_total_produtos,
    COALESCE(rv.faturamento_total, 0) AS faturamento_total,
    ROUND(
        COALESCE(rv.faturamento_total, 0) / NULLIF(rv.qtd_vendas, 0),
        2
    ) AS ticket_medio
FROM vendedores vd
LEFT JOIN (
    SELECT
        v.id_vendedor,
        COUNT(DISTINCT v.id_venda) AS qtd_vendas,
        COUNT(DISTINCT v.id_cliente) AS qtd_clientes_diferentes,
        SUM(iv.quantidade) AS qtd_total_produtos,
        SUM(iv.quantidade * iv.preco_unitario) AS faturamento_total
    FROM vendas v
    INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
    GROUP BY v.id_vendedor
) AS rv ON rv.id_vendedor = vd.id_vendedor
ORDER BY faturamento_total DESC;

-- ============================================================================
-- PARTE 4 — KPIs GERENCIAIS OBRIGATÓRIOS
-- ============================================================================

-- --------------------------------------------------------------------------
-- KPI 01 — Cliente que mais gastou na SportZone
-- --------------------------------------------------------------------------
SELECT
    c.nome AS cliente,
    SUM(iv.quantidade * iv.preco_unitario) AS valor_total_gasto
FROM clientes c
INNER JOIN vendas v      ON v.id_cliente = c.id_cliente
INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
GROUP BY c.id_cliente, c.nome
ORDER BY valor_total_gasto DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- KPI 02 — Cliente que realizou a maior quantidade de compras
-- --------------------------------------------------------------------------
SELECT
    c.nome AS cliente,
    COUNT(DISTINCT v.id_venda) AS qtd_compras
FROM clientes c
INNER JOIN vendas v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY qtd_compras DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- KPI 03 — Produto com maior quantidade de unidades vendidas
-- --------------------------------------------------------------------------
SELECT
    p.nome AS produto,
    SUM(iv.quantidade) AS qtd_vendida
FROM produtos p
INNER JOIN itens_venda iv ON iv.id_produto = p.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY qtd_vendida DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- KPI 04 — Produto que gerou o maior faturamento
-- --------------------------------------------------------------------------
SELECT
    p.nome AS produto,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM produtos p
INNER JOIN itens_venda iv ON iv.id_produto = p.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY faturamento DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- KPI 05 — Produtos que nunca foram vendidos (NOT EXISTS)
-- --------------------------------------------------------------------------
SELECT
    p.nome AS produto,
    p.categoria,
    p.estoque
FROM produtos p
WHERE NOT EXISTS (
    SELECT 1 FROM itens_venda iv WHERE iv.id_produto = p.id_produto
);


-- --------------------------------------------------------------------------
-- KPI 06 — Vendedor que realizou a maior quantidade de vendas
-- --------------------------------------------------------------------------
SELECT
    vd.nome AS vendedor,
    COUNT(DISTINCT v.id_venda) AS qtd_vendas
FROM vendedores vd
INNER JOIN vendas v ON v.id_vendedor = vd.id_vendedor
GROUP BY vd.id_vendedor, vd.nome
ORDER BY qtd_vendas DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- KPI 07 — Vendedor que gerou o maior faturamento
-- --------------------------------------------------------------------------
SELECT
    vd.nome AS vendedor,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento
FROM vendedores vd
INNER JOIN vendas v       ON v.id_vendedor = vd.id_vendedor
INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
GROUP BY vd.id_vendedor, vd.nome
ORDER BY faturamento DESC
LIMIT 1;


-- --------------------------------------------------------------------------
-- KPI 08 — Quantidade de clientes que nunca realizaram uma compra
-- --------------------------------------------------------------------------
SELECT
    COUNT(*) AS clientes_sem_compra
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM vendas v WHERE v.id_cliente = c.id_cliente
);


-- --------------------------------------------------------------------------
-- KPI 09 — Faturamento total da empresa
-- --------------------------------------------------------------------------
SELECT
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento_total
FROM itens_venda iv;


-- --------------------------------------------------------------------------
-- KPI 10 — Ticket médio geral das vendas
-- --------------------------------------------------------------------------
SELECT
    ROUND(AVG(valor_venda), 2) AS ticket_medio_geral
FROM (
    SELECT
        id_venda,
        SUM(quantidade * preco_unitario) AS valor_venda
    FROM itens_venda
    GROUP BY id_venda
) AS valor_por_venda;

-- ============================================================================
-- PARTE 5 — KPIs CRIADOS PELA DUPLA
-- ============================================================================

-- --------------------------------------------------------------------------
-- KPI 11 — Concentração de faturamento por categoria de produto
-- Área: Produtos / Comercial
-- --------------------------------------------------------------------------
SELECT
    p.categoria,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento,
    ROUND(
        100.0 * SUM(iv.quantidade * iv.preco_unitario)
        / (SELECT SUM(quantidade * preco_unitario) FROM itens_venda),
        2
    ) AS pct_faturamento
FROM produtos p
INNER JOIN itens_venda iv ON iv.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;


-- --------------------------------------------------------------------------
-- KPI 12 — Concentração de clientes e faturamento por cidade
-- Área: Marketing
-- --------------------------------------------------------------------------
SELECT
    gc.cidade,
    COUNT(*) AS qtd_clientes,
    SUM(gc.gasto) AS faturamento_cidade
FROM (
    SELECT
        c.id_cliente,
        c.cidade,
        COALESCE(SUM(iv.quantidade * iv.preco_unitario), 0) AS gasto
    FROM clientes c
    LEFT JOIN vendas v ON v.id_cliente = c.id_cliente
    LEFT JOIN itens_venda iv ON iv.id_venda = v.id_venda
    GROUP BY c.id_cliente, c.cidade
) AS gc
GROUP BY gc.cidade
ORDER BY faturamento_cidade DESC;

-- --------------------------------------------------------------------------
-- KPI 13 — Perfil de recorrência de compra dos clientes
-- Área: Marketing / Comercial
-- --------------------------------------------------------------------------
SELECT
    CASE
        WHEN qtd_compras = 0 THEN 'Sem compra'
        WHEN qtd_compras BETWEEN 1 AND 2 THEN 'Ocasional (1-2 compras)'
        ELSE 'Recorrente (3+ compras)'
    END AS perfil_cliente,
    COUNT(*) AS qtd_clientes
FROM (
    SELECT
        c.id_cliente,
        COUNT(DISTINCT v.id_venda) AS qtd_compras
    FROM clientes c
    LEFT JOIN vendas v ON v.id_cliente = c.id_cliente
    GROUP BY c.id_cliente
) AS compras
GROUP BY perfil_cliente
ORDER BY qtd_clientes DESC;

-- --------------------------------------------------------------------------
-- KPI 14 — Produtos com estoque elevado e baixo volume de vendas
-- (risco de capital parado / candidatos a promoção)
-- Área: Estoque / Logística
-- --------------------------------------------------------------------------
SELECT
    p.nome AS produto,
    p.categoria,
    p.estoque,
    COALESCE(vp.qtd_vendida, 0) AS qtd_vendida
FROM produtos p
LEFT JOIN (
    SELECT
        id_produto,
        SUM(quantidade) AS qtd_vendida
    FROM itens_venda
    GROUP BY id_produto
) AS vp ON vp.id_produto = p.id_produto
WHERE p.estoque >= 20
  AND COALESCE(vp.qtd_vendida, 0) <= 5
ORDER BY p.estoque DESC;

-- --------------------------------------------------------------------------
-- KPI 15 — Evolução mensal do faturamento
-- Área: Diretoria / Financeiro
-- --------------------------------------------------------------------------
SELECT
    DATE_FORMAT(v.data_venda, '%Y-%m') AS mes,
    COUNT(DISTINCT v.id_venda)         AS qtd_vendas,
    SUM(iv.quantidade * iv.preco_unitario) AS faturamento_mes
FROM vendas v
INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
GROUP BY mes
ORDER BY mes;


-- ============================================================================
-- ANEXO TÉCNICO — DEMONSTRAÇÃO DE RECURSOS SQL COMPLEMENTARES
-- (RIGHT JOIN, FULL OUTER JOIN simulado, CROSS JOIN, IN, LIKE, EXISTS,
--  HAVING, MIN/MAX e UNION), conforme exigido nos requisitos técnicos.
-- ============================================================================

-- --------------------------------------------------------------------------
-- A1 — RIGHT JOIN
-- Mesma informação do Relatório 3 (vendas por vendedor), obtida a partir
-- do lado "vendedores" via RIGHT JOIN, para demonstrar o uso do recurso.
-- --------------------------------------------------------------------------
SELECT
    vd.nome AS vendedor,
    COUNT(DISTINCT v.id_venda) AS qtd_vendas
FROM vendas v
RIGHT JOIN vendedores vd ON vd.id_vendedor = v.id_vendedor
GROUP BY vd.id_vendedor, vd.nome
ORDER BY qtd_vendas DESC;


-- --------------------------------------------------------------------------
-- A2 — FULL OUTER JOIN simulado no MySQL (LEFT JOIN + RIGHT JOIN + UNION)
-- Objetivo: comparar as cidades onde a SportZone tem clientes com as
-- cidades onde ela tem vendedores, identificando cidades com clientes
-- mas sem vendedor local (e vice-versa).
-- --------------------------------------------------------------------------
SELECT
    c.cidade                                                     AS cidade,
    'Possui clientes'                                            AS situacao,
    CASE WHEN vd.cidade IS NULL THEN 'Sem vendedor' ELSE 'Com vendedor' END AS vendedor_na_cidade
FROM clientes c
LEFT JOIN vendedores vd ON vd.cidade = c.cidade
GROUP BY c.cidade, vendedor_na_cidade

UNION

SELECT
    vd.cidade                                                    AS cidade,
    'Possui vendedor'                                            AS situacao,
    CASE WHEN c.cidade IS NULL THEN 'Sem cliente' ELSE 'Com cliente' END AS vendedor_na_cidade
FROM vendedores vd
LEFT JOIN clientes c ON c.cidade = vd.cidade
GROUP BY vd.cidade, vendedor_na_cidade

ORDER BY cidade;


-- --------------------------------------------------------------------------
-- A3 — CROSS JOIN + NOT EXISTS
-- Objetivo: cruzar todas as cidades de clientes com todas as categorias
-- de produto para encontrar combinações cidade x categoria que ainda
-- nunca geraram venda (oportunidades de expansão de mercado).
-- --------------------------------------------------------------------------
SELECT
    co.cidade,
    co.categoria
FROM (
    SELECT
        ci.cidade,
        ca.categoria
    FROM (
        SELECT DISTINCT cidade
        FROM clientes
    ) AS ci
    CROSS JOIN (
        SELECT DISTINCT categoria
        FROM produtos
    ) AS ca
) AS co
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT
            c.cidade,
            p.categoria
        FROM vendas v
        INNER JOIN clientes c ON c.id_cliente = v.id_cliente
        INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
        INNER JOIN produtos p ON p.id_produto = iv.id_produto
    ) AS vd
    WHERE vd.cidade = co.cidade
      AND vd.categoria = co.categoria
)
ORDER BY co.cidade, co.categoria;

-- --------------------------------------------------------------------------
-- A4 — IN, LIKE e EXISTS
-- Objetivo: localizar produtos das categorias de Musculação/Fitness cujo
-- nome contenha "Kit", ou que já tenham pelo menos uma venda registrada
-- (auditoria de catálogo para campanhas).
-- --------------------------------------------------------------------------
SELECT
    p.nome AS produto,
    p.categoria,
    p.marca,
    p.preco
FROM produtos p
WHERE (p.categoria IN ('Musculação', 'Fitness') AND p.nome LIKE '%Kit%')
   OR (p.categoria IN ('Musculação', 'Fitness') AND EXISTS (
        SELECT 1 FROM itens_venda iv WHERE iv.id_produto = p.id_produto
      ))
ORDER BY p.categoria, p.nome;


-- --------------------------------------------------------------------------
-- A5 — HAVING + MIN/MAX
-- Objetivo: identificar clientes de alto valor (gasto acima de R$ 3.000,00)
-- e mostrar a data da primeira e da última compra de cada um (janela de
-- relacionamento com a marca).
-- --------------------------------------------------------------------------
SELECT
    c.nome AS cliente,
    COUNT(DISTINCT v.id_venda)              AS qtd_compras,
    SUM(iv.quantidade * iv.preco_unitario)  AS valor_total,
    MIN(v.data_venda)                       AS primeira_compra,
    MAX(v.data_venda)                       AS ultima_compra
FROM clientes c
INNER JOIN vendas v       ON v.id_cliente = c.id_cliente
INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
GROUP BY c.id_cliente, c.nome
HAVING SUM(iv.quantidade * iv.preco_unitario) > 3000
ORDER BY valor_total DESC;


-- --------------------------------------------------------------------------
-- A6 — UNION
-- Objetivo: montar um mini "dashboard" com o Top 3 clientes e o Top 3
-- vendedores por faturamento em um único resultado.
-- --------------------------------------------------------------------------
SELECT * FROM (
    SELECT 'Cliente' AS tipo, c.nome AS nome, SUM(iv.quantidade * iv.preco_unitario) AS valor
    FROM clientes c
    INNER JOIN vendas v       ON v.id_cliente = c.id_cliente
    INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
    GROUP BY c.id_cliente, c.nome
    ORDER BY valor DESC
    LIMIT 3
) AS top_clientes

UNION

SELECT * FROM (
    SELECT 'Vendedor' AS tipo, vd.nome AS nome, SUM(iv.quantidade * iv.preco_unitario) AS valor
    FROM vendedores vd
    INNER JOIN vendas v       ON v.id_vendedor = vd.id_vendedor
    INNER JOIN itens_venda iv ON iv.id_venda = v.id_venda
    GROUP BY vd.id_vendedor, vd.nome
    ORDER BY valor DESC
    LIMIT 3
) AS top_vendedores

ORDER BY tipo, valor DESC;
