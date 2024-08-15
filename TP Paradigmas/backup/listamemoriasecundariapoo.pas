unit listamemoriasecundariaPOO;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,TiposDominio,SysUtils;

const
     Ruta = './archivo.dat';

type
  ClassLista = object
    l : file of t_evento;
    procedure Crear_Lista();
    procedure Agregar(x: t_evento);
    procedure Desplazar_Adelante(posicion: byte);
    procedure EliminarLista(buscado: byte; var x: t_evento);
    procedure Primero();
    function Fin(): boolean;
    function Tamanio(): byte;
    procedure Recuperar(var x: t_evento);
    procedure final();
  end;

implementation

procedure ClassLista.Crear_Lista();
begin
  Assign(l,ruta);
  Reset(l);
end;
procedure ClassLista.recuperar (var x:t_evento);
begin
  read(l,x);
end;
function ClassLista.Tamanio(): byte;
begin
  Tamanio:= filesize(l);
end;
Procedure ClassLista.Primero();
begin
  seek(l,0);
end;
procedure ClassLista.Agregar(x: t_evento);
begin
  Seek(l,tamanio); //aa
  Write(l,x);
end;
procedure ClassLista.desplazar_adelante(posicion:byte);
var
  i: byte;
  x: t_evento;
begin
  for i:= posicion to Tamanio - 2 do
  begin
    seek(l,i+1);
    read(l,x);
    seek(l,i);
    write(l,x);
  end;
end;
procedure ClassLista.Eliminarlista(buscado: byte;var x:t_evento);
begin
  seek(l,buscado);
  read(l,x);
  if tamanio>1 then
  begin
    desplazar_adelante(l,buscado);    //
  end
  else
    seek(l,buscado);
  truncate(l);
end;
function ClassLista.Fin():boolean;
begin
  fin:=eof(l);
end;
procedure ClassLista.final();
begin
  seek(l,filesize(l)-1);
end;
end.

