create schema lifegame;
use lifegame;
create table Pais( 
id_pais INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50) 
);  

create table categoria( 
id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50) 
); 

create table usuario( 
id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50) NOT NULL, 
documento VARCHAR(15) NOT NULL, 
birthdate DATE NOT NULL, 
id_pais INT NOT NULL, 
direccion VARCHAR(50), 
mail VARCHAR(50), 
telefono INT, 
FOREIGN KEY fk_id_pais(id_pais) REFERENCES Pais(id_pais)
);

create table empresa( 
id_empresa INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50) NOT NULL, 
id_pais INT NOT NULL, 
FOREIGN KEY fk_id_pais(id_pais)REFERENCES Pais(id_pais) 
); 

create table juego( 
id_juego INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50) NOT NULL, 
id_empresa INT NOT NULL, 
fecha DATE, 
id_categoria INT NOT NULL, 
descripcion VARCHAR(250), 
FOREIGN KEY fk_id_empresa(id_empresa)REFERENCES empresa(id_empresa), 
FOREIGN KEY fk_id_categoria(id_categoria)REFERENCES categoria(id_categoria) 
); 

create table valoracion( 
id_reseña INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
id_juego INT NOT NULL, 
valoracion INT NOT NULL, 
reseña VARCHAR(250), 
id_usuario INT NOT NULL, 
FOREIGN KEY fk_id_juego(id_juego)REFERENCES juego(id_juego), 
FOREIGN KEY fk_id_usuario(id_usuario)REFERENCES usuario(id_usuario) 
); 

create table compra( 
id_compra INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
id_usuario INT NOT NULL, 
id_juego INT NOT NULL, 
monto DECIMAL(6,2), 
FOREIGN KEY fk_id_usuario (id_usuario)REFERENCES usuario(id_usuario), 
FOREIGN KEY fk_id_juego(id_juego)REFERENCES juego(id_juego) 
);

insert INTO compra(id_compra, id_usuario, id_juego, monto)values(7,2,6,100.00),(8,1,7,778.00);

SELECT * from juego;

CREATE TABLE juegoJunio (
id_game INT PRIMARY KEY,
name VARCHAR(30),
description VARCHAR(150)
);

SELECT * from juegojunio;

DELIMITER $$
CREATE TRIGGER newgamejunio
AFTER INSERT ON juego
FOR EACH ROW 
INSERT INTO juegoJunio (id_game, name, description) VALUES (NEW.id_juego, NEW.nombre, NEW.descripcion);
INSERT INTO juego (id_juego, nombre,id_empresa, fecha,id_categoria, descripcion) VALUES (8,'DAY OF DEFEEAT:SOURCE',1,'2010-07-12',3,'Day of Defeat te ofrece la acción en línea más trepidante, ambientada en la Europa de la Segunda Guerra Mundial.');

END$$

Select * from juego;
Select * from juegojunio;

CREATE TABLE registro_compras (
id int primary key auto_increment,
comprador int,
juego int,
fecha datetime
);

DELIMITER //

CREATE TRIGGER informacion_compra
AFTER INSERT ON compra
FOR EACH ROW
BEGIN
    INSERT INTO registro_compras(comprador, juego)
    VALUES (NEW.id_usuario, NEW.id_juego);
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER setear_fecha_registro
BEFORE INSERT ON registro_compras
FOR EACH ROW
BEGIN
    SET NEW.fecha = NOW();
END //

DELIMITER ;

select * from compra ;

insert INTO compra(id_compra, id_usuario, id_juego, monto)values(9,5,8,685.00);
insert INTO compra(id_compra, id_usuario, id_juego, monto)values(10,2,4,0.00);

select * from registro_compras ; 
