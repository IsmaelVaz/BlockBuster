unit ufrmDataGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons,
  Grids, ToolWin, ImgList, Mask, ShellAPI,
  uP2SBFSystemModelClient;

type
  TfrmDataGroup = class(TForm)
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
    lblName: TLabel;
    lblDescription: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtName: TMaskEdit;
    txtDescription: TMaskEdit;
//$$** ENDSECTION
    imglstImagens: TImageList;
//$$** SECTION: GRIDS_DECLARATIONS
//$$** ENDSECTION
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
//$$** SECTION: BUTTONS_METHODS_DECLARATIONS
//$$** ENDSECTION
  private
    { Private declarations }
    FObject: TSysGroup;
    FNRelInsertedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ARRAYS_LOOKUP_DECLARATIONS
//$$** ENDSECTION

    procedure UpdateObject;
    procedure UpdateScreen;
    function ValidateScreen: Boolean;

//$$** SECTION: COMBOS_LOOKUP_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: GRIDS_METHODS_DECLARATIONS
//$$** ENDSECTION
  public
    { Public declarations }
    function Open(AObject: TSysGroup): Boolean;
  end;

var
  frmDataGroup: TfrmDataGroup;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFAbsModelClient, uP2SBFObjReposClient, uP2SBFAbsModelTypes,
     uP2SBFParams 
     ;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataGroup.FormCreate
//************************************************************************
procedure TfrmDataGroup.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataGroup.FormResize
//************************************************************************
procedure TfrmDataGroup.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataGroup.cmdOkClick
//************************************************************************
procedure TfrmDataGroup.cmdOkClick(Sender: TObject);
begin
   if ValidateScreen then begin
      ModalResult:=mrOk;
   end;
end;

//************************************************************************
//* TfrmDataGroup.cmdCancelClick
//************************************************************************
procedure TfrmDataGroup.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataGroup.UpdateObject
//************************************************************************
procedure TfrmDataGroup.UpdateObject;
begin
//$$** SECTION: UPDATEOBJECT_BODY
   FObject.Name:=txtName.Text;
   FObject.Description:=txtDescription.Text;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataGroup.UpdateScreen
//************************************************************************
procedure TfrmDataGroup.UpdateScreen;
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtName.Text:=FObject.Name;
   txtDescription.Text:=FObject.Description;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataGroup.ValidateScreen
//************************************************************************
function TfrmDataGroup.ValidateScreen: Boolean;
var
   i: Integer;
   Criteria1: TP2SBFCriteria;
   Criteria2: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
   ResultSet: TList;
   ValueStr: string;
   FlagUnique: Boolean;
   ObjectToCheck: TSysGroup;
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if Trim(txtName.Text)='' then begin
      Application.MessageBox('O campo "Nome" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      txtName.SetFocus;
      Result:=False;
      Exit;
   end;
   if Trim(txtDescription.Text)='' then begin
      Application.MessageBox('O campo "Descrição" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      txtDescription.SetFocus;
      Result:=False;
      Exit;
   end;
   
   // Group name must be unique
   Criteria1:=TP2SBFCriteria.Create;
   Criteria2:=TP2SBFCriteria.Create;
   CriteriaList:=TP2SBFCriteriaList.Create;
   ResultSet:=TList.Create;
   try
      ValueStr:=txtName.Text;
      FlagUnique:=True;
      CriteriaList.Clear;
      ResultSet.Clear;

      Criteria1.PropName:='oid';
      Criteria1.Operator:=ocoNotEqual;
      Criteria1.PropValue.AsInteger:=FObject.OID.ID;
      CriteriaList.Add(Criteria1);

      Criteria2.PropName:='Name';
      Criteria2.Operator:=ocoEquals;
      Criteria2.PropValue.AsString:=ValueStr;
      CriteriaList.Add(Criteria2);

      gP2SBFObjRepos.QueryPersistentObjects(TSysGroup,CriteriaList,ResultSet,'',True,True);

      if ResultSet.Count>0 then begin
         for i:=0 to ResultSet.Count-1 do begin
            ObjectToCheck:=TSysGroup(ResultSet.Items[i]);
            if not SameOID(ObjectToCheck.OID,FObject.OID) then begin
               FlagUnique:=False;
               Break;
            end;
         end;
      end;

      if not FlagUnique then begin
         Application.MessageBox('Já existe outro grupo com o mesmo nome.','Aviso',MB_ICONINFORMATION);
         if txtName.CanFocus then txtName.SetFocus;
         if txtName.CanFocus then txtName.SelectAll;
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
//* TfrmDataGroup.Open
//************************************************************************
function TfrmDataGroup.Open(AObject: TSysGroup): Boolean;
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
//$$** ENDSECTION

//$$** SECTION: BUTTONS_METHODS
//$$** ENDSECTION

end.
