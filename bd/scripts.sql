#drop database mydb;
use mydb;
select * from usuario;

#A darle con los procedures:

desc usuario;
delimiter $
#Procedure para dar de alta un usuario:
create procedure Alta_Usuario(in email varchar(50), in contra varchar(45))
begin
	declare existe int;
    set existe=(select count(*) from usuario where usuario.email=email);
    if existe=0 then
		insert into usuario values(default,email,1,current_date(),contra);
        select usuario.idUsuario as msj from usuario order by idUsuario desc limit 1;
	else
		select 0 as msj;
	end if;
end $

#procedure para dar de alta un trabajador
create procedure Alta_Trabajador(in idUsuario int,in nombre varchar(80), in tipo int)
begin
	insert into Trabajador values(idUsuario,nombre,tipo);
    select 1 as msj;
end $

#procedure para hacer inserciones al plan, hay que controlar los costos y numero de dispositivos cuando programemos
create procedure Alta_Plan(in max_dispo int, in costo float, in metodo_pago varchar(45))
begin 
		insert into plan values(default, max_dispo,costo,metodo_pago); 
        select 1 as msj;
end $


#procedure para dar de alta un cliente
create procedure Alta_Cliente(in idUsuario int, in saldo float, in Plan_idPlan int)
begin
	insert into cliente values (idUsuario,saldo,Plan_idPlan);
    select 1 as msj;
end $

#procedure para iniciar sesion
create procedure Iniciar_Sesion(in email varchar(50), in contra varchar (45))
begin
	declare existe int;
    set existe=(select count(*) from usuario where usuario.email=email);
    if existe=1 then
        select usuario.idUsuario as msj from usuario where usuario.email=email and usuario.contra=contra;
	else 
		select 0 as msj;
	end if;
end $

#procedure para insertar directores o actores
create procedure Alta_Dire_Actor(in nombre varchar(100), in tipo int)
begin
	insert into Dire_Actor values (default, nombre, tipo);
    select 1 as msj;
end $

#procedure para crear un perfil
create procedure Alta_Perfil(in Cliente_idCliente int, in url_imagen varchar(120), in nombre varchar(80), in ctr_parental tinyint)
begin
	insert into Perfil values (default,url_imagen,nombre,ctr_parental,Cliente_idCliente);
    select 1 as msj;
end $


#procedure para catalogo Peli_Serie
create procedure Alta_PeliSerie(in Trabajador_idTrabajador int, in valoracion int, in nombre varchar(60), in fecha date,in estado varchar(45),in anio varchar(45), in url_imagen varchar(120), in Descripcion varchar(500), in Genero_idGenero int, in Pelicula_idPelicula int, in Serie_idSerie int, in Clasificacion_idClasificacion int);
begin
	insert into peli-serie values (default,Trabajador_idTrabajador,valoracion,nombre,fecha,estado,anio,url_imagen,Descripcion,Genero_idGenero,Pelicula_idPelicula,Serie_idSerie,Clasificacion_idClasificacion);
    select 1 as msj;
end $

delimiter ;


drop procedure Alta_PeliSerie;
desc Trabajador;
desc Cliente;
desc Plan;
desc Usuario;
desc dire_actor;
desc perfil;
desc peli-serie;











drop procedure Alta_Trabajador;
drop procedure Alta_Usuario;
call Alta_Usuario('ionsito@gmail.com','gatitos');
call Alta_Trabajador(2,'Yo Soy un Puerquis',0);
call Alta_Plan(4,98,'Tarjeta de Regalo');
call Alta_Cliente(3,4,1);
call Iniciar_Sesion('ionsito@gmail.com','gatitos');
call Alta_Dire_Actor('Brad Pitt', 1);
call Alta_Perfil(3,"sin direccion","Ianoncio",0);

    
	