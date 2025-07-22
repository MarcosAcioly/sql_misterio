-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS misterio;
USE misterio;

-- Estrutura da tabela enderecos
CREATE TABLE enderecos (
  id int(11) NOT NULL,
  rua varchar(100) DEFAULT NULL,
  cidade varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Extraindo dados da tabela enderecos
INSERT INTO enderecos (id, rua, cidade) VALUES
(1, 'Rua das Flores', 'São Paulo'),
(2, 'Av. Central', 'Rio de Janeiro'),
(3, 'Rua da Paz', 'Curitiba'),
(4, 'Rua sem Nome', 'Recife');

-- Estrutura da tabela ocorrencias
CREATE TABLE ocorrencias (
  id int(11) NOT NULL,
  tipo varchar(50) DEFAULT NULL,
  descricao text DEFAULT NULL,
  pessoa_id int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Extraindo dados da tabela ocorrencias
INSERT INTO ocorrencias (id, tipo, descricao, pessoa_id) VALUES
(1, 'Roubo', 'Roubo de documentos confidenciais.', 3),
(2, 'Homicídio', 'Vítima encontrada na biblioteca.', 4),
(3, 'Vandalismo', 'Pichações na fachada da empresa.', 1);

-- Estrutura da tabela pessoas
CREATE TABLE pessoas (
  id int(11) NOT NULL,
  nome varchar(100) DEFAULT NULL,
  idade int(11) DEFAULT NULL,
  profissao varchar(100) DEFAULT NULL,
  suspeito tinyint(1) DEFAULT NULL,
  endereco_id int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Extraindo dados da tabela pessoas
INSERT INTO pessoas (id, nome, idade, profissao, suspeito, endereco_id) VALUES
(1, 'Ana Souza', 32, 'Médica', 0, 1),
(2, 'Carlos Dias', 45, 'Detetive', 0, 2),
(3, 'Maria Lima', 28, 'Advogada', 1, 3),
(4, 'Rafael Costa', NULL, 'Professor', 1, 4),
(5, 'João Pedro', 39, NULL, 0, NULL),
(6, 'João Pedro', 25, 'Digitador', 1, NULL),
(7, 'João Pedro', 33, 'Jardineiro', 1, NULL),
(8, 'João Pedro', 50, 'Mordomo', 1, NULL);

-- Estrutura da tabela testemunhos
CREATE TABLE testemunhos (
  id int(11) NOT NULL,
  pessoa_id int(11) DEFAULT NULL,
  relato text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Extraindo dados da tabela testemunhos
INSERT INTO testemunhos (id, pessoa_id, relato) VALUES
(1, 1, 'Vi alguém saindo da cena do crime.'),
(2, 2, 'Ouvi um barulho estranho na noite anterior.'),
(3, 3, 'Não vi nada suspeito.');

-- Índices para tabelas despejadas
-- Índices para tabela enderecos
ALTER TABLE enderecos ADD PRIMARY KEY (id);

-- Índices para tabela ocorrencias
ALTER TABLE ocorrencias ADD PRIMARY KEY (id);

-- Índices para tabela pessoas
ALTER TABLE pessoas ADD PRIMARY KEY (id);

-- Índices para tabela testemunhos
ALTER TABLE testemunhos ADD PRIMARY KEY (id);

-- AUTO_INCREMENT de tabelas despejadas
-- AUTO_INCREMENT de tabela enderecos
ALTER TABLE enderecos MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- AUTO_INCREMENT de tabela ocorrencias
ALTER TABLE ocorrencias MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- AUTO_INCREMENT de tabela pessoas
ALTER TABLE pessoas MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

-- AUTO_INCREMENT de tabela testemunhos
ALTER TABLE testemunhos MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

COMMIT;