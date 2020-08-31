drop database G3P1;

CREATE DATABASE IF NOT EXISTS G3P1;

-- GRUPO 3 PARALELO 1 SBDD --

use g3p1;

create table if not exists Localidad(
lat float comment "Latitud de la ubicación",
log float comment "Longitud de la ubicación",
calle1 varchar(50) not null comment "Calle Principal de la ubicación",
calle2 varchar(50) not null comment "Calle Secundaria de la ubicación",
canton varchar(50) not null comment "Cantón de la ubicación",
provincia varchar(50) not null comment "Provincia de la ubicación",
camp_ref varchar(50) not null comment "Campo de Referencia de la ubicación",
Primary key(lat,log)
);

/*
Esta tabla ha sido añadida para corregir un problema de
normalización en la tabla Medicina que no se resolvió en 
el paso a modelo lógico
*/
Create table if not exists Categoria(
codeCategoria int primary key auto_increment comment "Código de la Categoría",
nombre varchar(50) not null comment "Nombre de la Categoría"
);

create table if not exists Medicina(
codigo varchar(20) primary key comment "Código de la Medicina",
nombre varchar(50) not null comment "Nombre de la Medicina",
precio float not null comment "Precio al público de la Medicina",
met_comercializacion boolean default false comment "Indica si la medicina puede ser vendida con o sin prescripción médica",
codeCategoria int not null comment "Código de categoría de la Medicina",
foreign key(codeCategoria) references Categoria(codeCategoria)
);

CREATE TABLE if not exists Persona(
cedula char(7) PRIMARY KEY comment "Cédula de la Persona",
nombre varchar(50) NOT NULL comment "Nombre de la Persona",
apell_mat varchar(50) NOT NULL comment "Segundo apellido de la Persona",
apell_pat varchar(50) NOT NULL comment "Primer apellido de la Persona",
email varchar(50) NOT NULL comment "Correo Electrónico de la Persona", 
telf char(10) NOT NULL comment "Teléfono de la Persona",
direccion varchar(50) NOT NULL comment "Dirección de la Persona"
);

create table if not exists Cliente(
cedula char(7) primary key comment "Cédula del Cliente",
FOREIGN KEY (cedula) REFERENCES Persona(cedula)
);

create table if not exists Trabajador(
cedula char(7) primary key comment "Cédula del Trabajador",
sueldo float default 0.0 comment "Sueldo del Trabajador",
FOREIGN KEY (cedula) REFERENCES Persona(cedula)
);

Create table if not exists Administrador(
id_admin varchar(10) primary key comment "Identificador del Administrador",
cedula char(7) not null comment "Cédula del Administrador",
foreign key (cedula) references Trabajador (cedula)
);

Create table if not exists Jefe_Farmacia(
id_jefe varchar(10) primary key comment "Identificador del Jefe de la Farmacia",
cedula char(7) not null comment "Cédula del Jefe de la Farmacia",
foreign key (cedula) references Trabajador(cedula)
);

Create table  if not exists Bodega(
id varchar(10) primary key comment "Identificador de la Bodega",
direccion varchar(50) not null comment "Dirección de la Bodega",
id_admin varchar(10) not null comment "Identificador del Administrador que dirige la Bodega",
foreign key (id_admin) references Administrador (id_admin)
);

CREATE TABLE if not exists Bodeguero(
id_bodeguero varchar(10) PRIMARY KEY comment "Identificador del Bodeguero",
cedula char(7) NOT NULL comment "Cédula del Bodeguero",
id_bodega varchar(10) NOT NULL comment "Identificador de la Bodega donde trabaja",
FOREIGN KEY (id_bodega) REFERENCES Bodega(id),
FOREIGN KEY (cedula) REFERENCES Trabajador(cedula)
);

Create table if not exists Almacenamiento(
id_bodega varchar(10) comment "Identificador de la Bodega que almacena",
cod_med varchar(20) comment "Código de la medicina que se almacena",
stockB int not null comment "Cantidad de Medicina almacenada",
Primary key(id_bodega, cod_med),
foreign key (id_bodega) references Bodega (id),
foreign key (cod_med) references Medicina (codigo)
);

create table if not exists Farmacia(
id varchar(20) primary key comment "Identificador de la Farmacia",
ruc varchar(13) not null comment "Ruc de la Farmacia",
nom_farm varchar(50) comment "nombre de la Farmacia",
id_jefe varchar(10) not null comment "Identificador del Jefe que dirige la Farmacia",
lat_farm float not null comment "Latitud de la ubicación de la Farmacia",
log_farm float not null comment "Longitud de la ubicación de la Farmacia",
foreign key (lat_farm, log_farm) references Localidad(lat, log),
foreign key (id_jefe) references Jefe_Farmacia(id_jefe)
);

create table if not exists Vendedor(
id_vendedor varchar(10) primary key comment "Identificador del Vendedor",
cedula char(7) not null comment "Cédula del Vendedor",
id_farm varchar(20) not null comment "Identificador de la farmacia donde trabaja el vendedor",
foreign key (id_farm) references Farmacia(id),
foreign key (cedula) references Trabajador(cedula)
);

create table if not exists Inventario(
cod_lote int primary key auto_increment comment "Código de Lote de medicina",
cod_med varchar(20) not null,
id_farm varchar(20) not null,
fecha_caducidad date not null,
foreign key (cod_med) references Medicina(codigo),
foreign key (id_farm) references Farmacia(id)
);

create table if not exists Disponibilidad(
id_farm varchar(20) comment "Identificador de la Farmacia",
cod_med varchar(20) comment "Código de la medicina con la que cuenta la farmacia",
stockF int not null comment "Cantidad de la medicina que dispone la farmacia",
num_minimo int not null comment "Número mínimo de medicina que debe tener la farmacia",
Primary key(id_farm,cod_med),
foreign key(id_farm) references Farmacia(id),
foreign key(cod_med) references Medicina(codigo)
);

/*
Se añadió la tabla DetalleFactura, por lo que algunos atributos pasaron
de la tabla Factura a la nueva tabla
*/
create table if not exists Factura(
id_factura int primary key auto_increment comment "Identificador de la Factura",
id_vendedor varchar(10) not null comment "Código del Vendedor que realiza la venta",
cedula_cliente char(7) comment "Identificador del Cliente que realiza la compra",
fecha_Factura date comment "Fecha de la factura",
foreign key (id_vendedor) references Vendedor(id_vendedor),
foreign key (cedula_cliente) references Cliente(cedula)
);

Create table if not exists DetalleFactura(
id_factura int comment "Identificador de la factura emitida",
cod_med varchar(10) comment "Nombre de la medicina en la factura",
cantidad int default 1 comment "Cantidad de la medicina vendida", 
primary key (id_factura,cod_med),
foreign key (id_factura) references Factura (id_factura),
foreign key (cod_med) references Medicina (codigo)
);


create table if not exists Egreso(
id_egreso int primary key auto_increment comment "Identificador de Salida/Egreso",
id_farmacia varchar(20) not null comment "Farmacia que solicita la medicina",
id_bodega varchar(10) not null comment "Bodega que provee la medicina",
cod_med varchar(20) not null comment "Código de la medicina que se entrega",
f_solicitud Date not null comment "Fecha de la Solicitud del Pedido",
f_egreso Date not null comment "Fecha de Egreso a la farmacia",
cantidad int not null comment "Cantidad de medicina que solicita la farmacia",
foreign key (id_farmacia) references Farmacia(id),
foreign key (id_bodega) references Bodega(id),
foreign key (cod_med) references Medicina(codigo)
); 

create table if not exists Ingreso(
id_ingreso int PRIMARY KEY auto_increment comment "Identificador de Entrada/Ingreso",
id_bodega varchar(10) NOT NULL comment "Bodega que solicita la medicina", 
code_med varchar(20)  NOT NULL comment "Código de la medicina que se recibe",
cantidad int NOT NULL comment "Cantidad de la medicina que se recibe",
justificativo varchar(100) NOT NULL comment "Justificación del Pedido",
f_ingreso Date NOT NULL comment "Fecha de Ingreso a la bodega",
f_solicitud Date NOT NULL comment "Fecha de la Solicitud del Pedido",
FOREIGN KEY (id_bodega) REFERENCES Bodega(id),
FOREIGN KEY (code_med) REFERENCES Medicina(codigo)
);

-- INSERTS
insert into Localidad values 
(12.5,14.3,'9octubre','chimborazo','guayaquil','guayas','alado del kfc'),
(7.5,7.9,'via daule','km 23','guayaquil','guayas','casa sin pintar'),
(16.0,6.6,'perimetral','km 5','guayaquil','guayas','alado de la tablita'),
(15.5,10.3,'urdesa','23 cn','guayaquil','guayas','alado del CEN'),
(18.2,10.5,'urdesa','victor emilio estrada','guayaquil','guayas','alado pizzahut'),
(17.5,8.3,'bastion','pedro sanchez3ro','guayaquil','guayas','alado de pollos barcelona'),
(5.9,9.3,'puerto azul','Avenida 60 S-O','guayaquil','guayas','diagonal centro comercial Puerto Azul')
;

insert into Categoria(nombre) values
('Analgésicos'),
('Antialérgicos'),
('laxantes'),
('Antiinfecciosos'),
('Antipiréticos'),
('mucolíticos'),
('Antiinflamatorios')
;

insert into Medicina values
('med001','Simvastatina',1.5,true,2),
('med002','Aspirina',2.0,false,2),
('med003','Omeprazol',0.45,false,1),
('med004','Lexotiroxina sódica',4.0,true,5),
('med005','Ramipril',2.0,false,6),
('med006','Amlodipina',0.60,false,4),
('med007','Apronax',0.50, false,7)
;

insert into Persona values
('0231546','Jose','Molina','Garzon','paga@hotmail.com','2165465489','urdesa'),
('8795656','Raul','Mendoza','Guale','pama@hotmail.com','564654893','centro'),
('3216498','ken','miranda','martinez','kega@hotmail.com','865413216','sambo'),
('1008564','patricia','suarez','zambrano','pasu@hotmail.com','2164535489','urdesa'),
('4545649','mary','santa','cruz','masa@hotmail.com','2165623189','bastion'),
('1123321','maria','guerra','biassini','mesa@hotmail.com','2165458756','via la costa'),	
('7846521','pepe','santa','cruz','pesa@hotmail.com','2165953156','via la costa'),
('9245285','pancho','santa','sanchez','pasa@hotmail.com','2556543216','bastion'),
('4558722','pedro','pacheco','madero','pepa@hotmail.com','2789321256','garzota'),
('8725455','milena','santa','madero','misa@hotmail.com','2168793645','samanes'),
('4600876','gustavo','santa','madero','gusa@hotmail.com','2168622465','suburbio'),
('8637921','jose','santa','madero','josa@hotmail.com','2168677546','bastion'),
('1004571','mercy','rivera','miranda','mrmiranda@hotmail.com',2756056135,'suburbio'),
('4545645','marco','garcia','ramirez','margarcia@hotmail.com',2988556600,'villa olimpo'),
('1105621','pepe','garcia','lopez','pepelo@hotmail.com',2984625123,'puerto azul'),
('4696114','rodrigo','lopez','correa','lopezcorrea@hotmail.com',2885635275,'via a la costa'),
('8837910','kevin','villanueva','solano','kesolano@hotmail.com',2756410135,'urdenor'),
('2077893','alba','vargas','dominguez','alvargas@hotmail.com',2756014135,'suburbio'),
('2858755','dylan','carrera','diaz','dydiaz@hotmail.com',2756096135,'samanes'),
('4526618','damian','espinoza','velez','dami2000@hotmail.com',2942785565,'urdesa'),
('1323535','anderson', 'cajamarca','alvez','andercaja@hotmail.com',2874536991,'socio vivienda'),
('4545607','dylan','encalada','muñoz','encaladamu@hotmail.com',2286355995,'urdesa'),
('1001321','daniel','rivera','rivera','christian@hotmail.com',2958574462,'puerto azul'),
('9541574','anibal','jones','martinez','anibal@hotmail.com',2554544554,'urdenor'),
('4773215','josue','valdiviezo','palacios','palajosue@hotmail.com',2545251547,'samborondon'),
('1651551','nicolas','ramirez','nelson','nicolas@hotmail.com',2845691784,'samborondon'),
('7778691','hector','herrera','santos','hherrera@hotmail.com',2848178759,'perimetral'),
('7999651','oliver','rivera','tomala','oliverivera@hotmail.com',2548364844,'suburbio'),
('5645231','freddy','collaguazo','toala','freddy@hotmail.com',2784545365,'perimetral'),
('2500045','xavier','tingo','paredes','xavitingo@hotmail.com',2845152189,'villa club'),
('4003616','sofia','camacho','mieles','sofia@hotmail.com',2848477899,'villa olimpo'),
('8654654','elliot','santiesteban','garcia','eliotsanti@hotmail.com',2387645486,'villa club'),
('2342423','matias','santos','paredes','mati@hotmail.com',2545183523,'samborondon'),
('2005561','ezequiel','perez','gonzales','ezequiel@hotmail.com',2849651578,'suburbio'),
('0452668','paolo','rivera','hernandez','hernandez@hotmail.com',2847859974,'puerto azul'),
-- CEDULAS VEMDEDOR
('4003518','emilio','espinoza','biscaino','emidespi@hotmail.com','2243962423','duran'),	
('2377773','karlita','moscoso','arrieta','kamoarri@hotmail.com','2242323242','villa club'),   
('2112121','juliana','jurado','palma','juli22@hotmail.com','2321965005','guasmo'),	
('7883881','jimmy','clovis','perez','mrmiranda@hotmail.com',2862754449,'perimetral'),
('7400666','wuilson','rivera','gutierrez','wuilrigu@hotmail.com',2005258123,'suburbio'),
('5064251','klelia','altamirano','miranda','miraltamirano@hotmail.com',2999663859,'pto maritimo'),
('5694565','nicole','quishpe','vallejo','nikkivallejo@hotmail.com',2754260135,'perimetral'),
-- CEDULAS ADMINISTRADOR
('1542580','gilberto','arroto','garcia','gilgarcia@hotmail.com',2841659875,'villa club'),
('4937645','guillermo','palma','arroyo','guille@hotmail.com',26589475,'perimetral'),
('1511321','mateo','barcelata','munoz','matbarce@hotmail.com',2154425967,'puerto azul'),
('2554255','michael','ordonez','leon','michaelor@hotmail.com',2958388863,'las malvinas'),
('5426542','mateo','ribera','collazo','mateori@hotmail.com',2479453008,'pradera'),
('5451823','alvaro','noboa','delgado','alvarito@hotmail.com',2484961468,'samborondon'),
('1676255','rafael','gonzales','delgado','rafico@hotmail.com',2584005816,'samborondon'),
-- CEDULA JEFEFARMACIA
('7846999','sergio','vergara','washington','sergiowas@hotmail.com',2484774777,'via a la costa'),
('7415231','mateo','martinez','bravo','mateus@hotmail.com',2845835647,'samborondon'),
('5655582','luis','romero','socorro','luisrom@hotmail.com',2515471478,'villa olimpo'),
('2351451','marco','rincon','cruz','marcori@hotmail.com',2484285499,'suburbio'),
('0925645','jose','rodriguez','acosta','josero@hotmail.com',2848004848,'via a la costa'),
('0922236','santiago','fernandez','perez','santiago@hotmail.com',2584015863,'perimetral'),
('0236558','alejandro','ruisenor','palma','alejandro@hotmail.com',2498143631,'suburbio'),
-- CEDULAS BODEGUEROS
('5425422','emmanuel','bravo','urdaneta','emmabra@hotmail.com',2548361685, 'urdenor'),
('4554242','adrian','avila','romero','adrina@hotmail.com',2659857484,'urdesa'),
('8542524','hector','jaramillo','alves','jaramillo@hotmail.com',2124875489,'samborondon'),
('8585841','alonso','jeremias','chavez','alonso@hotmail.com',2489656674,'pradera'),
('6982425','ismael','barroso','pastuzo','ismael@hotmail.com',2564677458,'villa olimpo'),
('5842542','joel','urdaneta','ribera','joelurd@hotmail.com',2445004891,'suburbio'),
('8924004','miguel','alvarado','rodriguez','miguelito@hotmail.com',2848035648,'miraflores')
;

insert into Cliente values
('0231546'),
('8795656'),
('3216498'),
('1008564'),
('4545649'),
('1123321'),	
('7846521'),
('9245285'),
('4558722'),
('8725455'),
('4600876'),
('8637921'),
('1004571'),
('4545645'),
('1105621'),
('4696114'),
('8837910'),
('2077893'),
('2858755'),
('4526618'),
('1323535'),
('4545607'),
('1001321'),
('9541574'),
('4773215'),
('1651551'),
('7778691'),
('7999651'),
('5645231'),
('2500045'),
('4003616'),
('8654654'),
('2342423'),
('2005561'),
('0452668')
;

insert into Trabajador values
('4003518',450.50),
('2377773 ',395.50),
('2112121',400),
('7883881',380),
('7400666',495.50),
('5064251',390),
('5694565',410),
('1542580',454.50),
('4937645',789.12),
('1511321',675.50),
('2554255',680),
('5426542',700),
('5451823',700),
('1676255',862.50),
('7846999',620),
('7415231',726.60),
('5655582',625.50),
('2351451',780),
('0925645',650.55),
('0922236',700),
('0236558',745.50),
('5425422',490),
('4554242',400),
('8542524',490),
('8585841',500),
('6982425',520),
('5842542',450),
('8924004',450)
;

insert into Administrador values 
('admin001','1542580'),
('admin002','4937645'),
('admin003','1511321'),
('admin004','2554255'),
('admin005','5426542'),
('admin006','5451823'),
('admin007','1676255')
;

insert into Jefe_Farmacia values
('jef001','7846999'),
('jef002','7415231'),
('jef003','5655582'),
('jef004','2351451'),
('jef005','0925645'),
('jef006','0922236'),
('jef007','0236558')
;

insert into Bodega values
('bodega001','urdesa','admin001'),
('bodega002','bastion','admin002'),
('bodega003','alborada','admin003'),
('bodega004','perimetral','admin004'),
('bodega005','portete','admin005'),
('bodega006','centro','admin006'),
('bodega007','samborondon','admin007')
;

insert into Bodeguero values 
('bod001','5425422','bodega001'),
('bod002','4554242','bodega002'),
('bod003','8542524','bodega003'),
('bod004','8585841','bodega004'),
('bod005','6982425','bodega005'),
('bod006','5842542','bodega006'),
('bod007','8924004','bodega007')
;

insert into Almacenamiento values
('bodega001','med001',150),
('bodega001','med002',550),
('bodega001','med003',300),
('bodega001','med004',450),
('bodega001','med005',600),
('bodega001','med006',250),
('bodega001','med007',500),
('bodega002','med001',500),
('bodega002','med002',1550),
('bodega002','med003',1000),
('bodega002','med004',780),
('bodega002','med005',600),
('bodega002','med006',650),
('bodega002','med007',350),
('bodega003','med001',1500),
('bodega003','med002',900),
('bodega003','med003',880),
('bodega003','med004',690),
('bodega003','med005',300),
('bodega003','med006',350),
('bodega003','med007',450),
('bodega004','med001',480),
('bodega004','med002',950),
('bodega004','med003',650),
('bodega004','med004',1200),
('bodega004','med005',1400),
('bodega004','med006',1500),
('bodega004','med007',800),
('bodega005','med001',800),
('bodega005','med002',300),
('bodega005','med003',550),
('bodega005','med004',620),
('bodega005','med005',700),
('bodega005','med006',700),
('bodega005','med007',900),
('bodega006','med001',1000),
('bodega006','med002',1100),
('bodega006','med003',750),
('bodega006','med004',750),
('bodega006','med005',1500),
('bodega006','med006',1150),
('bodega006','med007',360),
('bodega007','med001',450),
('bodega007','med002',900),
('bodega007','med003',850),
('bodega007','med004',1000),
('bodega007','med005',1000),
('bodega007','med006',600),
('bodega007','med007',2000)
;

insert into Farmacia values
('farm001','65768654','comunitarias','jef001',12.5,14.3),
('farm002','45621354','cruz azul','jef002',15.5,10.3),
('farm003','12440598','sana sana','jef003',17.5,8.3),
('farm004','23581561','farmacias 911','jef004',7.5,7.9),
('farm005','65510006','sufarmacia','jef005',16.0,6.6),
('farm006','65616011','pharmacys','jef006',18.2,10.5),
('farm007','69458955','fybeca','jef007',5.9,9.3)
;

insert into Vendedor values
('vdd001','4003518','farm001'),
('vdd002','2377773','farm002'),
('vdd003','2112121','farm003'),
('vdd004','7883881','farm004'),
('vdd005','7400666','farm005'),
('vdd006','5064251','farm006'),
('vdd007','5694565','farm007')
;

insert into inventario values
(1,'med001','farm001','2021-01-02'),
(2,'med001','farm001','2020-06-02'),
(3,'med001','farm002','2021-01-02'),
(4,'med001','farm003','2022-01-02'),
(5,'med001','farm004','2023-01-02'),
(6,'med001','farm007','2024-05-02'),
(7,'med001','farm005','2021-01-02'),
(8,'med001','farm001','2020-01-02'),
(10,'med001','farm001','2021-04-02'),
(11,'med001','farm001','2022-01-02'),
(12,'med002','farm001','2022-03-02'),
(13,'med002','farm006','2023-10-02'),
(14,'med003','farm005','2022-01-02'),
(15,'med003','farm006','2021-01-02'),
(16,'med004','farm002','2021-01-02'),
(17,'med004','farm003','2020-01-02'),
(18,'med004','farm004','2023-01-02'),
(19,'med004','farm002','2026-11-02'),
(20,'med004','farm001','2020-01-02'),
(21,'med005','farm001','2022-12-02'),
(22,'med005','farm007','2020-01-02'),
(23,'med006','farm001','2022-05-02'),
(24,'med006','farm002','2023-01-02'),
(25,'med006','farm004','2024-01-02'),
(26,'med006','farm006','2020-01-02'),
(27,'med007','farm001','2022-06-02'),
(28,'med007','farm001','2020-01-02'),
(29,'med007','farm002','2023-06-02'),
(30,'med007','farm003','2023-05-02'),
(31,'med007','farm004','2021-12-02'),
(32,'med007','farm007','2022-01-02')
;

insert into Disponibilidad values
('farm001','med001',150,50),
('farm001','med002',150,50),
('farm001','med003',150,50),
('farm001','med004',150,50),
('farm001','med005',150,50),
('farm001','med006',150,50),
('farm001','med007',150,50),
('farm002','med001',500,30),
('farm002','med002',500,30),
('farm002','med003',500,30),
('farm002','med004',500,30),
('farm003','med005',50,20),
('farm004','med001',600,100),
('farm004','med002',450,100),
('farm004','med005',120,100),
('farm004','med006',25,20),
('farm005','med003',500,100),
('farm005','med006',500,100),
('farm006','med002',100,20),
('farm006','med005',100,20),
('farm006','med007',20,20),
('farm007','med001',750,20),
('farm007','med002',150,20),
('farm007','med004',750,20)
;

insert into Factura values
(1,'vdd001','0231546','2020-01-25'), 
(2,'vdd002','0231546','2020-01-03'),
(3,'vdd002','8795656','2020-01-06'),
(4,'vdd001','2342423','2020-01-17'),  
(5,'vdd003','3216498','2019-01-17'), 
(6,'vdd007','1008564','2020-01-19'), 
(7,'vdd004','4545649','2020-02-21'), 
(8,'vdd003','2005561','2020-02-23'), 
(9,'vdd001','4545649','2020-02-25'), 
(10,'vdd002','1123321','2020-02-25'),
(11,'vdd001','7846521','2020-02-25'),
(12,'vdd004','7846521','2020-02-27'), 
(13,'vdd002','9245285','2020-02-27'), 
(14,'vdd004','8654654','2020-02-27'), 
(15,'vdd001','4558722','2020-02-28'), 
(16,'vdd003','8725455','2020-02-01'),
(17,'vdd002','4600876','2020-02-03'),
(18,'vdd004','8637921','2020-03-05'),
(19,'vdd005','1004571','2020-03-07'),
(20,'vdd001','0452668','2020-03-09'),
(21,'vdd005','4545645','2020-03-22'),
(22,'vdd001','4545645','2020-03-25'),
(23,'vdd002','4545645','2020-04-25'),
(24,'vdd005','1105621','2020-04-25'),
(25,'vdd002','4696114','2020-04-27'),
(26,'vdd003','8837910','2020-04-27'),
(27,'vdd002','8837910','2020-04-27'),
(28,'vdd007','8837910','2020-04-28'),
(29,'vdd007','2077893','2020-04-30'),
(30,'vdd001','2077893','2020-04-30'),
(31,'vdd005','2858755','2020-05-05'),
(32,'vdd004','4526618','2020-05-15'),
(33,'vdd007','4526618','2020-05-20'),
(34,'vdd006','4526618','2020-06-02'),
(35,'vdd004','1323535','2020-06-02'),
(36,'vdd002','1323535','2020-06-02'),
(37,'vdd006','4545607','2020-06-03'),
(38,'vdd005','4545607','2020-06-05'),
(39,'vdd002','1001321','2020-07-25'),
(40,'vdd003','1001321','2020-07-27'),
(41,'vdd007','9541574','2020-07-29'),
(42,'vdd003','9541574','2020-08-06'),
(43,'vdd006','4773215','2020-08-12'),
(44,'vdd006','1651551','2020-08-12'),
(45,'vdd004','1651551','2020-08-13'),
(46,'vdd004','7778691','2020-08-15'),
(47,'vdd005','7999651','2020-08-16'),
(48,'vdd004','5645231','2020-08-17'),
(49,'vdd007','2500045','2020-08-21'),
(50,'vdd002','4003616','2020-08-23')
;

insert into DetalleFactura values
(1,'med001',2),
(1,'med003',2),
(1,'med007',2),
(2,'med002',1),
(3,'med004',1),
(4,'med005',1),
(5,'med006',4),
(6,'med001',1),
(6,'med002',2),
(6,'med005',5),
(7,'med003',3),
(7,'med004',1),
(8,'med002',3),
(9,'med002',3),
(10,'med002',2),
(11,'med001',1),
(11,'med002',1),
(11,'med004',1),
(12,'med005',1),
(13,'med006',1),
(14,'med003',1),
(14,'med005',1),
(14,'med006',2),
(15,'med003',3),
(16,'med003',4),
(17,'med002',1),
(18,'med001',1),
(19,'med001',1),
(20,'med006',3),
(21,'med006',3),
(22,'med002',2),
(22,'med005',5),
(22,'med006',3),
(23,'med003',1),
(23,'med004',10),
(24,'med004',1),
(25,'med004',1),
(26,'med004',1),
(27,'med005',1),
(28,'med006',3),
(29,'med006',3),
(30,'med002',2),
(30,'med003',1),
(30,'med004',2),
(31,'med007',2),
(32,'med002',2),
(33,'med003',2),
(34,'med003',2),
(35,'med002',2),
(35,'med006',12),
(36,'med006',1),
(37,'med007',1),
(38,'med005',1),
(39,'med005',1),
(40,'med005',1),
(41,'med005',10),
(41,'med006',10),
(41,'med007',5),
(42,'med004',3),
(43,'med004',3),
(44,'med001',1),
(44,'med002',3),
(44,'med003',3),
(44,'med004',5),
(44,'med005',5),
(44,'med006',2),
(44,'med007',1),
(45,'med002',3),
(46,'med003',1),
(47,'med004',1),
(47,'med007',1),
(48,'med006',1),
(49,'med006',1),
(50,'med001',1),
(50,'med002',3),
(50,'med003',5)
;

insert into Egreso values 
(1,'farm001','bodega001','med003','2020-01-12','2020-01-22',350),
(2,'farm002','bodega001','med006','2020-01-31','2020-02-16',400),
(3,'farm003','bodega003','med002','2020-02-03','2020-02-07',100),
(4,'farm001','bodega002','med001','2020-03-17','2020-04-01',200),
(5,'farm002','bodega002','med005','2020-03-12','2020-04-04',670),
(6,'farm003','bodega003','med004','2020-04-26','2020-05-08',1000),
(7,'farm004','bodega002','med007','2020-04-13','2020-05-09',500),
(8,'farm002','bodega006','med001','2020-04-15','2020-05-10',700),
(9,'farm005','bodega007','med002','2020-04-26','2020-06-15',900),
(10,'farm002','bodega001','med007','2020-05-24','2020-06-22',800),
(11,'farm007','bodega006','med004','2020-05-26','2020-06-29',800),
(12,'farm005','bodega002','med006','2020-05-27','2020-07-02',1200),
(13,'farm003','bodega007','med005','2020-05-28','2020-07-03',1000),
(14,'farm004','bodega004','med001','2020-06-10','2020-07-04',900),
(15,'farm001','bodega006','med007','2020-06-11','2020-07-06',800),
(16,'farm001','bodega002','med006','2020-06-13','2020-07-07',700),
(17,'farm003','bodega007','med005','2020-06-18','2020-07-12',650),
(18,'farm005','bodega001','med005','2020-06-20','2020-07-16',700),
(19,'farm007','bodega003','med003','2020-06-27','2020-07-25',650),
(20,'farm001','bodega006','med007','2020-06-28','2020-07-29',550),
(21,'farm006','bodega007','med001','2020-06-29','2020-08-10',950),
(22,'farm004','bodega005','med004','2020-07-14','2020-08-14',500),
(23,'farm005','bodega004','med006','2020-07-20','2020-08-16',1200),
(24,'farm007','bodega001','med003','2020-07-24','2020-08-18',600),
(25,'farm002','bodega007','med002','2020-07-26','2020-08-20',800)
;

insert into Ingreso values
(1,'bodega001','med001',200,'se agotó Simvastatina','2020-01-02','2019-11-12'),
(2,'bodega001','med002',300,'se agotó Aspirina','2020-01-03','2019-11-14'),
(3,'bodega003','med006',750,'está por agotarse Amlodipina','2020-01-08','2019-11-29'),
(4,'bodega001','med003',236,'está por agotarse Omeprazol','2020-01-09','2019-12-01'),
(5,'bodega002','med004',120,'se agotó Aspirina','2020-01-19','2019-12-15'),
(6,'bodega003','med005',1200,'hay muchos pedidos de Ramipril','2020-02-22','2019-12-18'),
(7,'bodega003','med005',700,'por agotarse Omeprazol','2020-02-21','2019-12-20'),
(8,'bodega005','med001',800,'por agotarse Ramipril','2020-02-21','2019-01-22'),
(9,'bodega007','med007',750,'por agotarse Ramipril','2020-03-21','2020-01-27'),
(10,'bodega001','med007',500,'por agotarse Simvastatina','2020-03-29','2020-01-29'),
(11,'bodega004','med002',600,'por agotarse Lexotiroxina sódica','2020-03-30','2020-02-03'),
(12,'bodega002','med004',550,'por agotarse Aspirina','2020-03-30','2020-02-08'),
(13,'bodega001','med005',750,'por agotarse Simvastatina','2020-03-30','2020-02-12'),
(14,'bodega007','med005',900,'por agotarse Ramipril','2020-04-30','2020-02-25'),
(15,'bodega007','med007',300,'por agotarse Ramipril','2020-04-30','2020-03-02'),
(16,'bodega003','med006',350,'por agotarse Omeprazol','2020-04-30','2020-03-09'),
(17,'bodega003','med001',650,'por agotarse Omeprazol','2020-04-30','2020-03-14'),
(18,'bodega002','med003',750,'por agotarse Aspirina','2020-05-30','2020-03-19'),
(19,'bodega005','med004',900,'por agotarse Ramipril','2020-05-30','2020-03-23'),
(20,'bodega005','med003',900,'por agotarse Ramipril','2020-05-30','2020-04-06'),
(21,'bodega006','med004',1000,'por agotarse Ramipril','2020-06-30','2020-04-10'),
(22,'bodega004','med006',650,'por agotarse Lexotiroxina sódica','2020-06-30','2020-04-15'),
(23,'bodega005','med007',600,'escasez de apronax','2020-06-30','2020-04-19'),
(24,'bodega005','med004',1100,'alta demanda de Lexotiroxina sódica','2020-07-30','2020-05-07'),
(25,'bodega006','med007',600,'esta por agotarse medicamento apronax','2020-07-30','2020-05-18')
;

-- VIEWS
create view reporteIngresosBodega as
select b.direccion direccionBodega, concat(p.nombre,' ',p.apell_pat,' ', apell_mat) solicitante, i.f_solicitud fechaSolicitud, m.nombre nombreMedicina, i.cantidad cantidadSolicitada from ingreso i
inner join (bodega b, medicina m, administrador a, persona p)
on (i.id_bodega = b.id and b.id_admin = a.id_admin and a.cedula = p.cedula and i.code_med = m.codigo);

create view reporteEgresosBodega as
select b.direccion direccionBodega, concat(p1.nombre,' ',p1.apell_pat,' ',p1.apell_mat) receptorSolicitud, e.f_egreso fechaEgreso, concat(p2.nombre,' ',p2.apell_pat,' ',p2.apell_mat) solicitante, f.nom_farm nombreFarmacia, concat(l.calle1, ' ', l.calle2, '-', l.camp_ref) direccionFarmacia, m.nombre nombreMedicina,e.cantidad cantidadMedicina from egreso e
inner join (bodega b, administrador a, persona p1, persona p2, farmacia f, jefe_farmacia jf, localidad l, medicina m)
on (e.id_bodega = b.id and b.id_admin = a.id_admin and a.cedula = p1.cedula and e.id_farmacia = f.id and f.id_jefe = jf.id_jefe and jf.cedula = p2.cedula and f.lat_farm = l.lat and f.log_farm = l.log and e.cod_med = m.codigo);

create view frecCompraCategoria as
select c.nombre nombreCategoria, concat(p.nombre,' ',p.apell_pat,' ', apell_mat) cliente, count(df.id_factura) cantidadCompras, sum(m.precio*df.cantidad) totalCompras from factura f 
inner join (detallefactura df, persona p, medicina m, categoria c)
on (f.id_factura = df.id_factura and f.cedula_cliente = p.cedula and df.cod_med = m.codigo and m.codeCategoria = c.codeCategoria)
group by c.codeCategoria, cliente;

-- STORED PROCEDURES AND TRANSACTIONS
drop procedure if exists verificarIngreso;
delimiter $$
create procedure verificarIngreso(in idBodega varchar(10), in codeMed varchar(20), in cant int, in just varchar(100), in fIngreso date, in fSolicitud date)
begin
	start transaction;
		insert into ingreso(id_bodega,code_med,cantidad,justificativo,f_ingreso,f_solicitud) value (idBodega,codeMed,cant,just,fIngreso,fSolicitud);
	commit;
end;
$$
delimiter ;

DELIMITER |
create trigger tgr_ingreso_bodega after insert
on ingreso for each row
begin
	update almacenamiento a set stockB = stockB + new.cantidad where a.id_bodega = new.id_bodega and a.cod_med = new.code_med;
end;
|
DELIMITER ;

drop procedure if exists verificarEgreso;
delimiter $$
create procedure verificarEgreso(in idFarmacia varchar(20), in idBodega varchar(10), in codeMed varchar(20), in cant int, in fEgreso date, in fSolicitud date)
begin
	start transaction;
	insert into egreso(id_farmacia,id_bodega,cod_med,cantidad,f_solicitud,f_egreso) value (idFarmacia,idBodega,codeMed,cant,fSolicitud,fEgreso);
    
    set @stockInBodega = (select stockB from almacenamiento a where a.id_bodega = idBodega and a.cod_med = codeMed);
    
    if cant <= @stockInBodega then
		commit;
    else
		rollback;
    end if;
end;
$$
delimiter ;

DELIMITER |
create trigger tgr_egreso_bodega after insert
on egreso for each row
begin
	update almacenamiento a set stockB = stockB - new.cantidad where a.id_bodega = new.id_bodega and a.cod_med = new.cod_med;
    update disponibilidad d set stockF = stockF + new.cantidad where d.id_farm = new.id_farmacia and d.cod_med = new.cod_med;
end;
|
DELIMITER ;

DELIMITER |
create trigger tgr_venta_farm after insert
on detallefactura for each row
begin
    update disponibilidad d set stockF = stockF - new.cantidad 
    where d.id_farm = (select id_farm from detallefactura df
					inner join (factura f, vendedor v)
					on (df.id_factura = f.id_factura and f.id_vendedor = v.id_vendedor)
					where df.id_factura = new.id_factura and df.cod_med = new.cod_med) 
	and d.cod_med = new.cod_med;
end;
|
DELIMITER ;

-- INDEXES
select c.nombre nombreCategoria, concat(p.nombre,' ',p.apell_pat,' ', apell_mat) cliente, count(df.id_factura) cantidadCompras, sum(m.precio*df.cantidad) totalCompras from factura f 
inner join (detallefactura df, persona p, medicina m, categoria c)
on (f.id_factura = df.id_factura and f.cedula_cliente = p.cedula and df.cod_med = m.codigo and m.codeCategoria = c.codeCategoria)
group by c.codeCategoria, cliente;

