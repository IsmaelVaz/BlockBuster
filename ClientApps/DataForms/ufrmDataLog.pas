unit ufrmDataLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Menus, ExtDlgs, jpeg,
  Grids, ToolWin, ImgList, Mask, ShellAPI, Math, DateUtils, Types,
  uComboBoxRoutines,
  uP2SBFAbsModelClient, uP2SBFAbsModelTypes, uP2SBFSystemModelClientForms,
  uP2SBFClassRegistryClient, uModelClient
//$$** SECTION: CUSTOM_INTERFACE_USES
//$$** ENDSECTION

//$$** SECTION: INTERFACE_USES_USER
//$$** ENDSECTION
  ;

type
  THackControl = class(TControl);

  TComboBox = class(StdCtrls.TComboBox)
     protected
        function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
  end;
  
  TfrmDataLog = class(TP2SBFClientDataForm)
    pnlTitle: TPanel;
    imgFormPicture: TImage;
    lblTitle: TLabel;
    scrScrollData: TScrollBox;
    pnlBottom: TPanel;
    cmdShowDocument: TBitBtn;
    pnlButtons: TPanel;
    cmdOk: TBitBtn;
    cmdCancel: TBitBtn;
    pagPages: TPageControl;
//$$** SECTION: TABS_DECLARATIONS
//$$** ENDSECTION
    splSplitter: TSplitter;
//$$** SECTION: LABELS_DECLARATIONS
    lblDataLog: TLabel;
    lblHoraLog: TLabel;
    lblLoginUsuario: TLabel;
    lblAcao: TLabel;
    lblOidObject: TLabel;
    lblTela: TLabel;
    lblReferencia: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtDataLog: TMaskEdit;
    txtHoraLog: TMaskEdit;
    txtLoginUsuario: TMaskEdit;
    cboAcao: TComboBox;
    txtOidObject: TMaskEdit;
    cboTela: TComboBox;
    memReferencia: TMemo;
//$$** ENDSECTION
    imglstImagens: TImageList;
//$$** SECTION: GRIDS_DECLARATIONS
//$$** ENDSECTION
    procedure cmdShowDocumentClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComboDropDownListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure scrScrollDataMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ControlEnter(Sender: TObject);
    procedure ControlExit(Sender: TObject);
    
//$$** SECTION: IMAGES_POPUPS_METHODS_DECLARATIONS
//$$** SECTION: BUTTONS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: COMBOS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: COMPONENTS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: CUSTOMBUTTONS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: GRIDDRAWCELL_METHODS_DECLARATIONS
//$$** ENDSECTION

  private
    { Private declarations }
    FFlagNew: Boolean;
    FObject: TLog;
    FNRelInsertedFlag: Boolean;
    FNRelEditedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ARRAYS_LOOKUP_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_HANDLERS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS_DECLARATIONS
//$$** ENDSECTION

    procedure UpdateObject(AObject: TLog);
    procedure UpdateScreen(AFlagNew: Boolean);
    function ValidateScreen: Boolean;
    function StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
    function CustomValidateScreen: Boolean;
    procedure AfterSendEMailDoc(Sender: TObject);
    procedure AfterPrintDoc(Sender: TObject);

//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_DECLARATION
//$$** ENDSECTION

//$$** SECTION: GRIDS_METHODS_DECLARATIONS
//$$** ENDSECTION

    function  CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
    procedure InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
    function  ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
    procedure BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
    procedure AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
    procedure AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
    procedure SortObjects;
  protected
    { Protected declarations }
//$$** SECTION: PROTECTEDDECL_IMPL_USER
//$$** ENDSECTION
  public
    { Public declarations }
    function Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean; override;

//$$** SECTION: UPDATE_VARIABLES_PROPERTIES
//$$** ENDSECTION

//$$** SECTION: PUBLICDECL_IMPL_USER
//$$** ENDSECTION
  end;

var
  frmDataLog: TfrmDataLog;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataLog.FormCreate
//************************************************************************
procedure TfrmDataLog.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLog.FormDestroy
//************************************************************************
procedure TfrmDataLog.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLog.FormActivate
//************************************************************************
procedure TfrmDataLog.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   // This section is used to automatically maximize the form if needed.
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLog.FormResize
//************************************************************************
procedure TfrmDataLog.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLog.FormKeyDown
//************************************************************************
procedure TfrmDataLog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.FormKeyPress
//************************************************************************
procedure TfrmDataLog.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataLog.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataLog.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataLog.scrScrollDataMouseWheel(
  Sender: TObject; Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint; var Handled: Boolean);
begin
   if Self.ActiveControl<>nil then begin
      if Self.ActiveControl is TComboBox then Exit;
   end;
   scrScrollData.VertScrollBar.Position:=scrScrollData.VertScrollBar.Position-(WheelDelta div 4);
   Handled:=True;
end;

//************************************************************************
//* TfrmDataLog.ControlEnter
//************************************************************************
procedure TfrmDataLog.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataLog.ControlExit
//************************************************************************
procedure TfrmDataLog.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataLog.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataLog.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION



//************************************************************************
//* TfrmDataLog.cmdOkClick
//************************************************************************
procedure TfrmDataLog.cmdOkClick(Sender: TObject);
var
   CanUpdate: Boolean;
begin
   if ValidateScreen then begin
      Screen.Cursor:=crHourglass;
      CanUpdate:=FObject.CanUpdate;
      Screen.Cursor:=crDefault;
      if not CanUpdate then begin
         if False then begin
            Application.MessageBox(PChar('Outro usuário na rede salvou este mesmo registro enquanto você o editava.'#13#10'Para evitar inconsistência de dados, você não pode salvá-lo.'+' Feche esta tela pelo botão "Cancelar" e a abra novamente para recarregar o registro alterado pelo outro usuário e, se necessário, fazer as alterações desejadas e salvar novamente.'),'Aviso',MB_ICONINFORMATION);
            Exit;
         end else begin
            if Application.MessageBox('Outro usuário na rede salvou este mesmo registro enquanto você o editava.'#13#10'Prosseguir com o salvamento fará com que os dados editados em sua tela sobrescrevam os dados que o outro usuário alterou.'#13#10#13#10'Deseja continuar e salvar este registro?','Confirmação',MB_ICONQUESTION+MB_OKCANCEL)<>IDOK then begin
               Exit;
            end;
         end;
      end;
      ModalResult:=mrOk;
   end;
end;

//************************************************************************
//* TfrmDataLog.cmdCancelClick
//************************************************************************
procedure TfrmDataLog.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataLog.UpdateObject
//************************************************************************
procedure TfrmDataLog.UpdateObject(AObject: TLog);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   if txtDataLog.Text<>'  /  /    ' then begin
      AObject.DataLog:=StrToDate(txtDataLog.Text);
   end else begin
      AObject.DataLog:=0;
   end;
   if txtHoraLog.Text<>'  :  :  ' then begin
      AObject.HoraLog:=StrToTime(txtHoraLog.Text);
   end else begin
      AObject.HoraLog:=0;
   end;
   AObject.LoginUsuario:=txtLoginUsuario.Text;
   if cboAcao.ItemIndex=0 then begin
      AObject.Acao:='U';
   end else if cboAcao.ItemIndex=1 then begin
      AObject.Acao:='D';
   end else if cboAcao.ItemIndex=2 then begin
      AObject.Acao:='C';
   end else if cboAcao.ItemIndex=3 then begin
      AObject.Acao:='CR';
   end else begin
      AObject.Acao:='';
   end;
   AObject.OidObject:=StrToInt(txtOidObject.Text);
   if cboTela.ItemIndex=0 then begin
      AObject.Tela:='D';
   end else if cboTela.ItemIndex=1 then begin
      AObject.Tela:='F';
   end else if cboTela.ItemIndex=2 then begin
      AObject.Tela:='L';
   end else if cboTela.ItemIndex=3 then begin
      AObject.Tela:='S';
   end else begin
      AObject.Tela:='';
   end;
   AObject.Referencia:=memReferencia.Lines.Text;
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLog.UpdateScreen
//************************************************************************
procedure TfrmDataLog.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   if FObject.DataLog<>0 then begin
      txtDataLog.Text:=FormatDateTime('dd/mm/yyyy',FObject.DataLog);
   end else begin
      txtDataLog.Text:='  /  /    ';
   end;
   if FObject.HoraLog<>0 then begin
      txtHoraLog.Text:=FormatDateTime('hh:nn:ss',FObject.HoraLog);
   end else begin
      txtHoraLog.Text:='  :  :  ';
   end;
   txtLoginUsuario.Text:=FObject.LoginUsuario;
   if FObject.Acao='U' then begin
      cboAcao.ItemIndex:=0;
   end else if FObject.Acao='D' then begin
      cboAcao.ItemIndex:=1;
   end else if FObject.Acao='C' then begin
      cboAcao.ItemIndex:=2;
   end else if FObject.Acao='CR' then begin
      cboAcao.ItemIndex:=3;
   end else begin
      cboAcao.ItemIndex:=-1;
   end;
   txtOidObject.Text:=IntToStr(FObject.OidObject);
   if FObject.Tela='D' then begin
      cboTela.ItemIndex:=0;
   end else if FObject.Tela='F' then begin
      cboTela.ItemIndex:=1;
   end else if FObject.Tela='L' then begin
      cboTela.ItemIndex:=2;
   end else if FObject.Tela='S' then begin
      cboTela.ItemIndex:=3;
   end else begin
      cboTela.ItemIndex:=-1;
   end;
   memReferencia.Lines.Text:=FObject.Referencia;
//$$** SECTION: UPDATESCREEN_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLog.ValidateScreen
//************************************************************************
function TfrmDataLog.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataLog.StandardValidateScreen
//************************************************************************
function TfrmDataLog.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
//$$** SECTION: VALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if txtDataLog.Text='  /  /    ' then begin
      Application.MessageBox('O campo "Data do Log" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtDataLog.CanFocus then txtDataLog.SetFocus;
      Result:=False;
      Exit;
   end;
   if txtDataLog.Text<>'  /  /    ' then begin
      try
         StrToDate(txtDataLog.Text);
      except
         Application.MessageBox('O valor do campo "Data do Log" é inválido.','Aviso',MB_ICONINFORMATION);
         if txtDataLog.CanFocus then txtDataLog.SetFocus;
         if txtDataLog.CanFocus then txtDataLog.SelectAll;
         Result:=False;
         Exit;
      end;
   end;
   if txtHoraLog.Text='  :  :  ' then begin
      Application.MessageBox('O campo "Hora do Log" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtHoraLog.CanFocus then txtHoraLog.SetFocus;
      Result:=False;
      Exit;
   end;
   if txtHoraLog.Text<>'  :  :  ' then begin
      try
         StrToTime(txtHoraLog.Text);
      except
         Application.MessageBox('O valor do campo "Hora do Log" é inválido.','Aviso',MB_ICONINFORMATION);
         if txtHoraLog.CanFocus then txtHoraLog.SetFocus;
         if txtHoraLog.CanFocus then txtHoraLog.SelectAll;
         Result:=False;
         Exit;
      end;
   end;
   if Trim(txtLoginUsuario.Text)='' then begin
      Application.MessageBox('O campo "Login" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtLoginUsuario.CanFocus then txtLoginUsuario.SetFocus;
      Result:=False;
      Exit;
   end;
   if cboAcao.ItemIndex=-1 then begin
      Application.MessageBox('O campo "Ação" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if cboAcao.CanFocus then cboAcao.SetFocus;
      Result:=False;
      Exit;
   end;
   if Trim(txtOidObject.Text)='' then begin
      Application.MessageBox('O campo "Oid Objeto" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtOidObject.CanFocus then txtOidObject.SetFocus;
      Result:=False;
      Exit;
   end;
   try
      StrToInt(Trim(txtOidObject.Text));
   except
      Application.MessageBox('O valor do campo "Oid Objeto" é inválido.','Aviso',MB_ICONINFORMATION);
      if txtOidObject.CanFocus then txtOidObject.SetFocus;
      if txtOidObject.CanFocus then txtOidObject.SelectAll;
      Result:=False;
      Exit;
   end;
   if cboTela.ItemIndex=-1 then begin
      Application.MessageBox('O campo "Tela" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if cboTela.CanFocus then cboTela.SetFocus;
      Result:=False;
      Exit;
   end;
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataLog.CustomValidateScreen
//************************************************************************
function TfrmDataLog.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataLog.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataLog.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.AfterPrintDoc
//************************************************************************
procedure TfrmDataLog.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.Open
//************************************************************************
function TfrmDataLog.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TLog(AObject);
   FNRelInsertedFlag:=False;
   FNRelEditedFlag:=False;
   FNRelDeletedFlag:=False;
   
   // Evita que o foco inicie em uma ComboBox. Muitos usuários tem por hábito rolar o MouseWheel
   // para navegar pelo formulário e o que acontece quando o foco está em uma ComboBox
   // é que o item da combo é rolado, e não o formulário.
   for i:=0 to scrScrollData.ControlCount-1 do begin
      if not (scrScrollData.Controls[i] is TLabel) then begin
         if scrScrollData.Controls[i].Enabled then begin
            if scrScrollData.Controls[i] is TComboBox then begin
               scrScrollData.TabStop:=True;
               Break;
            end else begin
               scrScrollData.TabStop:=False;
               Break;
            end;
         end;
      end;
   end;   
   
//$$** SECTION: BEFOREUPDATESCREEN_OPEN
//$$** ENDSECTION
   SortObjects;
   UpdateScreen(AFlagNew);
   Screen.Cursor:=crDefault;
   if not AHidden then begin
      if ShowModal=mrOk then begin
         Screen.Cursor:=crHourglass;
         UpdateObject(FObject);
//$$** SECTION: AFTERUPDATEOBJECT_OPEN
//$$** ENDSECTION
         FObject.Save(False,False);
         FObject.Refresh;
//$$** SECTION: AFTERREFRESHOBJECT_OPEN
//$$** ENDSECTION
         Result:=True;
         Screen.Cursor:=crDefault;
      end else begin
         // If any part was edited, we save FObject to ensure that calculated fields in
         // BeforeSave will be processed.
         Result:=False;
         if (FNRelInsertedFlag) or (FNRelEditedFlag) or (FNRelDeletedFlag) then begin
            Screen.Cursor:=crHourglass;
//$$** SECTION: BEFORECANCELSAVE
//$$** ENDSECTION
            FObject.Save(False,False);
            FObject.Refresh;
         //   Result:=True;
            Screen.Cursor:=crDefault;
         end;
      end;
   end else begin
      // When AHidden = False, do not call ShowModal.
      Result:=False;   // False to indicate that the object has not been saved.
   end;
end;

//$$** SECTION: GRIDS_METHODS
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS
//$$** ENDSECTION

//$$** SECTION: IMAGES_POPUPS_METHODS
//$$** ENDSECTION

//$$** SECTION: BUTTONS_METHODS
//$$** ENDSECTION

//$$** SECTION: COMBOS_METHODS
//$$** ENDSECTION

//$$** SECTION: COMPONENTS_METHODS
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.CanCreateObject
//************************************************************************
function TfrmDataLog.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.InitializeNewObject
//************************************************************************
procedure TfrmDataLog.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.ClientCanDeleteObject
//************************************************************************
function TfrmDataLog.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.BeforeEditObject
//************************************************************************
procedure TfrmDataLog.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.AfterSaveObject
//************************************************************************
procedure TfrmDataLog.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.AfterDeleteObject
//************************************************************************
procedure TfrmDataLog.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLog.SortObjects
//************************************************************************
procedure TfrmDataLog.SortObjects;
//$$** SECTION: SORTOBJECTS_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TComboBox.DoMouseWheel
//************************************************************************
function TComboBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
   // Override para não fazer nada, e não processar o scroll do mouse (mouse wheel) que altera
   // sem querer o item selecionado de uma ComboBox quando o usuário passa o mouse por cima.
   Result:=True;
end;

//$$** SECTION: USERMETHODS_FULLIMPL
//$$** ENDSECTION

initialization
   // Register Data Form Class
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataLog);

end.
