unit uPermissions;

interface

type
   TPermissionDefinition = record
      PermissionId: Integer;
      Title: string;
      HasView: Boolean;
      HasList: Boolean;
      HasInsert: Boolean;
      HasDelete: Boolean;
      HasUpdate: Boolean;
   end;

   TPermissionDefinitionArray = array of TPermissionDefinition;

var
   _gPermissionDefinitionArray: TPermissionDefinitionArray;

implementation

//************************************************************************
//* _InitializePermissionDefinitionArray
//************************************************************************
procedure _InitializePermissionDefinitionArray;
begin
//$$** SECTION: INITIALIZE_PERMISSIONDEF_ARRAY
    SetLength(_gPermissionDefinitionArray,1);
   // Log
   _gPermissionDefinitionArray[0].PermissionId:=1;
   _gPermissionDefinitionArray[0].Title:='Log';
   _gPermissionDefinitionArray[0].HasView:=True;
   _gPermissionDefinitionArray[0].HasList:=True;
   _gPermissionDefinitionArray[0].HasInsert:=False;
   _gPermissionDefinitionArray[0].HasDelete:=True;
   _gPermissionDefinitionArray[0].HasUpdate:=True;
//$$** ENDSECTION
end;

initialization
   _InitializePermissionDefinitionArray;

end.
