unit TiposDominio;
interface
const
  N = 100;
type
  t_tipo = (cumpleanios,aniversario,reunion,otro);
  t_evento = record
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
      elem: array[1..N] of t_evento;
  end;
implementation
end.

