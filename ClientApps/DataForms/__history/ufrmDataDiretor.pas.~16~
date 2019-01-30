unit ufrmDataDiretor;

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
  
  TfrmDataDiretor = class(TP2SBFClientDataForm)
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
    lblNomeExibicao: TLabel;
    lblNomeCompleto: TLabel;
    lblDataNascimento: TLabel;
    lblEndereco: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtNomeExibicao: TMaskEdit;
    txtNomeCompleto: TMaskEdit;
    txtDataNascimento: TMaskEdit;
    cmdEndereco: TButton;
    lblEnderecoValue: TLabel;
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
    procedure cmdEnderecoClick(Sender: TObject);
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
    FObject: TDiretor;
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
    procedure UpdateLabelEnderecoValue;
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS_DECLARATIONS
//$$** ENDSECTION

    procedure UpdateObject(AObject: TDiretor);
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
  frmDataDiretor: TfrmDataDiretor;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
     , ufrmDataEndereco
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataDiretor.FormCreate
//************************************************************************
procedure TfrmDataDiretor.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataDiretor.FormDestroy
//************************************************************************
procedure TfrmDataDiretor.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataDiretor.FormActivate
//************************************************************************
procedure TfrmDataDiretor.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   // This section is used to automatically maximize the form if needed.
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataDiretor.FormResize
//************************************************************************
procedure TfrmDataDiretor.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataDiretor.FormKeyDown
//************************************************************************
procedure TfrmDataDiretor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.FormKeyPress
//************************************************************************
procedure TfrmDataDiretor.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataDiretor.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataDiretor.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataDiretor.scrScrollDataMouseWheel(
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
//* TfrmDataDiretor.ControlEnter
//************************************************************************
procedure TfrmDataDiretor.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataDiretor.ControlExit
//************************************************************************
procedure TfrmDataDiretor.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataDiretor.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataDiretor.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION



//************************************************************************
//* TfrmDataDiretor.cmdOkClick
//************************************************************************
procedure TfrmDataDiretor.cmdOkClick(Sender: TObject);
var
   CanUpdate: Boolean;
begin
   if ValidateScreen then begin
      Screen.Cursor:=crHourglass;
      CanUpdate:=FObject.CanUpdate;
      Screen.Cursor:=crDefault;
      if not CanUpdate then begin
         if True then begin
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
//* TfrmDataDiretor.cmdCancelClick
//************************************************************************
procedure TfrmDataDiretor.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataDiretor.UpdateObject
//************************************************************************
procedure TfrmDataDiretor.UpdateObject(AObject: TDiretor);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   AObject.NomeExibicao:=txtNomeExibicao.Text;
   AObject.NomeCompleto:=txtNomeCompleto.Text;
   if txtDataNascimento.Text<>'  /  /    ' then begin
      AObject.DataNascimento:=StrToDate(txtDataNascimento.Text);
   end else begin
      AObject.DataNascimento:=0;
   end;
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataDiretor.UpdateScreen
//************************************************************************
procedure TfrmDataDiretor.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtNomeExibicao.Text:=FObject.NomeExibicao;
   txtNomeCompleto.Text:=FObject.NomeCompleto;
   if FObject.DataNascimento<>0 then begin
      txtDataNascimento.Text:=FormatDateTime('dd/mm/yyyy',FObject.DataNascimento);
   end else begin
      txtDataNascimento.Text:='  /  /    ';
   end;
   UpdateLabelEnderecoValue;
//$$** SECTION: UPDATESCREEN_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataDiretor.ValidateScreen
//************************************************************************
function TfrmDataDiretor.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataDiretor.StandardValidateScreen
//************************************************************************
function TfrmDataDiretor.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
//$$** SECTION: VALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if Trim(txtNomeExibicao.Text)='' then begin
      Application.MessageBox('O campo "Nome Exibição" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtNomeExibicao.CanFocus then txtNomeExibicao.SetFocus;
      Result:=False;
      Exit;
   end;
   if txtDataNascimento.Text<>'  /  /    ' then begin
      try
         StrToDate(txtDataNascimento.Text);
      except
         Application.MessageBox('O valor do campo "Data de Nascimento" é inválido.','Aviso',MB_ICONINFORMATION);
         if txtDataNascimento.CanFocus then txtDataNascimento.SetFocus;
         if txtDataNascimento.CanFocus then txtDataNascimento.SelectAll;
         Result:=False;
         Exit;
      end;
   end;
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataDiretor.CustomValidateScreen
//************************************************************************
function TfrmDataDiretor.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataDiretor.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataDiretor.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.AfterPrintDoc
//************************************************************************
procedure TfrmDataDiretor.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.Open
//************************************************************************
function TfrmDataDiretor.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
   NewObjectLog: TLog;
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TDiretor(AObject);
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

         NewObjectLog:= TLog.Create();
         NewObjectLog.DataLog:= Date();
         NewObjectLog.HoraLog:= Time();
         NewObjectLog.Tela:='D';
         NewObjectLog.Referencia:= 'Nome: '+FObject.NomeExibicao;
         NewObjectLog.OidObject:= FObject.OID.ID;

         if AFlagNew then begin
            NewObjectLog.Acao:='CR';
         end else begin
             NewObjectLog.Acao:='U';
         end;

         NewObjectLog.Save(false, false);
         NewObjectLog.Refresh;

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
            NewObjectLog:= TLog.Create();

            NewObjectLog.Acao:='C';
            NewObjectLog.Tela:='D';
            NewObjectLog.Referencia:= 'Nome: '+FObject.NomeExibicao;
            NewObjectLog.OidObject:= FObject.OID.ID;
            NewObjectLog.Save(false, false);
            NewObjectLog.Refresh;
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

//************************************************************************
//* TfrmDataDiretor.UpdateLabelEnderecoValue
//************************************************************************
procedure TfrmDataDiretor.UpdateLabelEnderecoValue;
var
   ObjectToCheck: TEndereco;
begin
   // Get object to check
   ObjectToCheck:=TEndereco(FObject.Endereco);
   // Get presentation value
   lblEnderecoValue.Caption:=ObjectToCheck.Endereco;
end;
//$$** ENDSECTION

//$$** SECTION: IMAGES_POPUPS_METHODS
//$$** ENDSECTION

//$$** SECTION: BUTTONS_METHODS

//************************************************************************
//* TfrmDataDiretor.cmdEnderecoClick
//************************************************************************
procedure TfrmDataDiretor.cmdEnderecoClick(Sender: TObject);
var
   ObjectToEdit: TEndereco;
   DataForm: TfrmDataEndereco;
begin
   if FFlagNew then begin
      if StandardValidateScreen(False) then begin
         Screen.Cursor:=crHourglass;
         if FObject.CanUpdate then begin
            UpdateObject(FObject);
            FObject.Save(False,False);
            FObject.Refresh;
            SortObjects;
            FFlagNew:=False;
         end;
         Screen.Cursor:=crDefault;
      end else begin
         Exit;
      end;
   end;
   ObjectToEdit:=TEndereco(FObject.Endereco);
   BeforeEditObject(ObjectToEdit);
   Application.CreateForm(TfrmDataEndereco,DataForm);
   try
      if DataForm.Open(ObjectToEdit,False) then begin
         FNRelEditedFlag:=True;
         // Refresh label
         UpdateLabelEnderecoValue;
      end;
   finally
      DataForm.Free;
   end;
end;
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
//* TfrmDataDiretor.CanCreateObject
//************************************************************************
function TfrmDataDiretor.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.InitializeNewObject
//************************************************************************
procedure TfrmDataDiretor.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.ClientCanDeleteObject
//************************************************************************
function TfrmDataDiretor.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.BeforeEditObject
//************************************************************************
procedure TfrmDataDiretor.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.AfterSaveObject
//************************************************************************
procedure TfrmDataDiretor.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.AfterDeleteObject
//************************************************************************
procedure TfrmDataDiretor.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataDiretor.SortObjects
//************************************************************************
procedure TfrmDataDiretor.SortObjects;
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
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataDiretor);

end.
