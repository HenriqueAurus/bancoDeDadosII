CREATE DATABASE cts;
USE cts;

DROP TABLE IF EXISTS vendas;

CREATE TABLE vendas (
    codigo_venda    INT PRIMARY KEY,
    data_venda      DATE NOT NULL,
    cliente         VARCHAR(100) NOT NULL,
    produto         VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50)  NOT NULL,
    quantidade      INT NOT NULL,
    valor_total     DECIMAL(10,2) NOT NULL,
    vendedor        VARCHAR(100) NOT NULL,
    status_venda    VARCHAR(20)  NOT NULL,   -- Concluída, Cancelada, Pendente...
    estado_cliente  VARCHAR(2)   NOT NULL    -- UF do cliente
);

-- Campos aleatórios


INSERT INTO vendas
(codigo_venda, data_venda, cliente, produto, categoria, quantidade, valor_total, vendedor, status_venda, estado_cliente)
VALUES
(1,  '2024-01-05', 'Ana Souza',      'Notebook X1',      'Eletrônicos', 1, 4500.00, 'Carlos Lima',   'Concluída', 'SP'),
(2,  '2024-01-08', 'Bruno Alves',    'Mouse Gamer',       'Eletrônicos', 2,  250.00, 'Fernanda Reis', 'Concluída', 'SP'),
(3,  '2024-01-10', 'Carla Dias',     'Cadeira Escritório','Móveis',      1,  900.00, 'Carlos Lima',   'Cancelada', 'RJ'),
(4,  '2024-01-12', 'Diego Martins',  'Mesa de Jantar',    'Móveis',      1, 1800.00, 'Juliana Costa', 'Concluída', 'MG'),
(5,  '2024-01-15', 'Elaine Pires',   'Smartphone Y2',     'Eletrônicos', 1, 3200.00, 'Fernanda Reis', 'Concluída', 'SP'),
(6,  '2024-01-18', 'Fábio Rocha',    'Sofá 3 Lugares',    'Móveis',      1, 2500.00, 'Carlos Lima',   'Concluída', 'PR'),
(7,  '2024-01-20', 'Gabriela Nunes', 'Fone Bluetooth',    'Eletrônicos', 3,  450.00, 'Juliana Costa', 'Pendente',  'RJ'),
(8,  '2024-01-22', 'Hugo Barros',    'Estante Livros',    'Móveis',      1,  700.00, 'Fernanda Reis', 'Concluída', 'MG'),
(9,  '2024-01-25', 'Isabela Farias', 'Monitor 27"',       'Eletrônicos', 2, 2600.00, 'Carlos Lima',   'Concluída', 'SP'),
(10, '2024-01-28', 'João Pedro',     'Guarda-Roupa',      'Móveis',      1, 1500.00, 'Juliana Costa', 'Concluída', 'PR'),
(11, '2024-02-02', 'Karina Melo',    'Teclado Mecânico',  'Eletrônicos', 1,  550.00, 'Fernanda Reis', 'Concluída', 'SP'),
(12, '2024-02-05', 'Lucas Tavares',  'Cama Box Casal',    'Móveis',      1, 2200.00, 'Carlos Lima',   'Cancelada', 'RJ'),
(13, '2024-02-08', 'Marcela Rangel', 'Tablet Z10',        'Eletrônicos', 1, 1900.00, 'Juliana Costa', 'Concluída', 'MG'),
(14, '2024-02-11', 'Nelson Prado',   'Rack para TV',      'Móveis',      1,  850.00, 'Fernanda Reis', 'Concluída', 'SP'),
(15, '2024-02-14', 'Olívia Castro',  'Smart TV 50"',      'Eletrônicos', 1, 3800.00, 'Carlos Lima',   'Concluída', 'PR'),
(16, '2024-02-17', 'Paulo Vieira',   'Poltrona Reclinável','Móveis',     1, 1600.00, 'Juliana Costa', 'Concluída', 'RJ'),
(17, '2024-02-20', 'Queila Duarte',  'Caixa de Som',      'Eletrônicos', 2,  600.00, 'Fernanda Reis', 'Concluída', 'SP'),
(18, '2024-02-23', 'Rafael Gomes',   'Mesa de Escritório','Móveis',      1, 1100.00, 'Carlos Lima',   'Concluída', 'MG'),
(19, '2024-02-26', 'Sara Lopes',     'Impressora Laser',  'Eletrônicos', 1,  980.00, 'Juliana Costa', 'Concluída', 'PR'),
(20, '2024-03-01', 'Tiago Ramos',    'Armário Cozinha',   'Móveis',      1, 1950.00, 'Fernanda Reis', 'Concluída', 'SP');


-- QUESTÃO 1 — Vendas concluídas
WITH vendas_concluidas AS (
    SELECT
        codigo_venda,
        data_venda,
        cliente,
        produto,
        valor_total,
        vendedor
    FROM vendas
    WHERE status_venda = 'Concluída'
)
SELECT
    codigo_venda,
    data_venda,
    cliente,
    produto,
    valor_total,
    vendedor
FROM vendas_concluidas
ORDER BY valor_total DESC;

-- QUESTÃO 2 — Faturamento por categoria
WITH resumo_categorias AS (
    SELECT
        categoria,
        COUNT(*)              AS quantidade_vendas,
        SUM(quantidade)       AS total_produtos_vendidos,
        SUM(valor_total)      AS faturamento_total,
        AVG(valor_total)      AS valor_medio_vendas
    FROM vendas
    GROUP BY categoria
)
SELECT
    categoria,
    quantidade_vendas,
    total_produtos_vendidos,
    faturamento_total,
    valor_medio_vendas
FROM resumo_categorias
WHERE faturamento_total > 10000.00
ORDER BY faturamento_total DESC;

-- QUESTÃO 3 — Desempenho dos vendedores
WITH desempenho_vendedores AS (
    SELECT
        vendedor,
        COUNT(*)              AS quantidade_vendas,
        SUM(quantidade)       AS total_produtos_vendidos,
        SUM(valor_total)      AS valor_total_vendido,
        AVG(valor_total)      AS ticket_medio
    FROM vendas
    GROUP BY vendedor
)
SELECT
    vendedor,
    quantidade_vendas,
    total_produtos_vendidos,
    valor_total_vendido,
    ticket_medio
FROM desempenho_vendedores
ORDER BY valor_total_vendido DESC
LIMIT 3;

-- QUESTÃO 4 — Estados com faturamento acima da média
WITH vendas_validas AS (
    SELECT *
    FROM vendas
    WHERE quantidade > 0
      AND status_venda <> 'Cancelada'
),

faturamento_estados AS (
    SELECT
        estado_cliente,
        COUNT(*)              AS quantidade_vendas,
        SUM(quantidade)       AS total_produtos_vendidos,
        SUM(valor_total)      AS faturamento_total
    FROM vendas_validas
    GROUP BY estado_cliente
),

media_faturamento AS (
    SELECT AVG(faturamento_total) AS media_geral
    FROM faturamento_estados
)

SELECT
    fe.estado_cliente,
    fe.quantidade_vendas,
    fe.total_produtos_vendidos,
    fe.faturamento_total,
    mf.media_geral,
    fe.faturamento_total - mf.media_geral AS diferenca_para_media
FROM faturamento_estados fe
CROSS JOIN media_faturamento mf
WHERE fe.faturamento_total > mf.media_geral
ORDER BY fe.faturamento_total DESC;

-- DESAFIO ADICIONAL — Questão 2 reescrita com subquery
SELECT
    categoria,
    quantidade_vendas,
    total_produtos_vendidos,
    faturamento_total,
    valor_medio_vendas
FROM (
    SELECT
        categoria,
        COUNT(*)              AS quantidade_vendas,
        SUM(quantidade)       AS total_produtos_vendidos,
        SUM(valor_total)      AS faturamento_total,
        AVG(valor_total)      AS valor_medio_vendas
    FROM vendas
    GROUP BY categoria
) AS resumo_categorias
WHERE faturamento_total > 10000.00
ORDER BY faturamento_total DESC;

