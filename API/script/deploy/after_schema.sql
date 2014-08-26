SELECT setval('user_id_seq', 10, true);
SELECT setval('role_id_seq', 10, true);

--insert brazilian states
INSERT INTO state (id, name, name_url, state_id, country_id) VALUES
(1, 'Acre', 'acre',1,1),
(2, 'Alagoas', 'alagoas',1,1),
(3, 'Amapá', 'amapa',1,1),
(4, 'Amazonas', 'amazonas',1,1),
(5, 'Bahia', 'bahia',1,1),
(6, 'Ceará', 'ceara',1,1),
(7, 'Distrito Federal', 'distrito_federal',1,1),
(8, 'Espírito Santo', 'espirito_santo',1,1),
(9, 'Goiás', 'goias',1,1),
(10, 'Maranhão', 'maranhao',1,1),
(11, 'Mato Grosso', 'mato_grosso',1,1),
(12, 'Mato Grosso do Sul', 'mato_grosso_do_sul',1,1),
(13, 'Minas Gerais', 'minas_gerais',1,1),
(14, 'Pará', 'para',1,1),
(15, 'Paraíba', 'paraiba',1,1),
(16, 'Paraná', 'parana',1,1),
(17, 'Pernambuco', 'pernambuco',1,1),
(18, 'Piauí', 'piaui',1,1),
(19, 'Rio de Janeiro', 'rio_de_janeiro',1,1),
(20, 'Rio Grande do Norte', 'rio_grande_do_norte',1,1),
(21, 'Rio Grande do Sul', 'rio_grande_do_sul',1,1),
(22, 'Rondônia', 'rondonia',1,1),
(23, 'Roraima', 'roraima',1,1),
(24, 'Santa Catarina', 'santa_catarina',1,1),
(25, 'São Paulo', 'sao_paulo',1,1),
(26, 'Sergipe', 'sergipe',1,1),
(27, 'Tocantins', 'tocantis',1,1);






