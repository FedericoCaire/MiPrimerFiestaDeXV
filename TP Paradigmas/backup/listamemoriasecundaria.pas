unit ListaMemoriaSecundaria;

{$mode ObjFPC}{$H+}

interface

uses
  crt,TiposDominio,Validaciones;

const
     Ruta = './archivo.dat';

var arch: t_archivo;

procedure Crear_Lista_Arch;
procedure CerrarArchivo(var arch: t_archivo);
procedure Registrar_Evento(evento: t_evento);
procedure Buscar_Por_Tipo(tipo:shortstring);
procedure Buscar_Por_Fechas(fechaini,fechafin:shortstring);
Procedure Buscar_Por_Titulo(titulo:shortstring);
procedure Eliminar_Evento(id:byte);

implementation

procedure Crear_Lista_Arch;
begin
  Assign(arch,Ruta);
  Reset(arch);
end;
procedure CerrarArchivo(var arch: t_archivo);
begin
  Close(arch);
end;
function Tamanio(var arch: t_archivo): byte;
begin
  Tamanio:= filesize(arch);
end;
Procedure Primero(var arch: t_archivo);
begin
  seek(arch,0);
end;
procedure AgregarArchivo(var arch: t_archivo; x: t_evento);
begin
  Seek(arch,tamanio(arch));
  Write(arch,x);
end;
procedure EliminarDelArchivo(var arch: t_archivo; pos: byte);
var
  x: t_evento;
begin
  seek(arch,pos);
  read(arch,x);
  if x.tipo <> 'BAJA' then
  begin
    x.tipo:= 'BAJA';
    seek(arch,filepos(arch)-1);
    write(arch,x);
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
procedure Registrar_Evento(evento: t_evento);
begin
   evento.id:= filesize(arch);
   AgregarArchivo(arch,evento);
end;
procedure Buscar_Por_Tipo(tipo:shortstring);
var
  evento: t_evento;
  enc: boolean;
begin
  enc:= false;
  Primero(arch);
  while not(EOF(arch)) do
  begin
    clrscr;
    read(arch,evento);
    if (evento.tipo=tipo) then
    begin
      enc:= true;
      Mostrar_Evento(evento);
    end;
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
  enc:= false;
  Primero(arch);
  While not(EOF(arch)) do
  begin
    clrscr;
    Read(arch,evento);
    if (Transf_Fecha(evento.fecha_inicio) >= Transf_Fecha(fechaini)) and (Transf_Fecha(evento.fecha_fin) <= Transf_Fecha(fechafin)) then
    begin
      enc:= true;
      Mostrar_Evento(evento);
    end;
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
  enc:= false;
  Primero(arch);
  While not(EOF(arch)) do
  begin
    clrscr;
    Read(arch,evento);
    if (Pos(titulo,evento.titulo) <> 0) and (evento.tipo <> 'BAJA') then
    begin
      enc:= true;
      Mostrar_Evento(evento);
    end;
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
begin
  if id < tamanio(arch) then
    EliminarDelArchivo(arch,id)
  else
    Writeln('No se encontro el evento a eliminar');
end;
end.

