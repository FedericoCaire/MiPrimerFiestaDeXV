unit Interfaz;

interface
uses
  crt,TiposDominio,Validaciones,ListaMemoriaSecundaria;
const
  color_selec=red;
  color_fondo=black;
  color_salir=red;

procedure Iniciar_Programa;

implementation
procedure Pedir_Datos_Evento(var evento: t_evento);
var
  aux: string;
begin
  clrscr;
  repeat
    gotoxy(1,1);
    clreol;
    write('Ingrese titulo: ');
    readln(evento.titulo);
  until evento.titulo <> '';
  repeat
  begin
    gotoxy(1,2);
    clreol;
    write('Ingrese tipo: ');
    readln(aux);
  end
  until Valida_Tipo(aux);
  evento.tipo:= aux;
  Repeat
    gotoxy(1,3);
    clreol;
    write('Ingrese descripcion: ');
    readln(evento.desc);
  until evento.desc <> '';
  repeat
  begin
    gotoxy(1,4);
    clreol;
    write('Ingrese fecha de inicio: ');
    readln(evento.fecha_inicio);
  end
  until Valida_Fecha(evento.fecha_inicio);
  repeat
  begin
    gotoxy(1,5);
    clreol;
    write('Ingrese fecha de final: ');
    readln(evento.fecha_fin);
  end
  until Valida_Fecha(evento.fecha_fin) and (Transf_Fecha(evento.fecha_fin) >= Transf_Fecha(evento.fecha_inicio));
  repeat
  begin
    gotoxy(1,6);
    clreol;
    write('Ingrese hora de inicio: ');
    readln(evento.hora_inicio);
  end
  until Valida_Hora(evento.hora_inicio);
  repeat
  begin
    gotoxy(1,7);
    clreol;
    write('Ingrese hora de final: ');
    readln(evento.hora_fin);
  end
  until ((Transf_Fecha(evento.fecha_fin) > Transf_Fecha(evento.fecha_inicio)) or (Transf_Hora(evento.hora_fin) > Transf_Hora(evento.hora_inicio))) and Valida_Hora(evento.hora_fin);
  Write('Ingrese ubicacion: ');
  readln(evento.ubicacion);
end;
procedure registra_evento(var l:t_lista;x:t_evento);
var
  aux:t_evento;
begin
  pedir_datos_evento(x);
  if tamanio(l)>0 then
  begin
   Final(l);
   Recuperar(l,aux);
   x.id:=aux.id+1;
  end
  else x.id:=0;
  agregar(l,x);
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
procedure Buscar_Por_Tipo(var l:t_lista;tipo:shortstring);
var
  evento: t_evento;
  enc: boolean;
begin
  enc:= false;
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
  enc:= false;
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
Procedure Buscar_Por_Titulo(var l:t_lista;titulo:shortstring);
var
  evento: t_evento;
  enc: boolean;
begin
  enc:= false;
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
procedure Pedir_ID_Evento(var id: byte);
begin
  clrscr;
  repeat
    gotoxy(1,1);
    clreol;
    Write('Ingrese el ID del evento: ');
    readln(id);
  until id < N;
end;
procedure Pedir_Tipo_Evento(var tipo_evento: shortstring);
var
  buscado: shortstring;
  aux_tipo: shortstring;
begin
  ClrScr;
  Repeat
    GoToxy(1,1);
    ClrEol;
    Write('Ingrese tipo de evento a Buscar: ');
    Readln(buscado);
    aux_tipo:= (Lowercase(buscado));
    GoToxy(1,3);
    ClrEol;
    TextColor(4);
    Writeln('No existe el Tipo de Evento Ingresado');
    TextColor(15);
  Until Valida_Tipo(aux_tipo);
  GoToxy(1,3);
  ClrEol;
  tipo_evento:= aux_tipo;
end;
procedure Pedir_FechaIni_FechaFin(var fecha_inicio,fecha_fin: shortstring);
begin
  ClrScr;
  fecha_inicio:='';
  fecha_fin:='';
  while not(Valida_Fecha(fecha_inicio)) do
  begin
    GoToxy(1,1);
    ClrEol;
    Write('Ingrese Fecha de Inicio(DD/MM/YYYY): ');
    Readln(fecha_inicio);
  end;
  while not(Valida_Fecha(fecha_fin)) or (Transf_Fecha(fecha_inicio) > Transf_Fecha(fecha_fin)) do
  begin
    GoToxy(1,2);
    ClrEol;
    Write('Ingrese Fecha de Fin(DD/MM/YYYY): ');
    Readln(fecha_fin);
  end;
end;
procedure Pedir_Titulo_Evento(var titulo: shortstring);
begin
  ClrScr;
  titulo:= '';
  while length(titulo) < 1 do
  begin
    GoToxy(1,1);
    ClrEol;
    Write('Ingrese el titulo del evento: ');
    Readln(titulo);
  end;
end;
procedure Menu_Opciones_Busqueda(var l:t_lista;var seleccionado: byte);
var
  exit:boolean;
  tecla:char;
begin
  exit:= false;
  seleccionado:= 1;
  while not exit do
  begin
    ClrScr;
    GoToxy(48,2);
    TextColor(3);
    Writeln('MENU DE OPCIONES');
    TextColor(15);
    if seleccionado = 1 then textbackground(color_selec) else textbackground(color_fondo);
    GoToxy(39,4);
    Writeln('     Buscar por Tipo de Evento     ');
    if seleccionado = 2 then textbackground(color_selec) else textbackground(color_fondo);
    GoToxy(39,6);
    Writeln('        Buscar Entre Fechas        ');
    if seleccionado = 3 then textbackground(color_selec) else textbackground(color_fondo);
    GoToxy(39,8);
    Writeln(' Buscar por Subcadena en el Titulo ');
    if seleccionado = 4 then textbackground(color_salir) else textbackground(color_fondo);
    GoToxy(39,10);
    Writeln('              Volver               ');
    TextBackground(0);
    tecla:= Readkey;
    if tecla = #00 then tecla:= Readkey;
    case tecla of
    #72:  if seleccionado > 1 then seleccionado:= seleccionado-1;
    #80:  if seleccionado < 4 then seleccionado:= seleccionado+1;
    #13:  exit:= true;
    end;
  end;
end;
procedure Busqueda(var l:t_lista);
var
  seleccionado: byte;
  tipo_evento: shortstring;
  fecha_inicio,fecha_fin,titulo: shortstring;
begin
  begin
    Menu_Opciones_Busqueda(l,seleccionado);
    case seleccionado of
    1: begin
         Pedir_Tipo_Evento(tipo_evento);
         Buscar_Por_Tipo(l,tipo_evento);
       end;
    2: begin
         Pedir_FechaIni_FechaFin(fecha_inicio,fecha_fin);
         Buscar_Por_Fechas(l,fecha_inicio,fecha_fin);
       end;
    3: begin
         Pedir_Titulo_Evento(titulo);
         Buscar_Por_Titulo(l,titulo);
       end;
    end;
  end;
end;
procedure Menu_Opciones(var seleccionado: byte);
var
  exit: boolean;
  tecla: char;
begin
  exit:= false;
  seleccionado:= 1;
  while not exit do
  begin
    ClrScr;
    GoToxy(45,2);
    TextColor(3);
    Writeln('MENU DE OPCIONES');
    TextColor(15);
    if seleccionado = 1 then textbackground(color_selec) else textbackground(color_fondo);
    GoToxy(40,4);
    Writeln('     Registrar Evento     ');
    if seleccionado = 2 then textbackground(color_selec) else textbackground(color_fondo);
    GoToxy(40,6);
    Writeln('      Buscar Evento       ');
    if seleccionado = 3 then textbackground(color_selec) else textbackground(color_fondo);
    GoToxy(40,8);
    Writeln('     Eliminar Evento      ');
    if seleccionado = 4 then textbackground(color_salir) else textbackground(color_fondo);
    GoToxy(40,10);
    Writeln('          Salir           ');
    TextBackground(0);
    tecla:= Readkey;
    if tecla=#00 then tecla:= Readkey;
    case tecla of
    #72: if seleccionado > 1 then seleccionado:= seleccionado-1;
    #80: if seleccionado < 4 then seleccionado:= seleccionado+1;
    #13: exit:= true;
    end;
  end;
end;
procedure Iniciar_Programa;
var
  seleccionado: byte;
  evento: t_evento;
  id: byte;
  l:t_lista;
begin
  seleccionado:= 0;
  Crear_Lista(l);
  While seleccionado <> 4 do
  begin
    menu_opciones(seleccionado);
    case seleccionado of
    1: begin
         registra_evento(l,evento);
       end;
    2: Busqueda(l);
    3: begin
         Pedir_ID_Evento(id);
         Eliminarlista(l,id,evento); //acá lo mismo
       end;
    end;
  end;
end;
{procedure prueba_unitaria_1();
var
  x:t_evento;
begin
  x.titulo:='a';
  x.desc:='a';
  x.tipo:='otro';
  x.fecha_inicio:='00/00/0000';
  x.fecha_fin:='00/00/0000';
  x.hora_inicio:='00:00';
  x.hora_fin:='00:00';
  x.ubicacion:='a';
  x.id:=1;
  agregar(x);
  if tamanio(l)=1 then writeln('Prueba Unitaria 1 superada') else writeln('Prueba Unitaria 1 fallada');
end;
procedure prueba_unitaria_2();
var
  x:t_evento;
begin
  x.titulo:='a';
  x.desc:='a';
  x.tipo:='otro';
  x.fecha_inicio:='00/00/0000';
  x.fecha_fin:='00/00/0000';
  x.hora_inicio:='00:00';
  x.hora_fin:='00:00';
  x.ubicacion:='a';
  x.id:=1;
  agregar(x);
  Eliminar_evento(x.id);
  if tamanio(l)=0 then writeln('Prueba Unitaria 2 superada') else writeln('Prueba Unitaria 2 fallada');
end; }
end.

