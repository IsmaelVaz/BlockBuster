unit ufrmCRUDSocio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ImgList, ComCtrls, ToolWin, Grids, StdCtrls, ExtCtrls, Menus,
  Types, Printers, Math, GIFImg,
  uComboBoxRoutines,
  uP2SBFUtils, uP2SBFParams, uP2SBFAbsModelTypes, uP2SBFAbsModelClient,
  uModelClient,
  uCRUDFormUtils;

type
  THackStringGrid = class(TStringGrid)
     public
        property GridState: TGridState read FGridState;
  end;

  TFastSearchThread = class;
  TgrdDataTopLeftChangedThread = class;
  
  TfrmCRUDSocio = class(TForm)
    imglstImagens: TImageList;
    pnlTop: TPanel;
//$$** SECTION: FILTERS_OBJECTS_DECLARATIONS
//$$** ENDSECTION
    lblFastSearchField: TLabel;
    txtFastSearch: TEdit;
    pnlTitle: TPanel;
    imgFormPicture: TImage;
    lblTitle: TLabel;
    tlbToolBar: TToolBar;
    popCustomButtons: TPopupMenu;
    //tmrColWidths: TTimer;
    cmdInsert: TToolButton;
    cmdDelete: TToolButton;
    cmdEdit: TToolButton;
    cmdRefresh: TToolButton;
    cmdList: TToolButton;
    cmdExportToExcel: TToolButton;
    cmdSearch: TToolButton;
    cmdCancelSearch: TToolButton;
    cmdSelectColumns: TToolButton;
    cmdCustomButtons: TToolButton;
    cmdSeparator1: TToolButton;
    cmdSeparator2: TToolButton;
    cmdSeparator3: TToolButton;
    lblPesquisaAvancadaAtiva: TLabel;
    lblSeparator: TLabel;
    lblRecordCount: TLabel;
    grdData: TStringGrid;
    pnlSpinner: TPanel;
    imgSpinner: TImage;
    pnlNotAllowed: TPanel;
//$$** SECTION: CONTROLS_DECLARATIONS
//$$** ENDSECTION
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure tmrColWidthsTimer(Sender: TObject);
    procedure txtFastSearchChange(Sender: TObject);
    procedure cmdInsertClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdRefreshClick(Sender: TObject);
    procedure cmdListClick(Sender: TObject);
    procedure mnuListPortraitClick(Sender: TObject);
    procedure mnuListLandscapeClick(Sender: TObject);
    procedure cmdExportToExcelClick(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure cmdCancelSearchClick(Sender: TObject);
    procedure cmdSelectColumnsClick(Sender: TObject);
    procedure cmdCustomButtonsClick(Sender: TObject);
    procedure txtFastSearchKeyPress(Sender: TObject; var Key: Char);
    procedure grdDataDblClick(Sender: TObject);
    procedure grdDataDrawCell(Sender: TObject; ACol,
                              ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure grdDataMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdDataMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure grdDataTopLeftChanged(Sender: TObject);
    procedure grdDataTopLeftChangedOnBackground(Sender: TObject);
    procedure grdDataTopLeftChangedOnBackgroundTerminate(Sender: TObject);
	
//$$** SECTION: FILTERS_METHODS_DECLARATIONS
//$$** ENDSECTION
  
//$$** SECTION: CUSTOMBUTTONS_METHODS_DECLARATIONS
//$$** ENDSECTION
  private
    { Private declarations }
  protected
    { Protected declarations }
    FArrayId: array of Integer;
    FArrayLoaded: array of Boolean;
    FCriteriaList: TP2SBFCriteriaList;
    FCriteriaListDesc: TStringList;
    FAvailableColumnList: TCRUDFormAvailableColumnList;
    FOrderByPropertyName: string;
    FOrderByPropertyType: TP2SBFType;
    FOrderByDirection: string;
    FOrderByPropertyFieldSize: Integer;

    FDestroying: Boolean;
    FFirstActivate: Boolean;
    FFlagLoading: Boolean;
    FPermissionToView: Boolean;
    FCurrentFastSearchThread: TFastSearchThread;
    FNextFastSearchThread: TFastSearchThread;
    FCurrentgrdDataTopLeftChangedThread: TgrdDataTopLeftChangedThread;
    FNextgrdDataTopLeftChangedThread: TgrdDataTopLeftChangedThread;
	
//$$** SECTION: ARRAYS_FILTERS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: FILTERS_COMBOS_HANDLERS_DECLARATIONS
//$$** ENDSECTION

//$$** SECTION: PROTECTEDDECL_IMPL_USER
//$$** ENDSECTION

    procedure InitializeAvailableColumns;
    procedure LoadConfigAvailableColumns;
    procedure SetOrderByColumn(AColumn: TCRUDFormAvailableColumn; ADirection: string = '');
    procedure SetupGridColumns;
    procedure SetupFinalCriteriaList(AFinalCriteriaList: TP2SBFCriteriaList);
    procedure CustomSetupFinalCriteriaList(AFinalCriteriaList: TP2SBFCriteriaList);
    procedure FillGridRow(ARow: Integer; AObject: TSocio);
    procedure ClearGridRow(ARow: Integer);
    procedure GetGridVisibleRange(var AStartRow: Integer; var AEndRow: Integer; var AFlagLoad: Boolean);
    procedure LoadData(APOIDToSelect: Integer = 0; AFullLoad: Boolean = False; ALimitOffset: Integer = 0; ALimitCount: Integer = 50; ASetOthersAsNotLoaded: Boolean = False);
    procedure RefreshVisibleRange(APOIDToSelect: Integer = 0);
    procedure RefreshVisibleRangeOnBackground(APOIDToSelect: Integer = 0);
    procedure RefreshVisibleRangeOnBackgroundTerminate(Sender: TObject);
    procedure UpdateInternalColumnWidths;
    procedure ResizeGrid;
    procedure FastSearch(AText: string);
    procedure FastSearchOnBackground(AText: string);
    procedure FastSearchOnBackgroundTerminate(Sender: TObject);
    procedure SelectRowByPOID(APOID: Integer);
    procedure SetupPermissions;
    procedure SetupFilters;
    procedure List(AOrientation: TPrinterOrientation);
    function  CanCreateObject: Boolean;
    procedure InitializeNewObject(ANewObject: TSocio);
    procedure AfterInsert(AObject: TSocio);
    procedure BeforeDelete(AObject: TSocio);
    procedure AfterDelete;
    procedure AfterEdit(AObject: TSocio);

    procedure ShowSpinner; virtual;
    procedure HideSpinner; virtual;
    //procedure VisibleChanging; override;

//$$** SECTION: FILTERS_COMBOS_LOOKUP_METHODS_DECLARATIONS
//$$** ENDSECTION
    
  public
    { Public declarations }
//$$** SECTION: PUBLICDECL_IMPL_USER
   FIsNewCreate: Boolean;
//$$** ENDSECTION
  end;

  TRefreshThread = class(TThread)
     protected
        FForm: TfrmCRUDSocio;
        FPOIDToSelect: Integer;
     public
        property Form: TfrmCRUDSocio read FForm write FForm;
        property POIDToSelect: Integer read FPOIDToSelect write FPOIDToSelect;

        procedure Execute; override;
  end;

  TFastSearchThread = class(TThread)
     protected
        FForm: TfrmCRUDSocio;
        FText: string;
     public
        property Form: TfrmCRUDSocio read FForm write FForm;
        property Text: string read FText write FText;

        procedure Execute; override;
  end;

  TgrdDataTopLeftChangedThread = class(TThread)
     protected
        FForm: TfrmCRUDSocio;
     public
        property Form: TfrmCRUDSocio read FForm write FForm;

        procedure Execute; override;
  end;

var
   frmCRUDSocio: TfrmCRUDSocio;

implementation

{$R *.dfm}

uses uMisc,uP2SBFObjReposClient,
     uP2SBFSystemModelClient,uP2SBFSystemModelClientForms,
     ufrmGeneralSearch,ufrmGeneralSelectionDialog,uClientGeneralReports,
     ufrmColumnSelection
//$$** SECTION: IMPLEMENTATION_USES
     , ufrmDataSocio
//$$** SECTION: IMPLEMENTATION_USES_USER
//$$** ENDSECTION
     ;

const
   cCRUDPermissionId = 0;
   cRecordCountLabelColor = $00CCB500;

//************************************************************************
//* TfrmCRUDSocio.FormCreate
//************************************************************************
procedure TfrmCRUDSocio.FormCreate(Sender: TObject);
begin
   FDestroying:=False;
   FFirstActivate:=True;
   FFlagLoading:=False;
   FPermissionToView:=False;
   FCurrentFastSearchThread:=nil;
   FNextFastSearchThread:=nil;
   FCurrentgrdDataTopLeftChangedThread:=nil;
   FNextgrdDataTopLeftChangedThread:=nil;
   
   FOrderByPropertyName:='';
   FOrderByPropertyType:=optUnknown;
   FOrderByDirection:='';
   FOrderByPropertyFieldSize:=0;   

//$$** SECTION: FILTERS_COMBOS_HANDLERS_CREATE
//$$** ENDSECTION

   FAvailableColumnList:=TCRUDFormAvailableColumnList.Create;
   FCriteriaList:=TP2SBFCriteriaList.Create;
   FCriteriaListDesc:=TStringList.Create;
   
   (* // C�digo antigo para preparar o form j� no FormCreate.
      // Descomentar para retornar � forma anterior. Eliminar o FormActivate e
      // redirecionar o TopLeftChanged do grid para grdDataTopLeftChanged (sem o OnBackground).
      // Adaptar tamb�m txtFastSearchChange e txtFastSearchKeyPress para como era antes.
      
   InitializeAvailableColumns;
   LoadConfigAvailableColumns;
   SetupGridColumns;
   SetupPermissions;   
   if grdData.Visible then begin
      SetupFilters;
      RefreshVisibleRange;
      ResizeGrid;
      tmrColWidths.Enabled:=True;
   end;
   if popCustomButtons.Items.Count=0 then begin
      //cmdSeparator3.Visible:=False;
      cmdCustomButtons.Visible:=False;
   end else begin
      //cmdSeparator3.Visible:=True;
      cmdCustomButtons.Visible:=True;
   end;
   
   // Colocar neste ponto a section FORMCREATE_IMPL_USER   
   *)
end;

//************************************************************************
//* TfrmCRUDSocio.FormActivate
//************************************************************************
procedure TfrmCRUDSocio.FormActivate(Sender: TObject);

// Esta section poderia se chamar FORMACTIVATE_VAR, mas por ser sido
// movida originalmente de FormCreate, mantivemos o nome para preservar
// compatibilidade com c�digos anteriores.

//$$** SECTION: FORMCREATE_VAR
//$$** ENDSECTION
begin
   if FFirstActivate then begin
      FFirstActivate:=False;
      pnlSpinner.Align:=alClient;   // Otherwise we are unable to center pnlSpinner manually here.
      InitializeAvailableColumns;
      LoadConfigAvailableColumns;
      grdData.DefaultRowHeight:=Max(grdData.DefaultRowHeight,Round(grdData.Canvas.TextHeight('Any text')*1.5));
      SetupGridColumns;
      SetupPermissions;
      if popCustomButtons.Items.Count=0 then begin
         cmdCustomButtons.Visible:=False;
      end else begin
         cmdCustomButtons.Visible:=True;
      end;
      if grdData.Visible then begin
         SetupFilters;
         //ResizeGrid;   // First time to set column widths after opening form

//$$** SECTION: FORMACTIVATE_BEFORE_REFRESH_IMPL_USER
//$$** ENDSECTION

         //tmrColWidths.Enabled:=True;
         Self.RefreshVisibleRangeOnBackground;
      end;

      // Esta section poderia se chamar FORMACTIVATE_IMPL_USER, mas por ser sido
      // movida originalmente de FormCreate, mantivemos o nome para preservar
      // compatibilidade com c�digos anteriores.
      
//$$** SECTION: FORMCREATE_IMPL_USER
//$$** ENDSECTION

   end else begin
      if grdData.Visible then begin
         // For�a reexibi��o da Scrollbar do grid, quando o form �
         // reapresentado ap�s ter sido oculto. Parece ser um bug da VCL
         // ou do Windows.
         grdData.Visible:=False;
         grdData.Visible:=True;
         ResizeGrid;
      end;
      if pnlNotAllowed.Visible then begin
         pnlNotAllowed.Visible:=False;
         pnlNotAllowed.Visible:=True;
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.FormDestroy
//************************************************************************
procedure TfrmCRUDSocio.FormDestroy(Sender: TObject);
begin
   FDestroying:=True;
   FCriteriaListDesc.Free;
   FCriteriaList.Free;
   FAvailableColumnList.Free;
   
//$$** SECTION: FILTERS_COMBOS_HANDLERS_DESTROY
//$$** ENDSECTION
   
end;

//************************************************************************
//* TfrmCRUDSocio.FormResize
//************************************************************************
procedure TfrmCRUDSocio.FormResize(Sender: TObject);
begin
   if not FDestroying then begin
      ResizeGrid;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.FormClose
//************************************************************************
procedure TfrmCRUDSocio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action:=caFree;
end;

{
//************************************************************************
//* TfrmCRUDSocio.tmrColWidthsTimer
//************************************************************************
procedure TfrmCRUDSocio.tmrColWidthsTimer(Sender: TObject);
begin
   UpdateInternalColumnWidths;
end;
}

//$$** SECTION: FILTERS_METHODS
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.txtFastSearchChange
//************************************************************************
procedure TfrmCRUDSocio.txtFastSearchChange(Sender: TObject);
begin
   //FastSearch(txtFastSearch.Text);
   FastSearchOnBackground(txtFastSearch.Text);
end;

//************************************************************************
//* TfrmCRUDSocio.txtFastSearchKeyPress
//************************************************************************
procedure TfrmCRUDSocio.txtFastSearchKeyPress(Sender: TObject; var Key: Char);
begin
   {if Key=#13 then begin
      Key:=#0;
      cmdEditClick(Self);
   end;}

   if Key=#13 then begin
      if FCurrentFastSearchThread=nil then begin
         Key:=#0;
         cmdEditClick(Self);
      end;
   end;   
end;

//************************************************************************
//* TfrmCRUDSocio.cmdInsertClick
//************************************************************************
procedure TfrmCRUDSocio.cmdInsertClick(Sender: TObject);
//$$** SECTION: INSERTBUTTONCLICK_FULLIMPL
var
   NewObject: TSocio;
   r: Boolean;
   DataForm: TP2SBFClientDataForm;
   Reason: string;
begin
   if not CanCreateObject then Exit;
   // Create object
   Screen.Cursor:=crHourglass;
   NewObject:=TSocio.Create;
   InitializeNewObject(NewObject);
   // Create data form
   Application.CreateForm(TfrmDataSocio,frmDataSocio);
   DataForm:=frmDataSocio;
   Screen.Cursor:=crDefault;
   // Show data form
   r:=frmDataSocio.Open(TSocio(NewObject),True);
   if r then begin
      // Refresh
      Screen.Cursor:=crHourglass;
      AfterInsert(NewObject);
      RefreshVisibleRange(NewObject.OID.ID);
      UpdateInternalColumnWidths;
      ResizeGrid;
      Screen.Cursor:=crDefault;
   end else begin
      Reason:='';
      if NewObject.CanDelete(Reason) then begin
         BeforeDelete(NewObject);
         NewObject.Delete;
         AfterDelete;
      end else begin
         // Refresh
         Screen.Cursor:=crHourglass;
         RefreshVisibleRange(NewObject.OID.ID);
         UpdateInternalColumnWidths;
         ResizeGrid;
         Screen.Cursor:=crDefault;
      end;
   end;
   DataForm.Free;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.cmdDeleteClick
//************************************************************************
procedure TfrmCRUDSocio.cmdDeleteClick(Sender: TObject);
var
   ObjectToDelete: TSocio;
   CanDelete: Boolean;
   Reason: string;
begin
   if High(FArrayId)>=0 then begin
      Screen.Cursor:=crHourglass;
      ObjectToDelete:=TSocio.Retrieve(POID(FArrayId[grdData.Row-1]),False) as TSocio;
      // Check if it is possible to delete (referential integrity)
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
      // Ask confirmation
      if Application.MessageBox('Confirma a exclus�o do registro selecionado?','Confirma��o',MB_ICONQUESTION+MB_OKCANCEL)=IDOK then begin
         // Delete object
         Screen.Cursor:=crHourglass;
         BeforeDelete(ObjectToDelete);
         ObjectToDelete.Delete;
         AfterDelete;
         RefreshVisibleRange;
         UpdateInternalColumnWidths;
         ResizeGrid;
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.cmdEditClick
//************************************************************************
procedure TfrmCRUDSocio.cmdEditClick(Sender: TObject);
//$$** SECTION: EDITBUTTONCLICK_FULLIMPL
var
   ObjectToEdit: TSocio;
   DataForm: TP2SBFClientDataForm;
begin
   if cmdEdit.Visible then begin
      if High(FArrayId)>=0 then begin
         // Retrieve object
         Screen.Cursor:=crHourglass;
         try
            ObjectToEdit:=TSocio.Retrieve(POID(FArrayId[grdData.Row-1]),True) as TSocio;
         except
            Screen.Cursor:=crDefault;
            Application.MessageBox(PChar('O registro selecionado n�o foi encontrado.'+#13#10+'Verifique se ele n�o foi exclu�do por outro usu�rio na rede.'+#13#10+'Clique no bot�o "Atualizar" para recarregar os dados.'),'Erro',MB_ICONEXCLAMATION);
            Exit;
         end;
         if ObjectToEdit is TSocio then begin
            Application.CreateForm(TfrmDataSocio,DataForm);
            try
               Screen.Cursor:=crDefault;
               // Show data form
               if DataForm.Open(TSocio(ObjectToEdit),False) then begin
                  Screen.Cursor:=crHourglass;
                  AfterEdit(ObjectToEdit);
               end else begin
                  Screen.Cursor:=crHourglass;
               end;
               // Refresh
               RefreshVisibleRange(ObjectToEdit.OID.ID);
               UpdateInternalColumnWidths;
               ResizeGrid;
            finally
               DataForm.Free;
               Screen.Cursor:=crDefault;
            end;
         end;
      end;
   end;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.cmdRefreshClick
//************************************************************************
procedure TfrmCRUDSocio.cmdRefreshClick(Sender: TObject);
var
   SelectedObjectId: Integer;
begin
   Screen.Cursor:=crHourglass;
   if High(FArrayId)>=0 then begin
      SelectedObjectId:=FArrayId[grdData.Row-1];
   end else begin
      SelectedObjectId:=0;
   end;
   // Refresh
   // Descomentar e tirar a chamada a RefreshVisibleRangeOnBackground para deixar como antes.
   {RefreshVisibleRange(SelectedObjectId);
   UpdateInternalColumnWidths;
   ResizeGrid;}
   Screen.Cursor:=crDefault;
   UpdateInternalColumnWidths;
   RefreshVisibleRangeOnBackground(SelectedObjectId);
end;

//************************************************************************
//* TfrmCRUDSocio.cmdListClick
//************************************************************************
procedure TfrmCRUDSocio.cmdListClick(Sender: TObject);
begin
   cmdList.CheckMenuDropDown;
end;

//************************************************************************
//* TfrmCRUDSocio.mnuListPortraitClick
//************************************************************************
procedure TfrmCRUDSocio.mnuListPortraitClick(
  Sender: TObject);
begin
   Self.List(poPortrait);
end;

//************************************************************************
//* TfrmCRUDSocio.mnuListLandscapeClick
//************************************************************************
procedure TfrmCRUDSocio.mnuListLandscapeClick(Sender: TObject);
begin
   Self.List(poLandscape);
end;

//************************************************************************
//* TfrmCRUDSocio.cmdExportToExcelClick
//************************************************************************
procedure TfrmCRUDSocio.cmdExportToExcelClick(Sender: TObject);
var
   ReportGenerator: TClientReportGenerator;
   SubTitle: string;
   IdToRefresh: Integer;
begin
   SubTitle:='';
   Screen.Cursor:=crHourglass;
   if High(FArrayId)>=0 then begin
      IdToRefresh:=FArrayId[grdData.Row-1];
   end else begin
      IdToRefresh:=0;
   end;
   // Refresh
   LoadData(IdToRefresh,True);  // Full load
   // Create report generator
   ReportGenerator:=TClientReportGenerator.Create;
   Screen.Cursor:=crDefault;
   // Show report
   ReportGenerator.ExportGridToExcel(grdData,lblTitle.Caption,SubTitle);
   // Free mem
   ReportGenerator.Free;
end;

//************************************************************************
//* TfrmCRUDSocio.cmdSearchClick
//************************************************************************
procedure TfrmCRUDSocio.cmdSearchClick(Sender: TObject);
var
   SelectedID: Integer;
begin
   Screen.Cursor:=crHourglass;
   // Save current selected object ID
   if High(FArrayId)>=0 then begin
      SelectedID:=FArrayId[grdData.Row-1];
   end else begin
      SelectedID:=0;
   end;
   // Create general search form
   Application.CreateForm(TfrmGeneralSearch,frmGeneralSearch);
   Screen.Cursor:=crDefault;
   // Call general search form
   if frmGeneralSearch.Open('frmCRUDSocio',FCriteriaList,FCriteriaListDesc) then begin
      Screen.Cursor:=crHourglass;
      RefreshVisibleRange(SelectedID);
      UpdateInternalColumnWidths;
      ResizeGrid;
      Screen.Cursor:=crDefault;
   end;
   // Free memory
   frmGeneralSearch.Free;
end;

//************************************************************************
//* TfrmCRUDSocio.cmdCancelSearchClick
//************************************************************************
procedure TfrmCRUDSocio.cmdCancelSearchClick(Sender: TObject);
var
   i: Integer;
   SelectedID: Integer;
begin
   Screen.Cursor:=crHourglass;
   // Save current selected object ID
   if High(FArrayId)>=0 then begin
      SelectedID:=FArrayId[grdData.Row-1];
   end else begin
      SelectedID:=0;
   end;
   // Clear criteria list
   for i:=0 to FCriteriaList.Count-1 do begin
      TP2SBFCriteria(FCriteriaList.Items[i]).Free;
   end;
   FCriteriaList.Clear;
   // Clear criteria list description
   FCriteriaListDesc.Clear;
   // Refresh screen
   RefreshVisibleRange(SelectedID);
   UpdateInternalColumnWidths;
   ResizeGrid;
   Screen.Cursor:=crDefault;
end;

//************************************************************************
//* TfrmCRUDSocio.cmdSelectColumnsClick
//************************************************************************
procedure TfrmCRUDSocio.cmdSelectColumnsClick(Sender: TObject);
begin
   //tmrColWidths.Enabled:=False;
   UpdateInternalColumnWidths;
   Application.CreateForm(TfrmColumnSelection,frmColumnSelection);
   try
      if frmColumnSelection.Open(Self.Name,FAvailableColumnList) then begin
         SetupGridColumns;
         RefreshVisibleRange;
         ResizeGrid;
      end;
   finally
      frmColumnSelection.Free;
      //tmrColWidths.Enabled:=True;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.cmdCustomButtonsClick
//************************************************************************
procedure TfrmCRUDSocio.cmdCustomButtonsClick(Sender: TObject);
begin
   cmdCustomButtons.CheckMenuDropdown;
end;


//************************************************************************
//* TfrmCRUDSocio.grdDataDblClick
//************************************************************************
procedure TfrmCRUDSocio.grdDataDblClick(Sender: TObject);
begin
   cmdEditClick(Self);
end;

//************************************************************************
//* TfrmCRUDSocio.grdDataDrawCell
//************************************************************************
procedure TfrmCRUDSocio.grdDataDrawCell(Sender: TObject; ACol,
                       ARow: Integer; Rect: TRect; State: TGridDrawState);
//$$** SECTION: DATADRAWCELL_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.grdDataMouseMove
//************************************************************************
procedure TfrmCRUDSocio.grdDataMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   i,c: Integer;
   Col,Row: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
   NewCursor: TCursor;
begin
   NewCursor:=crDefault;  // Default
   grdData.MouseToCell(X,Y,Col,Row);
   if Row=0 then begin  // Title
      c:=0;
      for i:=0 to FAvailableColumnList.Count-1 do begin
         AvailableColumn:=FAvailableColumnList.Items[i];
         if AvailableColumn.Visible then begin
            if c=Col then begin
               if AvailableColumn.CanOrderBy then begin
                  NewCursor:=crHandPoint;
               end;
               Break;
            end;
            c:=c+1;
         end;
      end;
   end;
   if grdData.Cursor<>NewCursor then begin
      grdData.Cursor:=NewCursor;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.grdDataMouseUp
//************************************************************************
procedure TfrmCRUDSocio.grdDataMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   i,c: Integer;
   Col,Row: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
begin
   if Button=mbLeft then begin
      if THackStringGrid(grdData).GridState<>gsColSizing then begin
         grdData.MouseToCell(X,Y,Col,Row);
         if Row=0 then begin  // Title
            c:=0;
            for i:=0 to FAvailableColumnList.Count-1 do begin
               AvailableColumn:=FAvailableColumnList.Items[i];
               if AvailableColumn.Visible then begin
                  if c=Col then begin
                     if AvailableColumn.CanOrderBy then begin
                        SetOrderByColumn(AvailableColumn);
                        lblFastSearchField.Caption:='Busca R�pida por '+AvailableColumn.PropertyDescription+':';
                        txtFastSearch.Text:='';
                        SetupGridColumns;   // Update Arrow on the Ordered Column Title
                        RefreshVisibleRangeOnBackground;
                     end;
                     Break;
                  end;
                  c:=c+1;
               end;
            end;
         end;
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.grdDataTopLeftChanged
//************************************************************************
procedure TfrmCRUDSocio.grdDataTopLeftChanged(Sender: TObject);
var
   b1,b2: Integer;
   FlagLoad: Boolean;
begin
   GetGridVisibleRange(b1,b2,FlagLoad);
   if FlagLoad then begin
      if b1<=b2 then begin
         LoadData(0,False,b1-1,(b2-b1)+1,False);
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.grdDataTopLeftChangedOnBackground
//************************************************************************
procedure TfrmCRUDSocio.grdDataTopLeftChangedOnBackground(Sender: TObject);
var
   grdDataTopLeftChangedThread: TgrdDataTopLeftChangedThread;
   RunThread: Boolean;
begin
   RunThread:=False;
   if FCurrentgrdDataTopLeftChangedThread=nil then begin
      FCurrentgrdDataTopLeftChangedThread:=TgrdDataTopLeftChangedThread.Create(True);  // True = create suspended
      grdDataTopLeftChangedThread:=FCurrentgrdDataTopLeftChangedThread;
      ShowSpinner;
      Screen.Cursor:=crAppStart;
      RunThread:=True;
   end else begin
      // Se j� h� um pr�ximo thread esperando, este deve sobrepor.
      if FNextgrdDataTopLeftChangedThread=nil then begin
         FNextgrdDataTopLeftChangedThread:=TgrdDataTopLeftChangedThread.Create(True);  // True = create suspended
      end;
      grdDataTopLeftChangedThread:=FNextgrdDataTopLeftChangedThread;
   end;
   // Setup thread
   grdDataTopLeftChangedThread.OnTerminate:=grdDataTopLeftChangedOnBackgroundTerminate;
   grdDataTopLeftChangedThread.FreeOnTerminate:=True;
   grdDataTopLeftChangedThread.Form:=Self;
   if RunThread then begin
      grdDataTopLeftChangedThread.Resume;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.grdDataTopLeftChangedOnBackgroundTerminate
//************************************************************************
procedure TfrmCRUDSocio.grdDataTopLeftChangedOnBackgroundTerminate(Sender: TObject);
begin
   FCurrentgrdDataTopLeftChangedThread:=FNextgrdDataTopLeftChangedThread;
   FNextgrdDataTopLeftChangedThread:=nil;
   if FCurrentgrdDataTopLeftChangedThread<>nil then begin
      // J� outro p�gina aguardando para ser carregada. Dispara essa busca sem
      // reexibir o grid.
      FCurrentgrdDataTopLeftChangedThread.Resume;
   end else begin
      HideSpinner;
      Screen.Cursor:=crDefault;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.InitializeAvailableColumns
//************************************************************************
procedure TfrmCRUDSocio.InitializeAvailableColumns;
//$$** SECTION: INITIALIZE_AVAILABLE_COLUMNS_FULLIMPL
var
   i: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
begin
   FAvailableColumnList.Clear;

   AvailableColumn:=TCRUDFormAvailableColumn.Create;
   AvailableColumn.PropertyName:='NumeroCarteira';
   AvailableColumn.PropertyDescription:='N�mero da Carteira';
   AvailableColumn.PropertyType:=optString;
   AvailableColumn.PropertyFieldSize:=50;
   AvailableColumn.ColumnWidth:=30;
   AvailableColumn.CanOrderBy:=True;
   AvailableColumn.Visible:=True;
   FAvailableColumnList.Add(AvailableColumn);
   SetOrderByColumn(AvailableColumn,'ASC');

   AvailableColumn:=TCRUDFormAvailableColumn.Create;
   AvailableColumn.PropertyName:='NomeExibicao';
   AvailableColumn.PropertyDescription:='Nome Exibi��o';
   AvailableColumn.PropertyType:=optString;
   AvailableColumn.PropertyFieldSize:=100;
   AvailableColumn.ColumnWidth:=69;
   AvailableColumn.CanOrderBy:=True;
   AvailableColumn.Visible:=True;
   FAvailableColumnList.Add(AvailableColumn);
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.LoadConfigAvailableColumns
//************************************************************************
procedure TfrmCRUDSocio.LoadConfigAvailableColumns;
var
   i: Integer;
   ArrayCRUDFormColumnConfig: TP2SBFAbsBizObjDynArray;
   CRUDFormColumnConfig: TSysCRUDFormColumnConfig;
   Column: TCRUDFormAvailableColumn;
   Index: Integer;
begin
   SetLength(ArrayCRUDFormColumnConfig,0);
   _gSysAccessControl.GetLoggedUserCRUDFormColumnConfig(Self.Name,
                                                        ArrayCRUDFormColumnConfig);
   for i:=0 to High(ArrayCRUDFormColumnConfig) do begin
      CRUDFormColumnConfig:=TSysCRUDFormColumnConfig(ArrayCRUDFormColumnConfig[i]);
      Index:=FAvailableColumnList.IndexByName(CRUDFormColumnConfig.ColumnName);
      if Index<>-1 then begin
         Column:=FAvailableColumnList.Items[Index];
         Column.Visible:=CRUDFormColumnConfig.Visible;
         Column.ColumnWidth:=CRUDFormColumnConfig.ColWidth;
         FAvailableColumnList.SetOrder(Column,CRUDFormColumnConfig.ColOrder);
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.SetOrderByColumn
//************************************************************************
procedure TfrmCRUDSocio.SetOrderByColumn(AColumn: TCRUDFormAvailableColumn; ADirection: string = '');
begin
   if FOrderByPropertyName=AColumn.PropertyName then begin
      if ADirection='' then begin
         // Invert order direction
         if FOrderByDirection='ASC' then begin
            FOrderByDirection:='DESC';
         end else begin
            FOrderByDirection:='ASC';
         end;
      end else begin
         FOrderByDirection:=ADirection;
      end;
   end else begin
      FOrderByPropertyName:=AColumn.PropertyName;
      FOrderByPropertyType:=AColumn.PropertyType;
      if ADirection='' then begin
         FOrderByDirection:='ASC';
      end else begin
         FOrderByDirection:=ADirection;
      end;
      FOrderByPropertyFieldSize:=AColumn.PropertyFieldSize;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.SetupGridColumns
//************************************************************************
procedure TfrmCRUDSocio.SetupGridColumns;
var
   i,c: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
begin
   if FAvailableColumnList.VisibleColumnsCount>0 then begin
      c:=0;
      grdData.ColCount:=FAvailableColumnList.VisibleColumnsCount;
      for i:=0 to FAvailableColumnList.Count-1 do begin
         AvailableColumn:=FAvailableColumnList.Items[i];
         if AvailableColumn.Visible then begin
            grdData.Cells[c,0]:=AvailableColumn.PropertyDescription;
            if FOrderByPropertyName=AvailableColumn.PropertyName then begin
               if FOrderByDirection='ASC' then begin
                  grdData.Cells[c,0]:=Chr($25B2)+' '+grdData.Cells[c,0];  // Arrow up (ascending order)
               end else begin
                  grdData.Cells[c,0]:=Chr($25BC)+' '+grdData.Cells[c,0];  // Arrow down (descending order)
               end;
            end;
            c:=c+1;
         end;
      end;
   end else begin
      grdData.ColCount:=0;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.SetupFinalCriteriaList
//************************************************************************
procedure TfrmCRUDSocio.SetupFinalCriteriaList(AFinalCriteriaList: TP2SBFCriteriaList);
var
   i: Integer;
   Id: Integer;
   Criteria: TP2SBFCriteria;
begin
   for i:=0 to FCriteriaList.Count-1 do begin
      Criteria:=TP2SBFCriteria.Create;
      Criteria.Assign(TP2SBFCriteria(FCriteriaList.Items[i]));
      AFinalCriteriaList.Add(Criteria);
   end;
//$$** SECTION: GET_FILTER_CRITERIA
//$$** ENDSECTION
   CustomSetupFinalCriteriaList(AFinalCriteriaList);
end;

//************************************************************************
//* TfrmCRUDSocio.CustomSetupFinalCriteriaList
//************************************************************************
procedure TfrmCRUDSocio.CustomSetupFinalCriteriaList(AFinalCriteriaList: TP2SBFCriteriaList);
//$$** SECTION: CUSTOM_GET_FILTER_CRITERIA_VAR
//$$** ENDSECTION
begin
//$$** SECTION: CUSTOM_GET_FILTER_CRITERIA_IMPL
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmCRUDSocio.FillGridRow
//************************************************************************
procedure TfrmCRUDSocio.FillGridRow(ARow: Integer; AObject: TSocio);
var
   i,c: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
   StrListAux: TStringList;
   RowHeight: Integer;
begin
   c:=0;
   for i:=0 to FAvailableColumnList.Count-1 do begin
      AvailableColumn:=FAvailableColumnList.Items[i];
      if AvailableColumn.Visible then begin
//$$** SECTION: FILL_GRID_COLUMNS
         if AvailableColumn.PropertyName='NumeroCarteira' then begin
            grdData.Cells[c,ARow]:=AObject.NumeroCarteira;
         end else if AvailableColumn.PropertyName='NomeExibicao' then begin
            grdData.Cells[c,ARow]:=AObject.NomeExibicao;
         end;
//$$** ENDSECTION
         c:=c+1;
      end;
   end;
   StrListAux:=TStringList.Create;
   try
      RowHeight:=grdData.DefaultRowHeight;
      for i:=0 to grdData.ColCount-1 do begin
         if grdData.ColWidths[i]>0 then begin
            // Uses a StringList to help couting the number of lines of the text.
            StrListAux.Clear;
            StrListAux.Text:=grdData.Cells[i,ARow];
            if StrListAux.Count=0 then begin
               StrListAux.Add(' ');    // Must have at least 1 line.
            end;
            RowHeight:=Max(RowHeight,(grdData.DefaultRowHeight*StrListAux.Count)-(2*(StrListAux.Count-1)));
         end;
      end;
   finally
      StrListAux.Free;
   end;
   grdData.RowHeights[ARow]:=RowHeight;
end;

//************************************************************************
//* TfrmCRUDSocio.ClearGridRow
//************************************************************************
procedure TfrmCRUDSocio.ClearGridRow(ARow: Integer);
var
   i: Integer;
begin
   for i:=0 to grdData.ColCount-1 do begin
      grdData.Cells[i,ARow]:='';
   end;
end;

//************************************************************************
//*TfrmCRUDSocio.GetGridVisibleRange
//************************************************************************
procedure TfrmCRUDSocio.GetGridVisibleRange(var AStartRow: Integer; var AEndRow: Integer; var AFlagLoad: Boolean);
var
   i: Integer;
begin
   AStartRow:=grdData.TopRow;
   AEndRow:=AStartRow+(Screen.Height div grdData.DefaultRowHeight);
   AFlagLoad:=False;
   for i:=AStartRow-1 to AEndRow-1 do begin
      if (i>=0) and (i<=High(FArrayLoaded)) then begin
         if not FArrayLoaded[i] then begin
            AFlagLoad:=True;
         end;
      end;
   end;
   if (not AFlagLoad) and (Length(FArrayLoaded)=0) then begin
      AFlagLoad:=True;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.LoadData
//************************************************************************
procedure TfrmCRUDSocio.LoadData(APOIDToSelect: Integer; AFullLoad: Boolean; ALimitOffset: Integer; ALimitCount: Integer; ASetOthersAsNotLoaded: Boolean);
var
   i,Id: Integer;
   ResultSet: TList;
   FinalCriteriaList: TP2SBFCriteriaList;
   Criteria: TP2SBFCriteria;
   QueryResultOIDList: TP2SBFQueryResultOIDList;
   LimitOffset,LimitCount: Integer;
   RecCount: Integer;
   OIDArrayToLoad: TOIDArray;
   OldTopRow: Integer;

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
   if FFlagLoading then Exit;  // Avoid that something invokes LoadData again while loading (ex: change of grid top row)
   FFlagLoading:=True;
   try
      // Build final criteria list = search criteria + filter criteria
      FinalCriteriaList:=TP2SBFCriteriaList.Create;
      ResultSet:=TList.Create;
      QueryResultOIDList:=TP2SBFQueryResultOIDList.Create;
      try
         SetupFinalCriteriaList(FinalCriteriaList);
         if AFullLoad then begin
            LimitOffset:=0;
            LimitCount:=0;
         end else begin
            LimitOffset:=ALimitOffset;
            LimitCount:=ALimitCount;
         end;
         RecCount:=gP2SBFObjRepos.QueryPersistentObjects(TSocio,FinalCriteriaList,ResultSet,FOrderByPropertyName+' '+FOrderByDirection,False,False,LimitOffset,LimitCount,0,0,QueryResultOIDList);
         if AFullLoad then begin
            // Adjust limit count to record count. Now we know the number of records.
            LimitCount:=RecCount;
         end else begin
            // Ajust limit offset and count. Now we know the number of records.
            if LimitOffset>RecCount-1 then begin
               LimitOffset:=RecCount;
            end;
            if RecCount-LimitOffset<LimitCount then begin
               LimitCount:=RecCount-LimitOffset;
            end;
         end;
         if RecCount=0 then begin
            SetLength(FArrayId,0);
            SetLength(FArrayLoaded,0);
            grdData.RowCount:=2;
            ClearGridRow(1);
         end else begin
            SetLength(OIDArrayToLoad,0);
            for i:=0 to LimitCount-1 do begin
//$$** SECTION: FILL_OIDARRAYTOLOAD
//$$** ENDSECTION
            end;
            gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,False,False);
            if Length(FArrayId)<>RecCount then begin
               SetLength(FArrayId,RecCount);
            end;
            if Length(FArrayLoaded)<>RecCount then begin
               SetLength(FArrayLoaded,RecCount);
            end;
            if grdData.RowCount<>RecCount+1 then begin
               OldTopRow:=grdData.TopRow;
               grdData.RowCount:=RecCount+1;
               if OldTopRow<=grdData.RowCount-1 then begin
                  grdData.TopRow:=OldTopRow;
               end;
            end;
            if AFullLoad or ASetOthersAsNotLoaded then begin
               for i:=0 to RecCount-1 do begin
                  if ((i>=LimitOffset) and (i<=LimitOffset+LimitCount-1)) then begin
                     FArrayId[i]:=TP2SBFQueryResultOID(QueryResultOIDList.Items[i-LimitOffset]).OID.ID;
                     FArrayLoaded[i]:=True;
                     FillGridRow(i+1,TSocio(ResultSet.Items[i-LimitOffset]));
                  end else begin
                     FArrayId[i]:=0;
                     FArrayLoaded[i]:=False;
                     ClearGridRow(i+1);
                  end;
                  // Auto Select row if necessary
                  if (FArrayId[i]=APOIDToSelect) and (FArrayId[i]<>0) then begin
                     grdData.Row:=i+1;
                  end;
               end;
            end else begin
               for i:=LimitOffset to LimitOffset+LimitCount-1 do begin
                  FArrayId[i]:=TP2SBFQueryResultOID(QueryResultOIDList.Items[i-LimitOffset]).OID.ID;
                  FArrayLoaded[i]:=True;
                  FillGridRow(i+1,TSocio(ResultSet.Items[i-LimitOffset]));
                  // Auto Select row if necessary
                  if (FArrayId[i]=APOIDToSelect) and (FArrayId[i]<>0) then begin
                     grdData.Row:=i+1;
                  end;
               end;
            end;
         end;
      finally
         ResultSet.Free;
         QueryResultOIDList.Free;
         // Free final criteria list
         for i:=0 to FinalCriteriaList.Count-1 do begin
            Criteria:=TP2SBFCriteria(FinalCriteriaList.Items[i]);
            Criteria.Free;
         end;
         FinalCriteriaList.Clear;
         FinalCriteriaList.Free;
      end;
      //
      if FCriteriaList.Count>0 then begin
         lblPesquisaAvancadaAtiva.Visible:=True;
      end else begin
         lblPesquisaAvancadaAtiva.Visible:=False;
      end;
      // Ensure correct order of exhibition
      if cmdCustomButtons.Visible then begin
         lblPesquisaAvancadaAtiva.Left:=cmdCustomButtons.Left+cmdCustomButtons.Width+1;
         if lblPesquisaAvancadaAtiva.Visible then begin
            lblSeparator.Left:=lblPesquisaAvancadaAtiva.Left+lblPesquisaAvancadaAtiva.Width+1;
         end else begin
            lblSeparator.Left:=cmdCustomButtons.Left+cmdCustomButtons.Width+1;
         end;
      end else begin
         lblPesquisaAvancadaAtiva.Left:=cmdSelectColumns.Left+cmdSelectColumns.Width+1;
         if lblPesquisaAvancadaAtiva.Visible then begin
            lblSeparator.Left:=lblPesquisaAvancadaAtiva.Left+lblPesquisaAvancadaAtiva.Width+1;
         end else begin
            lblSeparator.Left:=cmdSelectColumns.Left+cmdSelectColumns.Width+1;
         end;
      end;
      lblRecordCount.Left:=lblSeparator.Left+lblSeparator.Width+1;
      //
      if RecCount=0 then begin
         lblRecordCount.Caption:='  Nenhum Registro Encontrado  ';
         lblRecordCount.Color:=tlbToolbar.Color;
         lblRecordCount.Font.Color:=clWindowText;
      end else if RecCount=1 then begin
         lblRecordCount.Caption:='  '+IntToStr(RecCount)+' registro  ';
         lblRecordCount.Color:=cRecordCountLabelColor;
         lblRecordCount.Font.Color:=clWhite;
      end else begin
         lblRecordCount.Caption:='  '+IntToStr(RecCount)+' registros  ';
         lblRecordCount.Color:=cRecordCountLabelColor;
         lblRecordCount.Font.Color:=clWhite;
      end;
   finally
      FFlagLoading:=False;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.RefreshVisibleRange
//************************************************************************
procedure TfrmCRUDSocio.RefreshVisibleRange(APOIDToSelect: Integer = 0);
var
   b1,b2: Integer;
   FlagLoad: Boolean;
begin
   GetGridVisibleRange(b1,b2,FlagLoad);
   if b1<1 then b1:=1;
   if b1<=b2 then begin
      LoadData(APOIDToSelect,False,b1-1,(b2-b1)+1,True);
      grdDataTopLeftChanged(grdData);   // Autocorrect if the number of records has been changed since last refresh and there is at least one visible unloaded record
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.RefreshVisibleRangeOnBackground
//************************************************************************
procedure TfrmCRUDSocio.RefreshVisibleRangeOnBackground(APOIDToSelect: Integer = 0);
var
   RefreshThread: TRefreshThread;
begin
   Self.Enabled:=False;
   grdData.Visible:=False;
   ShowSpinner;

   RefreshThread:=TRefreshThread.Create(True);  // True = create suspended
   RefreshThread.OnTerminate:=RefreshVisibleRangeOnBackgroundTerminate;
   RefreshThread.Form:=Self;
   RefreshThread.POIDToSelect:=APOIDToSelect;
   RefreshThread.Resume;
end;

//************************************************************************
//* TfrmCRUDSocio.RefreshVisibleRangeOnBackgroundTerminate
//************************************************************************
procedure TfrmCRUDSocio.RefreshVisibleRangeOnBackgroundTerminate(Sender: TObject);
begin
   HideSpinner;
   grdData.Visible:=True;
   Self.Enabled:=True;
   //UpdateInternalColumnWidths;
   ResizeGrid;
end;

//************************************************************************
//* TfrmCRUDSocio.UpdateInternalColumnWidths
//************************************************************************
procedure TfrmCRUDSocio.UpdateInternalColumnWidths;
var
   i,c: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
begin
   c:=0;
   for i:=0 to FAvailableColumnList.Count-1 do begin
      AvailableColumn:=FAvailableColumnList.Items[i];
      if AvailableColumn.Visible then begin
         if grdData.ColWidths[c]>0 then begin
            try
               AvailableColumn.ColumnWidth:=(grdData.ColWidths[c]/grdData.ClientWidth)*100.0;
            except
               AvailableColumn.ColumnWidth:=20.0;  // Default
            end;
         end else begin
            AvailableColumn.ColumnWidth:=0.0;
         end;
         c:=c+1;
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.ResizeGrid
//************************************************************************
procedure TfrmCRUDSocio.ResizeGrid;
var
   i,c: Integer;
   AvailableColumn: TCRUDFormAvailableColumn;
begin
   c:=0;
   for i:=0 to FAvailableColumnList.Count-1 do begin
      AvailableColumn:=FAvailableColumnList.Items[i];
      if AvailableColumn.Visible then begin
         if AvailableColumn.ColumnWidth<=0.0 then begin
            grdData.ColWidths[c]:=-1;
         end else begin
            grdData.ColWidths[c]:=Round(grdData.ClientWidth*(AvailableColumn.ColumnWidth/100));
         end;
         c:=c+1;
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.FastSearch
//************************************************************************
procedure TfrmCRUDSocio.FastSearch(AText: string);

   function _GetTextParameter(AText: string): string;
   var
      i: Integer;
      Limit: Integer;
   begin
      Result:=AText;   // Default
      if FOrderByPropertyType=optInteger then begin
         try
            StrToInt(Result);
         except
            Result:=IntToStr(0);
         end;
      end else if FOrderByPropertyType=optDouble then begin
         try
            StrToFloat(Result);
         except
            // Date?
            try
               Result:=IntToStr(Trunc(StrToDate(Result)));
            except
               // Time?
               try
                  Result:=FloatToStr(StrToTime(Result));
               except
                  // Default
                  Result:=FloatToStr(0);
               end;
            end;
         end;
      end else if FOrderByPropertyType=optBoolean then begin
         if (LowerCase(Result)='s') or (LowerCase(Result)='si') or (LowerCase(Result)='sim') then begin
            Result:='T';
         end else begin
            Result:='F';
         end;
      end else if FOrderByPropertyType=optString then begin
         if FOrderByDirection='ASC' then begin
            Limit:=0;
         end else begin
            Limit:=FOrderByPropertyFieldSize;
         end;
         for i:=Length(AText)+1 to Limit do begin
            Result:=Result+Chr(255);
         end;
      end;
   end;

var
   i,Id: Integer;
   FinalCriteriaList: TP2SBFCriteriaList;
   Criteria: TP2SBFCriteria;
   ResultSet: TList;
   RecCount: Integer;
begin
   // Build final criteria list = search criteria + filter criteria
   FinalCriteriaList:=TP2SBFCriteriaList.Create;
   Criteria:=TP2SBFCriteria.Create;
   ResultSet:=TList.Create;
   try
      SetupFinalCriteriaList(FinalCriteriaList);
      Criteria.PropName:=FOrderByPropertyName;
      if FOrderByDirection='ASC' then begin
         Criteria.Operator:=ocoLessThan;
      end else begin
         Criteria.Operator:=ocoGreaterThan;
      end;
      if FOrderByPropertyType=optInteger then begin
         // Order by Integer
         Criteria.PropValue.AsInteger:=StrToInt(_GetTextParameter(AText));
      end else if FOrderByPropertyType=optDouble then begin
         // Order by Double
         Criteria.PropValue.AsDouble:=StrToFloat(_GetTextParameter(AText));
      end else begin
         // Default: Order by String
         Criteria.PropValue.AsString:=_GetTextParameter(AText);
      end;
      FinalCriteriaList.Add(Criteria);
      // Count how many objects there are before the desired one
      RecCount:=gP2SBFObjRepos.QueryPersistentObjects(TSocio,FinalCriteriaList,ResultSet,FOrderByPropertyName+' '+FOrderByDirection,False,False,0,1);
   finally
      ResultSet.Free;
      // Free final criteria list
      for i:=0 to FinalCriteriaList.Count-1 do begin
         Criteria:=TP2SBFCriteria(FinalCriteriaList.Items[i]);
         Criteria.Free;
      end;
      FinalCriteriaList.Clear;
      FinalCriteriaList.Free;
   end;
   // Put the grid in the right row
   if RecCount+1<=grdData.RowCount-1 then begin
      grdData.Row:=RecCount+1;
   end else begin
      grdData.Row:=grdData.RowCount-1;
   end;
   
//$$** SECTION: FAST_SEARCH_END_USER
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmCRUDSocio.FastSearchOnBackground
//************************************************************************
procedure TfrmCRUDSocio.FastSearchOnBackground(AText: string);
var
   FastSearchThread: TFastSearchThread;
   RunThread: Boolean;
begin
   RunThread:=False;
   if FCurrentFastSearchThread=nil then begin
      FCurrentFastSearchThread:=TFastSearchThread.Create(True);  // True = create suspended
      FastSearchThread:=FCurrentFastSearchThread;
      grdData.Visible:=False;
      ShowSpinner;
      RunThread:=True;
   end else begin
      // Se j� h� um pr�ximo thread esperando, o texto de busca ser� sobreposto
      // por este, mais atualizado.
      if FNextFastSearchThread=nil then begin
         FNextFastSearchThread:=TFastSearchThread.Create(True);  // True = create suspended
      end;
      FastSearchThread:=FNextFastSearchThread;
   end;
   // Setup thread
   FastSearchThread.OnTerminate:=FastSearchOnBackgroundTerminate;
   FastSearchThread.FreeOnTerminate:=True;
   FastSearchThread.Form:=Self;
   FastSearchThread.Text:=AText;
   if RunThread then begin
      FastSearchThread.Resume;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.FastSearchOnBackgroundTerminate
//************************************************************************
procedure TfrmCRUDSocio.FastSearchOnBackgroundTerminate(Sender: TObject);
begin
   FCurrentFastSearchThread:=FNextFastSearchThread;
   FNextFastSearchThread:=nil;
   if FCurrentFastSearchThread<>nil then begin
      // J� h� outra busca aguardando para ser feita. Dispara essa busca sem
      // reexibir o grid.
      FCurrentFastSearchThread.Resume;
   end else begin
      HideSpinner;
      grdData.Visible:=True;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.SelectRowByPOID
//************************************************************************
procedure TfrmCRUDSocio.SelectRowByPOID(APOID: Integer);
var
   i: Integer;
begin
   for i:=0 to High(FArrayId) do begin
      if FArrayId[i]=APOID then begin
         grdData.Row:=i+1;
         Break;
      end;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.SetupPermissions
//************************************************************************
procedure TfrmCRUDSocio.SetupPermissions;
var
   PermissionToView: Boolean;
   PermissionToList: Boolean;
   PermissionToInsert: Boolean;
   PermissionToDelete: Boolean;
   PermissionToUpdate: Boolean;
begin
   // Setup screen according to permissions
   if cCRUDPermissionId>0 then begin
      PermissionToView:=False;    // Default
      PermissionToList:=False;    // Default
      PermissionToInsert:=False;  // Default
      PermissionToDelete:=False;  // Default
      PermissionToUpdate:=False;  // Default
      _gSysAccessControl.CheckLoggedUserPermissions(cCRUDPermissionId,
                                                    PermissionToView,
                                                    PermissionToList,
                                                    PermissionToInsert,
                                                    PermissionToDelete,
                                                    PermissionToUpdate);
      FPermissionToView:=PermissionToView;
      if PermissionToView then begin
         // View OK. Check other permissions.
         grdData.Visible:=True;
         lblRecordCount.Visible:=True;
         pnlNotAllowed.Visible:=False;
         cmdInsert.Visible:=PermissionToInsert;
         cmdDelete.Visible:=PermissionToDelete;
         cmdEdit.Visible:=PermissionToUpdate;
         cmdRefresh.Visible:=True;
         cmdSeparator1.Visible:=cmdInsert.Visible or cmdDelete.Visible or cmdEdit.Visible;
         cmdList.Visible:=PermissionToList;
         cmdExportToExcel.Visible:=cmdList.Visible;
         cmdSeparator2.Visible:=cmdList.Visible;
         cmdSearch.Visible:=True;
         cmdCancelSearch.Visible:=True;
         cmdSelectColumns.Visible:=True;
         txtFastSearch.Enabled:=True;
         txtFastSearch.Color:=clWindow;
      end else begin
         // View not allowed
         pnlNotAllowed.Visible:=True;
         grdData.Visible:=False;
         lblRecordCount.Visible:=False;
         cmdInsert.Visible:=False;
         cmdDelete.Visible:=False;
         cmdEdit.Visible:=False;
         cmdRefresh.Visible:=False;
         cmdSeparator1.Visible:=False;
         cmdList.Visible:=False;
         cmdExportToExcel.Visible:=False;
         cmdSeparator2.Visible:=False;
         cmdSearch.Visible:=False;
         cmdCancelSearch.Visible:=False;
         cmdSelectColumns.Visible:=False;
         txtFastSearch.Enabled:=False;
         txtFastSearch.Color:=pnlTop.Color;
      end;
   end else begin
      // No associated permission. Allow all.
      FPermissionToView:=True;
      grdData.Visible:=True;
      lblRecordCount.Visible:=True;
      pnlNotAllowed.Visible:=False;
      cmdInsert.Visible:=True;
      cmdDelete.Visible:=True;
      cmdEdit.Visible:=True;
      cmdRefresh.Visible:=True;
      cmdSeparator1.Visible:=True;
      cmdList.Visible:=True;
      cmdExportToExcel.Visible:=True;
      cmdSeparator2.Visible:=True;
      cmdSearch.Visible:=True;
      cmdCancelSearch.Visible:=True;
      cmdSelectColumns.Visible:=True;
      txtFastSearch.Enabled:=True;
      txtFastSearch.Color:=clWindow;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.SetupFilters
//************************************************************************
procedure TfrmCRUDSocio.SetupFilters;
begin
//$$** SECTION: SETUP_FILTERS
//$$** ENDSECTION
end;

//************************************************************************
//* TfrmCRUDSocio.List
//************************************************************************
procedure TfrmCRUDSocio.List(AOrientation: TPrinterOrientation);

   function _GetArrayIndexTotalCols(AArrayColNameTotalCols: TStringDynArray): TIntegerDynArray;
   var
      i: Integer;
   begin
      SetLength(Result,Length(AArrayColNameTotalCols));
      for i:=0 to High(Result) do begin
         Result[i]:=FAvailableColumnList.VisibleIndexOf(FAvailableColumnList.ItemByName(AArrayColNameTotalCols[i]));
      end;
   end;

var
   ReportGenerator: TClientReportGenerator;
   SubTitle: string;
   IdToRefresh: Integer;
   ArrayColNameTotalCols: TStringDynArray;
begin
   SubTitle:='';
//$$** SECTION: GET_LIST_SUBTITLE
//$$** ENDSECTION
   SetLength(ArrayColNameTotalCols,0);
//$$** SECTION: SET_ARRAY_TOTAL_COLS
//$$** ENDSECTION
   Screen.Cursor:=crHourglass;
   if High(FArrayId)>=0 then begin
      IdToRefresh:=FArrayId[grdData.Row-1];
   end else begin
      IdToRefresh:=0;
   end;
   // Refresh
   LoadData(IdToRefresh,True);  // Full load
   // Create report generator
   ReportGenerator:=TClientReportGenerator.Create;
   Screen.Cursor:=crDefault;
   // Show report
   ReportGenerator.GenerateReportFromGrid(grdData,lblTitle.Caption,SubTitle,_GetArrayIndexTotalCols(ArrayColNameTotalCols),[],[],_GetArrayIndexTotalCols(ArrayColNameTotalCols),AOrientation);
   // Free mem
   ReportGenerator.Free;
end;

//************************************************************************
//* TfrmCRUDSocio.CanCreateObject
//************************************************************************
function  TfrmCRUDSocio.CanCreateObject: Boolean;
//$$** SECTION: CANCREATEOBJECT_FULLIMPL
begin
   Result:=True;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.InitializeNewObject
//************************************************************************
procedure TfrmCRUDSocio.InitializeNewObject(ANewObject: TSocio);
//$$** SECTION: INITIALIZENEWOBJECT_FULLIMPL
begin
   //
   FIsNewCreate:= True;
   ANewObject.TemLocPendente:= False;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.AfterInsert
//************************************************************************
procedure TfrmCRUDSocio.AfterInsert(AObject: TSocio);
//$$** SECTION: AFTERINSERT_FULLIMPL
begin
   //
    FIsNewCreate:= False;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.BeforeDelete
//************************************************************************
procedure TfrmCRUDSocio.BeforeDelete(AObject: TSocio);
//$$** SECTION: BEFOREDELETE_FULLIMPL
var
   NewObjectLog: TLog;
begin
   //
   NewObjectLog:= TLog.Create();

   NewObjectLog.DataLog:= Date();
   NewObjectLog.HoraLog:= Time();
   NewObjectLog.Tela:= 'S';

   if FIsNewCreate then
   begin
      NewObjectLog.Referencia:= 'Usuario clicou em Cancelar';
      NewObjectLog.Acao:='C';
   end else begin
      NewObjectLog.Referencia:= 'Num. Carteira: '+ AObject.NumeroCarteira
      + #13+ 'Nome: '+AObject.NomeExibicao;
      NewObjectLog.Acao:='D';
   end;

   NewObjectLog.OidObject:= AObject.OID.ID;
   NewObjectLog.Save(false, false);
   NewObjectLog.Refresh;
   FIsNewCreate:= False;
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.AfterDelete
//************************************************************************
procedure TfrmCRUDSocio.AfterDelete;
//$$** SECTION: AFTERDELETE_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.AfterEdit
//************************************************************************
procedure TfrmCRUDSocio.AfterEdit(AObject: TSocio);
//$$** SECTION: AFTEREDIT_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//$$** SECTION: FILTERS_COMBOS_LOOKUP_METHODS
//$$** ENDSECTION

//************************************************************************
//* TfrmCRUDSocio.ShowSpinner
//************************************************************************
procedure TfrmCRUDSocio.ShowSpinner;
begin
   if not pnlSpinner.Visible then begin
      pnlSpinner.Width:=90;
      pnlSpinner.Height:=83;
      pnlSpinner.Left:=grdData.Left+((grdData.Width-pnlSpinner.Width) div 2);
      pnlSpinner.Top:=grdData.Top+((grdData.Height-pnlSpinner.Height) div 2);
      pnlSpinner.Visible:=True;
      pnlSpinner.BringToFront;
      TGIFImage(imgSpinner.Picture.Graphic).Animate:=True;
   end;
end;

//************************************************************************
//* TfrmCRUDSocio.HideSpinner
//************************************************************************
procedure TfrmCRUDSocio.HideSpinner;
begin
   TGIFImage(imgSpinner.Picture.Graphic).Animate:=False;
   pnlSpinner.Visible:=False;
   pnlSpinner.Align:=alNone;
end;

(*
//************************************************************************
//* TfrmCRUDSocio.VisibleChanging
//************************************************************************
procedure TfrmCRUDSocio.VisibleChanging;
begin
  {if Visible then
    FormStyle := fsNormal
  else
    FormStyle := fsMDIChild;}
end;
*)

//************************************************************************
//* TRefreshThread.Execute
//************************************************************************
procedure TRefreshThread.Execute;
begin
   FForm.RefreshVisibleRange(FPOIDToSelect);
end;

//************************************************************************
//* TFastSearchThread.Execute
//************************************************************************
procedure TFastSearchThread.Execute;
begin
   FForm.FastSearch(FText);
end;

//************************************************************************
//* TgrdDataTopLeftChangedThread.Execute
//************************************************************************
procedure TgrdDataTopLeftChangedThread.Execute;
begin
   FForm.grdDataTopLeftChanged(FForm.grdData);
end;

//$$** SECTION: USERMETHODS_FULLIMPL
//$$** ENDSECTION

end.
