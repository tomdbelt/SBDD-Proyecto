use g3p1;
-- CREATE VIEW Informe 
-- AS SELECT I.idinsum_equipo as Codigo , I.descripcion_insumo , I.marca , A.descripcion_area , A.responsable_area , E.cantidad , E.f_envio 
-- FROM insum_equipo I JOIN entrega_equipo E ON E.idinsum_equipo=I.idinsum_equipo JOIN area_medica A ON A.idespecialidad_medica=E.idespecialidad_medica;

-- create view reporteIngresosBodega as
-- select b.direccion direccionBodega, concat(p.nombre,' ',p.apell_pat,' ', apell_mat) solicitante, i.f_solicitud fechaSolicitud, m.nombre nombreMedicina, i.cantidad cantidadSolicitada from ingreso i
-- inner join (bodega b, medicina m, administrador a, persona p)
-- on (i.id_bodega = b.id and b.id_admin = a.id_admin and a.cedula = p.cedula and i.code_med = m.codigo);

-- create view reporteEgresosBodega as
-- select b.direccion direccionBodega, concat(p1.nombre,' ',p1.apell_pat,' ',p1.apell_mat) receptorSolicitud, e.f_egreso fechaEgreso, concat(p2.nombre,' ',p2.apell_pat,' ',p2.apell_mat) solicitante, f.nom_farm nombreFarmacia, concat(l.calle1, ' ', l.calle2, '-', l.camp_ref) direccionFarmacia, m.nombre nombreMedicina,e.cantidad cantidadMedicina from egreso e
-- inner join (bodega b, administrador a, persona p1, persona p2, farmacia f, jefe_farmacia jf, localidad l, medicina m)
-- on (e.id_bodega = b.id and b.id_admin = a.id_admin and a.cedula = p1.cedula and e.id_farmacia = f.id and f.id_jefe = jf.id_jefe and jf.cedula = p2.cedula and f.lat_farm = l.lat and f.log_farm = l.log and e.cod_med = m.codigo);

-- create view frecCompraCategoria as
-- select c.nombre nombreCategoria, concat(p.nombre,' ',p.apell_pat,' ', apell_mat) cliente, count(df.id_factura) cantidadCompras, sum(m.precio*df.cantidad) totalCompras from factura f 
-- inner join (detallefactura df, persona p, medicina m, categoria c)
-- on (f.id_factura = df.id_factura and f.cedula_cliente = p.cedula and df.cod_med = m.codigo and m.codeCategoria = c.codeCategoria)
-- group by c.codeCategoria, cliente;

-- trigger
-- DELIMITER |
-- create trigger tgr before insert
-- on egreso for each row
-- begin


-- end;
-- |
-- DELIMITER ;

-- drop procedure if exists verificarIngreso;
-- delimiter $$
-- create procedure verificarIngreso(in idBodega varchar(10), in codeMed varchar(20), in cant int, in just varchar(100), in fIngreso date, in fSolicitud date)
-- begin
-- 	start transaction;
-- 		insert into ingreso(id_bodega,code_med,cantidad,justificativo,f_ingreso,f_solicitud) value (idBodega,codeMed,cant,just,fIngreso,fSolicitud);
-- 	commit;
-- end;
-- $$
-- delimiter ;

-- DELIMITER |
-- create trigger tgr_aumentar_almacenamiento after insert
-- on ingreso for each row
-- begin
-- 	update almacenamiento a set stockB = stockB + new.cantidad where a.id_bodega = new.id_bodega and a.cod_med = new.code_med;
-- end;
-- |
-- DELIMITER ;

-- drop procedure if exists verificarEgreso;
-- delimiter $$
-- create procedure verificarEgreso(in idFarmacia varchar(20), in idBodega varchar(10), in codeMed varchar(20), in cant int, in fEgreso date, in fSolicitud date)
-- begin
-- 	start transaction;
-- 	insert into egreso(id_farmacia,id_bodega,cod_med,cantidad,f_solicitud,f_egreso) value (idFarmacia,idBodega,codeMed,cant,fSolicitud,fEgreso);
--     
--     set @stockInBodega = (select stockB from almacenamiento a where a.id_bodega = idBodega and a.cod_med = codeMed);
--     
--     if cant <= @stockInBodega then
-- 		commit;
--     else
-- 		rollback;
--     end if;
-- end;
-- $$
-- delimiter ;

-- DELIMITER |
-- create trigger tgr_egreso_bodega after insert
-- on egreso for each row
-- begin
-- 	update almacenamiento a set stockB = stockB - new.cantidad where a.id_bodega = new.id_bodega and a.cod_med = new.cod_med;
--     update disponibilidad d set stockF = stockF + new.cantidad where d.id_farm = new.id_farmacia and d.cod_med = new.cod_med;
-- end;
-- |
-- DELIMITER ;

-- DELIMITER |
-- create trigger tgr_venta_farm after insert
-- on detallefactura for each row
-- begin
--     update disponibilidad d set stockF = stockF - new.cantidad 
--     where d.id_farm = (select id_farm from detallefactura df
-- 					inner join (factura f, vendedor v)
-- 					on (df.id_factura = f.id_factura and f.id_vendedor = v.id_vendedor)
-- 					where df.id_factura = new.id_factura and df.cod_med = new.cod_med) 
-- 	and d.cod_med = new.cod_med;
-- end;
-- |
-- DELIMITER ;

-- index
select c.nombre nombreCategoria, concat(p.nombre,' ',p.apell_pat,' ', apell_mat) cliente, count(df.id_factura) cantidadCompras, sum(m.precio*df.cantidad) totalCompras from factura f 
inner join (detallefactura df, persona p, medicina m, categoria c)
on (f.id_factura = df.id_factura and f.cedula_cliente = p.cedula and df.cod_med = m.codigo and m.codeCategoria = c.codeCategoria)
group by c.codeCategoria, cliente;

-- create index idx_
