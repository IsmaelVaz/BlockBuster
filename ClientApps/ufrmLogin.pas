unit ufrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, dxCore2, dxButtons, StdCtrls, Buttons, jpeg, IniFiles;

type
  TfrmLogin = class(TForm)
    imgKey: TImage;
    grpLogin: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    txtLogin: TEdit;
    txtPassword: TEdit;
    pnlBottom: TPanel;
    pnlBottomLeft: TPanel;
    cmdCancel: TBitBtn;
    cmdOk: TBitBtn;
    txtPort: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    txtServer: TEdit;
    pnlTop: TPanel;
    Shape3: TShape;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtServerKeyPress(Sender: TObject; var Key: Char);
    procedure txtPortKeyPress(Sender: TObject; var Key: Char);
    procedure txtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure txtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uP2SBFOrbClient;

//************************************************************************
//* TfrmLogin.FormCreate
//************************************************************************
procedure TfrmLogin.FormCreate(Sender: TObject);
var
   LoginIni: TMemIniFile;
begin
   // Project Name
   //txtProjectName.Caption:=Application.Title;
   // Defaults
   LoginIni:=TMemIniFile.Create(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'login.ini');
   try
      txtServer.Text:=LoginIni.ReadString('Login','Server','localhost');
      txtPort.Text:=IntToStr(LoginIni.ReadInteger('Login','Port',8085));
   finally
      LoginIni.Free;
   end;
   if ((Trim(txtServer.Text)<>'') and (Trim(txtPort.Text)<>'')) and
      (not ((Trim(txtServer.Text)='localhost') and (Trim(txtPort.Text)='8085'))) then begin
      txtServer.Enabled:=False;
      txtPort.Enabled:=False;
   end else begin
      txtServer.Enabled:=True;
      txtPort.Enabled:=True;
   end;   
end;

//************************************************************************
//* TfrmLogin.FormKeyDown
//************************************************************************
procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_F7 then begin
      Key:=0;
      txtServer.Enabled:=True;
      txtPort.Enabled:=True;
   end;
end;

//************************************************************************
//* TfrmLogin.txtServerKeyPress
//************************************************************************
procedure TfrmLogin.txtServerKeyPress(Sender: TObject; var Key: Char);
begin
   // Check ENTER
   if Key=#13 then begin
      Key:=#0;
      if txtPort.CanFocus then begin
         txtPort.SetFocus;
         txtPort.SelectAll;
      end;
   end;
end;

//************************************************************************
//* TfrmLogin.txtPortKeyPress
//************************************************************************
procedure TfrmLogin.txtPortKeyPress(Sender: TObject; var Key: Char);
begin
   // Check ENTER
   if Key=#13 then begin
      Key:=#0;
      if txtLogin.CanFocus then begin
         txtLogin.SetFocus;
         txtLogin.SelectAll;
      end;
   end;
end;

//************************************************************************
//* TfrmLogin.txtLoginKeyPress
//************************************************************************
procedure TfrmLogin.txtLoginKeyPress(Sender: TObject; var Key: Char);
begin
   // Check ENTER
   if Key=#13 then begin
      Key:=#0;
      if txtPassword.CanFocus then begin
         txtPassword.SetFocus;
         txtPassword.SelectAll;
      end;
   end;
end;

//************************************************************************
//* TfrmLogin.txtPasswordKeyPress
//************************************************************************
procedure TfrmLogin.txtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
   // Check ENTER
   if Key=#13 then begin
      Key:=#0;
      cmdOk.Click;
   end;
end;

//************************************************************************
//* TfrmLogin.cmdOkClick
//************************************************************************
procedure TfrmLogin.cmdOkClick(Sender: TObject);
var
   Port: Integer;
   LoginIni: TMemIniFile;
begin
   // Check server
   if Trim(txtServer.Text)='' then begin
      Application.MessageBox('É necessário especificar um servidor de aplicação.','Erro',MB_ICONEXCLAMATION);
      txtServer.SetFocus;
      Exit;
   end;
   // Check port
   try
      Port:=StrToInt(txtPort.Text);
   except
      Application.MessageBox('Porta inválida.','Erro',MB_ICONEXCLAMATION);
      txtPort.SetFocus;
      txtPort.SelectAll;
      Exit;
   end;
   // Check login
   if txtLogin.Text='' then begin
      Application.MessageBox('É necessário digitar um login.','Erro',MB_ICONEXCLAMATION);
      txtLogin.SetFocus;
      Exit;
   end;
   // Save info
   LoginIni:=TMemIniFile.Create(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'login.ini');
   LoginIni.WriteString('Login','Server',txtServer.Text);
   LoginIni.WriteInteger('Login','Port',Port);
   LoginIni.UpdateFile;
   LoginIni.Free;

   // Connect
   Screen.Cursor:=crHourglass;
   try
      txtLogin.Text:=Trim(LowerCase(txtLogin.Text));
      gP2SBFOrbClient.ConnectToServer(txtServer.Text,Port,txtLogin.Text,txtPassword.Text);
   except on E: Exception do begin
      Screen.Cursor:=crDefault;
      Application.MessageBox(PChar('Não foi possível efetuar conexão a '+txtServer.Text+#13#10#13#10+E.Message),'Erro',MB_ICONEXCLAMATION);
      Exit;
      end;
   end;
   Screen.Cursor:=crDefault;
   ModalResult:=mrOk;
end;

//************************************************************************
//* TfrmLogin.cmdCancelClick
//************************************************************************
procedure TfrmLogin.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

end.
