unit ListaMemoriaPrincipal;

interface

uses
  crt;

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
function Valida_Fecha(x: shortstring): boolean;
function Transf_Fecha(x: string): String;
procedure CrearLista(var l: t_lista);
procedure Agregar(var l: t_lista; x: t_dato_lista);
function Lista_Llena(var l: t_lista): boolean;
function Lista_Vacia(var l: t_lista): boolean;
procedure Desplazar_Atras(var l: t_lista; posicion: byte);
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
procedure EliminarLista(var l: t_lista; buscado: string; var x: t_dato_lista);
procedure Siguiente(var l: t_lista);
procedure Primero(var l: t_lista);
function Fin(l: t_lista): boolean;
function Tamanio(var l: t_lista): byte;
procedure Recuperar(var l: t_lista; var e: t_dato_lista);

implementation


Function StrToTipo(dato: string):t_tipo;
begin
    case dato of
    'cumpleanios': StrToTipo:= cumpleanios;
    'aniversario': StrToTipo:= aniversario;
    'reunion': StrToTipo:= reunion;
    'otro': StrToTipo:= otro;
    end;
end;
Function TipoToStr(dato: t_tipo):string;
begin
    case dato of
    cumpleanios: TipoToStr:= 'cumpleanios';
    aniversario: TipoToStr:= 'aniversario';
    reunion: TipoToStr:= 'reunion';
    otro: TipoToStr:= 'otro';
    end;
end;

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

function Valida_Fecha(x: shortstring): boolean;
var dia,mes: ShortInt; anio: integer;
begin
  valida_fecha:= false;
  if Length(x) = 10 then
    if (x[1] in ['0'..'3']) and (x[2] in ['0'..'9']) and (x[3] = '/') and (x[4] in ['0','1']) and (x[5] in ['0'..'9']) and (x[6] = '/') and (x[7] in ['1','2']) and (x[8] in ['0','9']) and (x[9] in ['0'..'9']) and (x[10] in ['0'..'9'])  then
    begin
      dia:= StrToInt(x[1] + x[2]);
      mes:= StrToInt(x[4] + x[5]);
      anio:= StrToInt(x[7] + x[8] + x[9] + x[10]);
      if ((anio >= 1900) and (anio <= 2024)) and (((mes in [1,3,5,7,8,10,12]) and (dia in [1..31])) or ((mes in [4,6,9,11]) and (dia in [1..30])) or ((mes = 2) and (dia in [1..28])) or (((anio mod 4) = 0) and (mes = 2) and (dia = 29))) then
        valida_fecha:= true;
    end;
end;

function Transf_Fecha(x: string): String;
var aux: string[8];
begin
   aux:= copy(x,7,4) + copy(x,4,2) + copy(x,1,2);
   transf_fecha:= aux;
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

procedure EliminarLista(var l: t_lista; buscado: string; var x: t_dato_lista);
begin
  if (Transf_Fecha(l.elem[l.cab].fecha_inicio) = Transf_Fecha(buscado)) then
  begin
    x := l.elem[l.cab];
    Desplazar_Adelante(l, 1)
  end
  else
  begin
    l.act := l.cab + 1;
    while (Transf_Fecha(l.elem[l.act].fecha_inicio) <> Transf_Fecha(buscado)) do
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

