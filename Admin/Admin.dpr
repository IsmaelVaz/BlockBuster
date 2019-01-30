//$$** SECTION: UNIT_ADMIN_PROJECT
program Admin;

uses
   Forms,
   SysUtils,
   uPermissions in '..\Common\uPermissions.pas',
   uMisc in '..\Common\uMisc.pas',   // Miscellaneous
   ufrmAdminModuleMain in 'ufrmAdminModuleMain.pas',    // Main Form
   ufrmLogin in '..\ClientApps\ufrmLogin.pas',   // Login form
   ufrmDataUser in 'ufrmDataUser.pas',   // User data form
   ufrmDataGroup in 'ufrmDataGroup.pas',   // Group data form
   ufrmGroupPermissions in 'ufrmGroupPermissions.pas',    // Group permissions form
   uModelClient in '..\ClientApps\uModelClient.pas',   // Client Model
   uSingletonsClient in '..\ClientApps\uSingletonsClient.pas';   // Singletons

{$R *.res}

begin
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}DecimalSeparator:=',';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator:='.';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ShortDateFormat:='d/m/y';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ShortTimeFormat:='hh:mm';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}LongTimeFormat:='hh:mm:ss';
   Application.Initialize;
   Application.Title:='Administrator Module';
   Application.CreateForm(TfrmAdminModuleMain,frmAdminModuleMain);
   Application.Run;
end.
