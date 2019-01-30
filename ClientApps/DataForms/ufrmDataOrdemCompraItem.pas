unit ufrmDataOrdemCompraItem;

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
  
  TfrmDataOrdemCompraItem = class(TP2SBFClientDataForm)
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
    lblQuantidadePositiva: TLabel;
    lblFilme: TLabel;
    lblValorTotal: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtQuantidadePositiva: TMaskEdit;
    cboFilme: TComboBox;
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
    procedure txtQuantidadePositivaChange(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: CUSTOMBUTTONS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: GRIDDRAWCELL_METHODS_DECLARATIONS
//$$** ENDSECTION

  private
    { Private declarations }
    FFlagNew: Boolean;
    FObject: TOrdemCompraItem;
    FNRelInsertedFlag: Boolean;
    FNRelEditedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ARRAYS_LOOKUP_DECLARATIONS
    FArrayLookupIdFilme: TIntegerDynArray;
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES
    FUpdateVar_Quantidade: Integer;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_HANDLERS_DECLARATIONS
   FcboFilmeHandler: TDynamicComboBoxHandler;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS_DECLARATIONS
    procedure LoadItemsComboLookupFilme(AText: string);
    procedure SelectItemComboLookupFilme(AOID: TOID; AForce: Boolean = True);
    procedure UpdateComboLookupFilme;
    procedure SetUpdateVariableComboFilme(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS_DECLARATIONS
    procedure SetUpdateVar_Quantidade(AValue: Integer);
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS_DECLARATIONS
//$$** ENDSECTION

    procedure UpdateObject(AObject: TOrdemCompraItem);
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
    property UpdateVar_Quantidade: Integer read FUpdateVar_Quantidade write SetUpdateVar_Quantidade;
//$$** ENDSECTION

//$$** SECTION: PUBLICDECL_IMPL_USER
//$$** ENDSECTION
  end;

var
  frmDataOrdemCompraItem: TfrmDataOrdemCompraItem;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataOrdemCompraItem.FormCreate
//************************************************************************
procedure TfrmDataOrdemCompraItem.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
   FcboFilmeHandler:=TDynamicComboBoxHandler.Create;
   FcboFilmeHandler.AssignToComboBox(cboFilme);
   FcboFilmeHandler.OnLoadItems:=LoadItemsComboLookupFilme;
   FcboFilmeHandler.OnSelectItem:=SetUpdateVariableComboFilme;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.FormDestroy
//************************************************************************
procedure TfrmDataOrdemCompraItem.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
   FcboFilmeHandler.Free;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.FormActivate
//************************************************************************
procedure TfrmDataOrdemCompraItem.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   // This section is used to automatically maximize the form if needed.
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.FormResize
//************************************************************************
procedure TfrmDataOrdemCompraItem.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.FormKeyDown
//************************************************************************
procedure TfrmDataOrdemCompraItem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.FormKeyPress
//************************************************************************
procedure TfrmDataOrdemCompraItem.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataOrdemCompraItem.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataOrdemCompraItem.scrScrollDataMouseWheel(
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
//* TfrmDataOrdemCompraItem.ControlEnter
//************************************************************************
procedure TfrmDataOrdemCompraItem.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.ControlExit
//************************************************************************
procedure TfrmDataOrdemCompraItem.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataOrdemCompraItem.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION



//************************************************************************
//* TfrmDataOrdemCompraItem.cmdOkClick
//************************************************************************
procedure TfrmDataOrdemCompraItem.cmdOkClick(Sender: TObject);
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
//* TfrmDataOrdemCompraItem.cmdCancelClick
//************************************************************************
procedure TfrmDataOrdemCompraItem.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.UpdateObject
//************************************************************************
procedure TfrmDataOrdemCompraItem.UpdateObject(AObject: TOrdemCompraItem);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   AObject.QuantidadePositiva:=StrToInt(txtQuantidadePositiva.Text);
   if (cboFilme.ItemIndex=-1) or (Length(FArrayLookupIdFilme)<=0) then begin
      AObject.Filme.OIDRef:=NullOID;
   end else begin
      AObject.Filme.OIDRef:=POID(FArrayLookupIdFilme[cboFilme.ItemIndex]);
   end;
   AObject.ValorTotal:=StrToFloat(txtValorTotal.Text);
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.UpdateScreen
//************************************************************************
procedure TfrmDataOrdemCompraItem.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtQuantidadePositiva.Text:=IntToStr(FObject.QuantidadePositiva);
   SelectItemComboLookupFilme(FObject.Filme.OIDRef);
   txtValorTotal.Text:=Format('%.2f',[FObject.ValorTotal]);
//$$** SECTION: UPDATESCREEN_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.ValidateScreen
//************************************************************************
function TfrmDataOrdemCompraItem.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.StandardValidateScreen
//************************************************************************
function TfrmDataOrdemCompraItem.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
//$$** SECTION: VALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: VALIDATESCREEN_BODY
   if Trim(txtQuantidadePositiva.Text)='' then begin
      Application.MessageBox('O campo "Quantidade" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtQuantidadePositiva.CanFocus then txtQuantidadePositiva.SetFocus;
      Result:=False;
      Exit;
   end;
   try
      StrToInt(Trim(txtQuantidadePositiva.Text));
   except
      Application.MessageBox('O valor do campo "Quantidade" é inválido.','Aviso',MB_ICONINFORMATION);
      if txtQuantidadePositiva.CanFocus then txtQuantidadePositiva.SetFocus;
      if txtQuantidadePositiva.CanFocus then txtQuantidadePositiva.SelectAll;
      Result:=False;
      Exit;
   end;
   if (cboFilme.ItemIndex=-1) or (cboFilme.Items.Count=0) then begin
      Application.MessageBox('O campo "Filme" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if cboFilme.CanFocus then cboFilme.SetFocus;
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
      Application.MessageBox('O valor do campo "Valor Total" é inválido.','Aviso',MB_ICONINFORMATION);
      if txtValorTotal.CanFocus then txtValorTotal.SetFocus;
      if txtValorTotal.CanFocus then txtValorTotal.SelectAll;
      Result:=False;
      Exit;
   end;
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.CustomValidateScreen
//************************************************************************
function TfrmDataOrdemCompraItem.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataOrdemCompraItem.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.AfterPrintDoc
//************************************************************************
procedure TfrmDataOrdemCompraItem.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.Open
//************************************************************************
function TfrmDataOrdemCompraItem.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TOrdemCompraItem(AObject);
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

//************************************************************************
//* TfrmDataOrdemCompraItem.LoadItemsComboLookupFilme
//************************************************************************
procedure TfrmDataOrdemCompraItem.LoadItemsComboLookupFilme(AText: string);
var
   DescriptionList: TStringList;
   Criteria: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
//$$** SECTION: LOADITEMSCOMBOLOOKUP_FILME_VAR
//$$** ENDSECTION
begin
   if Trim(AText)='' then begin
      SetLength(FArrayLookupIdFilme,0);
      ClearComboItemsWithoutLosingText(cboFilme);
      Exit;
   end;
   DescriptionList:=TStringList.Create;
   Criteria:=TP2SBFCriteria.Create;
   Criteria.PropName:='Nome';
   Criteria.Operator:=ocoLikes;
   Criteria.PropValue.AsString:=AText+'%';
   CriteriaList:=TP2SBFCriteriaList.Create;
   CriteriaList.Add(Criteria);
//$$** SECTION: LOADITEMSCOMBOLOOKUP_FILME_BEFOREQUERY
//$$** ENDSECTION
   try
      gP2SBFObjRepos.QueryDescriptionsOfPersistentObjects(TFilme,CriteriaList,FArrayLookupIdFilme,DescriptionList,'Nome',True);
      ClearComboItemsWithoutLosingText(cboFilme);
      cboFilme.Items.AddStrings(DescriptionList);
   finally
      CriteriaList.Free;
      Criteria.Free;
//$$** SECTION: LOADITEMSCOMBOLOOKUP_FILME_FINALIZE
//$$** ENDSECTION
      DescriptionList.Free;
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.SelectItemComboLookupFilme
//************************************************************************
procedure TfrmDataOrdemCompraItem.SelectItemComboLookupFilme(AOID: TOID; AForce: Boolean = True);
var
   i: Integer;
   ObjRef: TFilme;
begin
   cboFilme.ItemIndex:=-1;
   for i:=0 to High(FArrayLookupIdFilme) do begin
      if FArrayLookupIdFilme[i] = AOID.ID then begin
         cboFilme.ItemIndex:=i;
         Break;
      end;
   end;
   if (not SameOID(AOID,NullOID)) and (cboFilme.ItemIndex=-1) then begin
      ObjRef:=TFilme.Retrieve(AOID,True) as TFilme;
      cboFilme.Items.Add(ObjRef.Nome);
      cboFilme.ItemIndex:=cboFilme.Items.Count-1;
      SetLength(FArrayLookupIdFilme,High(FArrayLookupIdFilme)+2);
      FArrayLookupIdFilme[High(FArrayLookupIdFilme)]:=ObjRef.OID.ID;
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.UpdateComboLookupFilme
//************************************************************************
procedure TfrmDataOrdemCompraItem.UpdateComboLookupFilme;
begin
   if Trim(cboFilme.Text)<>'' then begin
      Screen.Cursor:=crHourglass;
      LoadItemsComboLookupFilme(cboFilme.Text);
      Screen.Cursor:=crDefault;
   end else begin
      cboFilme.Items.Clear;
      SetLength(FArrayLookupIdFilme,0);
   end;
end;

//************************************************************************
//* TfrmDataOrdemCompraItem.SetUpdateVariableComboFilme
//************************************************************************
procedure TfrmDataOrdemCompraItem.SetUpdateVariableComboFilme(Sender: TObject);
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

//* TfrmDataOrdemCompraItem.txtQuantidadePositivaChange
procedure TfrmDataOrdemCompraItem.txtQuantidadePositivaChange(Sender: TObject);
begin
   UpdateVar_Quantidade:=StrToIntDef(txtQuantidadePositiva.Text,0);
end;
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS

//************************************************************************
//* TfrmDataOrdemCompraItem.SetUpdateVar_Quantidade
//************************************************************************
procedure TfrmDataOrdemCompraItem.SetUpdateVar_Quantidade(AValue: Integer);
var
   AuxStr: string;
   AuxInt: Integer;
begin
   FUpdateVar_Quantidade:=AValue;
end;
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.CanCreateObject
//************************************************************************
function TfrmDataOrdemCompraItem.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.InitializeNewObject
//************************************************************************
procedure TfrmDataOrdemCompraItem.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.ClientCanDeleteObject
//************************************************************************
function TfrmDataOrdemCompraItem.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.BeforeEditObject
//************************************************************************
procedure TfrmDataOrdemCompraItem.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.AfterSaveObject
//************************************************************************
procedure TfrmDataOrdemCompraItem.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.AfterDeleteObject
//************************************************************************
procedure TfrmDataOrdemCompraItem.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataOrdemCompraItem.SortObjects
//************************************************************************
procedure TfrmDataOrdemCompraItem.SortObjects;
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
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataOrdemCompraItem);

end.
