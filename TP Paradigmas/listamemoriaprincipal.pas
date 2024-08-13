unit ListaMemoriaPrincipal;

interface

uses
  crt, SysUtils, TiposDominio, Validaciones;

type
t_lista = record
  cab,act,tam: byte;
  elem: array[1..N] of t_evento;
end;

procedure Crear_Lista(var l:t_lista);
procedure Agregar(var l: t_lista; x: t_evento);
procedure Desplazar_Atras(var l: t_lista; posicion: byte);
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
procedure EliminarLista(var l: t_lista; buscado: byte; var x: t_evento);
procedure Primero(var l: t_lista);
function Fin(l: t_lista): boolean;
function Tamanio(var l: t_lista): byte;
procedure Recuperar(var l: t_lista; var e: t_evento);
procedure Siguiente(var l: t_lista);
procedure final(var l:t_lista);

implementation
function Buscado(var l: t_lista; busc: byte): boolean;
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
end;
procedure Crear_Lista(var l:t_lista);
begin
  l.cab := 0;
  l.tam := 0;
end;
function Tamanio(var l: t_lista): byte;
begin
  Tamanio := l.tam;
end;
procedure Desplazar_Atras(var l: t_lista; posicion: byte);
var
  i: byte;
begin
  for i := Tamanio(l) downto posicion do
    l.elem[i + 1] := l.elem[i];
end;
procedure Agregar(var l: t_lista; x: t_evento);
begin
  if (l.cab = 0) then
  begin
    Inc(l.cab);
    l.elem[l.cab]:= x;
  end
  else
    if (l.elem[l.cab].id > x.id) then
    begin
      Desplazar_Atras(l, 1);
      l.elem[l.cab]:= x
    end
    else
    begin
      l.act:= l.cab + 1;
      while (l.act <= Tamanio(l)) and (l.elem[l.act].id < x.id) do
        inc(l.act);
      if l.act <= Tamanio(l) then
        Desplazar_Atras(l,l.act);
      l.elem[l.act]:= x;
    end;
  Inc(l.tam)
end;
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
var
  i: byte;
begin
  for i:= posicion to Tamanio(l) - 1 do
    l.elem[i]:= l.elem[i+1];
end;
procedure EliminarLista(var l: t_lista; buscado: byte; var x: t_evento);
begin
  if (l.elem[l.cab].id = buscado) then
  begin
    x:= l.elem[l.cab];
    if tamanio(l) > 1 then
    begin
      Desplazar_Adelante(l,1);
      l.cab:= 1;
    end
    else l.cab:= 0;
  end
  else
  begin
    l.act:= l.cab + 1;
    while (l.elem[l.act].id <> buscado) do
      Siguiente(l);
    x:= l.elem[l.act];
    if l.act < tamanio(l) then
      Desplazar_Adelante(l,l.act);
  end;
  Dec(l.tam)
end;
procedure Siguiente(var l: t_lista);
begin
  l.act := l.act + 1;
end;
procedure Primero(var l: t_lista);
begin
  l.act := l.cab;
end;
procedure Recuperar(var l: t_lista; var e: t_evento);
begin
  e:= l.elem[l.act];
  Siguiente(l);
end;
function Fin(l: t_lista): boolean;
begin
  Fin := l.act = Tamanio(l) + 1;
end;
procedure final(var l:t_lista);
begin
  l.act:=l.tam;
end;

end.

