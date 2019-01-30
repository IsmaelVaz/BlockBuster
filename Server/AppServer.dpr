//$$** SECTION: UNIT_APPSERVER_PROJECT
program AppServer;

uses
   Forms,
   SysUtils,
   ufrmAppServerUI in 'ufrmAppServerUI.pas',   // Main form
   uMisc in '..\Common\uMisc.pas',   // Miscellaneous
   uPermissions in '..\Common\uPermissions.pas',   // Permissions
   uModel in 'uModel.pas';   // Model

{$R *.res}

begin
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}DecimalSeparator:=',';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator:='.';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ShortDateFormat:='d/m/y';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ShortTimeFormat:='hh:mm';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}LongTimeFormat:='hh:mm:ss';
   Application.Initialize;
   Application.Title:='BlockBuster - Application Server';
   Application.CreateForm(TfrmAppServerUI,frmAppServerUI);
   Application.Run;
end.
