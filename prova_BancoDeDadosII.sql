CREATE DATABASE db_garantia_safra;

USE db_garantia_safra;

SELECT * FROM garantia_safra;


-- 1.2 Soma de valores e total de registros por ano

WITH resumo_garantia_safra AS (

    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        SUM(valor_parcela) AS Dinheiro_Movimentado,
        COUNT(*) AS Total_Parcelas_Pagas
    FROM garantia_safra
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    Dinheiro_Movimentado,
    Total_Parcelas_Pagas
FROM resumo_garantia_safra
ORDER BY Ano DESC, Dinheiro_Movimentado DESC;

-- 1.3 Beneficiários e municípios distintos

WITH resumo_garantia_safra AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        COUNT(DISTINCT nome_favorecido) AS Quantidade_beneficiarios,
        COUNT(DISTINCT id_municipio) AS Quantidade_municipios
    FROM garantia_safra
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    Quantidade_beneficiarios,
    Quantidade_municipios
FROM resumo_garantia_safra
ORDER BY Ano DESC, UF ASC;

-- 1.4 Ticket Médio e valor máximo

WITH resumo_garantia_safra AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        AVG(valor_parcela) AS ticket_medio,
        MAX(valor_parcela) AS maior_valor_registrado
    FROM garantia_safra
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    ticket_medio,
    maior_valor_registrado
FROM resumo_garantia_safra
ORDER BY Ano DESC, UF ASC;

-- 1.5 Parcelas altas, médias ou baixas

WITH classificacao_parcelas AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        COUNT(CASE WHEN valor_parcela > 500 THEN 1 END) AS qtd_alta,
        COUNT(CASE WHEN valor_parcela BETWEEN 201 AND 500 THEN 1 END) AS qtd_media,
        COUNT(CASE WHEN valor_parcela <= 200 THEN 1 END) AS qtd_baixa
    FROM garantia_safra
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    qtd_alta,
    qtd_media,
    qtd_baixa
FROM classificacao_parcelas
ORDER BY Ano DESC, UF ASC;

-- 1.6 Relatório Final

WITH relatorio_final AS (
    SELECT 
        sigla_uf,
        ano_referencia,
        SUM(valor_parcela) AS valor_total,
        COUNT(*) AS qtd_parcelas,
        COUNT(DISTINCT nome_favorecido) AS beneficiarios_unicos,
        COUNT(DISTINCT id_municipio) AS municipios_atendidos,
        AVG(valor_parcela) AS ticket_medio,
        MAX(valor_parcela) AS maior_valor,
        
        COUNT(CASE WHEN valor_parcela > 500 THEN 1 END) AS qtd_alta,
        COUNT(CASE WHEN valor_parcela BETWEEN 201 AND 500 THEN 1 END) AS qtd_media,
        COUNT(CASE WHEN valor_parcela <= 200 THEN 1 END) AS qtd_baixa
    FROM garantia_safra
    GROUP BY sigla_uf, ano_referencia
)
SELECT 
    sigla_uf,
    ano_referencia,
    valor_total,
    qtd_parcelas,
    beneficiarios_unicos,
    municipios_atendidos,
    ticket_medio,
    maior_valor,
    qtd_alta,
    qtd_media,
    qtd_baixa,
    
    CASE 
        WHEN ticket_medio > 500 THEN 'Alto'
        WHEN ticket_medio BETWEEN 201 AND 500 THEN 'Médio'
        ELSE 'Baixo'
    END AS classificao_ticket
FROM relatorio_final
ORDER BY ano_referencia ASC, valor_total DESC;

-- 2.1 Somente 2020

WITH registros_2020 AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio,
        nis_favorecido,
        nome_favorecido,
        valor_parcela
    FROM garantia_safra
    WHERE ano_referencia = 2020
)
SELECT 
    Ano,
    UF,
    id_municipio,
    nis_favorecido,
    nome_favorecido,
    valor_parcela
FROM registros_2020
ORDER BY UF DESC, nome_favorecido ASC;

-- 2.2 Total recebido por uf e quantidade de parcelas pagas

WITH resumo_garantia_safra AS (

    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        SUM(valor_parcela) AS valor_uf,
        COUNT(*) AS Total_Parcelas_Pagas
    FROM garantia_safra
	WHERE ano_referencia = 2020
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    valor_uf,
    Total_Parcelas_Pagas
FROM resumo_garantia_safra
ORDER BY valor_uf desc;

-- 2.3 Total beneficiários

WITH resumo_garantia_safra AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        COUNT(DISTINCT nome_favorecido) AS Quantidade_beneficiarios
    FROM garantia_safra
	WHERE ano_referencia = 2020
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    Quantidade_beneficiarios
FROM resumo_garantia_safra
ORDER BY Quantidade_beneficiarios DESC;

-- 2.4 Municipios distintos por uf

WITH resumo_garantia_safra AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
		COUNT(DISTINCT id_municipio) AS Quantidade_municipios
    FROM garantia_safra
    WHERE ano_referencia = 2020
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    Quantidade_municipios
FROM resumo_garantia_safra
ORDER BY Quantidade_municipios DESC;

-- 2.5 Valor total brasil

WITH resumo_garantia_safra AS (

    SELECT 
        ano_referencia AS Ano,
        SUM(valor_parcela) AS Dinheiro_Brasil,
        COUNT(*) AS Total_Parcelas_Pagas
    FROM garantia_safra
	WHERE ano_referencia = 2020
    GROUP BY ano_referencia
)
SELECT 
    Ano,
    Dinheiro_Brasil
FROM resumo_garantia_safra
ORDER BY Dinheiro_Movimentado desc;

-- 2.6 Valor uf alto medio baixo

WITH resumo_garantia_safra AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        SUM(valor_parcela) AS valor_uf
    FROM garantia_safra
    WHERE ano_referencia = 2020
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    valor_uf, 
    CASE 
        WHEN valor_uf >= 20000 THEN 'ALTO' 
        WHEN valor_uf >= 10000 AND valor_uf < 20000 THEN 'MÉDIO'
        ELSE 'BAIXO'
    END AS FAIXA
FROM resumo_garantia_safra
ORDER BY valor_uf DESC;

-- 2.7 CTE maiores valoretes totais

WITH melhores_uf AS (

    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        SUM(valor_parcela) AS valor_uf,
        COUNT(*) AS Total_Parcelas_Pagas
    FROM garantia_safra
	WHERE ano_referencia = 2020
    GROUP BY ano_referencia, sigla_uf
)
SELECT 
    Ano,
    UF,
    valor_uf,
    Total_Parcelas_Pagas
FROM melhores_uf
ORDER BY valor_uf desc LIMIT 5;

-- 2.8 Relatório Final

WITH resumo_2020 AS (
    SELECT 
        sigla_uf AS UF,
        SUM(valor_parcela) AS valor_total,
        COUNT(*) AS qtd_parcelas,
        COUNT(DISTINCT nome_favorecido) AS beneficiarios,
        COUNT(DISTINCT id_municipio) AS municipios
    FROM garantia_safra
    WHERE ano_referencia = 2020
    GROUP BY sigla_uf,
),
calculo_percentual AS (
    SELECT 
        UF,
        valor_total,
        qtd_parcelas,
        beneficiarios,
        municipios,

        ROUND((valor_total / SUM(valor_total) ) * 100, 2) AS participacao_pct,
        
        ROW_NUMBER() OVER(ORDER BY valor_total DESC) AS ranking
    FROM resumo_2020
)
SELECT 
    UF,
    valor_total,
    qtd_parcelas,
    beneficiarios,
    municipios,
    participacao_pct,

    CASE 
        WHEN valor_total >= 20000 THEN 'ALTO'
        WHEN valor_total >= 10000 AND valor_total < 20000 THEN 'MÉDIO'
        ELSE 'BAIXO'
    END AS faixa,
    
    CASE 
        WHEN ranking = 1 THEN 'LÍDER_BR'
        ELSE 'TOP_5'
    END AS grupo_destaque
FROM calculo_percentual
ORDER BY valor_total DESC
LIMIT 5;

-- 3.1 A partir de 2020

WITH registros_2020 AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio,
        nis_favorecido,
        nome_favorecido,
        valor_parcela
    FROM garantia_safra
    WHERE ano_referencia >= 2020
)
SELECT 
    Ano,
    UF,
    id_municipio,
    nis_favorecido,
    nome_favorecido,
    valor_parcela
FROM registros_2020
ORDER BY UF DESC, nome_favorecido ASC;

-- 3.2 Valores beneficiarios

WITH resumo_garantia_safra AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio AS Municipio, 
        nome_favorecido AS Nome,
        SUM(valor_parcela) AS valor_total_recebido,
        AVG(valor_parcela) AS media_por_parcela,
        COUNT(*) AS quantidade_parcelas
    FROM garantia_safra
    WHERE ano_referencia >= 2020
    GROUP BY ano_referencia, sigla_uf, id_municipio, nome_favorecido
)
SELECT 
    UF,
    Ano,
    Municipio,
    Nome,
    valor_total_recebido,
    media_por_parcela,
    quantidade_parcelas
FROM resumo_garantia_safra
ORDER BY UF ASC, Ano DESC,  Municipio ASC, Nome ASC;

-- 3.3 Valor de cada municipio por ano

WITH resumo_municipios AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio AS Municipio, 
        SUM(valor_parcela) AS valor_total_municipio,
        COUNT(*) AS total_parcelas_pagas
    FROM garantia_safra
    WHERE ano_referencia >= 2020

    GROUP BY ano_referencia, sigla_uf, id_municipio
)
SELECT 
    UF,
    Ano,
    Municipio,
    valor_total_municipio
FROM resumo_municipios
ORDER BY UF ASC, Ano DESC, valor_total_municipio DESC;

-- 3.4 valor maximo por beneficiario

WITH max_cliente AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio AS Municipio, 
        nome_favorecido AS Nome,
        SUM(valor_parcela) AS valor_total_recebido,
        MAX(valor_parcela) AS valor_max_cliente
    FROM garantia_safra
    WHERE ano_referencia >= 2020
    GROUP BY ano_referencia, sigla_uf, id_municipio, nome_favorecido
)
SELECT 
    UF,
    Ano,
    Municipio,
    Nome,
    valor_total_recebido,
	valor_max_cliente
FROM max_cliente
ORDER BY UF ASC, Ano DESC,  Municipio ASC, Nome ASC;

-- 3.5 cte que classifique valor total alto medio baixo

WITH valor_total AS (
    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio AS Municipio, 
        nome_favorecido AS Nome,
        SUM(valor_parcela) AS valor_total_class
    FROM garantia_safra
    WHERE ano_referencia >= 2020
    GROUP BY ano_referencia, sigla_uf, id_municipio, nome_favorecido
)
SELECT 
    UF,
    Ano,
    Municipio,
    Nome,
    valor_total_class,
        CASE 
        WHEN valor_total_class >= 800 THEN 'ALTO' 
        WHEN valor_total_class >= 500 AND valor_total_class < 800 THEN 'MÉDIO'
        ELSE 'BAIXO'
    END AS CLASSE
FROM valor_total
ORDER BY UF ASC, Ano DESC,  Municipio ASC, Nome ASC;

-- 3.6 Relatório final FINAL AAAAAAAAAAAAAAAAAAAA

WITH metricas_municipios AS (

    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio AS Municipio,
        SUM(valor_parcela) AS valor_total_municipio
    FROM garantia_safra
    WHERE ano_referencia >= 2020
    GROUP BY ano_referencia, sigla_uf, id_municipio
),

metricas_beneficiarios AS (

    SELECT 
        ano_referencia AS Ano,
        sigla_uf AS UF,
        id_municipio AS Municipio,
        nis_favorecido AS NIS,
        nome_favorecido AS Nome,
        SUM(valor_parcela) AS total_recebido,
        AVG(valor_parcela) AS media_por_parcela,
        COUNT(*) AS quantidade_parcelas
    FROM garantia_safra
    WHERE ano_referencia >= 2020
    GROUP BY ano_referencia, sigla_uf, id_municipio, nis_favorecido, nome_favorecido
),

consolidacao_final AS (

    SELECT 
        b.UF,
        b.Municipio,
        b.Ano,
        b.NIS,
        b.Nome,
        b.total_recebido,
        b.media_por_parcela,
        b.quantidade_parcelas,
        m.valor_total_municipio,
        

        ROUND((b.total_recebido / m.valor_total_municipio) * 100, 2) AS participacao_pct,
        

        MAX(b.total_recebido) OVER(PARTITION BY b.Ano, b.UF, b.Municipio) AS maior_total_individual_municipio
    FROM metricas_beneficiarios b
    INNER JOIN metricas_municipios m 
        ON b.Ano = m.Ano 
       AND b.UF = m.UF 
       AND b.Municipio = m.Municipio
)


SELECT 
    UF,
    Municipio,
    Ano,
    NIS,
    Nome,
    total_recebido AS 'TOTAL RECEBIDO',
    media_por_parcela AS 'MEDIA POR PARCELA',
    quantidade_parcelas AS 'QUANTIDADE PARCELAS',
    valor_total_municipio AS 'TOTAL DO MUNICIPIO',
    participacao_pct AS 'PARTICIPACAO_PCT',
    maior_total_individual_municipio AS 'MAIOR TOTAL INDIVIDUAL DO MUNICIPIO',
    
    CASE 
        WHEN total_recebido >= 800 THEN 'ALTO'
        WHEN total_recebido >= 500 AND total_recebido < 800 THEN 'MÉDIO'
        ELSE 'BAIXO'
    END AS faixa_de_valor,
    
    CASE 
        WHEN total_recebido = maior_total_individual_municipio THEN 'DESTAQUE_MUNICIPAL'
        ELSE 'OUTROS'
    END AS grupo_destaque
FROM consolidacao_final

ORDER BY UF ASC, Municipio ASC, Nome ASC;


