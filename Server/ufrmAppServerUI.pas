unit ufrmAppServerUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, IniFiles,
  uModel, uP2SBFOrbServer, uP2SBFOrbServerTypes, uP2SBFObjRepos, uP2SBFAbsModel,
  uP2SBFSystemModel, uP2SBFOrbServerUIManager,
  uP2SBFWebServer;

type

  TfrmAppServerUI = class(TForm)
    pnlTitulo: TPanel;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lstUsers: TListBox;
    cmdStartServer: TBitBtn;
    cmdStopServer: TBitBtn;
    lstPersistentRepos: TListBox;
    lstNonPersistentRepos: TListBox;
    procedure cmdStartServerClick(Sender: TObject);
    procedure cmdStopServerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FConnectionDataList: TList;
    procedure AfterConnect(Sender: TObject; AConnectionData: TP2SBFConnectionData);
    procedure AfterDisconnect(Sender: TObject; AConnectionData: TP2SBFConnectionData);
    procedure AfterAddObject(Sender: TObject; ABizObject: TP2SBFAbsBizObj);
    procedure AfterRemoveObject(Sender: TObject; ABizObject: TP2SBFAbsBizObj);
    procedure InitializeApplication;
    procedure FinalizeApplication;
  public
    { Public declarations }
  end;

var
  frmAppServerUI: TfrmAppServerUI;

implementation

{$R *.dfm}

//********************************************************************************
//* TfrmAppServerUI.FormCreate
//********************************************************************************
procedure TfrmAppServerUI.FormCreate(Sender: TObject);
begin
   // Create internal objects
   FConnectionDataList:=TList.Create;
   // Setup events
   gP2SBFOrbServer.AfterConnect:=AfterConnect;
   gP2SBFOrbServer.AfterDisconnect:=AfterDisconnect;
   gP2SBFObjRepos.AfterAddObject:=AfterAddObject;
   gP2SBFObjRepos.AfterRemoveObject:=AfterRemoveObject;
   // Initialize Application
   InitializeApplication;
end;

//********************************************************************************
//* TfrmAppServerUI.FormDestroy
//********************************************************************************
procedure TfrmAppServerUI.FormDestroy(Sender: TObject);
begin
   // Finalize Application
   FinalizeApplication;
   // Free mem
   FConnectionDataList.Free;
end;

//********************************************************************************
//* TfrmAppServerUI.FormClose
//********************************************************************************
procedure TfrmAppServerUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   {if gP2SBFOrbServer.Active then begin
      gP2SBFOrbServer.Close;
   end;}
end;

//********************************************************************************
//* TfrmAppServerUI.cmdStartServerClick
//********************************************************************************
procedure TfrmAppServerUI.cmdStartServerClick(Sender: TObject);
const
   cConfigFileName = 'config.ini';
var
   ConfigFile: TMemIniFile;
begin
   gP2SBFOrbServer.Open;
   ConfigFile:=TMemIniFile.Create(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+cConfigFileName);
   try
      if ConfigFile.ReadBool('WebServer','Active',False) then begin
         gP2SBFWebServer.Open;
      end;
   finally
      ConfigFile.Free;
   end;
end;

//********************************************************************************
//* TfrmAppServerUI.cmdStopServerClick
//********************************************************************************
procedure TfrmAppServerUI.cmdStopServerClick(Sender: TObject);
begin
   //gP2SBFOrbServer.Close;
end;

//********************************************************************************
//* TfrmAppServerUI.AfterConnect
//********************************************************************************
procedure TfrmAppServerUI.AfterConnect(Sender: TObject; AConnectionData: TP2SBFConnectionData);
begin
   FConnectionDataList.Add(AConnectionData);
   lstUsers.Items.Add(AConnectionData.Login);
end;

//********************************************************************************
//* TfrmAppServerUI.AfterDisconnect
//********************************************************************************
procedure TfrmAppServerUI.AfterDisconnect(Sender: TObject; AConnectionData: TP2SBFConnectionData);
var
   i: Integer;
begin
   i:=FConnectionDataList.IndexOf(AConnectionData);
   lstUsers.Items.Delete(i);
   FConnectionDataList.Remove(AConnectionData);
end;

//********************************************************************************
//* TfrmAppServerUI.AfterAddObject
//********************************************************************************
procedure TfrmAppServerUI.AfterAddObject(Sender: TObject; ABizObject: TP2SBFAbsBizObj);
begin
   if ABizObject is TP2SBFAbsPerBizObj then begin
      lstPersistentRepos.AddItem('P,'+IntToStr(ABizObject.OID.ID)+': '+ABizObject.ClassName,ABizObject);
   end else begin
      lstNonPersistentRepos.AddItem('N,'+IntToStr(ABizObject.OID.ID)+': '+ABizObject.ClassName,ABizObject);
   end;
end;

//********************************************************************************
//* TfrmAppServerUI.AfterRemoveObject
//********************************************************************************
procedure TfrmAppServerUI.AfterRemoveObject(Sender: TObject; ABizObject: TP2SBFAbsBizObj);
var
   i: Integer;
begin
   if ABizObject is TP2SBFAbsPerBizObj then begin
      i:=lstPersistentRepos.Items.IndexOfObject(ABizObject);
      lstPersistentRepos.Items.Delete(i);
   end else begin
      i:=lstNonPersistentRepos.Items.IndexOfObject(ABizObject);
      lstNonPersistentRepos.Items.Delete(i);
   end;
end;

//********************************************************************************
//* TfrmAppServerUI.InitializeApplication
//********************************************************************************
procedure TfrmAppServerUI.InitializeApplication;
//var
//   SysAccessControl: TSysAccessControl;
//$$** SECTION: INITIALIZEAPPLICATION_VAR

//$$** SECTION: INITIALIZEAPPLICATION_BEGIN
begin
//   SysAccessControl:=TSysAccessControl.Create(nil,'_gSysAccessControl');
//$$** SECTION: INITIALIZEAPPLICATION_IMPL

//$$** ENDSECTION
end;

//********************************************************************************
//* TfrmAppServerUI.FinalizeApplication
//********************************************************************************
procedure TfrmAppServerUI.FinalizeApplication;
//var
//   SysAccessControl: TSysAccessControl;
//$$** SECTION: FINALIZEAPPLICATION_VAR

//$$** SECTION: FINALIZEAPPLICATION_BEGIN
begin
//$$** SECTION: FINALIZEAPPLICATION_IMPL

//$$** ENDSECTION
//   SysAccessControl:=TSysAccessControl.RetrieveByName('_gSysAccessControl') as TSysAccessControl;
   //SysAccessControl.Free;
end;

end.

