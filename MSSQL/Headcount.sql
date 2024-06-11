SELECT
    FORMAT(REFERENCIA, 'MM/yyyy') AS MES,
    HFU.CODEMP AS ID_EMPRESA,
    EMP.RAZAOSOCIAL AS EMPRESA,
    DEP.CODDEP AS ID_DEPARTAMENTO,
    DEP.DESCRDEP AS DEPARTAMENTO,
    CUS.CODCENCUS AS ID_CENTRO_DE_RESULTADO,
    CUS.DESCRCENCUS AS CENTRO_DE_RESULTADO,
    CAR.CODCARGO AS ID_CARGO,
    CAR.DESCRCARGO AS CARGO,
    FUN.CODFUNC AS ID_COLABORADOR,
    COUNT(DISTINCT HFU.CODFUNC) AS HEADCOUNT,
    0 AS QUANTIDADE_ADMISSOES,
    0 AS QUANTIDADE_DEMISSOES
FROM TFPHFU HFU
LEFT JOIN TSIEMP EMP ON EMP.CODEMP = HFU.CODEMP
LEFT JOIN TFPFCO FCO ON FCO.CODFUNCAO = HFU.CODFUNCAO
LEFT JOIN TFPCAR CAR ON HFU.CODCARGO = CAR.CODCARGO
LEFT JOIN TFPDEP DEP ON DEP.CODDEP = HFU.CODDEP
LEFT JOIN TSICUS CUS ON CUS.CODCENCUS = DEP.CODCENCUS  
LEFT JOIN TFPFUN FUN ON HFU.CODFUNC = FUN.CODFUNC   
WHERE HFU.SITUACAO <> 0
GROUP BY 
    FORMAT(REFERENCIA, 'MM/yyyy'),
    DEP.CODDEP,
    CAR.CODCARGO,
    FCO.CODFUNCAO,
    DEP.DESCRDEP,
    CUS.CODCENCUS,
    CUS.DESCRCENCUS,
    CAR.CODCARGO,
    CAR.DESCRCARGO,
    HFU.CODEMP,
    EMP.RAZAOSOCIAL,
    FUN.CODFUNC,
    FUN.NOMEFUNC

UNION ALL

SELECT
    FORMAT(DTADM, 'MM/yyyy') AS MES,
    EMP.CODEMP AS ID_EMPRESA,
    EMP.RAZAOSOCIAL AS EMPRESA,
    DEP.CODDEP AS ID_DEPARTAMENTO,
    DEP.DESCRDEP AS DEPARTAMENTO,
    CUS.CODCENCUS AS ID_CENTRO_DE_RESULTADO,
    CUS.DESCRCENCUS AS CENTRO_DE_RESULTADO,
    CAR.CODCARGO AS ID_CARGO,
    CAR.DESCRCARGO AS CARGO,
    FUN.CODFUNC AS ID_COLABORADOR,
    0 AS HEADCOUNT,
    COUNT(DISTINCT CODFUNC) AS QUANTIDADE_ADMISSOES,
    0 AS QUANTIDADE_DEMISSOES
FROM TFPFUN FUN
LEFT JOIN TFPFCO FCO ON FCO.CODFUNCAO = FUN.CODFUNCAO
LEFT JOIN TSIEMP EMP ON EMP.CODEMP = FUN.CODEMP
LEFT JOIN TFPCAR CAR ON FUN.CODCARGO = CAR.CODCARGO
LEFT JOIN TFPDEP DEP ON DEP.CODDEP = FUN.CODDEP
LEFT JOIN TSICUS CUS ON CUS.CODCENCUS = DEP.CODCENCUS 
GROUP BY
    FORMAT(DTADM, 'MM/yyyy'),
    DEP.CODDEP,
    CAR.CODCARGO,
    FCO.CODFUNCAO,
    DEP.DESCRDEP,
    CUS.CODCENCUS,
    CUS.DESCRCENCUS,
    CAR.CODCARGO,
    CAR.DESCRCARGO,
    EMP.CODEMP,
    EMP.RAZAOSOCIAL,
    FUN.CODFUNC,
    FUN.NOMEFUNC

UNION ALL

SELECT
    FORMAT(DTDEM, 'MM/yyyy') AS MES,
    EMP.CODEMP AS ID_EMPRESA,
    EMP.RAZAOSOCIAL AS EMPRESA,
    DEP.CODDEP AS ID_DEPARTAMENTO,
    DEP.DESCRDEP AS DEPARTAMENTO,
    CUS.CODCENCUS AS ID_CENTRO_DE_RESULTADO,
    CUS.DESCRCENCUS AS CENTRO_DE_RESULTADO,
    CAR.CODCARGO AS ID_CARGO,
    CAR.DESCRCARGO AS CARGO,
    FUN.CODFUNC AS ID_COLABORADOR,
    0 AS HEADCOUNT,
    0 AS QUANTIDADE_ADMISSOES,
    COUNT(DISTINCT CODFUNC) AS QUANTIDADE_DEMISSOES
FROM TFPFUN FUN
LEFT JOIN TFPFCO FCO ON FCO.CODFUNCAO = FUN.CODFUNCAO
LEFT JOIN TSIEMP EMP ON EMP.CODEMP = FUN.CODEMP
LEFT JOIN TFPCAR CAR ON FUN.CODCARGO = CAR.CODCARGO
LEFT JOIN TFPDEP DEP ON DEP.CODDEP = FUN.CODDEP
LEFT JOIN TSICUS CUS ON CUS.CODCENCUS = DEP.CODCENCUS 
WHERE DTDEM IS NOT NULL 
GROUP BY
    FORMAT(DTDEM, 'MM/yyyy'),
    DEP.CODDEP,
    CAR.CODCARGO,
    FCO.CODFUNCAO,
    DEP.DESCRDEP,
    CUS.CODCENCUS,
    CUS.DESCRCENCUS,
    CAR.CODCARGO,
    CAR.DESCRCARGO,
    EMP.CODEMP,
    EMP.RAZAOSOCIAL,
    FUN.CODFUNC,
    FUN.NOMEFUNC