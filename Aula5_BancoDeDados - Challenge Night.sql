DROP DATABASE IF EXISTS techvendas;
CREATE DATABASE techvendas;
USE techvendas;

CREATE TABLE Clientes (
    id_cliente     INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente   VARCHAR(100) NOT NULL,
    cidade         VARCHAR(100) NOT NULL,
    data_cadastro  DATE         NOT NULL
);

CREATE TABLE Vendedores (
    id_vendedor    INT AUTO_INCREMENT PRIMARY KEY,
    nome_vendedor  VARCHAR(100) NOT NULL,
    setor          VARCHAR(50)  NOT NULL
);

CREATE TABLE Produtos (
    id_produto    INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto  VARCHAR(100)  NOT NULL,
    categoria     VARCHAR(50)   NOT NULL,
    preco         DECIMAL(10,2) NOT NULL
);

CREATE TABLE Vendas (
    id_venda      INT AUTO_INCREMENT PRIMARY KEY,
    data_venda    DATE NOT NULL,
    id_cliente    INT  NOT NULL,
    id_vendedor   INT  NOT NULL,
    CONSTRAINT fk_vendas_cliente
        FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente),
    CONSTRAINT fk_vendas_vendedor
        FOREIGN KEY (id_vendedor) REFERENCES Vendedores (id_vendedor)
);

CREATE TABLE Itens_Venda (
    id_item          INT AUTO_INCREMENT PRIMARY KEY,
    id_venda         INT           NOT NULL,
    id_produto       INT           NOT NULL,
    quantidade       INT           NOT NULL,
    valor_unitario   DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_itens_venda_venda
        FOREIGN KEY (id_venda) REFERENCES Vendas (id_venda),
    CONSTRAINT fk_itens_venda_produto
        FOREIGN KEY (id_produto) REFERENCES Produtos (id_produto)
);

CREATE TABLE Clientes_TechVendas (
    id_cliente    INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente  VARCHAR(100) NOT NULL,
    cpf           VARCHAR(11)  NOT NULL
);

CREATE TABLE Clientes_Empresa_Adquirida (
    id_cliente_adq  INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente    VARCHAR(100) NOT NULL,
    cpf             VARCHAR(11)  NOT NULL
);

INSERT INTO Clientes (nome_cliente, cidade, data_cadastro) VALUES
('Ana Souza',        'Curitiba',       '2025-02-10'),
('Bruno Lima',        'São Paulo',      '2025-03-05'),
('Carla Mendes',      'Curitiba',       '2025-03-18'),
('Diego Fernandes',   'Rio de Janeiro', '2025-04-22'),
('Elaine Ribeiro',    'Curitiba',       '2025-05-30'),
('Felipe Torres',     'Belo Horizonte', '2025-06-14'),
('Gabriela Rocha',    'São Paulo',      '2025-07-02'),
('Henrique Alves',    'Curitiba',       '2025-08-11'),
('Isabela Martins',   'Rio de Janeiro', '2025-09-25'),
('Rafael Nogueira',   'Curitiba',       '2025-10-01');

INSERT INTO Vendedores (nome_vendedor, setor) VALUES
('João Pedro',    'Eletrônicos'),
('Marina Alves',  'Informática'),
('Fernanda Dias', 'Utilidades Domésticas'),
('Rodrigo Souza', 'Eletrônicos'),
('Paulo Ricardo', 'Informática');

INSERT INTO Produtos (nome_produto, categoria, preco) VALUES
('Notebook Gamer',        'Informática',            4500.00),
('Mouse sem Fio',         'Informática',              79.90),
('Teclado Mecânico',      'Informática',             349.90),
('Smart TV 50"',          'Eletrônicos',            2699.00),
('Fone Bluetooth',        'Eletrônicos',             159.90),
('Caixa de Som Portátil', 'Eletrônicos',             229.90),
('Cafeteira Elétrica',    'Utilidades Domésticas',   199.90),
('Aspirador de Pó',       'Utilidades Domésticas',   349.00),
('Liquidificador',        'Utilidades Domésticas',   149.90),
('Ar-condicionado Split', 'Eletrônicos',            2199.00),
('Webcam Full HD',        'Informática',             219.90),
('Ferro de Passar',       'Utilidades Domésticas',    89.90);

INSERT INTO Vendas (data_venda, id_cliente, id_vendedor) VALUES
('2026-01-08', 1, 1),
('2026-01-15', 2, 2),
('2026-01-22', 1, 4),
('2026-02-03', 3, 3),
('2026-02-10', 4, 1),
('2026-02-18', 2, 2),
('2026-03-01', 6, 4),
('2026-03-09', 7, 3),
('2026-03-14', 1, 1),
('2026-03-20', 8, 4),
('2026-04-02', 9, 1),
('2026-04-11', 6, 2);

INSERT INTO Itens_Venda (id_venda, id_produto, quantidade, valor_unitario) VALUES
(1,  1, 1, 4500.00),
(1,  2, 1,   79.90),
(2,  3, 1,  349.90),
(3,  4, 1, 2699.00),
(4,  7, 2,  199.90),
(5,  6, 1,  229.90),
(5,  5, 1,  159.90),
(6,  2, 2,   79.90),
(7,  10,1, 2199.00),
(8,  9, 1,  149.90),
(9,  4, 1, 2699.00),
(10, 8, 1,  349.00),
(11, 1, 1, 4500.00),
(11, 11,1,  219.90),
(12, 3, 2,  349.90);

INSERT INTO Clientes_TechVendas (nome_cliente, cpf) VALUES
('Ana Souza',       '11111111111'),
('Bruno Lima',      '22222222222'),
('Carla Mendes',    '33333333333'),
('Diego Fernandes', '44444444444'),
('Elaine Ribeiro',  '55555555555'),
('Felipe Torres',   '66666666666');

INSERT INTO Clientes_Empresa_Adquirida (nome_cliente, cpf) VALUES
('Ana Souza',        '11111111111'),
('Carla Mendes',     '33333333333'),
('Marcelo Vidal',    '77777777777'),
('Patrícia Guimarães','88888888888'),
('Felipe Torres',    '66666666666'),
('Simone Castro',    '99999999999');



-- KPI 01 - Faturamento Mensal
-- Objetivo: Acompanhar a evolução do faturamento mês a mês para identificar
-- tendências de crescimento, queda ou sazonalidade nas vendas.
WITH receita_por_venda AS (
    SELECT
        v.id_venda,
        v.data_venda,
        SUM(iv.quantidade * iv.valor_unitario) AS valor_venda
    FROM Vendas AS v
    INNER JOIN Itens_Venda AS iv
        ON iv.id_venda = v.id_venda
    GROUP BY
        v.id_venda,
        v.data_venda
)
SELECT
    DATE_FORMAT(data_venda, '%Y-%m') AS mes_referencia,
    SUM(valor_venda) AS faturamento_mensal
FROM receita_por_venda
GROUP BY
    DATE_FORMAT(data_venda, '%Y-%m')
ORDER BY
    mes_referencia;
-- Interpretação: cada linha mostra o faturamento total de um mês. Uma
-- diretoria pode usar esse KPI para comparar meses, planejar metas e
-- identificar rapidamente quedas que exigem ação comercial.


-- KPI 02 - Clientes sem Nenhuma Compra
-- Objetivo: Identificar clientes cadastrados que nunca geraram receita,
-- para orientar campanhas de ativação ou reavaliação da base cadastrada.
SELECT
    c.id_cliente,
    c.nome_cliente,
    c.cidade,
    COUNT(v.id_venda) AS quantidade_compras
FROM Clientes AS c
LEFT JOIN Vendas AS v
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.id_cliente,
    c.nome_cliente,
    c.cidade
HAVING
    COUNT(v.id_venda) = 0
ORDER BY
    c.nome_cliente;
-- Interpretação: o resultado lista clientes "inativos" desde o cadastro.
-- Uma base grande nesse relatório indica oportunidade de campanhas de
-- reativação ou revisão da estratégia de aquisição de clientes.


-- KPI 03 - Top 5 Clientes por Valor Comprado
-- Objetivo: Destacar os clientes mais valiosos da empresa para ações de
-- fidelização e relacionamento comercial diferenciado.
WITH valor_por_cliente AS (
    SELECT
        c.id_cliente,
        c.nome_cliente,
        SUM(iv.quantidade * iv.valor_unitario) AS valor_total_comprado
    FROM Clientes AS c
    INNER JOIN Vendas AS v
        ON v.id_cliente = c.id_cliente
    INNER JOIN Itens_Venda AS iv
        ON iv.id_venda = v.id_venda
    GROUP BY
        c.id_cliente,
        c.nome_cliente
)
SELECT
    nome_cliente,
    valor_total_comprado
FROM valor_por_cliente
ORDER BY
    valor_total_comprado DESC
LIMIT 5;
-- Interpretação: esses são os clientes que mais geraram receita até o
-- momento. A diretoria comercial pode priorizá-los em programas de
-- fidelidade, condições especiais e atendimento consultivo.


-- KPI 04 - Vendedores sem Nenhuma Venda
-- Objetivo: Identificar vendedores cadastrados que ainda não converteram
-- nenhuma venda, sinalizando necessidade de treinamento ou suporte.
SELECT
    vd.id_vendedor,
    vd.nome_vendedor,
    vd.setor
FROM Vendedores AS vd
LEFT JOIN Vendas AS v
    ON v.id_vendedor = vd.id_vendedor
WHERE
    v.id_venda IS NULL;
-- Interpretação: vendedores nesta lista não fecharam nenhuma venda no
-- período analisado. Isso pode indicar onboarding recente, dificuldade
-- de desempenho ou necessidade de redistribuição de carteira.


-- KPI 05 - Ticket Médio por Vendedor
-- Objetivo: Avaliar o valor médio das vendas fechadas por cada vendedor,
-- permitindo comparar a qualidade das negociações entre a equipe.
WITH venda_valor AS (
    SELECT
        v.id_venda,
        v.id_vendedor,
        SUM(iv.quantidade * iv.valor_unitario) AS valor_venda
    FROM Vendas AS v
    INNER JOIN Itens_Venda AS iv
        ON iv.id_venda = v.id_venda
    GROUP BY
        v.id_venda,
        v.id_vendedor
)
SELECT
    vd.nome_vendedor,
    COUNT(DISTINCT vv.id_venda) AS quantidade_vendas,
    COALESCE(AVG(vv.valor_venda), 0) AS ticket_medio
FROM Vendedores AS vd
LEFT JOIN venda_valor AS vv
    ON vv.id_vendedor = vd.id_vendedor
GROUP BY
    vd.nome_vendedor
ORDER BY
    ticket_medio DESC;
-- Interpretação: vendedores com ticket médio mais alto tendem a negociar
-- produtos de maior valor ou vendas casadas. Vendedores com ticket médio
-- baixo podem se beneficiar de treinamento em upsell e cross-sell.


-- KPI 06 - Diversidade de Categorias por Cliente
-- Objetivo: Medir a amplitude do consumo de cada cliente entre as
-- categorias de produtos, identificando clientes com potencial de
-- venda cruzada ainda não explorado.
SELECT
    c.nome_cliente,
    COUNT(DISTINCT p.categoria) AS categorias_distintas_compradas
FROM Clientes AS c
INNER JOIN Vendas AS v
    ON v.id_cliente = c.id_cliente
INNER JOIN Itens_Venda AS iv
    ON iv.id_venda = v.id_venda
INNER JOIN Produtos AS p
    ON p.id_produto = iv.id_produto
GROUP BY
    c.nome_cliente
ORDER BY
    categorias_distintas_compradas DESC;
-- Interpretação: clientes que compram em apenas uma categoria são
-- candidatos naturais para ofertas de categorias ainda não exploradas,
-- aumentando o valor de vida (LTV) de cada conta.


-- KPI 07 - Produtos sem Movimentação de Vendas
-- Objetivo: Apontar produtos cadastrados que nunca foram vendidos, para
-- apoiar decisões sobre reposicionamento, promoção ou descontinuação.
SELECT
    p.id_produto,
    p.nome_produto,
    p.categoria,
    p.preco
FROM Produtos AS p
LEFT JOIN Itens_Venda AS iv
    ON iv.id_produto = p.id_produto
WHERE
    iv.id_item IS NULL;
-- Interpretação: itens nesta lista representam capital parado em
-- estoque sem retorno em vendas. A empresa pode avaliar ações de
-- marketing pontuais ou reavaliar a permanência desses produtos no mix.


-- KPI 08 - Faturamento Médio por Categoria
-- Objetivo: Comparar categorias de produtos pelo valor médio gerado por
-- item vendido, indicando quais categorias entregam maior valor agregado.
SELECT
    p.categoria,
    COUNT(iv.id_item) AS itens_vendidos,
    AVG(iv.quantidade * iv.valor_unitario) AS faturamento_medio_por_venda
FROM Produtos AS p
INNER JOIN Itens_Venda AS iv
    ON iv.id_produto = p.id_produto
GROUP BY
    p.categoria
ORDER BY
    faturamento_medio_por_venda DESC;
-- Interpretação: categorias com faturamento médio maior por item
-- costumam ter produtos de ticket mais alto. Esse KPI ajuda a decidir
-- onde concentrar esforço comercial para maximizar receita por venda.


-- KPI 09 - Amplitude de Preços por Categoria
-- Objetivo: Entender a variação de preços dentro de cada categoria,
-- apoiando decisões de posicionamento e política de descontos.
SELECT
    p.categoria,
    COUNT(p.id_produto) AS quantidade_produtos,
    MIN(p.preco) AS menor_preco,
    MAX(p.preco) AS maior_preco,
    AVG(p.preco) AS preco_medio
FROM Produtos AS p
GROUP BY
    p.categoria
ORDER BY
    preco_medio DESC;
-- Interpretação: categorias com grande amplitude entre menor e maior
-- preço podem exigir segmentação de público (entrada vs. premium),
-- enquanto categorias com pouca variação sugerem posicionamento único.


-- KPI 10 - Clientes Recorrentes vs. Clientes de Compra Única
-- Objetivo: Separar clientes que compraram mais de uma vez dos que
-- compraram apenas uma vez, medindo a fidelização da base ativa.
WITH compras_por_cliente AS (
    SELECT
        c.id_cliente,
        c.nome_cliente,
        COUNT(v.id_venda) AS quantidade_compras
    FROM Clientes AS c
    INNER JOIN Vendas AS v
        ON v.id_cliente = c.id_cliente
    GROUP BY
        c.id_cliente,
        c.nome_cliente
)
SELECT
    CASE
        WHEN quantidade_compras > 1 THEN 'Recorrente'
        ELSE 'Compra Única'
    END AS perfil_cliente,
    COUNT(*) AS quantidade_clientes
FROM compras_por_cliente
GROUP BY
    CASE
        WHEN quantidade_compras > 1 THEN 'Recorrente'
        ELSE 'Compra Única'
    END
ORDER BY
    quantidade_clientes DESC;
-- Interpretação: quanto maior a proporção de clientes recorrentes,
-- mais saudável é a retenção da empresa. Uma base concentrada em
-- compra única aponta a necessidade de estratégias de recompra.


-- KPI 11 - Participação Percentual de Cada Vendedor no Faturamento
-- Objetivo: Mostrar o peso de cada vendedor no resultado total da
-- empresa, apoiando decisões de bonificação e dimensionamento de equipe.
WITH faturamento_vendedor AS (
    SELECT
        vd.id_vendedor,
        vd.nome_vendedor,
        COALESCE(SUM(iv.quantidade * iv.valor_unitario), 0) AS faturamento
    FROM Vendedores AS vd
    LEFT JOIN Vendas AS v
        ON v.id_vendedor = vd.id_vendedor
    LEFT JOIN Itens_Venda AS iv
        ON iv.id_venda = v.id_venda
    GROUP BY
        vd.id_vendedor,
        vd.nome_vendedor
)
SELECT
    nome_vendedor,
    faturamento,
    ROUND(
        faturamento * 100.0 / NULLIF((SELECT SUM(faturamento) FROM faturamento_vendedor), 0),
        2
    ) AS percentual_participacao
FROM faturamento_vendedor
ORDER BY
    percentual_participacao DESC;
-- Interpretação: vendedores com participação desproporcionalmente alta
-- indicam concentração de resultado em poucas pessoas, um risco para a
-- continuidade do negócio caso esse profissional saia da empresa.


-- KPI 12 - Faturamento por Dia da Semana
-- Objetivo: Identificar em quais dias da semana a empresa mais vende,
-- apoiando decisões sobre escala de equipe e campanhas promocionais.
WITH receita_por_venda AS (
    SELECT
        v.id_venda,
        v.data_venda,
        SUM(iv.quantidade * iv.valor_unitario) AS valor_venda
    FROM Vendas AS v
    INNER JOIN Itens_Venda AS iv
        ON iv.id_venda = v.id_venda
    GROUP BY
        v.id_venda,
        v.data_venda
)
SELECT
    DAYNAME(data_venda) AS dia_da_semana,
    COUNT(id_venda) AS quantidade_vendas,
    SUM(valor_venda) AS faturamento_total
FROM receita_por_venda
GROUP BY
    DAYNAME(data_venda)
ORDER BY
    faturamento_total DESC;
-- Interpretação: dias com maior faturamento merecem reforço de equipe e
-- estoque, enquanto dias fracos podem receber promoções pontuais para
-- equilibrar o fluxo de vendas ao longo da semana.


-- KPI 13 - Taxa de Conversão da Base de Clientes
-- Objetivo: Medir qual proporção da base total de clientes cadastrados
-- já efetuou pelo menos uma compra, um indicador direto de ativação.
WITH clientes_compradores AS (
    SELECT DISTINCT id_cliente
    FROM Vendas
)
SELECT
    (SELECT COUNT(*) FROM Clientes) AS total_clientes_cadastrados,
    COUNT(cc.id_cliente) AS total_clientes_compradores,
    ROUND(
        COUNT(cc.id_cliente) * 100.0 / (SELECT COUNT(*) FROM Clientes),
        2
    ) AS taxa_conversao_percentual
FROM Clientes AS c
LEFT JOIN clientes_compradores AS cc
    ON cc.id_cliente = c.id_cliente;
-- Interpretação: uma taxa de conversão baixa indica que grande parte da
-- base cadastrada nunca comprou, sinalizando oportunidade de campanhas
-- de ativação ou revisão do processo comercial pós-cadastro.


-- KPI 14 - Ticket Médio por Item Vendido
-- Objetivo: Calcular o valor médio de cada linha de item vendido,
-- complementando o ticket médio por venda com uma visão por produto.
SELECT
    COUNT(iv.id_item) AS total_itens_vendidos,
    AVG(iv.quantidade * iv.valor_unitario) AS ticket_medio_por_item,
    MIN(iv.quantidade * iv.valor_unitario) AS menor_valor_item,
    MAX(iv.quantidade * iv.valor_unitario) AS maior_valor_item
FROM Itens_Venda AS iv;



-- KPI 15 - Ranking de Produtos por Faturamento dentro da Categoria
WITH faturamento_produto AS (
    SELECT
        p.categoria,
        p.nome_produto,
        COALESCE(SUM(iv.quantidade * iv.valor_unitario), 0) AS faturamento
    FROM Produtos AS p
    LEFT JOIN Itens_Venda AS iv
        ON iv.id_produto = p.id_produto
    GROUP BY
        p.categoria,
        p.nome_produto
)
SELECT
    categoria,
    nome_produto,
    faturamento
FROM faturamento_produto
ORDER BY
    categoria,
    faturamento DESC;
