unit listamemoriaprincipalPOO;

interface

uses
  TiposDominio;

type
  ClassLista = object
    cab,act,tam: byte;
    elem: array[1..N] of t_evento;
    procedure Crear_Lista;
    procedure Agregar(x: t_evento);
    procedure Desplazar_Atras(posicion: byte);
    procedure Desplazar_Adelante(posicion: byte);
    procedure EliminarLista(buscado: byte; var x: t_evento);
    procedure Primero();
    function Fin(): boolean;
    function Tamanio(): byte;
    procedure Recuperar(var x: t_evento);
    procedure Siguiente();
    procedure final();
  end;

implementation

{function Buscado(busc: byte): boolean;
var
  x: t_evento;
begin
  Buscado:= false;
  result:= false;
  primero(l);
  while not(Fin(l)) and not(Buscado) do
  begin
    recuperar(l,x);
    if x.id = busc then
      Buscado:= true;
    siguiente(l);
  end;
end;}
procedure ClassLista.Crear_Lista();
begin
  cab := 0;
  tam := 0;
end;
function ClassLista.Tamanio(): byte;
begin
  Tamanio := tam;
end;
procedure ClassLista.Desplazar_Atras(posicion: byte);
var
  i: byte;
begin
  for i := Tamanio downto posicion do
    elem[i + 1] := elem[i];
end;
procedure ClassLista.Agregar(x: t_evento);
begin
  if (cab = 0) then
  begin
    Inc(cab);
    elem[cab]:= x;
  end
  else
    if (elem[cab].id > x.id) then
    begin
      Desplazar_Atras(1);
      elem[cab]:= x
    end
    else
    begin
      act:= cab + 1;
      while (act <= Tamanio) and (elem[act].id < x.id) do
        inc(act);
      if act <= Tamanio then
        Desplazar_Atras(act);
      elem[act]:= x;
    end;
  Inc(tam)
end;
procedure ClassLista.Desplazar_Adelante(posicion: byte);
var
  i: byte;
begin
  for i:= posicion to Tamanio - 1 do
    elem[i]:= elem[i+1];
end;
procedure ClassLista.EliminarLista(buscado: byte; var x: t_evento);
begin
  if (elem[cab].id = buscado) then
  begin
    x:= elem[cab];
    if Tamanio > 1 then
    begin
      Desplazar_Adelante(1);
      cab:= 1;
    end
    else cab:= 0;
  end
  else
  begin
    act:= cab + 1;
    while (elem[act].id <> buscado) do
      Siguiente;
    x:= elem[act];
    if act < Tamanio then
      Desplazar_Adelante(act);
  end;
  Dec(tam)
end;
procedure ClassLista.Siguiente();
begin
  act := act + 1;
end;
procedure ClassLista.Primero();
begin
  act := cab;
end;
procedure ClassLista.Recuperar(var x: t_evento);
begin
  x:= elem[act];
  Siguiente;
end;
function ClassLista.Fin(): boolean;
begin
  Fin := act = Tamanio + 1;
end;
procedure ClassLista.Final();
begin
  act:=tam;
end;

end.

