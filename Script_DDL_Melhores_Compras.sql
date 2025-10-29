-- =====================================================================
-- SGV - SISTEMA DE GERENCIAMENTO DE VÍDEOS E ESTRUTURAS DE APOIO
-- Script DDL Final - Versão Refatorada e Padronizada
-- =====================================================================

-- Seção 1: Comandos para eliminar as tabelas em ordem de dependência
DROP TABLE MC_SGV_VISUALIZACAO;
DROP TABLE MC_SGV_SAC;
DROP TABLE MC_SGV_VIDEO;
DROP TABLE MC_PRODUTO;
DROP TABLE MC_CATEGORIA;
DROP TABLE MC_END_CLI;
DROP TABLE MC_CLIENTE;
DROP TABLE MC_END_FUNC;
DROP TABLE MC_FUNCIONARIO;
DROP TABLE MC_DEPTO;
DROP TABLE MC_LOGRADOURO;
DROP TABLE MC_BAIRRO;
DROP TABLE MC_CIDADE;
DROP TABLE MC_ESTADO;
DROP SEQUENCE SQ_MC_CATEGORIA;


-- =====================================================================
-- Seção 2: Comandos para criar as tabelas
-- =====================================================================

CREATE TABLE MC_ESTADO (
    SG_ESTADO       CHAR(2)         NOT NULL,
    NM_ESTADO       VARCHAR2(30)    NOT NULL
);

CREATE TABLE MC_CIDADE (
    CD_CIDADE       NUMBER(8)       NOT NULL,
    SG_ESTADO       CHAR(2)         NOT NULL,
    NM_CIDADE       VARCHAR2(60)    NOT NULL,
    CD_IBGE         NUMBER(8),
    NR_DDD          NUMBER(3)
);

CREATE TABLE MC_BAIRRO (
    CD_BAIRRO       NUMBER(8)       NOT NULL,
    CD_CIDADE       NUMBER(8)       NOT NULL,
    NM_BAIRRO       VARCHAR2(45)    NOT NULL,
    NM_ZONA_BAIRRO  VARCHAR2(20)
);

CREATE TABLE MC_LOGRADOURO (
    CD_LOGRADOURO   NUMBER(10)      NOT NULL,
    CD_BAIRRO       NUMBER(8)       NOT NULL,
    NM_LOGRADOURO   VARCHAR2(160)   NOT NULL,
    NR_CEP          CHAR(8)
);

CREATE TABLE MC_DEPTO (
    CD_DEPTO        NUMBER(3)       NOT NULL,
    NM_DEPTO        VARCHAR2(100)   NOT NULL,
    ST_DEPTO        CHAR(1)         NOT NULL
);

CREATE TABLE MC_FUNCIONARIO (
    CD_FUNCIONARIO    NUMBER(10)      NOT NULL,
    CD_DEPTO          NUMBER(3)       NOT NULL,
    CD_GERENTE        NUMBER(10),
    NM_FUNCIONARIO    VARCHAR2(160)   NOT NULL,
    DT_NASCIMENTO     DATE            NOT NULL,
    DS_CARGO          VARCHAR2(80)    NOT NULL,
    VL_SALARIO        NUMBER(10,2)    NOT NULL,
    DS_EMAIL          VARCHAR2(80)    NOT NULL,
    ST_FUNC           CHAR(1)         NOT NULL,
    DT_CADASTRAMENTO  DATE            NOT NULL,
    DT_DESLIGAMENTO   DATE
);

CREATE TABLE MC_END_FUNC (
    CD_FUNCIONARIO      NUMBER(10)      NOT NULL,
    CD_LOGRADOURO       NUMBER(10)      NOT NULL,
    NR_END              NUMBER(8)       NOT NULL,
    DS_COMPLEMENTO_END  VARCHAR2(80),
    DT_INICIO           DATE            NOT NULL,
    DT_TERMINO          DATE,
    ST_END              CHAR(1)         NOT NULL
);

CREATE TABLE MC_CLIENTE (
    NR_CLIENTE        NUMBER(10)      NOT NULL,
    NM_CLIENTE        VARCHAR2(160)   NOT NULL,
    ST_CLIENTE        CHAR(1)         NOT NULL,
    DS_EMAIL          VARCHAR2(100)   NOT NULL,
    NM_LOGIN          VARCHAR2(50)    NOT NULL,
    DS_SENHA          VARCHAR2(50)    NOT NULL,
    TP_CLIENTE        CHAR(2)         NOT NULL,
    NR_CPF            VARCHAR2(11),
    NR_CNPJ           VARCHAR2(14),
    DT_NASCIMENTO     DATE
);

CREATE TABLE MC_END_CLI (
    NR_CLIENTE          NUMBER(10)      NOT NULL,
    CD_LOGRADOURO       NUMBER(10)      NOT NULL,
    NR_END              NUMBER(8)       NOT NULL,
    DS_COMPLEMENTO_END  VARCHAR2(80),
    DT_INICIO           DATE            NOT NULL,
    DT_TERMINO          DATE,
    ST_END              CHAR(1)         NOT NULL
);

CREATE TABLE MC_CATEGORIA (
    CD_CATEGORIA      NUMBER(5)       NOT NULL,
    DS_CATEGORIA      VARCHAR2(100)   NOT NULL,
    SG_CATEGORIA      VARCHAR2(10),
    ST_CATEGORIA      CHAR(1)         NOT NULL,
    TP_CATEGORIA      VARCHAR2(10)    NOT NULL,
    DT_INICIO         DATE            NOT NULL,
    DT_TERMINO        DATE
);

CREATE TABLE MC_PRODUTO (
    CD_PRODUTO                  NUMBER(10)      NOT NULL,
    CD_CATEGORIA                NUMBER(5)       NOT NULL,
    NR_CD_BARRAS_PROD           VARCHAR2(50),
    DS_PRODUTO                  VARCHAR2(80)    NOT NULL,
    DS_COMPLETA_PROD            VARCHAR2(4000)  NOT NULL,
    VL_PRECO_UNITARIO           NUMBER(8,2)     NOT NULL,
    VL_TOTAL_IMPOSTO_PAGO       NUMBER(10,2)    NOT NULL,
    ST_PRODUTO                  CHAR(1)         NOT NULL,
    DT_INICIO                   DATE            NOT NULL,
    DT_TERMINO                  DATE
);

CREATE TABLE MC_SGV_VIDEO (
    CD_VIDEO          NUMBER(5)       NOT NULL,
    CD_PRODUTO        NUMBER(10)      NOT NULL,
    CD_CATEGORIA      NUMBER(5)       NOT NULL,
    ST_VIDEO          CHAR(1)         NOT NULL,
    DS_VIDEO          VARCHAR2(100)   NOT NULL,
    DT_INICIO         DATE            NOT NULL,
    DT_TERMINO        DATE
);

CREATE TABLE MC_SGV_SAC (
    NR_SAC                      NUMBER(10)      GENERATED AS IDENTITY NOT NULL,
    NR_CLIENTE                  NUMBER(10)      NOT NULL,
    CD_PRODUTO                  NUMBER(10)      NOT NULL,
    CD_FUNCIONARIO              NUMBER(10),
    DS_DETALHADA_SAC            VARCHAR2(4000)  NOT NULL,
    DT_ABERTURA_SAC             DATE            NOT NULL,
    DT_ATENDIMENTO              DATE,
    NR_HORAS_TOTAL_SAC          NUMBER(5,2),
    DS_DETALHADA_RETORNO_SAC    CLOB,
    TP_SAC                      NUMBER(1)       NOT NULL,
    ST_SAC                      CHAR(1)         NOT NULL,
    NR_INDICE_SATISFACAO        NUMBER(2)
);



CREATE TABLE MC_SGV_VISUALIZACAO (
    CD_VISUALIZACAO      NUMBER(10)    NOT NULL,
    CD_VIDEO             NUMBER(5)     NOT NULL,
    NR_CLIENTE           NUMBER(10),
    DT_HR_VISUALIZACAO   DATE          NOT NULL
);

-- Seção 2.1: Comandos para criar as sequences
CREATE SEQUENCE SQ_MC_CATEGORIA START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- =====================================================================
-- Seção 3: Comandos para adicionar os comentários (documentação)
-- =====================================================================

-- Comentários: MC_ESTADO
COMMENT ON TABLE MC_ESTADO IS 'Armazena os estados da federação brasileira.';
COMMENT ON COLUMN MC_ESTADO.SG_ESTADO IS 'Armazena a sigla do estado (PK). Conteúdo obrigatório, formato CHAR(2) em maiúsculo.';
COMMENT ON COLUMN MC_ESTADO.NM_ESTADO IS 'Armazena o nome completo do estado. Conteúdo obrigatório.';

-- Comentários: MC_CIDADE
COMMENT ON TABLE MC_CIDADE IS 'Armazena as cidades brasileiras, relacionadas a um estado.';
COMMENT ON COLUMN MC_CIDADE.CD_CIDADE IS 'Armazena o código de identificação único da cidade (PK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CIDADE.SG_ESTADO IS 'Armazena a chave estrangeira para o estado da cidade (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CIDADE.NM_CIDADE IS 'Armazena o nome da cidade. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CIDADE.CD_IBGE IS 'Armazena o código do IBGE da cidade, utilizado para emissão de NFe. Conteúdo opcional.';
COMMENT ON COLUMN MC_CIDADE.NR_DDD IS 'Armazena o código de DDD da cidade. Conteúdo opcional.';

-- Comentários: MC_BAIRRO
COMMENT ON TABLE MC_BAIRRO IS 'Armazena os bairros, relacionados a uma cidade.';
COMMENT ON COLUMN MC_BAIRRO.CD_BAIRRO IS 'Armazena o código de identificação único do bairro (PK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_BAIRRO.CD_CIDADE IS 'Armazena a chave estrangeira para a cidade do bairro (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_BAIRRO.NM_BAIRRO IS 'Armazena o nome do bairro. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_BAIRRO.NM_ZONA_BAIRRO IS 'Armazena a zona de localização do bairro (Ex: Zona Sul). Conteúdo opcional.';

-- Comentários: MC_LOGRADOURO
COMMENT ON TABLE MC_LOGRADOURO IS 'Armazena os logradouros (ruas, avenidas), relacionados a um bairro.';
COMMENT ON COLUMN MC_LOGRADOURO.CD_LOGRADOURO IS 'Armazena o código de identificação único do logradouro (PK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_LOGRADOURO.CD_BAIRRO IS 'Armazena a chave estrangeira para o bairro do logradouro (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_LOGRADOURO.NM_LOGRADOURO IS 'Armazena o nome do logradouro. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_LOGRADOURO.NR_CEP IS 'Armazena o CEP do logradouro em 8 dígitos numéricos, sem máscara. Conteúdo opcional.';

-- Comentários: MC_DEPTO
COMMENT ON TABLE MC_DEPTO IS 'Armazena os departamentos da empresa Melhores Compras.';
COMMENT ON COLUMN MC_DEPTO.CD_DEPTO IS 'Armazena o código de identificação único do departamento (PK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_DEPTO.NM_DEPTO IS 'Armazena o nome do departamento. Conteúdo obrigatório e único.';
COMMENT ON COLUMN MC_DEPTO.ST_DEPTO IS 'Armazena o status do departamento. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';

-- Comentários: MC_FUNCIONARIO
COMMENT ON TABLE MC_FUNCIONARIO IS 'Armazena os dados dos funcionários da empresa Melhores Compras.';
COMMENT ON COLUMN MC_FUNCIONARIO.CD_FUNCIONARIO IS 'Armazena o código de identificação único do funcionário (PK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.CD_DEPTO IS 'Armazena a chave estrangeira para o departamento do funcionário (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.CD_GERENTE IS 'Armazena o código do gestor do funcionário (FK auto-referenciada). Conteúdo opcional.';
COMMENT ON COLUMN MC_FUNCIONARIO.NM_FUNCIONARIO IS 'Armazena o nome completo do funcionário. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.DT_NASCIMENTO IS 'Armazena a data de nascimento do funcionário. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.DS_CARGO IS 'Armazena o cargo do funcionário. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.VL_SALARIO IS 'Armazena o valor do salário do funcionário. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.DS_EMAIL IS 'Armazena o e-mail corporativo do funcionário. Conteúdo obrigatório e único.';
COMMENT ON COLUMN MC_FUNCIONARIO.ST_FUNC IS 'Armazena o status do funcionário. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.DT_CADASTRAMENTO IS 'Armazena a data de admissão do funcionário. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_FUNCIONARIO.DT_DESLIGAMENTO IS 'Armazena a data de desligamento do funcionário. Conteúdo opcional.';

-- Comentários: MC_END_FUNC
COMMENT ON TABLE MC_END_FUNC IS 'Tabela associativa que armazena os endereços de um funcionário.';
COMMENT ON COLUMN MC_END_FUNC.CD_FUNCIONARIO IS 'Chave estrangeira para o funcionário (parte da PK).';
COMMENT ON COLUMN MC_END_FUNC.CD_LOGRADOURO IS 'Chave estrangeira para o logradouro (parte da PK).';
COMMENT ON COLUMN MC_END_FUNC.NR_END IS 'Armazena o número do endereço do funcionário. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_END_FUNC.DS_COMPLEMENTO_END IS 'Armazena o complemento do endereço. Conteúdo opcional.';
COMMENT ON COLUMN MC_END_FUNC.DT_INICIO IS 'Armazena a data de início de validade deste endereço. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_END_FUNC.DT_TERMINO IS 'Armazena a data de término de validade deste endereço. Conteúdo opcional.';
COMMENT ON COLUMN MC_END_FUNC.ST_END IS 'Armazena o status do endereço. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';

-- Comentários: MC_CLIENTE
COMMENT ON TABLE MC_CLIENTE IS 'Armazena os dados dos clientes da plataforma, que podem ser pessoas físicas ou jurídicas.';
COMMENT ON COLUMN MC_CLIENTE.NR_CLIENTE IS 'Armazena o número de identificação único do cliente (PK). Conteúdo obrigatório e sequencial.';
COMMENT ON COLUMN MC_CLIENTE.NM_CLIENTE IS 'Armazena o nome completo (pessoa física) ou a razão social (pessoa jurídica) do cliente. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CLIENTE.ST_CLIENTE IS 'Armazena o status do cliente. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CLIENTE.DS_EMAIL IS 'Armazena o e-mail de contato do cliente. Conteúdo obrigatório e único (UK).';
COMMENT ON COLUMN MC_CLIENTE.NM_LOGIN IS 'Armazena o nome de usuário para acesso à plataforma. Conteúdo obrigatório e único (UK).';
COMMENT ON COLUMN MC_CLIENTE.DS_SENHA IS 'Armazena a senha de acesso do cliente. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CLIENTE.TP_CLIENTE IS 'Armazena o tipo de cliente. Deve ser ''PF'' (Pessoa Física) ou ''PJ'' (Pessoa Jurídica). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CLIENTE.NR_CPF IS 'Armazena os 11 dígitos do CPF do cliente, sem máscara. Conteúdo obrigatório se TP_CLIENTE for ''PF''.';
COMMENT ON COLUMN MC_CLIENTE.NR_CNPJ IS 'Armazena os 14 dígitos do CNPJ do cliente, sem máscara. Conteúdo obrigatório se TP_CLIENTE for ''PJ''.';
COMMENT ON COLUMN MC_CLIENTE.DT_NASCIMENTO IS 'Armazena a data de nascimento para clientes PF. Conteúdo obrigatório se TP_CLIENTE for ''PF''.';

-- Comentários: MC_END_CLI
COMMENT ON TABLE MC_END_CLI IS 'Tabela associativa que armazena os endereços de um cliente.';
COMMENT ON COLUMN MC_END_CLI.NR_CLIENTE IS 'Chave estrangeira para o cliente (parte da PK).';
COMMENT ON COLUMN MC_END_CLI.CD_LOGRADOURO IS 'Chave estrangeira para o logradouro (parte da PK).';
COMMENT ON COLUMN MC_END_CLI.NR_END IS 'Armazena o número do endereço do cliente. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_END_CLI.DS_COMPLEMENTO_END IS 'Armazena o complemento do endereço. Conteúdo opcional.';
COMMENT ON COLUMN MC_END_CLI.DT_INICIO IS 'Armazena a data de início de validade deste endereço. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_END_CLI.DT_TERMINO IS 'Armazena a data de término de validade deste endereço. Conteúdo opcional.';
COMMENT ON COLUMN MC_END_CLI.ST_END IS 'Armazena o status do endereço. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';

-- Comentários: MC_CATEGORIA
COMMENT ON TABLE MC_CATEGORIA IS 'Armazena as categorias que podem ser associadas a produtos ou a vídeos.';
COMMENT ON COLUMN MC_CATEGORIA.CD_CATEGORIA IS 'Armazena o código de identificação único da categoria (PK). Conteúdo obrigatório e sequencial.';
COMMENT ON COLUMN MC_CATEGORIA.DS_CATEGORIA IS 'Armazena o nome descritivo da categoria. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CATEGORIA.SG_CATEGORIA IS 'Armazena a sigla da categoria para uso em relatórios. Conteúdo opcional, mas deve ser único (UK).';
COMMENT ON COLUMN MC_CATEGORIA.ST_CATEGORIA IS 'Armazena o status da categoria. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CATEGORIA.TP_CATEGORIA IS 'Armazena o tipo da categoria para diferenciar seu uso. Deve ser ''PRODUTO'' ou ''VIDEO''. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CATEGORIA.DT_INICIO IS 'Armazena a data em que a categoria se tornou ativa. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_CATEGORIA.DT_TERMINO IS 'Armazena a data em que a categoria foi desativada. Conteúdo opcional.';

-- Comentários: MC_PRODUTO
COMMENT ON TABLE MC_PRODUTO IS 'Armazena as informações dos produtos comercializados na plataforma de e-commerce.';
COMMENT ON COLUMN MC_PRODUTO.CD_PRODUTO IS 'Armazena o código de identificação único do produto (PK). Conteúdo obrigatório e sequencial.';
COMMENT ON COLUMN MC_PRODUTO.CD_CATEGORIA IS 'Armazena a chave estrangeira para a categoria do produto (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_PRODUTO.NR_CD_BARRAS_PROD IS 'Armazena o código de barras padrão EAN13 do produto. Conteúdo opcional.';
COMMENT ON COLUMN MC_PRODUTO.DS_PRODUTO IS 'Armazena o nome comercial do produto. Conteúdo obrigatório e único (UK).';
COMMENT ON COLUMN MC_PRODUTO.DS_COMPLETA_PROD IS 'Armazena a descrição técnica e detalhada do produto. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_PRODUTO.VL_PRECO_UNITARIO IS 'Armazena o preço atual de venda do produto. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_PRODUTO.VL_TOTAL_IMPOSTO_PAGO IS 'Armazena o valor total do imposto pago para comercializar o produto. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_PRODUTO.ST_PRODUTO IS 'Armazena o status do produto. Deve ser ''A'' (Ativo), ''I'' (Inativo) ou ''P'' (Prospecção). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_PRODUTO.DT_INICIO IS 'Armazena a data de início do ciclo de vida do produto. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_PRODUTO.DT_TERMINO IS 'Armazena a data de término do ciclo de vida do produto. Conteúdo opcional.';

-- Comentários: MC_SGV_VIDEO
COMMENT ON TABLE MC_SGV_VIDEO IS 'Armazena os vídeos explicativos ou promocionais associados aos produtos.';
COMMENT ON COLUMN MC_SGV_VIDEO.CD_VIDEO IS 'Armazena o código de identificação único do vídeo (PK). Conteúdo obrigatório e sequencial.';
COMMENT ON COLUMN MC_SGV_VIDEO.CD_PRODUTO IS 'Armazena a chave estrangeira para o produto ao qual o vídeo pertence (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_VIDEO.CD_CATEGORIA IS 'Armazena a chave estrangeira para a categoria do vídeo (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_VIDEO.ST_VIDEO IS 'Armazena o status do vídeo. Deve ser ''A'' (Ativo) ou ''I'' (Inativo). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_VIDEO.DS_VIDEO IS 'Armazena o título ou descrição breve do vídeo. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_VIDEO.DT_INICIO IS 'Armazena a data em que o vídeo se tornou disponível. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_VIDEO.DT_TERMINO IS 'Armazena a data em que o vídeo foi desativado. Conteúdo opcional.';

-- Comentários: MC_SGV_SAC
COMMENT ON TABLE MC_SGV_SAC IS 'Armazena os registros de chamados do Serviço de Atendimento ao Cliente (SAC).';
COMMENT ON COLUMN MC_SGV_SAC.NR_SAC IS 'Armazena o número de identificação único do chamado (PK). Conteúdo obrigatório e sequencial.';
COMMENT ON COLUMN MC_SGV_SAC.NR_CLIENTE IS 'Armazena a chave estrangeira para o cliente que abriu o chamado (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_SAC.CD_PRODUTO IS 'Armazena a chave estrangeira para o produto relacionado ao chamado (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_SAC.CD_FUNCIONARIO IS 'Armazena a chave estrangeira para o funcionário que atendeu o chamado (FK). Conteúdo opcional.';
COMMENT ON COLUMN MC_SGV_SAC.DS_DETALHADA_SAC IS 'Armazena o texto inicial escrito pelo cliente ao abrir o chamado. Limite de 4000 caracteres. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_SAC.DT_ABERTURA_SAC IS 'Armazena a data e hora de abertura do chamado. Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_SAC.DT_ATENDIMENTO IS 'Armazena a data e hora em que o chamado foi atendido/fechado. Conteúdo opcional.';
COMMENT ON COLUMN MC_SGV_SAC.NR_HORAS_TOTAL_SAC IS 'Armazena a duração total do atendimento, em horas. Conteúdo opcional.';
COMMENT ON COLUMN MC_SGV_SAC.DS_DETALHADA_RETORNO_SAC IS 'Armazena a resposta detalhada fornecida pelo funcionário. Conteúdo opcional.';
COMMENT ON COLUMN MC_SGV_SAC.TP_SAC IS 'Armazena o tipo do chamado. Deve ser 1 (Sugestão) ou 2 (Reclamação). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_SAC.ST_SAC IS 'Armazena o status do chamado (A, E, C, F, X). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_SAC.NR_INDICE_SATISFACAO IS 'Armazena a nota de satisfação do cliente (1 a 10). Conteúdo opcional.';

-- Comentários: MC_SGV_VISUALIZACAO
COMMENT ON TABLE MC_SGV_VISUALIZACAO IS 'Registra cada evento de visualização de um vídeo por um cliente ou usuário anônimo.';
COMMENT ON COLUMN MC_SGV_VISUALIZACAO.CD_VISUALIZACAO IS 'Armazena o código de identificação único da visualização (PK). Conteúdo obrigatório e sequencial.';
COMMENT ON COLUMN MC_SGV_VISUALIZACAO.CD_VIDEO IS 'Armazena a chave estrangeira para o vídeo que foi visualizado (FK). Conteúdo obrigatório.';
COMMENT ON COLUMN MC_SGV_VISUALIZACAO.NR_CLIENTE IS 'Armazena a chave estrangeira para o cliente que realizou a visualização (FK). Conteúdo opcional para permitir usuários anônimos.';
COMMENT ON COLUMN MC_SGV_VISUALIZACAO.DT_HR_VISUALIZACAO IS 'Armazena a data e hora exatas em que a visualização ocorreu. Conteúdo obrigatório.';


-- =====================================================================
-- Seção 4: Comandos para adicionar as CONSTRAINTS (PK, UK, CK)
-- =====================================================================

-- Constraints: MC_ESTADO
ALTER TABLE MC_ESTADO ADD CONSTRAINT PK_MC_ESTADO PRIMARY KEY (SG_ESTADO);

-- Constraints: MC_CIDADE
ALTER TABLE MC_CIDADE ADD CONSTRAINT PK_MC_CIDADE PRIMARY KEY (CD_CIDADE);

-- Constraints: MC_BAIRRO
ALTER TABLE MC_BAIRRO ADD CONSTRAINT PK_MC_BAIRRO PRIMARY KEY (CD_BAIRRO);

-- Constraints: MC_LOGRADOURO
ALTER TABLE MC_LOGRADOURO ADD CONSTRAINT PK_MC_LOGRADOURO PRIMARY KEY (CD_LOGRADOURO);

-- Constraints: MC_DEPTO
ALTER TABLE MC_DEPTO ADD CONSTRAINT PK_MC_DEPTO PRIMARY KEY (CD_DEPTO);
ALTER TABLE MC_DEPTO ADD CONSTRAINT UN_MC_DEPTO_NOME UNIQUE (NM_DEPTO);
ALTER TABLE MC_DEPTO ADD CONSTRAINT CK_MC_DEPTO_STATUS CHECK (ST_DEPTO IN ('A', 'I'));

-- Constraints: MC_FUNCIONARIO
ALTER TABLE MC_FUNCIONARIO ADD CONSTRAINT PK_MC_FUNCIONARIO PRIMARY KEY (CD_FUNCIONARIO);
ALTER TABLE MC_FUNCIONARIO ADD CONSTRAINT UN_MC_FUNCIONARIO_EMAIL UNIQUE (DS_EMAIL);
ALTER TABLE MC_FUNCIONARIO ADD CONSTRAINT CK_MC_FUNCIONARIO_STATUS CHECK (ST_FUNC IN ('A', 'I'));

-- Constraints: MC_END_FUNC
ALTER TABLE MC_END_FUNC ADD CONSTRAINT PK_MC_END_FUNC PRIMARY KEY (CD_FUNCIONARIO, CD_LOGRADOURO);
ALTER TABLE MC_END_FUNC ADD CONSTRAINT CK_MC_END_FUNC_STATUS CHECK (ST_END IN ('A', 'I'));

-- Constraints: MC_CLIENTE
ALTER TABLE MC_CLIENTE ADD CONSTRAINT PK_MC_CLIENTE PRIMARY KEY (NR_CLIENTE);
ALTER TABLE MC_CLIENTE ADD CONSTRAINT UN_MC_CLIENTE_EMAIL UNIQUE (DS_EMAIL);
ALTER TABLE MC_CLIENTE ADD CONSTRAINT UN_MC_CLIENTE_LOGIN UNIQUE (NM_LOGIN);
ALTER TABLE MC_CLIENTE ADD CONSTRAINT CK_MC_CLIENTE_STATUS CHECK (ST_CLIENTE IN ('A', 'I'));
ALTER TABLE MC_CLIENTE ADD CONSTRAINT CK_MC_CLIENTE_TIPO_DOC CHECK ((TP_CLIENTE = 'PF' AND NR_CPF IS NOT NULL AND REGEXP_LIKE(NR_CPF, '^[0-9]{11}$') AND NR_CNPJ IS NULL AND DT_NASCIMENTO IS NOT NULL) OR (TP_CLIENTE = 'PJ' AND NR_CNPJ IS NOT NULL AND REGEXP_LIKE(NR_CNPJ, '^[0-9]{14}$') AND NR_CPF IS NULL AND DT_NASCIMENTO IS NULL));

-- Constraints: MC_END_CLI
ALTER TABLE MC_END_CLI ADD CONSTRAINT PK_MC_END_CLI PRIMARY KEY (NR_CLIENTE, CD_LOGRADOURO);
ALTER TABLE MC_END_CLI ADD CONSTRAINT CK_MC_END_CLI_STATUS CHECK (ST_END IN ('A', 'I'));

-- Constraints: MC_CATEGORIA
ALTER TABLE MC_CATEGORIA ADD CONSTRAINT PK_MC_CATEGORIA PRIMARY KEY (CD_CATEGORIA);
ALTER TABLE MC_CATEGORIA ADD CONSTRAINT UN_MC_CATEG_SIGLA UNIQUE (SG_CATEGORIA);
ALTER TABLE MC_CATEGORIA ADD CONSTRAINT CK_MC_CATEG_STATUS CHECK (ST_CATEGORIA IN ('A', 'I'));
ALTER TABLE MC_CATEGORIA ADD CONSTRAINT CK_MC_CATEG_TIPO CHECK (TP_CATEGORIA IN ('PRODUTO', 'VIDEO'));

-- Constraints: MC_PRODUTO
ALTER TABLE MC_PRODUTO ADD CONSTRAINT PK_MC_PRODUTO PRIMARY KEY (CD_PRODUTO);
ALTER TABLE MC_PRODUTO ADD CONSTRAINT UN_MC_PROD_DESCRICAO UNIQUE (DS_PRODUTO);
ALTER TABLE MC_PRODUTO ADD CONSTRAINT CK_MC_PROD_STATUS CHECK (ST_PRODUTO IN ('A', 'I', 'P'));

-- Constraints: MC_SGV_VIDEO
ALTER TABLE MC_SGV_VIDEO ADD CONSTRAINT PK_MC_SGV_VIDEO PRIMARY KEY (CD_VIDEO);
ALTER TABLE MC_SGV_VIDEO ADD CONSTRAINT CK_MC_SGV_VIDEO_STATUS CHECK (ST_VIDEO IN ('A', 'I'));

-- Constraints: MC_SGV_SAC
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT PK_MC_SGV_SAC PRIMARY KEY (NR_SAC);
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT CK_MC_SGV_SAC_TIPO CHECK (TP_SAC IN (1, 2));
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT CK_MC_SGV_SAC_STATUS CHECK (ST_SAC IN ('A', 'E', 'C', 'F', 'X'));
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT CK_MC_SGV_SAC_SATISFACAO CHECK (NR_INDICE_SATISFACAO BETWEEN 1 AND 10);

-- Constraints: MC_SGV_VISUALIZACAO
ALTER TABLE MC_SGV_VISUALIZACAO ADD CONSTRAINT PK_MC_SGV_VISUALIZACAO PRIMARY KEY (CD_VISUALIZACAO);
ALTER TABLE MC_SGV_VISUALIZACAO ADD CONSTRAINT UN_MC_SGV_VISUALIZACAO_DATA UNIQUE (CD_VIDEO, DT_HR_VISUALIZACAO);


-- =====================================================================
-- Seção 5: Comandos para adicionar as Chaves Estrangeiras (Relacionamentos)
-- =====================================================================

ALTER TABLE MC_CIDADE ADD CONSTRAINT FK_MC_ESTADO_CIDADE FOREIGN KEY (SG_ESTADO) REFERENCES MC_ESTADO (SG_ESTADO);
ALTER TABLE MC_BAIRRO ADD CONSTRAINT FK_MC_CIDADE_BAIRRO FOREIGN KEY (CD_CIDADE) REFERENCES MC_CIDADE (CD_CIDADE);
ALTER TABLE MC_LOGRADOURO ADD CONSTRAINT FK_MC_BAIRRO_LOGRAD FOREIGN KEY (CD_BAIRRO) REFERENCES MC_BAIRRO (CD_BAIRRO);
ALTER TABLE MC_FUNCIONARIO ADD CONSTRAINT FK_MC_DEPTO_FUNC FOREIGN KEY (CD_DEPTO) REFERENCES MC_DEPTO (CD_DEPTO);
ALTER TABLE MC_FUNCIONARIO ADD CONSTRAINT FK_MC_FUNC_SUPERIOR FOREIGN KEY (CD_GERENTE) REFERENCES MC_FUNCIONARIO (CD_FUNCIONARIO);
ALTER TABLE MC_END_FUNC ADD CONSTRAINT FK_MC_FUNC_END FOREIGN KEY (CD_FUNCIONARIO) REFERENCES MC_FUNCIONARIO (CD_FUNCIONARIO);
ALTER TABLE MC_END_FUNC ADD CONSTRAINT FK_MC_END_FUNC_LOGRAD FOREIGN KEY (CD_LOGRADOURO) REFERENCES MC_LOGRADOURO (CD_LOGRADOURO);
ALTER TABLE MC_END_CLI ADD CONSTRAINT FK_MC_CLIENTE_END_CLI FOREIGN KEY (NR_CLIENTE) REFERENCES MC_CLIENTE (NR_CLIENTE);
ALTER TABLE MC_END_CLI ADD CONSTRAINT FK_MC_LOGRAD_END_CLI FOREIGN KEY (CD_LOGRADOURO) REFERENCES MC_LOGRADOURO (CD_LOGRADOURO);
ALTER TABLE MC_PRODUTO ADD CONSTRAINT FK_MC_CATEG_PROD FOREIGN KEY (CD_CATEGORIA) REFERENCES MC_CATEGORIA (CD_CATEGORIA);
ALTER TABLE MC_SGV_VIDEO ADD CONSTRAINT FK_MC_PROD_VIDEO FOREIGN KEY (CD_PRODUTO) REFERENCES MC_PRODUTO (CD_PRODUTO);
ALTER TABLE MC_SGV_VIDEO ADD CONSTRAINT FK_MC_CATEG_VIDEO FOREIGN KEY (CD_CATEGORIA) REFERENCES MC_CATEGORIA (CD_CATEGORIA);
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT FK_MC_CLIENTE_SAC FOREIGN KEY (NR_CLIENTE) REFERENCES MC_CLIENTE (NR_CLIENTE);
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT FK_MC_PROD_SAC FOREIGN KEY (CD_PRODUTO) REFERENCES MC_PRODUTO (CD_PRODUTO);
ALTER TABLE MC_SGV_SAC ADD CONSTRAINT FK_MC_FUNC_SAC FOREIGN KEY (CD_FUNCIONARIO) REFERENCES MC_FUNCIONARIO (CD_FUNCIONARIO);
ALTER TABLE MC_SGV_VISUALIZACAO ADD CONSTRAINT FK_MC_VIDEO_VISU FOREIGN KEY (CD_VIDEO) REFERENCES MC_SGV_VIDEO (CD_VIDEO);
ALTER TABLE MC_SGV_VISUALIZACAO ADD CONSTRAINT FK_MC_CLIENTE_VISU FOREIGN KEY (NR_CLIENTE) REFERENCES MC_CLIENTE (NR_CLIENTE);
