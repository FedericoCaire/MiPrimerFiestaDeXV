unit TiposDominio;

interface

const
  N = 100;

type
  t_evento = record
     id: byte;
     titulo: shortstring;
     desc: shortstring;
     tipo: shortstring;
     fecha_inicio: shortstring;
     fecha_fin: shortstring;
     hora_inicio: shortstring;
     hora_fin: shortstring;
     ubicacion: shortstring;
  end;
  t_lista = record
    cab,act,tam: byte;
    elem: array[1..N] of t_evento;
  end;
  t_archivo = file of t_evento;

implementation
end.

