unit ufrmDataUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons,
  Grids, ToolWin, ImgList, Mask, ShellAPI,
  uP2SBFSystemModelClient, CheckLst;

type
  TfrmDataUser = class(TForm)
    pnlTitle: TPanel;
    imgFormPicture: TImage;
    lblTitle: TLabel;
    scrScrollData: TScrollBox;
    pnlBotom: TPanel;
    pnlButtons: TPanel;
    cmdOk: TBitBtn;
    cmdCancel: TBitBtn;
    pagPages: TPageControl;
//$$** SECTION: TABS_DECLARATIONS
//$$** ENDSECTION
    splSplitter: TSplitter;
//$$** SECTION: LABELS_DECLARATIONS
    lblLogin: TLabel;
    lblPassword: TLabel;
    lblFullName: TLabel;
    lblEMail: TLabel;
    lblAssociatedGroup: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtLogin: TMaskEdit;
    txtPassword: TMaskEdit;
    txtFullName: TMaskEdit;
    txtEMail: TMaskEdit;
    cmdEMail: TButton;
    cboAssociatedGroup: TComboBox;
//$$** ENDSECTION
    imglstImagens: TImageList;
    chkFlagAdmin: TCheckBox;
    lblFlagAdmin: TLabel;
    Label1: TLabel;
    chklstRoutingGroups: TCheckListBox;
//$$** SECTION: GRIDS_DECLARATIONS
//$$** ENDSECTION
    procedure txtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
//$$** SECTION: BUTTONS_METHODS_DECLARATIONS
    procedure cmdEMailClick(Sender: TObject);
//$$** ENDSECTION
  private
    { Private declarations }
    FObject: TSysUser;
    FNRelInsertedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ARRAYS_LOOKUP_DECLARATIONS
    FArrayLookupIdAssociatedGroup: array of Integer;
//$$** ENDSECTION
    FArrayRoutingGroupNames: array of string;

    procedure UpdateObject;
    procedure UpdateScreen;
    function ValidateScreen: Boolean;
    function IsRoutingGroupPartOfUser(ARoutingGroupName: string): Boolean;

//$$** SECTION: COMBOS_LOOKUP_METHODS_DECLARATIONS
    procedure LoadItemsComboLookupAssociatedGroup;
    procedure SelectItemComboLookupAssociatedGroup;
//$$** ENDSECTION

//$$** SECTION: GRIDS_METHODS_DECLARATIONS
//$$** ENDSECTION
  public
    { Public declarations }
    function Open(AObject: TSysUser): Boolean;
  end;

var
  frmDataUser: TfrmDataUser;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFAbsModelClient, uP2SBFObjReposClient, uP2SBFAbsModelTypes,
     uP2SBFClassRegistryClient, uP2SBFParams, uMisc
     ;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataUser.FormCreate
//************************************************************************
procedure TfrmDataUser.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
   LoadItemsComboLookupAssociatedGroup;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataUser.FormResize
//************************************************************************
procedure TfrmDataUser.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataUser.txtLoginKeyPress
//************************************************************************
procedure TfrmDataUser.txtLoginKeyPress(Sender: TObject; var Key: Char);
var
   Str: string;
begin
   Str:=Key;
   Str:=LowerCase(RemoveSpecialChars(Str));
   if Str<>'' then begin
      Key:=Str[1];
   end;
   if not (Key in ['a'..'z','0'..'9','.','-','_',#8]) then begin
      Key:=#0;
   end;
end;

//************************************************************************
//* TfrmDataUser.cmdOkClick
//************************************************************************
procedure TfrmDataUser.cmdOkClick(Sender: TObject);
begin
   if ValidateScreen then begin
      ModalResult:=mrOk;
   end;
end;

//************************************************************************
//* TfrmDataUser.cmdCancelClick
//************************************************************************
procedure TfrmDataUser.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataUser.UpdateObject
//************************************************************************
procedure TfrmDataUser.UpdateObject;
var
   i: Integer;
   SysUserRoutingGroup: TSysUserRoutingGroup;
begin
//$$** SECTION: UPDATEOBJECT_BODY
   FObject.Login:=txtLogin.Text;
   FObject.Password:=txtPassword.Text;
   FObject.FullName:=txtFullName.Text;
   FObject.EMail:=txtEMail.Text;
   if cboAssociatedGroup.ItemIndex=-1 then begin
      FObject.AssociatedGroup.OIDRef:=NullOID;
   end else begin
      FObject.AssociatedGroup.OIDRef:=POID(FArrayLookupIdAssociatedGroup[cboAssociatedGroup.ItemIndex]);
   end;
   FObject.FlagAdmin:=chkFlagAdmin.Checked;
//$$** ENDSECTION
   // Routing groups
   FObject.RoutingGroups.Clear;
   for i:=0 to High(FArrayRoutingGroupNames) do begin
      if chklstRoutingGroups.Checked[i] then begin
         SysUserRoutingGroup:=TSysUserRoutingGroup.Create;
         SysUserRoutingGroup.RoutingGroupName:=FArrayRoutingGroupNames[i];
         FObject.RoutingGroups.Add(SysUserRoutingGroup);
      end;
   end;
end;

//************************************************************************
//* TfrmDataUser.UpdateScreen
//************************************************************************
procedure TfrmDataUser.UpdateScreen;
var
   i: Integer;
   RoutingGroupList: TList;
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtLogin.Text:=FObject.Login;
   txtPassword.Text:=FObject.Password;
   txtFullName.Text:=FObject.FullName;
   txtEMail.Text:=FObject.EMail;
   SelectItemComboLookupAssociatedGroup;
   chkFlagAdmin.Checked:=FObject.FlagAdmin;
//$$** ENDSECTION
   // Routing Groups
   RoutingGroupList:=TList.Create;
   gP2SBFClassRegistry.GetRoutingGroupClasses(RoutingGroupList);
   SetLength(FArrayRoutingGroupNames,RoutingGroupList.Count);
   chklstRoutingGroups.Items.Clear;
   for i:=0 to RoutingGroupList.Count-1 do begin
      FArrayRoutingGroupNames[i]:=TP2SBFAbsBizClass(RoutingGroupList.Items[i]).ClassName;
      chklstRoutingGroups.Items.Add(gP2SBFClassRegistry.GetClassDescription(TP2SBFAbsBizClass(RoutingGroupList.Items[i])));
      chklstRoutingGroups.Checked[i]:=IsRoutingGroupPartOfUser(FArrayRoutingGroupNames[i]);
   end;
   RoutingGroupList.Free;
end;

//************************************************************************
//* TfrmDataUser.ValidateScreen
//************************************************************************
function TfrmDataUser.ValidateScreen: Boolean;
var
   i: Integer;
   Criteria1: TP2SBFCriteria;
   Criteria2: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
   ResultSet: TList;
   ValueStr: string;
   FlagUnique: Boolean;
   ObjectToCheck: TSysUser;
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if Trim(txtLogin.Text)='' then begin
      Application.MessageBox('O campo "Login" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      txtLogin.SetFocus;
      Result:=False;
      Exit;
   end;
   if Trim(txtPassword.Text)='' then begin
      Application.MessageBox('O campo "Senha" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      txtPassword.SetFocus;
      Result:=False;
      Exit;
   end;
   if Trim(txtFullName.Text)='' then begin
      Application.MessageBox('O campo "Nome Completo" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      txtFullName.SetFocus;
      Result:=False;
      Exit;
   end;
   if cboAssociatedGroup.ItemIndex=-1 then begin
      Application.MessageBox('O campo "Grupo" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      cboAssociatedGroup.SetFocus;
      Result:=False;
      Exit;
   end;
   
   // Login must be unique
   Criteria1:=TP2SBFCriteria.Create;
   Criteria2:=TP2SBFCriteria.Create;
   CriteriaList:=TP2SBFCriteriaList.Create;
   ResultSet:=TList.Create;
   try
      ValueStr:=txtLogin.Text;
      FlagUnique:=True;
      CriteriaList.Clear;
      ResultSet.Clear;

      Criteria1.PropName:='oid';
      Criteria1.Operator:=ocoNotEqual;
      Criteria1.PropValue.AsInteger:=FObject.OID.ID;
      CriteriaList.Add(Criteria1);

      Criteria2.PropName:='Login';
      Criteria2.Operator:=ocoEquals;
      Criteria2.PropValue.AsString:=ValueStr;
      CriteriaList.Add(Criteria2);

      gP2SBFObjRepos.QueryPersistentObjects(TSysUser,CriteriaList,ResultSet,'',True,True);

      if ResultSet.Count>0 then begin
         for i:=0 to ResultSet.Count-1 do begin
            ObjectToCheck:=TSysUser(ResultSet.Items[i]);
            if not SameOID(ObjectToCheck.OID,FObject.OID) then begin
               FlagUnique:=False;
               Break;
            end;
         end;
      end;

      if not FlagUnique then begin
         Application.MessageBox('Já existe outro registro com o mesmo login.','Aviso',MB_ICONINFORMATION);
         if txtLogin.CanFocus then txtLogin.SetFocus;
         if txtLogin.CanFocus then txtLogin.SelectAll;
         Result:=False;
         Exit;
      end;
   finally
      ResultSet.Free;
      CriteriaList.Free;
      Criteria2.Free;
      Criteria1.Free;
   end;   
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataUser.IsRoutingGroupPartOfUser
//************************************************************************
function TfrmDataUser.IsRoutingGroupPartOfUser(ARoutingGroupName: string): Boolean;
var
   i: Integer;
begin
   Result:=False;
   for i:=0 to FObject.RoutingGroups.Count-1 do begin
      if TSysUserRoutingGroup(FObject.RoutingGroups.Items[i]).RoutingGroupName=ARoutingGroupName then begin
         Result:=True;
         Break;
      end;
   end;
end;

//************************************************************************
//* TfrmDataUser.Open
//************************************************************************
function TfrmDataUser.Open(AObject: TSysUser): Boolean;
begin
   Screen.Cursor:=crHourglass;
   FObject:=AObject;
   FNRelInsertedFlag:=False;
   FNRelDeletedFlag:=False;
   UpdateScreen;
   Screen.Cursor:=crDefault;
   if ShowModal=mrOk then begin
      Screen.Cursor:=crHourglass;
      UpdateObject;
      FObject.Save;
      Result:=True;
      Screen.Cursor:=crDefault;
   end else begin
      if (FNRelInsertedFlag) or (FNRelDeletedFlag) then begin
         Screen.Cursor:=crHourglass;
         FObject.Save;
         Screen.Cursor:=crDefault;
      end;
      Result:=False;
   end;
end;

//$$** SECTION: GRIDS_METHODS
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS

//************************************************************************
//* TfrmDataUser.LoadItemsComboLookupAssociatedGroup
//************************************************************************
procedure TfrmDataUser.LoadItemsComboLookupAssociatedGroup;
var
   i: Integer;
   ResultSet: TList;
begin
   ResultSet:=TList.Create;
   gP2SBFObjRepos.QueryPersistentObjects(TSysGroup,nil,ResultSet,'Name',True);
   cboAssociatedGroup.Items.Clear;
   if ResultSet.Count=0 then begin
      SetLength(FArrayLookupIdAssociatedGroup,0);
   end else begin
      SetLength(FArrayLookupIdAssociatedGroup,ResultSet.Count);
      for i:=0 to ResultSet.Count-1 do begin
         FArrayLookupIdAssociatedGroup[i]:=TSysGroup(ResultSet.Items[i]).OID.ID;
         cboAssociatedGroup.Items.Add(TSysGroup(ResultSet.Items[i]).Name);
      end;
   end;
   ResultSet.Free;
end;

//************************************************************************
//* TfrmDataUser.SelectItemComboLookupAssociatedGroup
//************************************************************************
procedure TfrmDataUser.SelectItemComboLookupAssociatedGroup;
var
   i: Integer;
begin
   cboAssociatedGroup.ItemIndex:=-1;
   for i:=0 to High(FArrayLookupIdAssociatedGroup) do begin
      if FArrayLookupIdAssociatedGroup[i] = FObject.AssociatedGroup.OIDRef.ID then begin
         cboAssociatedGroup.ItemIndex:=i;
         Break;
      end;
   end;
end;
//$$** ENDSECTION

//$$** SECTION: BUTTONS_METHODS

//************************************************************************
//* TfrmDataUser.cmdEMailClick
//************************************************************************
procedure TfrmDataUser.cmdEMailClick(Sender: TObject);
begin
   if Trim(txtEMail.Text)<>'' then begin
      ShellExecute(handle,'Open',PChar('mailto:'+txtEMail.Text),nil,nil,SW_SHOWNORMAL);
   end else begin
      Application.MessageBox('Nenhum e-mail preenchido.','Aviso',MB_ICONINFORMATION);
   end;
end;
//$$** ENDSECTION

end.
