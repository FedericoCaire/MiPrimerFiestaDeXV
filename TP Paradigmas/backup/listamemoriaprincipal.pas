unit ListaMemoriaPrincipal;

interface

uses
  crt, Validaciones, SysUtils;

const
  N = 100;

type
  t_tipo = (cumpleanios,aniversario,reunion,otro);

  t_dato_lista = record
     id: integer;
     titulo:string;
     desc: string;
     tipo: t_tipo;
     fecha_inicio: string;
     fecha_fin: string;
     hora_inicio: string;
     hora_fin: string;
     ubicacion: string;
  end;

  t_lista = record
      cab,act,tam: integer;
      elem: array[1..N] of t_dato_lista;
  end;


Function StrToTipo(dato: string):t_tipo;
Function TipoToStr(dato: t_tipo):string;
procedure Mostrar_Evento(x: t_dato_lista);
procedure CrearLista(var l: t_lista);
procedure Agregar(var l: t_lista; x: t_dato_lista);
function Lista_Llena(var l: t_lista): boolean;
function Lista_Vacia(var l: t_lista): boolean;
procedure Desplazar_Atras(var l: t_lista; posicion: byte);
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
procedure EliminarLista(var l: t_lista; buscado: integer; var x: t_dato_lista);
procedure Siguiente(var l: t_lista);
procedure Primero(var l: t_lista);
function Fin(l: t_lista): boolean;
function Tamanio(var l: t_lista): byte;
procedure Recuperar(var l: t_lista; var e: t_dato_lista);

implementation
procedure Mostrar_Evento(x: t_dato_lista);
begin
  Writeln('');
  Writeln('ID: ', x.id);
  Writeln('Titulo: ',x.titulo);
  Writeln('Descripcion: ',x.desc);
  Writeln('Tipo de Evento: ',x.tipo);
  Writeln('Fecha de Inicio: ',x.fecha_inicio);
  Writeln('Fecha de Finalizacion: ',x.fecha_fin);
  Writeln('Hora de Inicio: ',x.hora_inicio);
  Writeln('Hora de Finalizacion: ',x.hora_fin);
  Writeln('Ubicacion: ',x.ubicacion);
  readkey;
end;

procedure CrearLista(var l: t_lista);
begin
  l.cab := 0;
  l.tam := 0;
end;

function Tamanio(var l: t_lista): byte;
begin
  Tamanio := l.tam;
end;

function Lista_Llena(var l: t_lista): boolean;
begin
  Lista_Llena := l.tam = n;
end;

function Lista_Vacia(var l: t_lista): boolean;
begin
  Lista_Vacia := l.tam = 0;
end;

procedure Desplazar_Atras(var l: t_lista; posicion: byte);
var
  i: byte;
begin
  for i := Tamanio(l) downto posicion do
    l.elem[i + 1] := l.elem[i];
end;

procedure Agregar(var l: t_lista; x: t_dato_lista);
begin
  if (l.cab = 0) then
  begin
    Inc(l.cab);
    l.elem[l.cab] := x
  end
  else if (Transf_Fecha(l.elem[l.cab].fecha_inicio) > Transf_Fecha(x.fecha_inicio)) then
  begin
    Desplazar_Atras(l, 1);
    l.cab := 1;
    l.elem[l.cab] := x
  end
  else
  begin
    l.act := l.cab + 1;
    while (l.act <= Tamanio(l)) and (Transf_Fecha(l.elem[l.act].fecha_inicio) < Transf_Fecha(x.fecha_inicio)) do
      inc(l.act);
    if l.act < Tamanio(l) then
      Desplazar_Atras(l, l.act);
    l.elem[l.act] := x;
  end;
  Inc(l.tam)
end;

procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
var
  i: byte;
begin
  for i := posicion to Tamanio(l) - 1 do
    l.elem[i] := l.elem[i + 1];
end;

procedure EliminarLista(var l: t_lista; buscado: integer; var x: t_dato_lista);
begin
  if (l.elem[l.cab].id = buscado) then
  begin
    x := l.elem[l.cab];
    Desplazar_Adelante(l, 1)
  end
  else
  begin
    l.act := l.cab + 1;
    while (l.elem[l.act].id <> buscado) do
      inc(l.act);
    x := l.elem[l.act];
    Desplazar_Adelante(l, l.act);
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

procedure Recuperar(var l: t_lista; var e: t_dato_lista);
begin
  e := l.elem[l.act];
end;

function Fin(l: t_lista): boolean;
begin
  Fin := l.act = Tamanio(l) + 1;
end;

end.

