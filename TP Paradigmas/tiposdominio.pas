unit TiposDominio;

interface

const
  N = 100;

type
  t_evento = record
     id: byte;
     titulo: shortstring;
     desc: shortstring;
     tipo: string[15];
     fecha_inicio: string[15];
     fecha_fin: string[15];
     hora_inicio: string[7];
     hora_fin: string[7];
     ubicacion: shortstring;
  end;

implementation
end.

