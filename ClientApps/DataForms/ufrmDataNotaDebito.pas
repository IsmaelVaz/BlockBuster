unit ufrmDataNotaDebito;

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
  
  TfrmDataNotaDebito = class(TP2SBFClientDataForm)
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
    lblNumero: TLabel;
    lblLocacao: TLabel;
    lblDescricao: TLabel;
    lblValorTotal: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtNumero: TMaskEdit;
    cboLocacao: TComboBox;
    txtDescricao: TMaskEdit;
    txtValorTotal: TMaskEdit;
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
    FObject: TNotaDebito;
    FNRelInsertedFlag: Boolean;
    FNRelEditedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ARRAYS_LOOKUP_DECLARATIONS
    FArrayLookupIdLocacao: TIntegerDynArray;
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_HANDLERS_DECLARATIONS
   FcboLocacaoHandler: TDynamicComboBoxHandler;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS_DECLARATIONS
    procedure LoadItemsComboLookupLocacao(AText: string);
    procedure SelectItemComboLookupLocacao(AOID: TOID; AForce: Boolean = True);
    procedure UpdateComboLookupLocacao;
    procedure SetUpdateVariableComboLocacao(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS_DECLARATIONS
//$$** ENDSECTION

    procedure UpdateObject(AObject: TNotaDebito);
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
  frmDataNotaDebito: TfrmDataNotaDebito;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataNotaDebito.FormCreate
//************************************************************************
procedure TfrmDataNotaDebito.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
   FcboLocacaoHandler:=TDynamicComboBoxHandler.Create;
   FcboLocacaoHandler.AssignToComboBox(cboLocacao);
   FcboLocacaoHandler.OnLoadItems:=LoadItemsComboLookupLocacao;
   FcboLocacaoHandler.OnSelectItem:=SetUpdateVariableComboLocacao;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataNotaDebito.FormDestroy
//************************************************************************
procedure TfrmDataNotaDebito.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
   FcboLocacaoHandler.Free;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataNotaDebito.FormActivate
//************************************************************************
procedure TfrmDataNotaDebito.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   // This section is used to automatically maximize the form if needed.
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataNotaDebito.FormResize
//************************************************************************
procedure TfrmDataNotaDebito.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataNotaDebito.FormKeyDown
//************************************************************************
procedure TfrmDataNotaDebito.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
   if Key = VK_F7 then begin
      cboLocacao.Enabled:= True;
   end;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.FormKeyPress
//************************************************************************
procedure TfrmDataNotaDebito.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataNotaDebito.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataNotaDebito.scrScrollDataMouseWheel(
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
//* TfrmDataNotaDebito.ControlEnter
//************************************************************************
procedure TfrmDataNotaDebito.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.ControlExit
//************************************************************************
procedure TfrmDataNotaDebito.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataNotaDebito.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION



//************************************************************************
//* TfrmDataNotaDebito.cmdOkClick
//************************************************************************
procedure TfrmDataNotaDebito.cmdOkClick(Sender: TObject);
var
   CanUpdate: Boolean;
begin
   if ValidateScreen then begin
      Screen.Cursor:=crHourglass;
      CanUpdate:=FObject.CanUpdate;
      Screen.Cursor:=crDefault;
      if not CanUpdate then begin
         if False then begin
            Application.MessageBox(PChar('Outro usu�rio na rede salvou este mesmo registro enquanto voc� o editava.'#13#10'Para evitar inconsist�ncia de dados, voc� n�o pode salv�-lo.'+' Feche esta tela pelo bot�o "Cancelar" e a abra novamente para recarregar o registro alterado pelo outro usu�rio e, se necess�rio, fazer as altera��es desejadas e salvar novamente.'),'Aviso',MB_ICONINFORMATION);
            Exit;
         end else begin
            if Application.MessageBox('Outro usu�rio na rede salvou este mesmo registro enquanto voc� o editava.'#13#10'Prosseguir com o salvamento far� com que os dados editados em sua tela sobrescrevam os dados que o outro usu�rio alterou.'#13#10#13#10'Deseja continuar e salvar este registro?','Confirma��o',MB_ICONQUESTION+MB_OKCANCEL)<>IDOK then begin
               Exit;
            end;
         end;
      end;
      ModalResult:=mrOk;
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.cmdCancelClick
//************************************************************************
procedure TfrmDataNotaDebito.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataNotaDebito.UpdateObject
//************************************************************************
procedure TfrmDataNotaDebito.UpdateObject(AObject: TNotaDebito);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   AObject.Numero:=StrToInt(txtNumero.Text);
   if (cboLocacao.ItemIndex=-1) or (Length(FArrayLookupIdLocacao)<=0) then begin
      AObject.Locacao.OIDRef:=NullOID;
   end else begin
      AObject.Locacao.OIDRef:=POID(FArrayLookupIdLocacao[cboLocacao.ItemIndex]);
   end;
   AObject.Descricao:=txtDescricao.Text;
   AObject.ValorTotal:=StrToFloat(txtValorTotal.Text);
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataNotaDebito.UpdateScreen
//************************************************************************
procedure TfrmDataNotaDebito.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtNumero.Text:=IntToStr(FObject.Numero);
   SelectItemComboLookupLocacao(FObject.Locacao.OIDRef);
   txtDescricao.Text:=FObject.Descricao;
   txtValorTotal.Text:=Format('%.2f',[FObject.ValorTotal]);
//$$** SECTION: UPDATESCREEN_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataNotaDebito.ValidateScreen
//************************************************************************
function TfrmDataNotaDebito.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.StandardValidateScreen
//************************************************************************
function TfrmDataNotaDebito.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
//$$** SECTION: VALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if Trim(txtNumero.Text)='' then begin
      Application.MessageBox('O campo "N�mero" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtNumero.CanFocus then txtNumero.SetFocus;
      Result:=False;
      Exit;
   end;
   try
      StrToInt(Trim(txtNumero.Text));
   except
      Application.MessageBox('O valor do campo "N�mero" � inv�lido.','Aviso',MB_ICONINFORMATION);
      if txtNumero.CanFocus then txtNumero.SetFocus;
      if txtNumero.CanFocus then txtNumero.SelectAll;
      Result:=False;
      Exit;
   end;
   if Trim(txtDescricao.Text)='' then begin
      Application.MessageBox('O campo "Descri��o" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtDescricao.CanFocus then txtDescricao.SetFocus;
      Result:=False;
      Exit;
   end;
   if Trim(txtValorTotal.Text)='' then begin
      Application.MessageBox('O campo "Valor Total" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtValorTotal.CanFocus then txtValorTotal.SetFocus;
      Result:=False;
      Exit;
   end;
   try
      StrToFloat(Trim(txtValorTotal.Text));
   except
      Application.MessageBox('O valor do campo "Valor Total" � inv�lido.','Aviso',MB_ICONINFORMATION);
      if txtValorTotal.CanFocus then txtValorTotal.SetFocus;
      if txtValorTotal.CanFocus then txtValorTotal.SelectAll;
      Result:=False;
      Exit;
   end;
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataNotaDebito.CustomValidateScreen
//************************************************************************
function TfrmDataNotaDebito.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataNotaDebito.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataNotaDebito.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.AfterPrintDoc
//************************************************************************
procedure TfrmDataNotaDebito.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.Open
//************************************************************************
function TfrmDataNotaDebito.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TNotaDebito(AObject);
   FNRelInsertedFlag:=False;
   FNRelEditedFlag:=False;
   FNRelDeletedFlag:=False;
   
   // Evita que o foco inicie em uma ComboBox. Muitos usu�rios tem por h�bito rolar o MouseWheel
   // para navegar pelo formul�rio e o que acontece quando o foco est� em uma ComboBox
   // � que o item da combo � rolado, e n�o o formul�rio.
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

//************************************************************************
//* TfrmDataNotaDebito.LoadItemsComboLookupLocacao
//************************************************************************
procedure TfrmDataNotaDebito.LoadItemsComboLookupLocacao(AText: string);
var
   DescriptionList: TStringList;
   Criteria: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
//$$** SECTION: LOADITEMSCOMBOLOOKUP_LOCACAO_VAR
//$$** ENDSECTION
begin
   if Trim(AText)='' then begin
      SetLength(FArrayLookupIdLocacao,0);
      ClearComboItemsWithoutLosingText(cboLocacao);
      Exit;
   end;
   DescriptionList:=TStringList.Create;
   Criteria:=TP2SBFCriteria.Create;
   Criteria.PropName:='NumeroRef';
   Criteria.Operator:=ocoLikes;
   Criteria.PropValue.AsString:=AText+'%';
   CriteriaList:=TP2SBFCriteriaList.Create;
   CriteriaList.Add(Criteria);
//$$** SECTION: LOADITEMSCOMBOLOOKUP_LOCACAO_BEFOREQUERY
//$$** ENDSECTION
   try
      gP2SBFObjRepos.QueryDescriptionsOfPersistentObjects(TLocacao,CriteriaList,FArrayLookupIdLocacao,DescriptionList,'NumeroRef',True);
      ClearComboItemsWithoutLosingText(cboLocacao);
      cboLocacao.Items.AddStrings(DescriptionList);
   finally
      CriteriaList.Free;
      Criteria.Free;
//$$** SECTION: LOADITEMSCOMBOLOOKUP_LOCACAO_FINALIZE
//$$** ENDSECTION
      DescriptionList.Free;
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.SelectItemComboLookupLocacao
//************************************************************************
procedure TfrmDataNotaDebito.SelectItemComboLookupLocacao(AOID: TOID; AForce: Boolean = True);
var
   i: Integer;
   ObjRef: TLocacao;
begin
   cboLocacao.ItemIndex:=-1;
   for i:=0 to High(FArrayLookupIdLocacao) do begin
      if FArrayLookupIdLocacao[i] = AOID.ID then begin
         cboLocacao.ItemIndex:=i;
         Break;
      end;
   end;
   if (not SameOID(AOID,NullOID)) and (cboLocacao.ItemIndex=-1) then begin
      ObjRef:=TLocacao.Retrieve(AOID,True) as TLocacao;
      cboLocacao.Items.Add(ObjRef.NumeroRef);
      cboLocacao.ItemIndex:=cboLocacao.Items.Count-1;
      SetLength(FArrayLookupIdLocacao,High(FArrayLookupIdLocacao)+2);
      FArrayLookupIdLocacao[High(FArrayLookupIdLocacao)]:=ObjRef.OID.ID;
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.UpdateComboLookupLocacao
//************************************************************************
procedure TfrmDataNotaDebito.UpdateComboLookupLocacao;
begin
   if Trim(cboLocacao.Text)<>'' then begin
      Screen.Cursor:=crHourglass;
      LoadItemsComboLookupLocacao(cboLocacao.Text);
      Screen.Cursor:=crDefault;
   end else begin
      cboLocacao.Items.Clear;
      SetLength(FArrayLookupIdLocacao,0);
   end;
end;

//************************************************************************
//* TfrmDataNotaDebito.SetUpdateVariableComboLocacao
//************************************************************************
procedure TfrmDataNotaDebito.SetUpdateVariableComboLocacao(Sender: TObject);
begin
   // No update variable
end;
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
//* TfrmDataNotaDebito.CanCreateObject
//************************************************************************
function TfrmDataNotaDebito.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.InitializeNewObject
//************************************************************************
procedure TfrmDataNotaDebito.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.ClientCanDeleteObject
//************************************************************************
function TfrmDataNotaDebito.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.BeforeEditObject
//************************************************************************
procedure TfrmDataNotaDebito.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.AfterSaveObject
//************************************************************************
procedure TfrmDataNotaDebito.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.AfterDeleteObject
//************************************************************************
procedure TfrmDataNotaDebito.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataNotaDebito.SortObjects
//************************************************************************
procedure TfrmDataNotaDebito.SortObjects;
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
   // Override para n�o fazer nada, e n�o processar o scroll do mouse (mouse wheel) que altera
   // sem querer o item selecionado de uma ComboBox quando o usu�rio passa o mouse por cima.
   Result:=True;
end;

//$$** SECTION: USERMETHODS_FULLIMPL
//$$** ENDSECTION

initialization
   // Register Data Form Class
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataNotaDebito);

end.
