unit ListaMemoriaPrincipal;

interface

uses
  crt, SysUtils,TiposDominio;

function Valida_Hora(hora: shortstring): boolean;
function Transf_Hora(hora: shortstring): integer;
Function Valida_Tipo(aux: shortstring): boolean;
procedure Mostrar_Evento(x: t_evento);
function Valida_Fecha(x: shortstring): boolean;
function Transf_Fecha(x: shortstring): shortstring;
procedure CrearLista(var l: t_lista);
procedure Agregar(var l: t_lista; x: t_evento);
function Lista_Llena(var l: t_lista): boolean;
function Lista_Vacia(var l: t_lista): boolean;
procedure Desplazar_Atras(var l: t_lista; posicion: byte);
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
procedure EliminarLista(var l: t_lista; buscado: byte; var x: t_evento);
procedure Siguiente(var l: t_lista);
procedure Primero(var l: t_lista);
function Fin(l: t_lista): boolean;
function Tamanio(var l: t_lista): byte;
procedure Recuperar(var l: t_lista; var e: t_evento);
procedure Registrar_Evento(var l: t_lista; evento:t_evento);
procedure Buscar_Por_Evento(var l: t_lista; tipo:shortstring);
procedure Buscar_Por_Fechas(var l:t_lista; fechaini,fechafin:shortstring);
Procedure Buscar_Por_Titulo(var l: t_lista; titulo:shortstring);
procedure Eliminar_Evento(var l:t_lista; id:byte);

implementation

function Valida_Hora(hora: shortstring): boolean;
begin
  if not(hora[1] in ['0'..'2']) or not(hora[2] in ['0'..'9']) or ((hora[1] = '2') and (hora[2] in ['4'..'9'])) or not(hora[4] in ['0'..'5']) or not(hora[5] in ['0'..'9']) then
    result:=false
  else result:= true;
end;
function Transf_Hora(hora: shortstring): integer;
begin
   Transf_Hora:=  StrToInt(hora[1]+hora[2]+hora[4]+hora[5]);
end;
function Valida_Tipo(aux: shortstring):boolean;
begin
  case aux of
    'cumpleanios': Valida_Tipo:= True;
    'aniversario': Valida_Tipo:= True;
    'reunion': Valida_Tipo:= True;
    'otro': Valida_Tipo:= True;
  else Valida_Tipo:=False
  end;
end;
procedure Mostrar_Evento(x: t_evento);
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
  TextColor(3);
  Writeln('');
  Write('Presione una Tecla para continuar');
  TextColor(15);
  Readkey;
end;
function Valida_Fecha(x: shortstring): boolean;
var dia,mes: ShortInt; anio: integer;
begin
  Valida_Fecha:= false;
  if Length(x) = 10 then
    if (x[1] in ['0'..'3']) and (x[2] in ['0'..'9']) and (x[3] = '/') and (x[4] in ['0','1']) and (x[5] in ['0'..'9']) and (x[6] = '/') and (x[7] in ['1','2']) and (x[8] in ['0','9']) and (x[9] in ['0'..'9']) and (x[10] in ['0'..'9'])  then
    begin
      dia:= StrToInt(x[1] + x[2]);
      mes:= StrToInt(x[4] + x[5]);
      anio:= StrToInt(x[7] + x[8] + x[9] + x[10]);
      if ((anio >= 1900) and (anio <= 2024)) and (((mes in [1,3,5,7,8,10,12]) and (dia in [1..31])) or ((mes in [4,6,9,11]) and (dia in [1..30])) or ((mes = 2) and (dia in [1..28])) or (((anio mod 4) = 0) and (mes = 2) and (dia = 29))) then
        Valida_Fecha:= true;
    end;
end;
function Transf_Fecha(x: shortstring): shortstring;
var aux: string[8];
begin
   aux:= copy(x,7,4) + copy(x,4,2) + copy(x,1,2);
   Transf_Fecha:= aux;
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
      inc(l.act);
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
end;
function Fin(l: t_lista): boolean;
begin
  Fin := l.act = Tamanio(l) + 1;
end;
procedure Registrar_Evento(var l: t_lista; evento: t_evento);
begin
   evento.id:= l.tam;
   agregar(l,evento);
end;
procedure Buscar_Por_Evento(var l: t_lista; tipo:shortstring);
var
  evento: t_evento;
  enc: boolean;
begin
  Primero(l);
  while not(Fin(l)) do
  begin
    clrscr;
    Recuperar(l,evento);
    if (evento.tipo=tipo) then
    begin
      enc:= true;
      Mostrar_Evento(evento);
    end;
    Siguiente(l);
  end;
  clrscr;
  if enc then
  begin
    Writeln('No se han encontrado mas eventos');
    readkey;
  end
  else
  begin
   Writeln('No se han encontrado eventos');
   readkey;
  end;
end;
procedure Buscar_Por_Fechas(var l:t_lista; fechaini,fechafin:shortstring);
var
  evento: t_evento;
  enc: boolean;
begin
  Primero(l);
  While not(Fin(l)) do
  begin
    clrscr;
    Recuperar(l,evento);
    if (Transf_Fecha(evento.fecha_inicio) >= Transf_Fecha(fechaini)) and (Transf_Fecha(evento.fecha_fin) <= Transf_Fecha(fechafin)) then
    begin
      enc:= true;
      Mostrar_Evento(evento);
    end;
    Siguiente(l);
  end;
  clrscr;
  if enc then
  begin
    Writeln('No se han encontrado mas eventos');
    readkey;
  end
  else
  begin
    Writeln('No se han encontrado eventos');
    readkey;
  end;
end;
Procedure Buscar_Por_Titulo(var l: t_lista; titulo:shortstring);
var
  evento: t_evento;
  enc: boolean;
begin
  Primero(l);
  While not(Fin(l)) do
  begin
    clrscr;
    recuperar(l,evento);
    if Pos(titulo,evento.titulo)<>0 then
    begin
      enc:= true;
      Mostrar_Evento(evento);
    end;
    Siguiente(l);
  end;
  clrscr;
  if enc then
  begin
    Writeln('No se han encontrado mas eventos');
    readkey;
  end
  else
  begin
   Writeln('No se han encontrado eventos');
   readkey;
  end;
end;
procedure Eliminar_Evento(var l:t_lista; id:byte);
var
  x: t_evento;
begin
  EliminarLista(l,id,x);
end;
end.

