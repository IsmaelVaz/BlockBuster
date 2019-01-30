unit uMisc;

// Miscellaneous procedures and functions

interface

uses SysUtils, Windows;

function GetTempDir: string;
function InsertZerosLeft(AStr: string; ANumZeros: Integer): string;
function IsValidEMail(AEmail: string): Boolean;
function RemoveSpecialChars(AStr: string): string;
function XMLEncode(AStr: string): string;
function XMLEntitiesDecode(AStr: string): string;

implementation

//********************************************************************************
//* GetTempDir
//********************************************************************************
function GetTempDir: String;
begin
   SetLength(Result, GetTempPath(0, nil));
   SetLength(Result, GetTempPath(Length(Result), PChar(Result)));
end;

//********************************************************************************
//* InsertZerosLeft
//********************************************************************************
function InsertZerosLeft(AStr: string; ANumZeros: Integer): string;
var
   i: Integer;
begin
   Result:=AStr;
   for i:=Length(AStr)+1 to ANumZeros do begin
      Result:='0'+Result;
   end;
end;

//********************************************************************************
//* IsValidEMail
//********************************************************************************
function IsValidEMail(AEmail: string): Boolean;
const
    // Valid characters in an "atom"
    atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                                '\', '/', '"', '.', '[', ']', #127];
    // Valid characters in a "quoted-string"
    quoted_string_chars = [#0..#255] - ['"', #13, '\'];
    // Valid characters in a subdomain
    letters = ['A'..'Z', 'a'..'z'];
    letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
    subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];
type
    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
      STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
      STATE_SUBDOMAIN, STATE_HYPHEN);
var
    State: States;
    i, n, subdomains: integer;
    c: char;
begin
    State := STATE_BEGIN;
    n := Length(AEmail);
    i := 1;
    subdomains := 1;
    while (i <= n) do begin
      c := AEMail[i];
      case State of
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not (c in atom_chars) then
          break;
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not (c in quoted_string_chars) then
          break;
      STATE_QCHAR:
        State := STATE_QTEXT;
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else
          break;
      STATE_SUBDOMAIN:
        if c = '.' then begin
          inc(subdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end else if c = '-' then
          State := STATE_HYPHEN
        else if not (c in letters_digits) then
          break;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
      end;
      inc(i);
    end;
    if i <= n then
      Result := False
    else
      Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

//********************************************************************************
//* RemoveSpecialChars
//********************************************************************************
function RemoveSpecialChars(AStr: string): string;
var
   i,t: Integer;
begin
   Result:=AStr;
   t:=Length(Result);
   for i:=1 to t do begin
      case Result[i] of
         'ç': Result[i]:='c';
         'ñ': Result[i]:='n';
         'á': Result[i]:='a';
         'é': Result[i]:='e';
         'í': Result[i]:='i';
         'ó': Result[i]:='o';
         'ú': Result[i]:='u';
         'à': Result[i]:='a';
         'è': Result[i]:='e';
         'ì': Result[i]:='i';
         'ò': Result[i]:='o';
         'ù': Result[i]:='u';
         'â': Result[i]:='a';
         'ê': Result[i]:='e';
         'î': Result[i]:='i';
         'ô': Result[i]:='o';
         'û': Result[i]:='u';
         'ä': Result[i]:='a';
         'ë': Result[i]:='e';
         'ï': Result[i]:='i';
         'ö': Result[i]:='o';
         'ü': Result[i]:='u';
         'ã': Result[i]:='a';
         'õ': Result[i]:='o';
         'Ç': Result[i]:='C';
         'Ñ': Result[i]:='N';
         'Á': Result[i]:='A';
         'É': Result[i]:='E';
         'Í': Result[i]:='I';
         'Ó': Result[i]:='O';
         'Ú': Result[i]:='U';
         'À': Result[i]:='A';
         'È': Result[i]:='E';
         'Ì': Result[i]:='I';
         'Ò': Result[i]:='O';
         'Ù': Result[i]:='U';
         'Â': Result[i]:='A';
         'Ê': Result[i]:='E';
         'Î': Result[i]:='I';
         'Ô': Result[i]:='O';
         'Û': Result[i]:='U';
         'Ä': Result[i]:='A';
         'Ë': Result[i]:='E';
         'Ï': Result[i]:='I';
         'Ö': Result[i]:='O';
         'Ü': Result[i]:='U';
         'Ã': Result[i]:='A';
         'Õ': Result[i]:='O';
      end;
   end;
end;

//********************************************************************************
//* XMLEncode
//********************************************************************************
function XMLEncode(AStr: string): string;
begin
   Result:=AStr;
   Result:=StringReplace(Result,'&','&amp;',[rfReplaceAll]);
   Result:=StringReplace(Result,'"','&quot;',[rfReplaceAll]);
   Result:=StringReplace(Result,#39,'&apos;',[rfReplaceAll]);
   Result:=StringReplace(Result,'<','&lt;',[rfReplaceAll]);
   Result:=StringReplace(Result,'>','&gt;',[rfReplaceAll]);
end;

//********************************************************************************
//* XMLEntitiesDecode
//********************************************************************************
function XMLEntitiesDecode(AStr: string): string;
begin
   Result:=AStr;
   Result:=StringReplace(Result,'&quot;','"',[rfReplaceAll]);
   Result:=StringReplace(Result,'&apos;',#39,[rfReplaceAll]);
   Result:=StringReplace(Result,'&lt;','<',[rfReplaceAll]);
   Result:=StringReplace(Result,'&gt;','>',[rfReplaceAll]);
   Result:=StringReplace(Result,'&amp;','&',[rfReplaceAll]);
end;

end.
