unit ListaMemoriaSecundaria;

{$mode ObjFPC}{$H+}

interface

uses
  crt,TiposDominio,Validaciones;

const
     Ruta = './archivo.dat';
type
t_lista = file of t_evento;

procedure Crear_Lista(var l:t_lista);
procedure Agregar(var l: t_lista; x: t_evento);
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
procedure EliminarLista(var l: t_lista; buscado: byte; var x: t_evento);
procedure Primero(var l: t_lista);
function Fin(var l: t_lista): boolean;
function Tamanio(var l: t_lista): byte;
procedure Recuperar(var l: t_lista; var x: t_evento);
procedure final(var l:t_lista);
implementation
procedure Crear_Lista(var l:t_lista);
begin
  Assign(l,ruta);
  Rewrite(l);
end;
procedure recuperar (var l:t_lista;var x:t_evento);
begin
  read(l,x);
end;
function Tamanio(var l: t_lista): byte;
begin
  Tamanio:= filesize(l);
end;
Procedure Primero(var l: t_lista);
begin
  seek(l,0);
end;
procedure Agregar(var l: t_lista; x: t_evento);
begin
  Seek(l,tamanio(l));
  Write(l,x);
end;
procedure desplazar_adelante(var l:t_lista;posicion:byte);
var
  i: byte;
  x: t_evento;
begin
  for i:= posicion to Tamanio(l) - 2 do
  begin
    seek(l,i+1);
    read(l,x);
    seek(l,i);
    write(l,x);
  end;
end;
procedure Eliminarlista(var l: t_lista; buscado: byte;var x:t_evento);
begin
  seek(l,buscado);
  read(l,x);
  if tamanio(l)>1 then
  begin
    desplazar_adelante(l,buscado);
  end
  else
    seek(l,buscado);
  truncate(l);
end;
function Fin(var l:t_lista):boolean;
begin
  fin:=eof(l);
end;
procedure final(var l:t_lista);
begin
  seek(l,filesize(l)-1);
end;
end.

