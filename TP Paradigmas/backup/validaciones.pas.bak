unit Validaciones;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils;

function Transf_Hora(hora: shortstring): integer;
function Valida_Hora(hora: shortstring): boolean;
function Valida_Fecha(x: shortstring): boolean;
function Transf_Fecha(x: string): String;

implementation

function Transf_Hora(hora: shortstring): integer;
begin
   Transf_Hora:=  StrToInt(copy(hora,1,2) + copy(hora,4,2));
end;
function Valida_Hora(hora: shortstring): boolean;
begin
  if not(hora[1] in ['0'..'2']) or not(hora[2] in ['0'..'9']) or ((hora[1] = '2') and (hora[2] in ['4'..'9'])) or not(hora[4] in ['0'..'5']) or not(hora[5] in ['0'..'9']) then
    result:=false
  else result:= true;
end;
function Valida_Fecha(x: shortstring): boolean;
var dia,mes: ShortInt; anio: integer;
begin
  valida_fecha:= false;
  if Length(x) = 10 then
    if (x[1] in ['0'..'3']) and (x[2] in ['0'..'9']) and (x[3] = '/') and (x[4] in ['0','1']) and (x[5] in ['0'..'9']) and (x[6] = '/') and (x[7] in ['1','2']) and (x[8] in ['0','9']) and (x[9] in ['0'..'9']) and (x[10] in ['0'..'9'])  then
    begin
      dia:= StrToInt(x[1] + x[2]);
      mes:= StrToInt(x[4] + x[5]);
      anio:= StrToInt(x[7] + x[8] + x[9] + x[10]);
      if ((anio >= 1900) and (anio <= 2024)) and (((mes in [1,3,5,7,8,10,12]) and (dia in [1..31])) or ((mes in [4,6,9,11]) and (dia in [1..30])) or ((mes = 2) and (dia in [1..28])) or (((anio mod 4) = 0) and (mes = 2) and (dia = 29))) then
        valida_fecha:= true;
    end;
end;
function Transf_Fecha(x: string): String;
var aux: string[8];
begin
   aux:= copy(x,7,4) + copy(x,4,2) + copy(x,1,2);
   transf_fecha:= aux;
end;

end.

