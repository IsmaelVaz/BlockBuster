unit ufrmDataLocacao;

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
  
  TfrmDataLocacao = class(TP2SBFClientDataForm)
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
    tabTab1: TTabSheet;
//$$** ENDSECTION
    splSplitter: TSplitter;
//$$** SECTION: LABELS_DECLARATIONS
    lblNumero: TLabel;
    lblSocio: TLabel;
    lblStatusLocacao: TLabel;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    lblValorTotal: TLabel;
    lblDesconto: TLabel;
    lblAcrescimo: TLabel;
    lblValorFinal: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtNumero: TMaskEdit;
    cboSocio: TComboBox;
    cboStatusLocacao: TComboBox;
    txtDataInicial: TMaskEdit;
    txtDataFinal: TMaskEdit;
    txtValorTotal: TMaskEdit;
    txtDesconto: TMaskEdit;
    txtAcrescimo: TMaskEdit;
    txtValorFinal: TMaskEdit;
    cmdCustomButton1: TBitBtn;
    cmdCustomButton2: TBitBtn;
    cmdCustomButton3: TBitBtn;
//$$** ENDSECTION
    imglstImagens: TImageList;
//$$** SECTION: GRIDS_DECLARATIONS
    tlbToolBar1: TToolBar;
    cmdInsert1: TToolButton;
    cmdDelete1: TToolButton;
    cmdEdit1: TToolButton;
    cmdSeparator1_1: TToolButton;
    cmdList1: TToolButton;
    cmdExportToExcel1: TToolButton;
    grdDataItens: TStringGrid;
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
    procedure cmdInsert1Click(Sender: TObject);
    procedure cmdDelete1Click(Sender: TObject);
    procedure cmdEdit1Click(Sender: TObject);
    procedure cmdList1Click(Sender: TObject);
    procedure cmdExportToExcel1Click(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: COMBOS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: COMPONENTS_METHODS_DECLARATIONS
    procedure txtNumeroChange(Sender: TObject);
    procedure txtValorTotalChange(Sender: TObject);
    procedure txtDescontoChange(Sender: TObject);
    procedure txtAcrescimoChange(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: CUSTOMBUTTONS_METHODS_DECLARATIONS
    procedure cmdCustomButton1Click(Sender: TObject);
    procedure cmdCustomButton2Click(Sender: TObject);
    procedure cmdCustomButton3Click(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: GRIDDRAWCELL_METHODS_DECLARATIONS
    procedure grdDataItensDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//$$** ENDSECTION

  private
    { Private declarations }
    FFlagNew: Boolean;
    FObject: TLocacao;
    FNRelInsertedFlag: Boolean;
    FNRelEditedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
    FArrayPctColWidthsItens: array of Double;
//$$** ENDSECTION

//$$** SECTION: ARRAYS_LOOKUP_DECLARATIONS
    FArrayLookupIdSocio: TIntegerDynArray;
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES
    FUpdateVar_Numero: Integer;
    FUpdateVar_ValorTotal: Double;
    FUpdateVar_Desconto: Double;
    FUpdateVar_Acrescimo: Double;
    FUpdateVar_Itens: TList;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_HANDLERS_DECLARATIONS
   FcboSocioHandler: TDynamicComboBoxHandler;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS_DECLARATIONS
    procedure LoadItemsComboLookupSocio(AText: string);
    procedure SelectItemComboLookupSocio(AOID: TOID; AForce: Boolean = True);
    procedure UpdateComboLookupSocio;
    procedure SetUpdateVariableComboSocio(Sender: TObject);
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS_DECLARATIONS
    procedure SetUpdateVar_Numero(AValue: Integer);
    procedure SetUpdateVar_ValorTotal(AValue: Double);
    procedure SetUpdateVar_Desconto(AValue: Double);
    procedure SetUpdateVar_Acrescimo(AValue: Double);
    procedure SetUpdateVar_Itens;
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS_DECLARATIONS
    function Calculate_ValorTotal: Double;
    function Calculate_ValorFinal: Double;
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS_DECLARATIONS
//$$** ENDSECTION

    procedure UpdateObject(AObject: TLocacao);
    procedure UpdateScreen(AFlagNew: Boolean);
    function ValidateScreen: Boolean;
    function StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
    function CustomValidateScreen: Boolean;
    procedure AfterSendEMailDoc(Sender: TObject);
    procedure AfterPrintDoc(Sender: TObject);

//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_DECLARATION
//$$** ENDSECTION

//$$** SECTION: GRIDS_METHODS_DECLARATIONS
    procedure SetupGridColumnsItens;
    procedure RefreshDataItens(APOIDToSelect: Integer = 0);
    procedure ResizeGridItens;
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
    property UpdateVar_Numero: Integer read FUpdateVar_Numero write SetUpdateVar_Numero;
    property UpdateVar_ValorTotal: Double read FUpdateVar_ValorTotal write SetUpdateVar_ValorTotal;
    property UpdateVar_Desconto: Double read FUpdateVar_Desconto write SetUpdateVar_Desconto;
    property UpdateVar_Acrescimo: Double read FUpdateVar_Acrescimo write SetUpdateVar_Acrescimo;
    property UpdateVar_Itens: TList read FUpdateVar_Itens;
//$$** ENDSECTION

//$$** SECTION: PUBLICDECL_IMPL_USER
//$$** ENDSECTION
  end;

var
  frmDataLocacao: TfrmDataLocacao;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
     , ufrmDataLocacaoItem
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataLocacao.FormCreate
//************************************************************************
procedure TfrmDataLocacao.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
   FUpdateVar_Itens:=TList.Create;
   FcboSocioHandler:=TDynamicComboBoxHandler.Create;
   FcboSocioHandler.AssignToComboBox(cboSocio);
   FcboSocioHandler.OnLoadItems:=LoadItemsComboLookupSocio;
   FcboSocioHandler.OnSelectItem:=SetUpdateVariableComboSocio;
   grdDataItens.DefaultRowHeight:=Max(grdDataItens.DefaultRowHeight,Round(grdDataItens.Canvas.TextHeight('Any text')*1.5));
   SetupGridColumnsItens;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.FormDestroy
//************************************************************************
procedure TfrmDataLocacao.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
   FcboSocioHandler.Free;
   FUpdateVar_Itens.Free;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.FormActivate
//************************************************************************
procedure TfrmDataLocacao.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   WindowState:=wsMaximized;
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.FormResize
//************************************************************************
procedure TfrmDataLocacao.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
   ResizeGridItens;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.FormKeyDown
//************************************************************************
procedure TfrmDataLocacao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.FormKeyPress
//************************************************************************
procedure TfrmDataLocacao.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataLocacao.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataLocacao.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataLocacao.scrScrollDataMouseWheel(
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
//* TfrmDataLocacao.ControlEnter
//************************************************************************
procedure TfrmDataLocacao.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataLocacao.ControlExit
//************************************************************************
procedure TfrmDataLocacao.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataLocacao.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.grdDataItensDrawCell
//************************************************************************
procedure TfrmDataLocacao.grdDataItensDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//$$** SECTION: GRIDDRAWCELL_FULLIMPL_11_26
begin
   //
end;
//$$** ENDSECTION


//************************************************************************
//* TfrmDataLocacao.cmdCustomButton1Click
//************************************************************************
procedure TfrmDataLocacao.cmdCustomButton1Click(Sender: TObject);
//$$** SECTION: CUSTOMBUTTONCLICK_FULLIMPL_1
var
   FSocio: TSocio;
   QuantidadeLocada, i: Integer;
   Item: TLocacaoItem;
   Filme: TFilme;
   FraseFilmeSemQtd: String;
begin
   //
   try
      if (ValidateScreen) then begin
         UpdateObject(FObject);

         FObject.Save(False,False);
         FObject.Refresh;

         FSocio:= TSocio.Retrieve(FObject.Socio.OIDRef) as TSocio;

         if FSocio.TemLocPendente = False then begin
            if FObject.Itens.Count>0 then begin

               FraseFilmeSemQtd:= '';
               QuantidadeLocada:= 0;

               for i:= 0 to FObject.Itens.Count-1 do begin
                  Item:= TLocacaoItem(FObject.Itens.Items[i]);
                  QuantidadeLocada:= Item.QuantidadePositiva;

                  Filme:= TFilme.Retrieve(Item.Filme.OIDRef) as TFilme;

                  if Filme.QuantidadeEstoque < QuantidadeLocada then begin
                     FraseFilmeSemQtd:= FraseFilmeSemQtd+#13
                        + Filme.Nome;
                  end;
               end;

               if FraseFilmeSemQtd='' then begin
                  FObject.StatusLocacao:='A';

                  for i:= 0 to FObject.Itens.Count-1 do begin
                     Item:= TLocacaoItem(FObject.Itens.Items[i]);
                     QuantidadeLocada:= Item.QuantidadePositiva;

                     Filme:= TFilme.Retrieve(Item.Filme.OIDRef) as TFilme;
                     Filme.QuantidadeEstoque:= Filme.QuantidadeEstoque - QuantidadeLocada;
                     Filme.QuantidadeReservada:= Filme.QuantidadeReservada + QuantidadeLocada;
                     Filme.Save(False, False);
                  end;

                  FObject.Save(False, False);
                  FObject.Refresh;

                  Application.MessageBox('Loca��o Aprovada.','Aviso',MB_ICONINFORMATION);

                  UpdateScreen(false);
                  exit;
               end else begin
                  Application.MessageBox(PChar('Os itens abaixo n�o tem quantidade suficiente em estoque.'+FraseFilmeSemQtd),'Aviso',MB_ICONINFORMATION);
                  exit;
               end;
            end else begin
               Application.MessageBox('� preciso ter ao menos um item na Loca��o.','Aviso',MB_ICONINFORMATION);
               exit;
            end;
         end else begin
            Application.MessageBox('O S�cio possu� loca��o pendente'+#13+'Finalize a Loca��o pendente antes de iniciar uma nova.','Aviso',MB_ICONINFORMATION);
            exit;
         end;
      end;
   finally
      {FSocio.Free;
      Item.Free;
      Filme.Free;}
   end;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.cmdCustomButton2Click
//************************************************************************
procedure TfrmDataLocacao.cmdCustomButton2Click(Sender: TObject);
//$$** SECTION: CUSTOMBUTTONCLICK_FULLIMPL_2
var
   Socio: TSocio;
   QuantidadeLocada, i: Integer;
   Item: TLocacaoItem;
   Filme: TFilme;
begin
   //
   if (ValidateScreen) then begin
      if (FObject.StatusLocacao = 'A') then begin
         FObject.StatusLocacao:= 'L';

         Socio:= TSocio.Retrieve(FObject.Socio.OIDRef) as TSocio;
         Socio.TemLocPendente:= True;
         Socio.Save(False, False);

         for i:= 0 to FObject.Itens.Count-1 do begin
            Item:= TLocacaoItem(FObject.Itens.Items[i]);
            QuantidadeLocada:= Item.QuantidadePositiva;

            Filme:= TFilme.Retrieve(Item.Filme.OIDRef) as TFilme;

            Filme.QuantidadeReservada:= Filme.QuantidadeReservada - QuantidadeLocada;
            Filme.QuantidadeLocacao:= Filme.QuantidadeLocacao + QuantidadeLocada;

            Filme.Save(False, False);
         end;

         FObject.Save(False, False);
         FObject.Refresh;

         Application.MessageBox('Loca��o iniciada.','Aviso',MB_ICONINFORMATION);
         UpdateScreen(false);
         exit;
      end else begin
         Application.MessageBox('� preciso aprovar a Ficha antes de iniciar a Loca��o','Aviso',MB_ICONINFORMATION);
         exit;
      end;
   end;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.cmdCustomButton3Click
//************************************************************************
procedure TfrmDataLocacao.cmdCustomButton3Click(Sender: TObject);
//$$** SECTION: CUSTOMBUTTONCLICK_FULLIMPL_3
var
   FSocio: TSocio;
   QuantidadeLocada, i: Integer;
   Item: TLocacaoItem;
   Filme: TFilme;
begin
   //
   if (ValidateScreen) then begin
      if (FObject.StatusLocacao = 'L') then begin
         FObject.StatusLocacao:= 'F';
         FSocio:= TSocio.Retrieve(FObject.Socio.OIDRef) as TSocio;

         FSocio.TemLocPendente:= False;
         FSocio.Save(False, False);

         for i:= 0 to FObject.Itens.Count-1 do begin
            Item:= TLocacaoItem(FObject.Itens.Items[i]);
            QuantidadeLocada:= Item.QuantidadePositiva;

            Filme:= TFilme.Retrieve(Item.Filme.OIDRef) as TFilme;


            Filme.QuantidadeLocacao:= Filme.QuantidadeLocacao - QuantidadeLocada;
            Filme.QuantidadeEstoque:= Filme.QuantidadeEstoque + QuantidadeLocada;

            Filme.Save(False, False);
         end;

         FObject.Save(False, False);
         FObject.Refresh;

         Application.MessageBox('Loca��o Finalizada.','Aviso',MB_ICONINFORMATION);
         UpdateScreen(False);
         exit;
      end else begin
         Application.MessageBox('A ficha n�o est� em loca��o','Aviso',MB_ICONINFORMATION);
         exit;
      end;
   end;
end;
//$$** ENDSECTION


//************************************************************************
//* TfrmDataLocacao.cmdOkClick
//************************************************************************
procedure TfrmDataLocacao.cmdOkClick(Sender: TObject);
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
//* TfrmDataLocacao.cmdCancelClick
//************************************************************************
procedure TfrmDataLocacao.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataLocacao.UpdateObject
//************************************************************************
procedure TfrmDataLocacao.UpdateObject(AObject: TLocacao);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   AObject.Numero:=StrToInt(txtNumero.Text);
   if (cboSocio.ItemIndex=-1) or (Length(FArrayLookupIdSocio)<=0) then begin
      AObject.Socio.OIDRef:=NullOID;
   end else begin
      AObject.Socio.OIDRef:=POID(FArrayLookupIdSocio[cboSocio.ItemIndex]);
   end;
   if cboStatusLocacao.ItemIndex=0 then begin
      AObject.StatusLocacao:='P';
   end else if cboStatusLocacao.ItemIndex=1 then begin
      AObject.StatusLocacao:='A';
   end else if cboStatusLocacao.ItemIndex=2 then begin
      AObject.StatusLocacao:='L';
   end else if cboStatusLocacao.ItemIndex=3 then begin
      AObject.StatusLocacao:='F';
   end else begin
      AObject.StatusLocacao:='';
   end;
   if txtDataInicial.Text<>'  /  /    ' then begin
      AObject.DataInicial:=StrToDate(txtDataInicial.Text);
   end else begin
      AObject.DataInicial:=0;
   end;
   if txtDataFinal.Text<>'  /  /    ' then begin
      AObject.DataFinal:=StrToDate(txtDataFinal.Text);
   end else begin
      AObject.DataFinal:=0;
   end;
   AObject.ValorTotal:=StrToFloat(txtValorTotal.Text);
   AObject.Desconto:=StrToFloat(txtDesconto.Text);
   AObject.Acrescimo:=StrToFloat(txtAcrescimo.Text);
   AObject.ValorFinal:=StrToFloat(txtValorFinal.Text);
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.UpdateScreen
//************************************************************************
procedure TfrmDataLocacao.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtNumero.Text:=IntToStr(FObject.Numero);
   SelectItemComboLookupSocio(FObject.Socio.OIDRef);
   if FObject.StatusLocacao='P' then begin
      cboStatusLocacao.ItemIndex:=0;
   end else if FObject.StatusLocacao='A' then begin
      cboStatusLocacao.ItemIndex:=1;
   end else if FObject.StatusLocacao='L' then begin
      cboStatusLocacao.ItemIndex:=2;
   end else if FObject.StatusLocacao='F' then begin
      cboStatusLocacao.ItemIndex:=3;
   end else begin
      cboStatusLocacao.ItemIndex:=-1;
   end;
   if FObject.DataInicial<>0 then begin
      txtDataInicial.Text:=FormatDateTime('dd/mm/yyyy',FObject.DataInicial);
   end else begin
      txtDataInicial.Text:='  /  /    ';
   end;
   if FObject.DataFinal<>0 then begin
      txtDataFinal.Text:=FormatDateTime('dd/mm/yyyy',FObject.DataFinal);
   end else begin
      txtDataFinal.Text:='  /  /    ';
   end;
   txtValorTotal.Text:=Format('%.2f',[FObject.ValorTotal]);
   txtDesconto.Text:=Format('%.2f',[FObject.Desconto]);
   txtAcrescimo.Text:=Format('%.2f',[FObject.Acrescimo]);
   txtValorFinal.Text:=Format('%.2f',[FObject.ValorFinal]);
   RefreshDataItens;
   ResizeGridItens;
//$$** SECTION: UPDATESCREEN_USER
   //Se estiver em loca��o, desativa bot�o de Aprovar e o de Iniciar a Loca��o
   if FObject.StatusLocacao = 'L' then
   begin
      cmdCustomButton1.Enabled:= False;
      cmdCustomButton2.Enabled:= False;
      cmdCustomButton3.Enabled:= True;

      txtDataInicial.Enabled:= False;
      txtDataFinal.Enabled:= False;

      tlbToolBar1.Enabled:= False;
      grdDataItens.Enabled:= False;
   end;

   //Se estiver Aprovado, desativa bot�o de Aprovar e o de Finalizar a Loca��o
   if FObject.StatusLocacao = 'A' then
   begin
      cmdCustomButton1.Enabled:= False;
      cmdCustomButton2.Enabled:= True;
      cmdCustomButton3.Enabled:= False;

      txtDataInicial.Enabled:= True;
      txtDataFinal.Enabled:= True;

      tlbToolBar1.Enabled:= True;
      grdDataItens.Enabled:= True;
   end;

   //Se estiver Finalizado, desativa bot�o de Aprovar, Iniciar e Finalizar a Loca��o
   if FObject.StatusLocacao = 'F' then
   begin
      cmdCustomButton1.Enabled:= False;
      cmdCustomButton2.Enabled:= False;
      cmdCustomButton3.Enabled:= False;

      txtDataInicial.Enabled:= False;
      txtDataFinal.Enabled:= False;

      tlbToolBar1.Enabled:= False;
      grdDataItens.Enabled:= False;
   end;

   //Se estiver Em Prepara��o, desativa bot�o de Iniciar e Finalizar a Loca��o
   if FObject.StatusLocacao = 'P' then
   begin
      cmdCustomButton1.Enabled:= True;
      cmdCustomButton2.Enabled:= False;
      cmdCustomButton3.Enabled:= False;

      txtDataInicial.Enabled:= True;
      txtDataFinal.Enabled:= True;

      tlbToolBar1.Enabled:= True;
      grdDataItens.Enabled:= True;
   end;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.ValidateScreen
//************************************************************************
function TfrmDataLocacao.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.StandardValidateScreen
//************************************************************************
function TfrmDataLocacao.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
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
   if (cboSocio.ItemIndex=-1) or (cboSocio.Items.Count=0) then begin
      Application.MessageBox('O campo "S�cio" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if cboSocio.CanFocus then cboSocio.SetFocus;
      Result:=False;
      Exit;
   end;
   if cboStatusLocacao.ItemIndex=-1 then begin
      Application.MessageBox('O campo "Status" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if cboStatusLocacao.CanFocus then cboStatusLocacao.SetFocus;
      Result:=False;
      Exit;
   end;
   if txtDataInicial.Text<>'  /  /    ' then begin
      try
         StrToDate(txtDataInicial.Text);
      except
         Application.MessageBox('O valor do campo "Data Inicial" � inv�lido.','Aviso',MB_ICONINFORMATION);
         if txtDataInicial.CanFocus then txtDataInicial.SetFocus;
         if txtDataInicial.CanFocus then txtDataInicial.SelectAll;
         Result:=False;
         Exit;
      end;
   end;
   if txtDataFinal.Text='  /  /    ' then begin
      Application.MessageBox('O campo "DataFinal" deve ser preenchido.','Aviso',MB_ICONINFORMATION);
      if txtDataFinal.CanFocus then txtDataFinal.SetFocus;
      Result:=False;
      Exit;
   end;
   if txtDataFinal.Text<>'  /  /    ' then begin
      try
         StrToDate(txtDataFinal.Text);
      except
         Application.MessageBox('O valor do campo "DataFinal" � inv�lido.','Aviso',MB_ICONINFORMATION);
         if txtDataFinal.CanFocus then txtDataFinal.SetFocus;
         if txtDataFinal.CanFocus then txtDataFinal.SelectAll;
         Result:=False;
         Exit;
      end;
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
   try
      StrToFloat(Trim(txtDesconto.Text));
   except
      Application.MessageBox('O valor do campo "Desconto" � inv�lido.','Aviso',MB_ICONINFORMATION);
      if txtDesconto.CanFocus then txtDesconto.SetFocus;
      if txtDesconto.CanFocus then txtDesconto.SelectAll;
      Result:=False;
      Exit;
   end;
   try
      StrToFloat(Trim(txtAcrescimo.Text));
   except
      Application.MessageBox('O valor do campo "Acr�scimo" � inv�lido.','Aviso',MB_ICONINFORMATION);
      if txtAcrescimo.CanFocus then txtAcrescimo.SetFocus;
      if txtAcrescimo.CanFocus then txtAcrescimo.SelectAll;
      Result:=False;
      Exit;
   end;
   try
      StrToFloat(Trim(txtValorFinal.Text));
   except
      Application.MessageBox('O valor do campo "Valor Final" � inv�lido.','Aviso',MB_ICONINFORMATION);
      if txtValorFinal.CanFocus then txtValorFinal.SetFocus;
      if txtValorFinal.CanFocus then txtValorFinal.SelectAll;
      Result:=False;
      Exit;
   end;
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataLocacao.CustomValidateScreen
//************************************************************************
function TfrmDataLocacao.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
var
   FDataInicialCompare, FDataFinalCompare: TDate;
   FValorCompare: Double;
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
   try
      StrToDate(txtDataInicial.Text);
      FDataInicialCompare:= StrToDate(txtDataInicial.Text);
      FDataFinalCompare:= StrToDate(txtDataFinal.Text);
      if FDataInicialCompare >  FDataFinalCompare then
      begin
         Application.MessageBox('A Data Final n�o pode ser menor que a Data Inicial.','Aviso',MB_ICONINFORMATION);
         if txtDataFinal.CanFocus then txtDataFinal.SetFocus;
         if txtDataFinal.CanFocus then txtDataFinal.SelectAll;
         Result:=False;
         Exit;
      end;
   except
      Result:=False;
      Exit;
   end;

   try
      FValorCompare:= StrToFloat(Trim(txtValorFinal.Text));
      if FValorCompare <= 0 then
      begin
         Application.MessageBox('O valor do campo "Valor Final" deve ser maior que 0.','Aviso',MB_ICONINFORMATION);
         if txtValorFinal.CanFocus then txtValorFinal.SetFocus;
         if txtValorFinal.CanFocus then txtValorFinal.SelectAll;
         Result:=False;
         Exit;
      end;
   except
      Application.MessageBox('O valor do campo "Valor Final" � inv�lido.','Aviso',MB_ICONINFORMATION);
      if txtValorFinal.CanFocus then txtValorFinal.SetFocus;
      if txtValorFinal.CanFocus then txtValorFinal.SelectAll;
      Result:=False;
      Exit;
   end;

//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataLocacao.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataLocacao.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.AfterPrintDoc
//************************************************************************
procedure TfrmDataLocacao.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.Open
//************************************************************************
function TfrmDataLocacao.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
   NewObjectLog: TLog;
   Socio: TSocio;
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TLocacao(AObject);
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
         Socio:= TSocio.Retrieve(FObject.Socio.OIDRef) as TSocio;
         NewObjectLog:= TLog.Create();

         NewObjectLog.DataLog:= Date();
         NewObjectLog.HoraLog:= Time();

         if AFlagNew then begin
            NewObjectLog.Acao:='CR';
         end else begin
             NewObjectLog.Acao:='U';
         end;

         NewObjectLog.Referencia:= 'Numero: '+IntToStr(FObject.Numero)+#13+' Socio: '+Socio.NomeExibicao;
         NewObjectLog.Tela:= 'L';
         NewObjectLog.OidObject:= FObject.OID.ID;
         NewObjectLog.Save(false, false);
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

//************************************************************************
//* TfrmDataLocacao.SetupGridColumnsItens
//************************************************************************
procedure TfrmDataLocacao.SetupGridColumnsItens;
begin
   grdDataItens.ColCount:=3;
   grdDataItens.Cells[0,0]:='Quantidade';
   grdDataItens.Cells[1,0]:='Filme';
   grdDataItens.Cells[2,0]:='Valor Total';
   SetLength(FArrayPctColWidthsItens,3);
   FArrayPctColWidthsItens[0]:=10;    // Quantidade
   FArrayPctColWidthsItens[1]:=30;    // Filme
   FArrayPctColWidthsItens[2]:=30;    // Valor Total
end;

//************************************************************************
//* TfrmDataLocacao.RefreshDataItens
//************************************************************************
procedure TfrmDataLocacao.RefreshDataItens(APOIDToSelect: Integer = 0);
var
   i: Integer;
   OIDArrayToLoad: TOIDArray;
//$$** SECTION: REFRESHDATA_11_26_VAR_USER
//$$** ENDSECTION

   procedure _AddOIDToLoad(AOID: TOID);
   var
      i: Integer;
      Found: Boolean;
   begin
      Found:=False;
      for i:=0 to High(OIDArrayToLoad) do begin
         if SameOID(OIDArrayToLoad[i],AOID) then begin
            Found:=True;
            Break;
         end;
      end;
      if not Found then begin
         SetLength(OIDArrayToLoad,Length(OIDArrayToLoad)+1);
         OIDArrayToLoad[High(OIDArrayToLoad)]:=AOID;
      end;
   end;
begin
//$$** SECTION: REFRESHDATA_11_26_INITIALIZE
//$$** ENDSECTION
   if FObject.Itens.Count=0 then begin
      grdDataItens.RowCount:=2;
      for i:=0 to grdDataItens.ColCount-1 do begin
         grdDataItens.Cells[i,1]:=''
      end;
   end else begin
      SetLength(OIDArrayToLoad,0);
      for i:=0 to FObject.Itens.Count-1 do begin
         if TLocacaoItem(FObject.Itens.Items[i]).Filme.OIDRef.ID<>0 then begin
            _AddOIDToLoad(TLocacaoItem(FObject.Itens.Items[i]).Filme.OIDRef);
         end;
      end;
      gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,False,False);
      grdDataItens.RowCount:=FObject.Itens.Count+1;
      for i:=0 to FObject.Itens.Count-1 do begin
         grdDataItens.Cells[0,i+1]:=IntToStr(TLocacaoItem(FObject.Itens.Items[i]).QuantidadePositiva);
         if TLocacaoItem(FObject.Itens.Items[i]).Filme.OIDRef.ID<>0 then begin
            grdDataItens.Cells[1,i+1]:=TFilme(TFilme.Retrieve(TLocacaoItem(FObject.Itens.Items[i]).Filme.OIDRef)).Nome;
         end else begin
            grdDataItens.Cells[1,i+1]:='';
         end;
         grdDataItens.Cells[2,i+1]:=Format('%.2n',[TLocacaoItem(FObject.Itens.Items[i]).ValorTotal]);
         // Auto Select row if necessary
         if TLocacaoItem(FObject.Itens.Items[i]).OID.ID = APOIDToSelect then begin
            grdDataItens.Row:=i+1;
         end;
      end;
   end;
//$$** SECTION: REFRESHDATA_11_26_FINALIZE
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataLocacao.ResizeGridItens
//************************************************************************
procedure TfrmDataLocacao.ResizeGridItens;
var
   i: Integer;
begin
   for i:=0 to High(FArrayPctColWidthsItens) do begin
      grdDataItens.ColWidths[i]:=Round(grdDataItens.ClientWidth*(FArrayPctColWidthsItens[i]/100));
   end;
end;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS

//************************************************************************
//* TfrmDataLocacao.LoadItemsComboLookupSocio
//************************************************************************
procedure TfrmDataLocacao.LoadItemsComboLookupSocio(AText: string);
var
   DescriptionList: TStringList;
   Criteria: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
//$$** SECTION: LOADITEMSCOMBOLOOKUP_SOCIO_VAR
//$$** ENDSECTION
begin
   if Trim(AText)='' then begin
      SetLength(FArrayLookupIdSocio,0);
      ClearComboItemsWithoutLosingText(cboSocio);
      Exit;
   end;
   DescriptionList:=TStringList.Create;
   Criteria:=TP2SBFCriteria.Create;
   Criteria.PropName:='NomeExibicao';
   Criteria.Operator:=ocoLikes;
   Criteria.PropValue.AsString:=AText+'%';
   CriteriaList:=TP2SBFCriteriaList.Create;
   CriteriaList.Add(Criteria);
//$$** SECTION: LOADITEMSCOMBOLOOKUP_SOCIO_BEFOREQUERY
//$$** ENDSECTION
   try
      gP2SBFObjRepos.QueryDescriptionsOfPersistentObjects(TSocio,CriteriaList,FArrayLookupIdSocio,DescriptionList,'NomeExibicao',True);
      ClearComboItemsWithoutLosingText(cboSocio);
      cboSocio.Items.AddStrings(DescriptionList);
   finally
      CriteriaList.Free;
      Criteria.Free;
//$$** SECTION: LOADITEMSCOMBOLOOKUP_SOCIO_FINALIZE
//$$** ENDSECTION
      DescriptionList.Free;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.SelectItemComboLookupSocio
//************************************************************************
procedure TfrmDataLocacao.SelectItemComboLookupSocio(AOID: TOID; AForce: Boolean = True);
var
   i: Integer;
   ObjRef: TSocio;
begin
   cboSocio.ItemIndex:=-1;
   for i:=0 to High(FArrayLookupIdSocio) do begin
      if FArrayLookupIdSocio[i] = AOID.ID then begin
         cboSocio.ItemIndex:=i;
         Break;
      end;
   end;
   if (not SameOID(AOID,NullOID)) and (cboSocio.ItemIndex=-1) then begin
      ObjRef:=TSocio.Retrieve(AOID,True) as TSocio;
      cboSocio.Items.Add(ObjRef.NomeExibicao);
      cboSocio.ItemIndex:=cboSocio.Items.Count-1;
      SetLength(FArrayLookupIdSocio,High(FArrayLookupIdSocio)+2);
      FArrayLookupIdSocio[High(FArrayLookupIdSocio)]:=ObjRef.OID.ID;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.UpdateComboLookupSocio
//************************************************************************
procedure TfrmDataLocacao.UpdateComboLookupSocio;
begin
   if Trim(cboSocio.Text)<>'' then begin
      Screen.Cursor:=crHourglass;
      LoadItemsComboLookupSocio(cboSocio.Text);
      Screen.Cursor:=crDefault;
   end else begin
      cboSocio.Items.Clear;
      SetLength(FArrayLookupIdSocio,0);
   end;
end;

//************************************************************************
//* TfrmDataLocacao.SetUpdateVariableComboSocio
//************************************************************************
procedure TfrmDataLocacao.SetUpdateVariableComboSocio(Sender: TObject);
begin
   // No update variable
end;
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS
//$$** ENDSECTION

//$$** SECTION: IMAGES_POPUPS_METHODS
//$$** ENDSECTION

//$$** SECTION: BUTTONS_METHODS

//************************************************************************
//* TfrmDataLocacao.cmdInsert1Click
//************************************************************************
procedure TfrmDataLocacao.cmdInsert1Click(Sender: TObject);
var
   NewObject: TLocacaoItem;
   DataForm: TfrmDataLocacaoItem;
begin
   if not CanCreateObject(TLocacaoItem) then Exit;
   if FFlagNew then begin
      if StandardValidateScreen then begin
         Screen.Cursor:=crHourglass;
         if FObject.CanUpdate then begin
            UpdateObject(FObject);
            FObject.Save(False,False);
            FObject.Refresh;
            SortObjects;
            FFlagNew:=False;
         end;
      end else begin
         Exit;
      end;
   end;
   Screen.Cursor:=crHourglass;
   NewObject:=TLocacaoItem.Create;
   InitializeNewObject(NewObject);
   Application.CreateForm(TfrmDataLocacaoItem,DataForm);
   try
      Screen.Cursor:=crDefault;
      if DataForm.Open(NewObject,True) then begin
         Screen.Cursor:=crHourglass;
         // Add object
         FObject.Itens.SavePersistentItemReference(NewObject);
         FObject.Itens.Add(NewObject);
         FNRelInsertedFlag:=True;
         // Update variable
         SetUpdateVar_Itens;
         AfterSaveObject(NewObject);
         SortObjects;
         // Refresh
         RefreshDataItens(NewObject.OID.ID);
         ResizeGridItens;
         Screen.Cursor:=crDefault;
      end else begin
         NewObject.Delete;
         SortObjects;
      end;
   finally
      DataForm.Free;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.cmdDelete1Click
//************************************************************************
procedure TfrmDataLocacao.cmdDelete1Click(Sender: TObject);
var
   CanDelete: Boolean;
   Reason: string;
   ObjectToDelete: TLocacaoItem;
   ObjectClass: TP2SBFAbsPerBizClass;
begin
   if FObject.Itens.Count>0 then begin
      Screen.Cursor:=crHourglass;
      ObjectToDelete:=TLocacaoItem.Retrieve(FObject.Itens.Items[grdDataItens.Row-1].OID,False) as TLocacaoItem;
      Reason:='';
      if not ClientCanDeleteObject(ObjectToDelete,Reason) then begin
         Screen.Cursor:=crDefault;
         Application.MessageBox(PChar('O registro selecionado n�o pode ser exclu�do pela seguinte raz�o:'+#13#10+Reason),'Seguran�a',MB_ICONEXCLAMATION);
         Exit;
      end;
      Reason:='';
      try
         CanDelete:=ObjectToDelete.CanDelete(Reason);
      except
         Screen.Cursor:=crDefault;
         Application.MessageBox(PChar('O registro selecionado n�o foi encontrado.'+#13#10+'Verifique se ele n�o foi exclu�do por outro usu�rio na rede.'+#13#10+'Clique no bot�o "Atualizar" para recarregar os dados.'),'Erro',MB_ICONEXCLAMATION);
         Exit;
      end;
      Screen.Cursor:=crDefault;
      if not CanDelete then begin
         Application.MessageBox(PChar('O registro selecionado n�o pode ser exclu�do pela seguinte raz�o:'+#13#10+Reason),'Seguran�a',MB_ICONEXCLAMATION);
         Exit;
      end;
      if Application.MessageBox('Confirma a exclus�o do registro selecionado?','Confirma��o',MB_ICONQUESTION+MB_OKCANCEL)=IDOK then begin
         // Delete object
         Screen.Cursor:=crHourglass;
         ObjectClass:=TP2SBFAbsPerBizClass(ObjectToDelete.ClassType);
         FObject.Itens.DeletePersistentItemReference(ObjectToDelete);
         FObject.Itens.Remove(ObjectToDelete);
         ObjectToDelete.Delete;
         FNRelDeletedFlag:=True;
         SetUpdateVar_Itens;
         RefreshDataItens;
         ResizeGridItens;
         AfterDeleteObject(ObjectClass);
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.cmdEdit1Click
//************************************************************************
procedure TfrmDataLocacao.cmdEdit1Click(Sender: TObject);
var
   ObjectToEdit: TLocacaoItem;
   DataForm: TfrmDataLocacaoItem;
begin
   if (cmdEdit1.Visible) and (cmdEdit1.Enabled) then begin
      if FObject.Itens.Count>0 then begin
         // Retrieve object
         Screen.Cursor:=crHourglass;
         //FObject.Itens.Items[grdDataItens.Row-1].Refresh;
         ObjectToEdit:=TLocacaoItem(FObject.Itens.Items[grdDataItens.Row-1]);
         try
            ObjectToEdit.Refresh;
         except
            Screen.Cursor:=crDefault;
            Application.MessageBox(PChar('O registro selecionado n�o foi encontrado.'+#13#10+'Verifique se ele n�o foi exclu�do por outro usu�rio na rede.'+#13#10+'Clique no bot�o "Atualizar" para recarregar os dados.'),'Erro',MB_ICONEXCLAMATION);
            Exit;
         end;
         BeforeEditObject(ObjectToEdit);
         // Create data form
         Application.CreateForm(TfrmDataLocacaoItem,DataForm);
         try
            Screen.Cursor:=crDefault;
            // Show data form
            if DataForm.Open(ObjectToEdit,False) then begin
               FNRelEditedFlag:=True;
               // Update variable
               SetUpdateVar_Itens;
               Screen.Cursor:=crHourglass;
               AfterSaveObject(ObjectToEdit);
               SortObjects;
               // Refresh
               RefreshDataItens(ObjectToEdit.OID.ID);
               ResizeGridItens;
               Screen.Cursor:=crDefault;
            end else begin
               SortObjects;
            end;
         finally
            DataForm.Free;
         end;
      end;
   end;
end;

//************************************************************************
//* TfrmDataLocacao.cmdList1Click
//************************************************************************
procedure TfrmDataLocacao.cmdList1Click(Sender: TObject);
var
   ReportGenerator: TClientReportGenerator;
begin
   // Create report generator
   ReportGenerator:=TClientReportGenerator.Create;
   // Show report
   ReportGenerator.GenerateReportFromGrid(grdDataItens,tabTab1.Caption,'',[],[],[],[]);
   // Free mem
   ReportGenerator.Free;
end;

//************************************************************************
//* TfrmDataLocacao.cmdExportToExcel1Click
//************************************************************************
procedure TfrmDataLocacao.cmdExportToExcel1Click(Sender: TObject);
var
   ReportGenerator: TClientReportGenerator;
begin
   // Create report generator
   ReportGenerator:=TClientReportGenerator.Create;
   try
      // Export to Excel
      ReportGenerator.ExportGridToExcel(grdDataItens,tabTab1.Caption,'');
   finally
      // Free mem
      ReportGenerator.Free;
   end;
end;
//$$** ENDSECTION

//$$** SECTION: COMBOS_METHODS
//$$** ENDSECTION

//$$** SECTION: COMPONENTS_METHODS

//* TfrmDataLocacao.txtNumeroChange
procedure TfrmDataLocacao.txtNumeroChange(Sender: TObject);
begin
   UpdateVar_Numero:=StrToIntDef(txtNumero.Text,0);
end;

//* TfrmDataLocacao.txtValorTotalChange
procedure TfrmDataLocacao.txtValorTotalChange(Sender: TObject);
begin
   UpdateVar_ValorTotal:=StrToFloatDef(txtValorTotal.Text,0.0);
end;

//* TfrmDataLocacao.txtDescontoChange
procedure TfrmDataLocacao.txtDescontoChange(Sender: TObject);
begin
   UpdateVar_Desconto:=StrToFloatDef(txtDesconto.Text,0.0);
end;

//* TfrmDataLocacao.txtAcrescimoChange
procedure TfrmDataLocacao.txtAcrescimoChange(Sender: TObject);
begin
   UpdateVar_Acrescimo:=StrToFloatDef(txtAcrescimo.Text,0.0);
end;
//$$** ENDSECTION

//$$** SECTION: UPDATE_VARIABLES_METHODS

//************************************************************************
//* TfrmDataLocacao.SetUpdateVar_Numero
//************************************************************************
procedure TfrmDataLocacao.SetUpdateVar_Numero(AValue: Integer);
var
   AuxStr: string;
   AuxInt: Integer;
begin
   FUpdateVar_Numero:=AValue;
end;

//************************************************************************
//* TfrmDataLocacao.SetUpdateVar_ValorTotal
//************************************************************************
procedure TfrmDataLocacao.SetUpdateVar_ValorTotal(AValue: Double);
var
   AuxStr: string;
   AuxInt: Integer;
begin
   FUpdateVar_ValorTotal:=AValue;
   txtValorFinal.Text:=Format('%.2f',[Calculate_ValorFinal]);
end;

//************************************************************************
//* TfrmDataLocacao.SetUpdateVar_Desconto
//************************************************************************
procedure TfrmDataLocacao.SetUpdateVar_Desconto(AValue: Double);
var
   AuxStr: string;
   AuxInt: Integer;
begin
   FUpdateVar_Desconto:=AValue;
   txtValorFinal.Text:=Format('%.2f',[Calculate_ValorFinal]);
end;

//************************************************************************
//* TfrmDataLocacao.SetUpdateVar_Acrescimo
//************************************************************************
procedure TfrmDataLocacao.SetUpdateVar_Acrescimo(AValue: Double);
var
   AuxStr: string;
   AuxInt: Integer;
begin
   FUpdateVar_Acrescimo:=AValue;
   txtValorFinal.Text:=Format('%.2f',[Calculate_ValorFinal]);
end;

//************************************************************************
//* TfrmDataLocacao.SetUpdateVar_Itens
//************************************************************************
procedure TfrmDataLocacao.SetUpdateVar_Itens;
var
   i: Integer;
   AuxStr: string;
   AuxInt: Integer;
begin
   FUpdateVar_Itens.Clear;
   for i:=0 to FObject.Itens.Count-1 do begin
      FUpdateVar_Itens.Add(TP2SBFAbsBizObj(FObject.Itens.Items[i]));
   end;
   txtValorTotal.Text:=Format('%.2f',[Calculate_ValorTotal]);
end;
//$$** ENDSECTION

//$$** SECTION: CALCULATE_METHODS

//************************************************************************
//* TfrmDataLocacao.Calculate_ValorTotal
//************************************************************************
function TfrmDataLocacao.Calculate_ValorTotal: Double;
var
   i: Integer;
   Item: TLocacaoItem;
begin
   Result:=0.0;
   for i:=0 to FObject.Itens.Count-1 do begin
      Item:=TLocacaoItem(FObject.Itens.Items[i]);
      Result:=RoundTo(Result+Item.ValorTotal,-2);
   end;
end;

//************************************************************************
//* TfrmDataLocacao.Calculate_ValorFinal
//************************************************************************
function TfrmDataLocacao.Calculate_ValorFinal: Double;
begin
   Result:= RoundTo(UpdateVar_ValorTotal+
      UpdateVar_Acrescimo-UpdateVar_Desconto, -2);
end;
//$$** ENDSECTION

//$$** SECTION: ENABLEDCONDITION_METHODS
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.CanCreateObject
//************************************************************************
function TfrmDataLocacao.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.InitializeNewObject
//************************************************************************
procedure TfrmDataLocacao.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.ClientCanDeleteObject
//************************************************************************
function TfrmDataLocacao.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.BeforeEditObject
//************************************************************************
procedure TfrmDataLocacao.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.AfterSaveObject
//************************************************************************
procedure TfrmDataLocacao.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.AfterDeleteObject
//************************************************************************
procedure TfrmDataLocacao.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataLocacao.SortObjects
//************************************************************************
procedure TfrmDataLocacao.SortObjects;
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
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataLocacao);

end.
