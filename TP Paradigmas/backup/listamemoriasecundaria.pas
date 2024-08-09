unit ListaMemoriaSecundaria;

{$mode ObjFPC}{$H+}

interface

uses
  TiposDominio;

const
     Ruta = './archivo.dat';

type
  t_archivo = file of char;

procedure CrearArchivo(var arch: t_archivo);
procedure AbrirArchivo(var arch: t_archivo);
procedure CerrarArchivo(var arch: t_archivo);
{procedure AgregarArchivo(var arch: t_archivo; x: t_evento);
procedure EliminarDelArchivo(var arch: t_archivo; posicion: byte);}

implementation

procedure CrearArchivo(var arch: t_archivo);
begin
  Assign(arch,Ruta);
  Rewrite(arch);
end;
procedure AbrirArchivo(var arch: t_archivo);
begin
  Assign(arch,Ruta);
  Reset(arch);
end;
procedure CerrarArchivo(var arch: t_archivo);
begin
  Close(arch);
end;
{procedure AgregarArchivo(var arch: t_archivo; x: t_dato_lista);
begin
  Seek(arch,filesize(arch));
  Write(arch,x);
end;
procedure EliminarDelArchivo(var arch: t_archivo; posicion: byte);
begin

end; }
end.

