unit Interfaz;

interface
uses
  crt,TiposDominio,ListaMemoriaPrincipal;
const
  color_selec=red;
  color_fondo=black;
  color_salir=red;

procedure inicia_programa;

implementation

procedure pedir_datos_evento(var evento:t_evento);
var
  aux:string;
begin
  clrscr;
  write('Ingrese titulo: ');
  readln(evento.titulo);
  repeat
  begin
    gotoxy(1,2);
    clreol;
    write('Ingrese tipo: ');
    readln(aux);
  end
  until Valida_Tipo(aux);
  evento.tipo:= StrToTipo(aux);
  write('Ingrese descripcion: ');
  readln(evento.desc);
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
  until Valida_Hora(evento.hora_fin) and ((Transf_Fecha(evento.fecha_fin) <> Transf_Fecha(evento.fecha_inicio)) or (Transf_Hora(evento.hora_fin) > Transf_Hora(evento.hora_inicio)));
  Write('Ingrese ubicacion: ');
  readln(evento.ubicacion);
end;
procedure pedir_id_evento(l: t_lista; var id:byte);
begin
  clrscr;
  repeat
    Write('Ingrese el ID del evento: ');
    readln(id);
  until id < l.tam;
end;
procedure pedir_tipo_evento(var tipo_evento:t_tipo);
var
  buscado:string;
  aux_tipo:t_tipo;
begin
  clrscr;
  write('Ingrese tipo de evento a Buscar: ');
  readln(buscado);
  aux_tipo:= StrToTipo(Lowercase(buscado));
  if not(aux_tipo in [cumpleanios..otro]) then writeln('No existe el Tipo de Evento Ingresado')
  else
    tipo_evento:=aux_tipo;
end;
procedure pedir_fechaini_fechafin(var fecha_inicio,fecha_fin:string);
begin
  clrscr;
  fecha_inicio:='';
  fecha_fin:='';
  while not(Valida_Fecha(fecha_inicio)) do
  begin
    write('Ingrese Fecha de Inicio(DD/MM/YYYY): ');
    readln(fecha_inicio);
  end;
  while not(Valida_Fecha(fecha_fin)) and (Transf_Fecha(fecha_inicio) > Transf_Fecha(fecha_fin)) do
  begin
    write('Ingrese Fecha de Fin(DD/MM/YYYY): ');
    readln(fecha_fin);
  end;
end;
procedure pedir_titulo_evento(var titulo:string);
begin
  clrscr;
  titulo:= '';
  while length(titulo) < 1 do
  begin
  write('Ingrese el titulo del evento: ');
  readln(titulo);
  end;
end;
procedure menu_opciones_busqueda(var seleccionado:byte);
var
  exit:boolean;
  tecla:char;
begin
  exit:=false;
  seleccionado:=1;

  while not exit do
  begin
    clrscr;
    if seleccionado=1 then textbackground(color_selec) else textbackground(color_fondo);
    writeln('Buscar por Tipo de Evento');
    if seleccionado=2 then textbackground(color_selec) else textbackground(color_fondo);
    writeln('Buscar Entre Fechas');
    if seleccionado=3 then textbackground(color_selec) else textbackground(color_fondo);
    writeln('Buscar por Subcadena en el Titulo');
    if seleccionado=4 then textbackground(color_salir) else textbackground(color_fondo);
    writeln('Volver');
    textbackground(0);
    tecla:=readkey;

    if tecla=#00 then tecla:=readkey;

    case tecla of
    #72:  if seleccionado>1 then seleccionado:=seleccionado-1;
    #80:  if seleccionado<4 then seleccionado:=seleccionado+1;
    #13:  exit:=true;
    end;
  end;
end;
procedure Busqueda(var l: t_lista);
var
  seleccionado: byte;
  tipo_evento:t_tipo;
  fecha_inicio,fecha_fin,titulo:string;
begin
  if l.tam<>0 then
  begin
    Menu_Opciones_Busqueda(seleccionado);
    case seleccionado of
      1:begin
        pedir_tipo_evento(tipo_evento);
        Buscar_Por_Evento(l,tipo_evento);
      end;
      2:begin
        pedir_fechaini_fechafin(fecha_inicio,fecha_fin);
        Buscar_Por_Fechas(l,fecha_inicio,fecha_fin);
      end;
      3:begin
        pedir_titulo_evento(titulo);
        Buscar_Por_Titulo(l,titulo);
      end;
    end;
  end
  else
  begin
    clrscr;
    write('No hay eventos registrados');
    readkey;
  end;
end;
procedure menu_opciones(var seleccionado:byte);
var
  exit:boolean;
  tecla:char;
begin
  exit:=false;
  seleccionado:=1;
  while not exit do
  begin
    clrscr;
    if seleccionado=1 then textbackground(color_selec) else textbackground(color_fondo);
    writeln('Registrar Evento');
    if seleccionado=2 then textbackground(color_selec) else textbackground(color_fondo);
    writeln('Buscar Evento');
    if seleccionado=3 then textbackground(color_selec) else textbackground(color_fondo);
    writeln('Eliminar Evento');
    if seleccionado=4 then textbackground(color_salir) else textbackground(color_fondo);
    writeln('Salir');
    textbackground(0);
    tecla:=readkey;
    if tecla=#00 then tecla:=readkey;
    case tecla of
    #72:  if seleccionado>1 then seleccionado:=seleccionado-1;
    #80:  if seleccionado<4 then seleccionado:=seleccionado+1;
    #13:  exit:=true;
    end;
  end;
end;
procedure inicia_programa;
var
  seleccionado: byte;
  evento: t_evento;
  lista: t_lista;
  id: byte;
begin
  seleccionado:=0;
  CrearLista(lista);
  While seleccionado <> 4 do
  begin
    menu_opciones(seleccionado);
    case seleccionado of
      1: begin
        Pedir_datos_evento(evento);
        Registrar_Evento(lista,evento);
      end;
      2: Busqueda(lista);
      3: begin
        if lista.tam <> 0 then
        begin
          pedir_id_evento(lista,id);
          Eliminar_Evento(lista,id);
        end
        else
        begin
          clrscr;
          write('No hay ningun evento registrado');
          readkey;
        end;
      end;
    end;
  end;
end;

end.

