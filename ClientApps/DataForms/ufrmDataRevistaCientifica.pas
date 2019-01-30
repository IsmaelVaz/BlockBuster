unit ufrmDataRevistaCientifica;

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
  
  TfrmDataRevistaCientifica = class(TP2SBFClientDataForm)
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
    lblTitulo: TLabel;
    lblPeriodicidade: TLabel;
//$$** SECTION: CONTROLS_DECLARATIONS
    txtTitulo: TMaskEdit;
    cboPeriodicidade: TComboBox;
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
    grdDataEdicoes: TStringGrid;
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
//$$** ENDSECTION

//$$** SECTION: CUSTOMBUTTONS_METHODS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: GRIDDRAWCELL_METHODS_DECLARATIONS
    procedure grdDataEdicoesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//$$** ENDSECTION

  private
    { Private declarations }
    FFlagNew: Boolean;
    FObject: TRevistaCientifica;
    FNRelInsertedFlag: Boolean;
    FNRelEditedFlag: Boolean;
    FNRelDeletedFlag: Boolean;
//$$** SECTION: ARRAYS_COLWIDTHS_DECLARATIONS
    FArrayPctColWidthsEdicoes: array of Double;
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

    procedure UpdateObject(AObject: TRevistaCientifica);
    procedure UpdateScreen(AFlagNew: Boolean);
    function ValidateScreen: Boolean;
    function StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
    function CustomValidateScreen: Boolean;
    procedure AfterSendEMailDoc(Sender: TObject);
    procedure AfterPrintDoc(Sender: TObject);

//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_DECLARATION
//$$** ENDSECTION

//$$** SECTION: GRIDS_METHODS_DECLARATIONS
    procedure SetupGridColumnsEdicoes;
    procedure RefreshDataEdicoes(APOIDToSelect: Integer = 0);
    procedure ResizeGridEdicoes;
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
  frmDataRevistaCientifica: TfrmDataRevistaCientifica;

implementation

{$R *.dfm}

//$$** SECTION: IMPLEMENTATION_USES
uses uP2SBFObjReposClient, uP2SBFParams,
     uClientGeneralReports
     , ufrmDataEdicao
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

//************************************************************************
//* TfrmDataRevistaCientifica.FormCreate
//************************************************************************
procedure TfrmDataRevistaCientifica.FormCreate(Sender: TObject);
begin
//$$** SECTION: FORMCREATE_BODY
   grdDataEdicoes.DefaultRowHeight:=Max(grdDataEdicoes.DefaultRowHeight,Round(grdDataEdicoes.Canvas.TextHeight('Any text')*1.5));
   SetupGridColumnsEdicoes;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.FormDestroy
//************************************************************************
procedure TfrmDataRevistaCientifica.FormDestroy(Sender: TObject);
begin
//$$** SECTION: FORMDESTROY_BODY
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.FormActivate
//************************************************************************
procedure TfrmDataRevistaCientifica.FormActivate(Sender: TObject);
begin
//$$** SECTION: FORMACTIVATE_BODY
   // This section is used to automatically maximize the form if needed.
   Repaint;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.FormResize
//************************************************************************
procedure TfrmDataRevistaCientifica.FormResize(Sender: TObject);
begin
//$$** SECTION: FORMRESIZE_BODY
   ResizeGridEdicoes;
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.FormKeyDown
//************************************************************************
procedure TfrmDataRevistaCientifica.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//$$** SECTION: FORMKEYDOWN_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.FormKeyPress
//************************************************************************
procedure TfrmDataRevistaCientifica.FormKeyPress(Sender: TObject; var Key: Char);
//$$** SECTION: FORMKEYPRESS_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.ComboDropDownListKeyDown
//************************************************************************
procedure TfrmDataRevistaCientifica.ComboDropDownListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_DELETE then begin
      TComboBox(Sender).ItemIndex:=-1;
      if Assigned(TComboBox(Sender).OnClick) then TComboBox(Sender).OnClick(Sender);
   end;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.scrScrollDataMouseWheel
//************************************************************************
procedure TfrmDataRevistaCientifica.scrScrollDataMouseWheel(
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
//* TfrmDataRevistaCientifica.ControlEnter
//************************************************************************
procedure TfrmDataRevistaCientifica.ControlEnter(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=RGB(255,255,128);
   end;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.ControlExit
//************************************************************************
procedure TfrmDataRevistaCientifica.ControlExit(Sender: TObject);
begin
   if (Sender is TControl) and (Sender<>nil) then begin
      THackControl(Sender).Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.cmdShowDocumentClick
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdShowDocumentClick(Sender: TObject);
//$$** SECTION: SHOWDOCUMENTCLICK_FULLIMPL
begin
   // No document to show
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.grdDataEdicoesDrawCell
//************************************************************************
procedure TfrmDataRevistaCientifica.grdDataEdicoesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//$$** SECTION: GRIDDRAWCELL_FULLIMPL_7_6
begin
   //
end;
//$$** ENDSECTION



//************************************************************************
//* TfrmDataRevistaCientifica.cmdOkClick
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdOkClick(Sender: TObject);
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
//* TfrmDataRevistaCientifica.cmdCancelClick
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.UpdateObject
//************************************************************************
procedure TfrmDataRevistaCientifica.UpdateObject(AObject: TRevistaCientifica);
//$$** SECTION: UPDATEOBJECT_VAR
//$$** SECTION: UPDATEOBJECT_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATEOBJECT_BODY
   AObject.Titulo:=txtTitulo.Text;
   if cboPeriodicidade.ItemIndex=0 then begin
      AObject.Periodicidade:=1;
   end else if cboPeriodicidade.ItemIndex=1 then begin
      AObject.Periodicidade:=2;
   end else if cboPeriodicidade.ItemIndex=2 then begin
      AObject.Periodicidade:=6;
   end else begin
      AObject.Periodicidade:=-1;
   end;
//$$** SECTION: UPDATEOBJECT_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.UpdateScreen
//************************************************************************
procedure TfrmDataRevistaCientifica.UpdateScreen(AFlagNew: Boolean);
//$$** SECTION: UPDATESCREEN_VAR
//$$** SECTION: UPDATESCREEN_VAR_USER
//$$** ENDSECTION
begin
//$$** SECTION: UPDATESCREEN_BODY
   txtTitulo.Text:=FObject.Titulo;
   if FObject.Periodicidade=1 then begin
      cboPeriodicidade.ItemIndex:=0;
   end else if FObject.Periodicidade=2 then begin
      cboPeriodicidade.ItemIndex:=1;
   end else if FObject.Periodicidade=6 then begin
      cboPeriodicidade.ItemIndex:=2;
   end else begin
      cboPeriodicidade.ItemIndex:=-1;
   end;
   RefreshDataEdicoes;
   ResizeGridEdicoes;
//$$** SECTION: UPDATESCREEN_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.ValidateScreen
//************************************************************************
function TfrmDataRevistaCientifica.ValidateScreen: Boolean;
begin
   Result:=StandardValidateScreen;
   if Result then begin
      Result:=CustomValidateScreen;
   end;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.StandardValidateScreen
//************************************************************************
function TfrmDataRevistaCientifica.StandardValidateScreen(ACheckFormButtons: Boolean = True): Boolean;
//$$** SECTION: VALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: VALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.CustomValidateScreen
//************************************************************************
function TfrmDataRevistaCientifica.CustomValidateScreen: Boolean;
//$$** SECTION: CUSTOMVALIDATESCREEN_VAR
//$$** SECTION: ENDSECTION
begin
//$$** SECTION: CUSTOMVALIDATESCREEN_BODY
//$$** SECTION: ENDSECTION
   Result:=True;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.AfterSendEMailDoc
//************************************************************************
procedure TfrmDataRevistaCientifica.AfterSendEMailDoc(Sender: TObject);
//$$** SECTION: AFTERSENDEMAILDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.AfterPrintDoc
//************************************************************************
procedure TfrmDataRevistaCientifica.AfterPrintDoc(Sender: TObject);
//$$** SECTION: AFTERPRINTDOC_FULLIMPL
begin
//
end;
//$$** ENDSECTION


//$$** SECTION: SETDEFAULTEMAILPROPSDOC_METHOD_SIGNATURE
//$$** SECTION: SETDEFAULTEMAILPROPSDOC_FULLIMPL

//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.Open
//************************************************************************
function TfrmDataRevistaCientifica.Open(AObject: TP2SBFAbsPerBizObj; AFlagNew: Boolean; AHidden: Boolean = False): Boolean;
var
   i: Integer;
//$$** SECTION: OPEN_VAR
//$$** ENDSECTION
begin
   Screen.Cursor:=crHourglass;
   FFlagNew:=AFlagNew;
   FObject:=TRevistaCientifica(AObject);
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

//************************************************************************
//* TfrmDataRevistaCientifica.SetupGridColumnsEdicoes
//************************************************************************
procedure TfrmDataRevistaCientifica.SetupGridColumnsEdicoes;
begin
   grdDataEdicoes.ColCount:=3;
   grdDataEdicoes.Cells[0,0]:='Número';
   grdDataEdicoes.Cells[1,0]:='Volume';
   grdDataEdicoes.Cells[2,0]:='Data da Edição';
   SetLength(FArrayPctColWidthsEdicoes,3);
   FArrayPctColWidthsEdicoes[0]:=30;    // Número
   FArrayPctColWidthsEdicoes[1]:=30;    // Volume
   FArrayPctColWidthsEdicoes[2]:=39;    // Data da Edição
end;

//************************************************************************
//* TfrmDataRevistaCientifica.RefreshDataEdicoes
//************************************************************************
procedure TfrmDataRevistaCientifica.RefreshDataEdicoes(APOIDToSelect: Integer = 0);
var
   i: Integer;
   OIDArrayToLoad: TOIDArray;
//$$** SECTION: REFRESHDATA_7_6_VAR_USER
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
//$$** SECTION: REFRESHDATA_7_6_INITIALIZE
//$$** ENDSECTION
   if FObject.Edicoes.Count=0 then begin
      grdDataEdicoes.RowCount:=2;
      for i:=0 to grdDataEdicoes.ColCount-1 do begin
         grdDataEdicoes.Cells[i,1]:=''
      end;
   end else begin
      SetLength(OIDArrayToLoad,0);
      for i:=0 to FObject.Edicoes.Count-1 do begin
      end;
      gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,False,False);
      grdDataEdicoes.RowCount:=FObject.Edicoes.Count+1;
      for i:=0 to FObject.Edicoes.Count-1 do begin
         grdDataEdicoes.Cells[0,i+1]:=IntToStr(TEdicao(FObject.Edicoes.Items[i]).Numero);
         grdDataEdicoes.Cells[1,i+1]:=IntToStr(TEdicao(FObject.Edicoes.Items[i]).Volume);
         if TEdicao(FObject.Edicoes.Items[i]).DataEdicao<>0.0 then begin
            grdDataEdicoes.Cells[2,i+1]:=FormatDateTime('dd/mm/yyyy',TEdicao(FObject.Edicoes.Items[i]).DataEdicao);
         end else begin
            grdDataEdicoes.Cells[2,i+1]:='';
         end;
         // Auto Select row if necessary
         if TEdicao(FObject.Edicoes.Items[i]).OID.ID = APOIDToSelect then begin
            grdDataEdicoes.Row:=i+1;
         end;
      end;
   end;
//$$** SECTION: REFRESHDATA_7_6_FINALIZE
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmDataRevistaCientifica.ResizeGridEdicoes
//************************************************************************
procedure TfrmDataRevistaCientifica.ResizeGridEdicoes;
var
   i: Integer;
begin
   for i:=0 to High(FArrayPctColWidthsEdicoes) do begin
      grdDataEdicoes.ColWidths[i]:=Round(grdDataEdicoes.ClientWidth*(FArrayPctColWidthsEdicoes[i]/100));
   end;
end;
//$$** ENDSECTION

//$$** SECTION: COMBOS_LOOKUP_METHODS
//$$** ENDSECTION

//$$** SECTION: LABELS_PART_METHODS
//$$** ENDSECTION

//$$** SECTION: IMAGES_POPUPS_METHODS
//$$** ENDSECTION

//$$** SECTION: BUTTONS_METHODS

//************************************************************************
//* TfrmDataRevistaCientifica.cmdInsert1Click
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdInsert1Click(Sender: TObject);
var
   NewObject: TEdicao;
   DataForm: TfrmDataEdicao;
begin
   if not CanCreateObject(TEdicao) then Exit;
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
   NewObject:=TEdicao.Create;
   NewObject.Revista.OIDRef:=FObject.OID;
   InitializeNewObject(NewObject);
   Application.CreateForm(TfrmDataEdicao,DataForm);
   try
      Screen.Cursor:=crDefault;
      if DataForm.Open(NewObject,True) then begin
         Screen.Cursor:=crHourglass;
         // Add object
         FObject.Edicoes.SavePersistentItemReference(NewObject);
         FObject.Edicoes.Add(NewObject);
         FNRelInsertedFlag:=True;
         AfterSaveObject(NewObject);
         SortObjects;
         // Refresh
         RefreshDataEdicoes(NewObject.OID.ID);
         ResizeGridEdicoes;
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
//* TfrmDataRevistaCientifica.cmdDelete1Click
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdDelete1Click(Sender: TObject);
var
   CanDelete: Boolean;
   Reason: string;
   ObjectToDelete: TEdicao;
   ObjectClass: TP2SBFAbsPerBizClass;
begin
   if FObject.Edicoes.Count>0 then begin
      Screen.Cursor:=crHourglass;
      ObjectToDelete:=TEdicao.Retrieve(FObject.Edicoes.Items[grdDataEdicoes.Row-1].OID,False) as TEdicao;
      Reason:='';
      if not ClientCanDeleteObject(ObjectToDelete,Reason) then begin
         Screen.Cursor:=crDefault;
         Application.MessageBox(PChar('O registro selecionado não pode ser excluído pela seguinte razão:'+#13#10+Reason),'Segurança',MB_ICONEXCLAMATION);
         Exit;
      end;
      Reason:='';
      try
         CanDelete:=ObjectToDelete.CanDelete(Reason);
      except
         Screen.Cursor:=crDefault;
         Application.MessageBox(PChar('O registro selecionado não foi encontrado.'+#13#10+'Verifique se ele não foi excluído por outro usuário na rede.'+#13#10+'Clique no botão "Atualizar" para recarregar os dados.'),'Erro',MB_ICONEXCLAMATION);
         Exit;
      end;
      Screen.Cursor:=crDefault;
      if not CanDelete then begin
         Application.MessageBox(PChar('O registro selecionado não pode ser excluído pela seguinte razão:'+#13#10+Reason),'Segurança',MB_ICONEXCLAMATION);
         Exit;
      end;
      if Application.MessageBox('Confirma a exclusão do registro selecionado?','Confirmação',MB_ICONQUESTION+MB_OKCANCEL)=IDOK then begin
         // Delete object
         Screen.Cursor:=crHourglass;
         ObjectClass:=TP2SBFAbsPerBizClass(ObjectToDelete.ClassType);
         FObject.Edicoes.DeletePersistentItemReference(ObjectToDelete);
         FObject.Edicoes.Remove(ObjectToDelete);
         ObjectToDelete.Delete;
         FNRelDeletedFlag:=True;
         RefreshDataEdicoes;
         ResizeGridEdicoes;
         AfterDeleteObject(ObjectClass);
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.cmdEdit1Click
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdEdit1Click(Sender: TObject);
var
   ObjectToEdit: TEdicao;
   DataForm: TfrmDataEdicao;
begin
   if (cmdEdit1.Visible) and (cmdEdit1.Enabled) then begin
      if FObject.Edicoes.Count>0 then begin
         // Retrieve object
         Screen.Cursor:=crHourglass;
         //FObject.Edicoes.Items[grdDataEdicoes.Row-1].Refresh;
         ObjectToEdit:=TEdicao(FObject.Edicoes.Items[grdDataEdicoes.Row-1]);
         try
            ObjectToEdit.Refresh;
         except
            Screen.Cursor:=crDefault;
            Application.MessageBox(PChar('O registro selecionado não foi encontrado.'+#13#10+'Verifique se ele não foi excluído por outro usuário na rede.'+#13#10+'Clique no botão "Atualizar" para recarregar os dados.'),'Erro',MB_ICONEXCLAMATION);
            Exit;
         end;
         BeforeEditObject(ObjectToEdit);
         // Create data form
         Application.CreateForm(TfrmDataEdicao,DataForm);
         try
            Screen.Cursor:=crDefault;
            // Show data form
            if DataForm.Open(ObjectToEdit,False) then begin
               FNRelEditedFlag:=True;
               Screen.Cursor:=crHourglass;
               AfterSaveObject(ObjectToEdit);
               SortObjects;
               // Refresh
               RefreshDataEdicoes(ObjectToEdit.OID.ID);
               ResizeGridEdicoes;
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
//* TfrmDataRevistaCientifica.cmdList1Click
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdList1Click(Sender: TObject);
var
   ReportGenerator: TClientReportGenerator;
begin
   // Create report generator
   ReportGenerator:=TClientReportGenerator.Create;
   // Show report
   ReportGenerator.GenerateReportFromGrid(grdDataEdicoes,tabTab1.Caption,'',[],[],[],[]);
   // Free mem
   ReportGenerator.Free;
end;

//************************************************************************
//* TfrmDataRevistaCientifica.cmdExportToExcel1Click
//************************************************************************
procedure TfrmDataRevistaCientifica.cmdExportToExcel1Click(Sender: TObject);
var
   ReportGenerator: TClientReportGenerator;
begin
   // Create report generator
   ReportGenerator:=TClientReportGenerator.Create;
   try
      // Export to Excel
      ReportGenerator.ExportGridToExcel(grdDataEdicoes,tabTab1.Caption,'');
   finally
      // Free mem
      ReportGenerator.Free;
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
//* TfrmDataRevistaCientifica.CanCreateObject
//************************************************************************
function TfrmDataRevistaCientifica.CanCreateObject(ABizClass: TP2SBFAbsPerBizClass): Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.InitializeNewObject
//************************************************************************
procedure TfrmDataRevistaCientifica.InitializeNewObject(ANewObject: TP2SBFAbsPerBizObj);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.ClientCanDeleteObject
//************************************************************************
function TfrmDataRevistaCientifica.ClientCanDeleteObject(AObject: TP2SBFAbsPerBizObj; var AReason: string): Boolean;
//$$** SECTION: CLIENTCANDELETEOBJECT_FULLIMPL
begin
   AReason:='';
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.BeforeEditObject
//************************************************************************
procedure TfrmDataRevistaCientifica.BeforeEditObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: BEFOREEDITOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.AfterSaveObject
//************************************************************************
procedure TfrmDataRevistaCientifica.AfterSaveObject(AObject: TP2SBFAbsPerBizObj);
//$$** SECTION: AFTERSAVEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.AfterDeleteObject
//************************************************************************
procedure TfrmDataRevistaCientifica.AfterDeleteObject(AClass: TP2SBFAbsPerBizClass);
//$$** SECTION: AFTERDELETEOBJECT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmDataRevistaCientifica.SortObjects
//************************************************************************
procedure TfrmDataRevistaCientifica.SortObjects;
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
   gP2SBFClassRegistry.RegisterDataFormClass(TfrmDataRevistaCientifica);

end.
