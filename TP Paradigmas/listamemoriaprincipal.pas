unit ListaMemoriaPrincipal;

interface

uses
  crt, SysUtils, TiposDominio, validaciones;

var l:t_lista;

procedure Mostrar_Evento(x: t_evento);
procedure Crear_Lista_Arch;
procedure Agregar(var l: t_lista; x: t_evento);
procedure Desplazar_Atras(var l: t_lista; posicion: byte);
procedure Desplazar_Adelante(var l: t_lista; posicion: byte);
procedure EliminarLista(var l: t_lista; buscado: byte; var x: t_evento);
procedure Siguiente(var l: t_lista);
procedure Primero(var l: t_lista);
function Fin(l: t_lista): boolean;
function Tamanio(var l: t_lista): byte;
procedure Recuperar(var l: t_lista; var e: t_evento);
procedure Registrar_Evento(evento:t_evento);
procedure Buscar_Por_Tipo(tipo:shortstring);
procedure Buscar_Por_Fechas(fechaini,fechafin:shortstring);
Procedure Buscar_Por_Titulo(titulo:shortstring);
procedure Eliminar_Evento(id:byte);

implementation

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
function Buscado(var l: t_lista; busc: byte): boolean;
var
  enc: boolean;
  x: t_evento;
begin
  enc:= false;
  result:= false;
  primero(l);
  while not(Fin(l)) and not(enc) do
  begin
    recuperar(l,x);
    if x.id = busc then
      enc:= true;
    siguiente(l);
  end;
end;
procedure Crear_Lista_Arch;
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
end;
function Fin(l: t_lista): boolean;
begin
  Fin := l.act = Tamanio(l) + 1;
end;
procedure Registrar_Evento(evento: t_evento);
begin
  if tamanio(l) = 0 then
    evento.id:= 0
  else
    evento.id:= l.elem[tamanio(l)].id+1;
  agregar(l,evento);
end;
procedure Buscar_Por_Tipo(tipo:shortstring);
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
procedure Buscar_Por_Fechas(fechaini,fechafin:shortstring);
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
Procedure Buscar_Por_Titulo(titulo:shortstring);
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
procedure Eliminar_Evento(id:byte);
var
  x: t_evento;
begin
  if buscado(l,id) then
    EliminarLista(l,id,x)
  else
    Writeln('No se encontro el evento a eliminar');
end;
end.

