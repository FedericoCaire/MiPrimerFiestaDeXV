unit listamemoriasecundariaPOO;

{$mode ObjFPC}{$H+}

interface

uses
  Crt,Classes,TiposDominio,SysUtils;

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
    procedure Final();
  end;

implementation

procedure ClassLista.Crear_Lista();
begin
  Assign(l,Ruta);
  Reset(l);
end;
procedure ClassLista.recuperar (var x:t_evento);
begin
  Read(l,x);
end;
function ClassLista.Tamanio(): byte;
begin
  Tamanio:= FileSize(l);
end;
Procedure ClassLista.Primero();
begin
  Seek(l,0);
end;
procedure ClassLista.Agregar(x: t_evento);
begin
  Seek(l,tamanio);
  Write(l,x);
end;
procedure ClassLista.Desplazar_Adelante(posicion: byte);
var
  i: byte;
  x: t_evento;
begin
  for i:= posicion to Tamanio - 2 do
  begin
    Seek(l,i+1);
    Read(l,x);
    Seek(l,i);
    Write(l,x);
  end;
end;
procedure ClassLista.Eliminarlista(buscado: byte;var x:t_evento);
var
    enc: boolean;
begin
  Primero;
  enc:= false;
  while not enc and not Fin do
  begin
    Recuperar(x);
    if x.id = buscado then
      enc:= true;
  end;
  if not enc then
  begin
    clrscr;
    TextColor(4);
    Write('El ID ingresado no existe');
    TextColor(15);
    readkey;
  end
  else
  begin
    if Tamanio = 1 then Seek(l,0)
    else if (Filepos(l) - 1 < Tamanio - 1) then
      begin
        Desplazar_Adelante(FilePos(l)-1);
        Seek(l,Tamanio-1);
      end else Seek(l,Tamanio-1);
    Truncate(l);
  end;
end;
function ClassLista.Fin():boolean;
begin
  Fin:= Eof(l);
end;
procedure ClassLista.Final();
begin
  Seek(l,FileSize(l)-1);
end;
end.

