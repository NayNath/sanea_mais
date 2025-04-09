CREATE DATABASE sanea_mais;
USE sanea_mais;

-- Tabela de usuários/cidadãos
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(11) UNIQUE NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    senha_hash VARCHAR(255), -- Para cadastro opcional
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de regiões/bairros de Santos
CREATE TABLE regioes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    populacao INT,
    area DECIMAL(10, 2) -- km²
);

-- Tabela de tipos de problemas
CREATE TABLE tipos_problema (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT,
    icone VARCHAR(30)
);

-- Tabela principal de reclamações
CREATE TABLE reclamacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    tipo_problema_id INT NOT NULL,
    regiao_id INT NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    descricao TEXT NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    data_reclamacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'em_analise', 'resolvido', 'arquivado') DEFAULT 'pendente',
    anexo_path VARCHAR(255),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tipo_problema_id) REFERENCES tipos_problema(id),
    FOREIGN KEY (regiao_id) REFERENCES regioes(id)
);

-- Tabela para acompanhamento das reclamações
CREATE TABLE acompanhamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reclamacao_id INT NOT NULL,
    responsavel VARCHAR(100),
    acao TEXT NOT NULL,
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reclamacao_id) REFERENCES reclamacoes(id)
);


-- Inserir regiões/bairros de Santos
INSERT INTO regioes (nome, latitude, longitude, populacao, area) VALUES
('Centro', -23.960833, -46.333889, 15000, 2.5),
('Gonzaga', -23.9675, -46.336944, 25000, 3.8),
('Ponta da Praia', -23.980833, -46.299722, 18000, 4.2),
('José Menino', -23.986944, -46.305556, 22000, 3.5),
('Vila Nova', -23.993056, -46.322222, 30000, 5.1),
('Embaré', -23.974167, -46.329722, 19000, 3.2),
('Aparecida', -23.966111, -46.344444, 28000, 4.8),
('Boqueirão', -23.985, -46.338889, 32000, 6.0),
('Campo Grande', -23.996389, -46.355, 27000, 7.2),
('São Manoel', -23.990278, -46.341667, 21000, 4.5);

INSERT INTO tipos_problema (nome, descricao, icone) VALUES
('Esgoto a céu aberto', 'Vazamento ou acúmulo de esgoto em vias públicas', 'fa-tint'),
('Falta de água', 'Ausência prolongada de abastecimento de água', 'fa-faucet'),
('Água contaminada', 'Água com cor, odor ou sabor estranho', 'fa-flask'),
('Entupimento', 'Bueiros ou redes de esgoto entupidas', 'fa-water'),
('Alagamento', 'Pontos de alagamento recorrente', 'fa-umbrella'),
('Vazamento', 'Vazamentos de água em vias públicas', 'fa-tint'),
('Outros', 'Outros problemas relacionados a saneamento', 'fa-question-circle');





