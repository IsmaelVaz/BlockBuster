unit ufrmAdminModuleMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, ToolWin, XPMenu, XPMan, Grids,
  ExtCtrls, StdCtrls;

type
  TfrmAdminModuleMain = class(TForm)
    mnuMainMenu: TMainMenu;
    Arquivo1: TMenuItem;
    mnuExit: TMenuItem;
    mnuGroups: TMenuItem;
    mnuGroupsNew: TMenuItem;
    mnuGroupsDelete: TMenuItem;
    mnuGroupsEdit: TMenuItem;
    mnuUsers: TMenuItem;
    mnuUsersNew: TMenuItem;
    mnuUsersDelete: TMenuItem;
    mnuUsersEdit: TMenuItem;
    imglstMenus: TImageList;
    XPManifest1: TXPManifest;
    XPMenu1: TXPMenu;
    tlbToolbar: TToolBar;
    cmdGroupsNew: TToolButton;
    cmdGroupsDelete: TToolButton;
    cmdGroupsEdit: TToolButton;
    ToolButton3: TToolButton;
    cmdUsersNew: TToolButton;
    cmdUsersDelete: TToolButton;
    cmdUsersEdit: TToolButton;
    ToolButton7: TToolButton;
    cmdExit: TToolButton;
    grdUserData: TStringGrid;
    splSplitter: TSplitter;
    stsStatusBar: TStatusBar;
    pnlTitleUsers: TPanel;
    imgFormPicture: TImage;
    lblTitle: TLabel;
    popUsers: TPopupMenu;
    popUsersNew: TMenuItem;
    popUsersDelete: TMenuItem;
    popUsersEdit: TMenuItem;
    popGroups: TPopupMenu;
    popGroupsNew: TMenuItem;
    popGroupsDelete: TMenuItem;
    popGroupsEdit: TMenuItem;
    pnlGroups: TPanel;
    pnlTitleGroups: TPanel;
    Image1: TImage;
    Label1: TLabel;
    grdGroupData: TStringGrid;
    mnuGroupsSeparator: TMenuItem;
    mnuGroupsPermissions: TMenuItem;
    popGroupsSeparator: TMenuItem;
    popGroupsPermissions: TMenuItem;
    cmdGroupsPermissions: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuGroupsNewClick(Sender: TObject);
    procedure mnuGroupsDeleteClick(Sender: TObject);
    procedure mnuGroupsEditClick(Sender: TObject);
    procedure mnuUsersNewClick(Sender: TObject);
    procedure mnuUsersDeleteClick(Sender: TObject);
    procedure mnuUsersEditClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuGroupsPermissionsClick(Sender: TObject);
  private
    { Private declarations }
    FLoggedIn: Boolean;
    FArrayUserId: array of Integer;
    FArrayGroupId: array of Integer;
    FArrayUserPctColWidths: array of Double;
    FArrayGroupPctColWidths: array of Double;
    procedure SetupUserGridColumns;
    procedure SetupGroupGridColumns;
    procedure RefreshUserData(APOIDToSelect: Integer = 0);
    procedure RefreshGroupData(APOIDToSelect: Integer = 0);
    procedure ResizeUserGrid;
    procedure ResizeGroupGrid;
    procedure SelectUserRowByPOID(APOID: Integer);
    procedure SelectGroupRowByPOID(APOID: Integer);
  public
    { Public declarations }
  end;

var
  frmAdminModuleMain: TfrmAdminModuleMain;

implementation

{$R *.dfm}

uses uP2SBFAbsModelTypes,uP2SBFObjReposClient,uP2SBFSystemModelClient,
     uModelClient, uSingletonsClient,
     ufrmLogin,ufrmDataUser,ufrmDataGroup,ufrmGroupPermissions;

//************************************************************************
//* FormCreate
//************************************************************************
procedure TfrmAdminModuleMain.FormCreate(Sender: TObject);
var
   User: TSysUser;
   Login: string;
begin
   FLoggedIn:=False;
   // Login
   if not FLoggedIn then begin
      //WindowState:=wsMaximized;
      Application.CreateForm(TfrmLogin,frmLogin);
      if frmLogin.ShowModal=mrOk then begin
         FLoggedIn:=True;
         Login:=frmLogin.txtLogin.Text;
         stsStatusBar.Panels[1].Text:=frmLogin.txtLogin.Text;
         stsStatusBar.Panels[2].Text:=frmLogin.txtServer.Text+':'+frmLogin.txtPort.Text;
         frmLogin.Free;
      end else begin
         frmLogin.Free;
         Application.Terminate;
         Exit;
      end;
   end;
   Screen.Cursor:=crHourglass;
   _InitializeSingletons;
   User:=_gSysAccessControl.GetUserByLogin(Login) as TSysUser;
   if User=nil then begin
      Application.MessageBox('Usuário não encontrado.','Segurança',MB_ICONEXCLAMATION);
      Application.Terminate;
      Exit;
   end else begin
      if not User.FlagAdmin then begin
         Application.MessageBox('Sem permissão de acesso para este módulo.','Segurança',MB_ICONEXCLAMATION);
         Application.Terminate;
         Exit;
      end;
   end;
   SetupUserGridColumns;
   RefreshUserData;
   ResizeUserGrid;
   SetupGroupGridColumns;
   RefreshGroupData;
   ResizeGroupGrid;
   Screen.Cursor:=crDefault;
end;

//************************************************************************
//* FormDestroy
//************************************************************************
procedure TfrmAdminModuleMain.FormDestroy(Sender: TObject);
begin
//
end;

//************************************************************************
//* FormActivate
//************************************************************************
procedure TfrmAdminModuleMain.FormActivate(Sender: TObject);
begin
//
end;

//************************************************************************
//* FormResize
//************************************************************************
procedure TfrmAdminModuleMain.FormResize(Sender: TObject);
begin
   ResizeUserGrid;
   ResizeGroupGrid;
end;

//************************************************************************
//* mnuExitClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuExitClick(Sender: TObject);
begin
   Close;
end;

//************************************************************************
//* mnuGroupsNewClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuGroupsNewClick(Sender: TObject);
var
   NewObject: TSysGroup;
begin
   // Create object
   Screen.Cursor:=crHourglass;
   NewObject:=TSysGroup.Create;
   // Create data form
   Application.CreateForm(TfrmDataGroup,frmDataGroup);
   Screen.Cursor:=crDefault;
   // Show data form
   if frmDataGroup.Open(NewObject) then begin
      // Refresh
      Screen.Cursor:=crHourglass;
      RefreshGroupData(NewObject.OID.ID);
      ResizeGroupGrid;
      Screen.Cursor:=crDefault;
   end else begin
      NewObject.Delete;
   end;
   frmDataGroup.Free;
end;

//************************************************************************
//* mnuGroupsDeleteClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuGroupsDeleteClick(Sender: TObject);
var
   ObjectToDelete: TSysGroup;
   CanDelete: Boolean;
   Reason: string;
begin
   if High(FArrayGroupId)>=0 then begin
      Screen.Cursor:=crHourglass;
      ObjectToDelete:=TSysGroup.Retrieve(POID(FArrayGroupId[grdGroupData.Row-1])) as TSysGroup;
      // Check if it is possible to delete (referential integrity)
      Reason:='';
      CanDelete:=ObjectToDelete.CanDelete(Reason);
      Screen.Cursor:=crDefault;
      if not CanDelete then begin
         Application.MessageBox(PChar('O registro selecionado não pode ser excluído pela seguinte razão:'+#13#10+Reason),'Segurança',MB_ICONEXCLAMATION);
         Exit;
      end;
      // Ask confirmation
      if Application.MessageBox('Confirma a exclusão do registro selecionado?','Confirmação',MB_ICONQUESTION+MB_OKCANCEL)=IDOK then begin
         // Delete object
         Screen.Cursor:=crHourglass;
         ObjectToDelete.Delete;
         RefreshGroupData;
         ResizeGroupGrid;
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* mnuGroupsEditClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuGroupsEditClick(Sender: TObject);
var
   ObjectToEdit: TSysGroup;
begin
   if High(FArrayGroupId)>=0 then begin
      // Retrieve object
      Screen.Cursor:=crHourglass;
      ObjectToEdit:=TSysGroup.Retrieve(POID(FArrayGroupId[grdGroupData.Row-1]),True) as TSysGroup;
      // Create data form
      Application.CreateForm(TfrmDataGroup,frmDataGroup);
      Screen.Cursor:=crDefault;
      // Show data form
      if frmDataGroup.Open(ObjectToEdit) then begin
         // Refresh
         Screen.Cursor:=crHourglass;
         RefreshGroupData(ObjectToEdit.OID.ID);
         ResizeGroupGrid;
         Screen.Cursor:=crDefault;
      end;
      frmDataGroup.Free;
   end;
end;

//************************************************************************
//* mnuGroupsPermissionsClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuGroupsPermissionsClick(Sender: TObject);
var
   ObjectToEdit: TSysGroup;
begin
   if High(FArrayGroupId)>=0 then begin
      // Retrieve object
      Screen.Cursor:=crHourglass;
      ObjectToEdit:=TSysGroup.Retrieve(POID(FArrayGroupId[grdGroupData.Row-1]),True) as TSysGroup;
      // Create data form
      Application.CreateForm(TfrmGroupPermissions,frmGroupPermissions);
      Screen.Cursor:=crDefault;
      // Show data form
      frmGroupPermissions.Open(ObjectToEdit);
      frmGroupPermissions.Free;
   end;
end;

//************************************************************************
//* mnuUsersNewClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuUsersNewClick(Sender: TObject);
var
   NewObject: TSysUser;
begin
   // Create object
   Screen.Cursor:=crHourglass;
   NewObject:=TSysUser.Create;
   // Create data form
   Application.CreateForm(TfrmDataUser,frmDataUser);
   Screen.Cursor:=crDefault;
   // Show data form
   if frmDataUser.Open(NewObject) then begin
      // Refresh
      Screen.Cursor:=crHourglass;
      RefreshUserData(NewObject.OID.ID);
      ResizeUserGrid;
      Screen.Cursor:=crDefault;
   end else begin
      NewObject.Delete;
   end;
   frmDataUser.Free;
end;

//************************************************************************
//* mnuUsersDeleteClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuUsersDeleteClick(Sender: TObject);
var
   ObjectToDelete: TSysUser;
   CanDelete: Boolean;
   Reason: string;
begin
   if High(FArrayUserId)>=0 then begin
      Screen.Cursor:=crHourglass;
      ObjectToDelete:=TSysUser.Retrieve(POID(FArrayUserId[grdUserData.Row-1])) as TSysUser;
      // Check if it is possible to delete (referential integrity)
      Reason:='';
      CanDelete:=ObjectToDelete.CanDelete(Reason);
      Screen.Cursor:=crDefault;
      if not CanDelete then begin
         Application.MessageBox(PChar('O registro selecionado não pode ser excluído pela seguinte razão:'+#13#10+Reason),'Segurança',MB_ICONEXCLAMATION);
         Exit;
      end;
      // Ask confirmation
      if Application.MessageBox('Confirma a exclusão do registro selecionado?','Confirmação',MB_ICONQUESTION+MB_OKCANCEL)=IDOK then begin
         // Delete object
         Screen.Cursor:=crHourglass;
         ObjectToDelete.Delete;
         RefreshUserData;
         ResizeUserGrid;
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* mnuUsersEditClick
//************************************************************************
procedure TfrmAdminModuleMain.mnuUsersEditClick(Sender: TObject);
var
   ObjectToEdit: TSysUser;
begin
   if High(FArrayUserId)>=0 then begin
      // Retrieve object
      Screen.Cursor:=crHourglass;
      ObjectToEdit:=TSysUser.Retrieve(POID(FArrayUserId[grdUserData.Row-1]),True) as TSysUser;
      // Create data form
      Application.CreateForm(TfrmDataUser,frmDataUser);
      Screen.Cursor:=crDefault;
      // Show data form
      if frmDataUser.Open(ObjectToEdit) then begin
         // Refresh
         Screen.Cursor:=crHourglass;
         RefreshUserData(ObjectToEdit.OID.ID);
         ResizeUserGrid;
         Screen.Cursor:=crDefault;
      end;
      frmDataUser.Free;
   end;
end;

//************************************************************************
//* SetupUserGridColumns
//************************************************************************
procedure TfrmAdminModuleMain.SetupUserGridColumns;
begin
   grdUserData.ColCount:=3;
   grdUserData.Cells[0,0]:='Login';
   grdUserData.Cells[1,0]:='Nome Completo';
   grdUserData.Cells[2,0]:='E-Mail';
   SetLength(FArrayUserPctColWidths,3);
   FArrayUserPctColWidths[0]:=19;    // Login
   FArrayUserPctColWidths[1]:=40;    // Nome Completo
   FArrayUserPctColWidths[2]:=40;    // E-Mail
end;

//************************************************************************
//* SetupGroupGridColumns
//************************************************************************
procedure TfrmAdminModuleMain.SetupGroupGridColumns;
begin
   grdGroupData.ColCount:=2;
   grdGroupData.Cells[0,0]:='Nome';
   grdGroupData.Cells[1,0]:='Descrição';
   SetLength(FArrayGroupPctColWidths,2);
   FArrayGroupPctColWidths[0]:=39;    // Nome
   FArrayGroupPctColWidths[1]:=60;    // Descrição
end;

//************************************************************************
//* RefreshUserData
//************************************************************************
procedure TfrmAdminModuleMain.RefreshUserData(APOIDToSelect: Integer = 0);
var
   i: Integer;
   ResultSet: TList;
begin
   ResultSet:=TList.Create;
   gP2SBFObjRepos.QueryPersistentObjects(TSysUser,nil,ResultSet,'Login',True);
   if ResultSet.Count=0 then begin
      SetLength(FArrayUserId,0);
      grdUserData.RowCount:=2;
      for i:=0 to grdUserData.ColCount-1 do begin
         grdUserData.Cells[i,1]:='';
      end;
   end else begin
      SetLength(FArrayUserId,ResultSet.Count);
      grdUserData.RowCount:=ResultSet.Count+1;
      for i:=0 to ResultSet.Count-1 do begin
         FArrayUserId[i]:=TSysUser(ResultSet.Items[i]).OID.ID;
         grdUserData.Cells[0,i+1]:=TSysUser(ResultSet.Items[i]).Login;
         grdUserData.Cells[1,i+1]:=TSysUser(ResultSet.Items[i]).FullName;
         grdUserData.Cells[2,i+1]:=TSysUser(ResultSet.Items[i]).EMail;
         // Auto Select row if necessary
         if FArrayUserId[i]=APOIDToSelect then begin
            grdUserData.Row:=i+1;
         end;
      end;
   end;
   ResultSet.Free;
end;

//************************************************************************
//* RefreshGroupData
//************************************************************************
procedure TfrmAdminModuleMain.RefreshGroupData(APOIDToSelect: Integer = 0);
var
   i: Integer;
   ResultSet: TList;
begin
   ResultSet:=TList.Create;
   gP2SBFObjRepos.QueryPersistentObjects(TSysGroup,nil,ResultSet,'Name',True);
   if ResultSet.Count=0 then begin
      SetLength(FArrayGroupId,0);
      grdGroupData.RowCount:=2;
      for i:=0 to grdGroupData.ColCount-1 do begin
         grdGroupData.Cells[i,1]:='';
      end;
   end else begin
      SetLength(FArrayGroupId,ResultSet.Count);
      grdGroupData.RowCount:=ResultSet.Count+1;
      for i:=0 to ResultSet.Count-1 do begin
         FArrayGroupId[i]:=TSysGroup(ResultSet.Items[i]).OID.ID;
         grdGroupData.Cells[0,i+1]:=TSysGroup(ResultSet.Items[i]).Name;
         grdGroupData.Cells[1,i+1]:=TSysGroup(ResultSet.Items[i]).Description;
         // Auto Select row if necessary
         if FArrayGroupId[i]=APOIDToSelect then begin
            grdGroupData.Row:=i+1;
         end;
      end;
   end;
   ResultSet.Free;
end;

//************************************************************************
//* ResizeUserGrid
//************************************************************************
procedure TfrmAdminModuleMain.ResizeUserGrid;
var
   i: Integer;
begin
   for i:=0 to High(FArrayUserPctColWidths) do begin
      grdUserData.ColWidths[i]:=Round(grdUserData.ClientWidth*(FArrayUserPctColWidths[i]/100));
   end;
end;

//************************************************************************
//* ResizeGroupGrid
//************************************************************************
procedure TfrmAdminModuleMain.ResizeGroupGrid;
var
   i: Integer;
begin
   for i:=0 to High(FArrayGroupPctColWidths) do begin
      grdGroupData.ColWidths[i]:=Round(grdGroupData.ClientWidth*(FArrayGroupPctColWidths[i]/100));
   end;
end;

//************************************************************************
//* SelectUserRowByPOID
//************************************************************************
procedure TfrmAdminModuleMain.SelectUserRowByPOID(APOID: Integer);
var
   i: Integer;
begin
   for i:=0 to High(FArrayUserId) do begin
      if FArrayUserId[i]=APOID then begin
         grdUserData.Row:=i+1;
         Break;
      end;
   end;
end;

//************************************************************************
//* SelectGroupRowByPOID
//************************************************************************
procedure TfrmAdminModuleMain.SelectGroupRowByPOID(APOID: Integer);
var
   i: Integer;
begin
   for i:=0 to High(FArrayGroupId) do begin
      if FArrayGroupId[i]=APOID then begin
         grdGroupData.Row:=i+1;
         Break;
      end;
   end;
end;

end.
