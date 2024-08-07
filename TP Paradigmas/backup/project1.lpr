program project1;

uses crt,TiposDominio, Interfaz, ListaMemoriaPrincipal;
var seleccionado:byte;
    x: t_dato_lista;
    lista: t_lista;

begin
  CrearLista(lista);
  While seleccionado <> 4 do
  begin
    menu_opciones(seleccionado);
    case seleccionado of
    1: Registrar_Evento(lista);
    2: Busqueda(lista);
    3: Eliminar_Evento(lista);
    end;
  end;
end.

