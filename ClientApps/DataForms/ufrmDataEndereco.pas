unit ufrmDataEndereco;

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
  
  TfrmDataEndereco = class(TP2SBFClientDataForm)
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
    lblEndereco: TLabel;
    lblNumero: TLabel;
    lblComplemento: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtEndereco: TMaskEdit;
    txtNumero: TMaskEdit;
    txtComplemento: TMaskEdit;
    txtBairro: TMaskEdit;
    txtCidade: TMaskEdit;
    txtEstado: TMaskEdit;
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
    FObject: TEndereco;
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

    procedure UpdateObject(AObject: TEndereco);
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
  frmDataEndereco: TfrmDataEndereco;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataEndereco.FormCreate
//************************************************************************
procedure TfrmDataEndereco.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataEndereco.FormDestroy
//************************************************************************
procedure TfrmDataEndereco.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataEndereco.FormActivate
//************************************************************************
procedure TfrmDataEndereco.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   // This section is used to automatically maximize the form if needed.
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataEndereco.FormResize
//************************************************************************
procedure TfrmDataEndereco.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataEndereco.FormKeyDown
//************************************************************************
procedure TfrmDataEndereco.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.FormKeyPress
//************************************************************************
procedure TfrmDataEndereco.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataEndereco.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataEndereco.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataEndereco.scrScrollDataMouseWheel(
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
//* TfrmDataEndereco.ControlEnter
//************************************************************************
procedure TfrmDataEndereco.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataEndereco.ControlExit
//************************************************************************
procedure TfrmDataEndereco.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataEndereco.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataEndereco.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION



//************************************************************************
//* TfrmDataEndereco.cmdOkClick
//************************************************************************
procedure TfrmDataEndereco.cmdOkClick(Sender: TObject);
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
//* TfrmDataEndereco.cmdCancelClick
//************************************************************************
procedure TfrmDataEndereco.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataEndereco.UpdateObject
//************************************************************************
procedure TfrmDataEndereco.UpdateObject(AObject: TEndereco);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   AObject.Endereco:=txtEndereco.Text;
   AObject.Numero:=txtNumero.Text;
   AObject.Complemento:=txtComplemento.Text;
   AObject.Bairro:=txtBairro.Text;
   AObject.Cidade:=txtCidade.Text;
   AObject.Estado:=txtEstado.Text;
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataEndereco.UpdateScreen
//************************************************************************
procedure TfrmDataEndereco.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtEndereco.Text:=FObject.Endereco;
   txtNumero.Text:=FObject.Numero;
   txtComplemento.Text:=FObject.Complemento;
   txtBairro.Text:=FObject.Bairro;
   txtCidade.Text:=FObject.Cidade;
   txtEstado.Text:=FObject.Estado;
//$$** SECTION: UPDATESCREEN_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataEndereco.ValidateScreen
//************************************************************************
function TfrmDataEndereco.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataEndereco.StandardValidateScreen
//************************************************************************
function TfrmDataEndereco.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
//$$** SECTION: VALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if Trim(txtEndereco.Text)='' then begin
      Application.MessageBox('O campo "Endereço" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtEndereco.CanFocus then txtEndereco.SetFocus;
      Result:=False;
      Exit;
   end;
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataEndereco.CustomValidateScreen
//************************************************************************
function TfrmDataEndereco.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataEndereco.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataEndereco.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.AfterPrintDoc
//************************************************************************
procedure TfrmDataEndereco.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.Open
//************************************************************************
function TfrmDataEndereco.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TEndereco(AObject);
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
//* TfrmDataEndereco.CanCreateObject
//************************************************************************
function TfrmDataEndereco.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.InitializeNewObject
//************************************************************************
procedure TfrmDataEndereco.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.ClientCanDeleteObject
//************************************************************************
function TfrmDataEndereco.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.BeforeEditObject
//************************************************************************
procedure TfrmDataEndereco.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.AfterSaveObject
//************************************************************************
procedure TfrmDataEndereco.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.AfterDeleteObject
//************************************************************************
procedure TfrmDataEndereco.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataEndereco.SortObjects
//************************************************************************
procedure TfrmDataEndereco.SortObjects;
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
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataEndereco);

end.
