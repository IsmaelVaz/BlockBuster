unit uSingletonsClient;

interface

uses SysUtils,
     uP2SBFObjReposClient,uP2SBFSystemModelClient,uModelClient;

procedure _InitializeSingletons;

implementation

procedure _InitializeSingletons;
var
   ObjectNameArrayToLoad: array of string;

   procedure _AddObjectNameToLoad(AObjectName: string);
   var
      i: Integer;
      Found: Boolean;
   begin
      Found:=False;
      for i:=0 to High(ObjectNameArrayToLoad) do begin
         if UpperCase(ObjectNameArrayToLoad[i])=UpperCase(AObjectName) then begin
            Found:=True;
            Break;
         end;
      end;
      if not Found then begin
         SetLength(ObjectNameArrayToLoad,Length(ObjectNameArrayToLoad)+1);
         ObjectNameArrayToLoad[High(ObjectNameArrayToLoad)]:=AObjectName;
      end;
   end;
begin
   _gSysAccessControl:=TSysAccessControl.RetrieveByName('_gSysAccessControl',True) as TSysAccessControl;

   SetLength(ObjectNameArrayToLoad,0);

//$$** SECTION: SINGLETONS_INITIALIZATIONS
//$$** ENDSECTION
end;

end.
