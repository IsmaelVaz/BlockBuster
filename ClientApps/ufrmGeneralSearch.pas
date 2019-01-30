unit ufrmGeneralSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, IniFiles, Types,
  uP2SBFAbsModelClient,uP2SBFParams;

type
  TfrmGeneralSearch = class(TForm)
    grpSearch: TGroupBox;
    Label1: TLabel;
    cboField: TComboBox;
    Label2: TLabel;
    cboOperator: TComboBox;
    Label3: TLabel;
    Bevel1: TBevel;
    txtValue: TMaskEdit;
    cmdInsertCriteria: TBitBtn;
    lstCriteriaList: TListBox;
    cmdDeleteCriteria: TBitBtn;
    cmdOk: TBitBtn;
    cmdCancel: TBitBtn;
    cboValue: TComboBox;
    chkValue: TCheckBox;
    cmdValue: TButton;
    lblOtherResults: TLabel;
    cmdSave: TBitBtn;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    cmdOpen: TBitBtn;
    cboValueDynamicLoad: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cboFieldClick(Sender: TObject);
    procedure cmdInsertCriteriaClick(Sender: TObject);
    procedure cmdDeleteCriteriaClick(Sender: TObject);
    procedure txtValueKeyPress(Sender: TObject; var Key: Char);
    procedure cmdValueClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdOpenClick(Sender: TObject);
    procedure cboValueDynamicLoadKeyPress(Sender: TObject; var Key: Char);
    procedure cboValueDynamicLoadDropDown(Sender: TObject);
    procedure cboValueDynamicLoadChange(Sender: TObject);
  private
    { Private declarations }
    FClass: TP2SBFAbsPerBizClass;
    FSearchFormId: string;
    FSearchFieldList: TList;
    FOperatorList: TP2SBFCritOpArray;
    FArrayIdLookupCombo: TIntegerDynArray;
    FArrayIdLookupComboDynamicLoad: TIntegerDynArray;
    FInternalCriteriaList: TP2SBFCriteriaList;
    FObjectListCriteria: TList;
    procedure SetupSearchFieldsCombo;
    function  GetCriteriaToInsert(ACriteria: TP2SBFCriteria; var ACriteriaDesc: string): Boolean;
    procedure SaveInternalCriteriaListToStream(AStream: TStream);
    procedure LoadInternalCriteriaListFromStream(AStream: TStream);
  protected
    { Protected declarations }
    procedure LoadItemsComboLookupDynamicLoad(AText: string);
    procedure UpdateComboLookupDynamicLoad;
    procedure SetHorizontalScrollBar(lb: TListBox);
  public
    { Public declarations }
    function Open(ASearchFormId: string; ACriteriaList: TP2SBFCriteriaList; ACriteriaListDesc: TStringList): Boolean;
  end;

var
  frmGeneralSearch: TfrmGeneralSearch;

implementation

{$R *.dfm}

uses uP2SBFAbsModelTypes,uP2SBFClassRegistryClient,uP2SBFUtils,uP2SBFObjReposClient,
     ufrmGeneralSearchMergeCriteriaSelection;

//************************************************************************
//* TfrmGeneralSearch.FormCreate
//************************************************************************
procedure TfrmGeneralSearch.FormCreate(Sender: TObject);
begin
   FSearchFieldList:=TList.Create;
   FObjectListCriteria:=TList.Create;
   FInternalCriteriaList:=TP2SBFCriteriaList.Create;
   SetLength(FOperatorList,0);
   SetLength(FArrayIdLookupCombo,0);
   SetLength(FArrayIdLookupComboDynamicLoad,0);
end;

//************************************************************************
//* TfrmGeneralSearch.FormDestroy
//************************************************************************
procedure TfrmGeneralSearch.FormDestroy(Sender: TObject);
var
   i: Integer;
begin
   // Clear internal criteria list
   for i:=0 to FInternalCriteriaList.Count-1 do begin
      TP2SBFCriteria(FInternalCriteriaList.Items[i]).Free;
   end;
   FInternalCriteriaList.Clear;
   // Free objects
   FObjectListCriteria.Free;
   FInternalCriteriaList.Free;
   FSearchFieldList.Free;
end;

//************************************************************************
//* TfrmGeneralSearch.cboFieldClick
//************************************************************************
procedure TfrmGeneralSearch.cboFieldClick(Sender: TObject);
var
   i: Integer;
   SearchFieldEntry: TP2SBFSearchFieldEntry;
   HasCurrentOperator: Boolean;
   CurrentOperator: TP2SBFCritOp;
   PropertyClass: TP2SBFAbsBizClass;
   //ResultSet: TList;
   DescriptionList: TStringList;
begin
   if cboField.ItemIndex<>-1 then begin
      if cboOperator.ItemIndex<>-1 then begin
         HasCurrentOperator:=True;
         CurrentOperator:=FOperatorList[cboOperator.ItemIndex];
      end else begin
         HasCurrentOperator:=False;
      end;
      SearchFieldEntry:=TP2SBFSearchFieldEntry(FSearchFieldList.Items[cboField.ItemIndex]);
      // Fill operator combo
      cboOperator.Items.Clear;
      case SearchFieldEntry.PropType of
         optString: begin
            if (SearchFieldEntry.PresentationControl<>fpcComboFixed) then begin
               // and (SearchFieldEntry.PresentationMask='') then begin
               cboOperator.Items.Add('é igual a');
               cboOperator.Items.Add('é diferente de');
               cboOperator.Items.Add('começa com');
               cboOperator.Items.Add('contém');
               SetLength(FOperatorList,4);
               FOperatorList[0]:=ocoEquals;
               FOperatorList[1]:=ocoNotEqual;
               FOperatorList[2]:=ocoLikes;
               FOperatorList[3]:=ocoLikes;
            end else begin
               cboOperator.Items.Add('é igual a');
               cboOperator.Items.Add('é diferente de');
               SetLength(FOperatorList,2);
               FOperatorList[0]:=ocoEquals;
               FOperatorList[1]:=ocoNotEqual;
            end;
         end;
         optInteger,optDouble: begin
            if SearchFieldEntry.PresentationControl<>fpcComboFixed then begin
               cboOperator.Items.Add('= (é igual a)');
               cboOperator.Items.Add('<> (é diferente de)');
               cboOperator.Items.Add('> (maior que)');
               cboOperator.Items.Add('>= (maior ou igual a)');
               cboOperator.Items.Add('< (menor que)');
               cboOperator.Items.Add('<= (menor ou igual a)');
               SetLength(FOperatorList,6);
               FOperatorList[0]:=ocoEquals;
               FOperatorList[1]:=ocoNotEqual;
               FOperatorList[2]:=ocoGreaterThan;
               FOperatorList[3]:=ocoGreaterEqualThan;
               FOperatorList[4]:=ocoLessThan;
               FOperatorList[5]:=ocoLessEqualThan;
            end else begin
               cboOperator.Items.Add('é igual a');
               cboOperator.Items.Add('é diferente de');
               SetLength(FOperatorList,2);
               FOperatorList[0]:=ocoEquals;
               FOperatorList[1]:=ocoNotEqual;
            end;
         end;
         optBoolean: begin
            cboOperator.Items.Add('é igual a');
            cboOperator.Items.Add('é diferente de');
            SetLength(FOperatorList,2);
            FOperatorList[0]:=ocoEquals;
            FOperatorList[1]:=ocoNotEqual;
         end;
         optObject: begin
            if gP2SBFClassRegistry.IsObjectProperty(FClass,SearchFieldEntry.PropName) then begin
               cboOperator.Items.Add('é igual a');
               cboOperator.Items.Add('é diferente de');
               SetLength(FOperatorList,2);
               FOperatorList[0]:=ocoEquals;
               FOperatorList[1]:=ocoNotEqual;
            end else if gP2SBFClassRegistry.Is1NObjectProperty(FClass,SearchFieldEntry.PropName) then begin
               cboOperator.Items.Add('contém');
               SetLength(FOperatorList,1);
               FOperatorList[0]:=ocoContainsObject;
            end;
         end;
      end;
      // Show the approppriate presentation control
      txtValue.Visible:=False;
      cboValue.Visible:=False;
      cboValueDynamicLoad.Visible:=False;
      chkValue.Visible:=False;
      cmdValue.Visible:=False;
      lblOtherResults.Visible:=False;
      txtValue.Text:='';
      cboValue.ItemIndex:=-1;
      cboValueDynamicLoad.ItemIndex:=-1;
      cboValueDynamicLoad.Text:='';
      chkValue.Checked:=False;
      FObjectListCriteria.Clear;
      case SearchFieldEntry.PresentationControl of
         fpcEdit: begin
            txtValue.CharCase:=ecNormal;
            txtValue.EditMask:=SearchFieldEntry.PresentationMask;
            txtValue.Visible:=True;
         end;
         fpcCombo: begin
            cboValue.Style:=csDropDown;
            cboValue.Items.Text:=SearchFieldEntry.ComboDisplayList;
            cboValue.Visible:=True;
         end;
         fpcComboFixed: begin
            cboValue.Style:=csDropDownList;
            cboValue.Items.Text:=SearchFieldEntry.ComboDisplayList;
            cboValue.Visible:=True;
         end;
         fpcComboLookup: begin
            if not SearchFieldEntry.LookupComboDynamicLoad then begin
               Screen.Cursor:=crHourglass;
               cboValue.Style:=csDropDownList;
               cboValue.Items.Clear;
               SetLength(FArrayIdLookupCombo,0);
               // Get lookup items
               PropertyClass:=gP2SBFClassRegistry.GetObjectPropertyClass(FClass,SearchFieldEntry.PropName);
               if PropertyClass=nil then begin
                  PropertyClass:=gP2SBFClassRegistry.Get1NObjectPropertyClass(FClass,SearchFieldEntry.PropName);
               end;
               if PropertyClass<>nil then begin
                  // Prepare ResultSet
                  {ResultSet:=TList.Create;
                  gP2SBFObjRepos.QueryPersistentObjects(TP2SBFAbsPerBizClass(PropertyClass),SearchFieldEntry.LookupComboCriteriaList,ResultSet,SearchFieldEntry.LookupComboPropName,True);
                  SetLength(FArrayIdLookupCombo,ResultSet.Count);
                  // Fill combo
                  for i:=0 to ResultSet.Count-1 do begin
                     cboValue.Items.Add(TP2SBFAbsBizObj(ResultSet.Items[i]).GetSimplePropertyValue(SearchFieldEntry.LookupComboPropName));
                     FArrayIdLookupCombo[i]:=TP2SBFAbsBizObj(ResultSet.Items[i]).OID.ID;
                  end;
                  cboValue.Visible:=True;
                  // Free mem
                  ResultSet.Free;}
                  cboValue.Items.Clear;
                  SetLength(FArrayIdLookupCombo,0);
                  DescriptionList:=TStringList.Create;
                  try
                     gP2SBFObjRepos.QueryDescriptionsOfPersistentObjects(TP2SBFAbsPerBizClass(PropertyClass),SearchFieldEntry.LookupComboCriteriaList,FArrayIdLookupCombo,DescriptionList,SearchFieldEntry.LookupComboPropName,True);
                     cboValue.Items.Clear;
                     cboValue.Items.AddStrings(DescriptionList);
                     cboValue.Visible:=True;
                  finally
                     DescriptionList.Free;
                  end;
               end;
               Screen.Cursor:=crDefault;
            end else begin
               Screen.Cursor:=crHourglass;
               cboValueDynamicLoad.Items.Clear;
               SetLength(FArrayIdLookupComboDynamicLoad,0);
               // Get lookup items
               PropertyClass:=gP2SBFClassRegistry.GetObjectPropertyClass(FClass,SearchFieldEntry.PropName);
               if PropertyClass=nil then begin
                  PropertyClass:=gP2SBFClassRegistry.Get1NObjectPropertyClass(FClass,SearchFieldEntry.PropName);
               end;
               if PropertyClass<>nil then begin
                  cboValueDynamicLoad.Visible:=True;
               end;
               Screen.Cursor:=crDefault;
            end;
         end;
         fpcEMail: begin
            txtValue.CharCase:=ecLowerCase;
            txtValue.EditMask:='';
            txtValue.Visible:=True;
         end;
         fpcDate: begin
            txtValue.CharCase:=ecNormal;
            txtValue.EditMask:='99/99/9999;1;_';
            txtValue.Visible:=True;
         end;
         fpcTime: begin
            txtValue.CharCase:=ecNormal;
            txtValue.EditMask:='99:99:99;1;_';
            txtValue.Visible:=True;
         end;
         fpcDateTime: begin
            txtValue.CharCase:=ecNormal;
            txtValue.EditMask:='99/99/9999 99:99:99;1;_';
            txtValue.Visible:=True;
         end;
         fpcCurrency: begin
            txtValue.CharCase:=ecNormal;
            txtValue.EditMask:='';
            txtValue.Visible:=True;
         end;
         fpcMemo: begin
            txtValue.CharCase:=ecNormal;
            txtValue.EditMask:='';
            txtValue.Visible:=True;
         end;
         fpcCheck: begin
            chkValue.Visible:=True;
         end;
         fpcFormButton: begin
            cmdValue.Visible:=True;
         end;
         fpcPartsGrid: begin
            cmdValue.Visible:=True;
         end;
      end;
      // Reselect operator
      if HasCurrentOperator then begin
         for i:=0 to High(FOperatorList) do begin
            if FOperatorList[i]=CurrentOperator then begin
               cboOperator.ItemIndex:=i;
               Break;
            end;
         end;
      end;
      if (cboOperator.ItemIndex=-1) and (cboOperator.Items.Count=1) then begin
         cboOperator.ItemIndex:=0;
      end;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cboValueDynamicLoadKeyPress
//************************************************************************
procedure TfrmGeneralSearch.cboValueDynamicLoadKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Key<>#13 then begin
      cboValueDynamicLoad.Tag:=1;
   end else begin
      cboValueDynamicLoad.Tag:=0;
      if (cboValueDynamicLoad.ItemIndex=-1) and (cboValueDynamicLoad.Items.Count>0) then cboValueDynamicLoad.ItemIndex:=0;
      cboValueDynamicLoadChange(Self);
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cboValueDynamicLoadDropDown
//************************************************************************
procedure TfrmGeneralSearch.cboValueDynamicLoadDropDown(Sender: TObject);
begin
   UpdateComboLookupDynamicLoad;
end;

//************************************************************************
//* TfrmGeneralSearch.cboValueDynamicLoadChange
//************************************************************************
procedure TfrmGeneralSearch.cboValueDynamicLoadChange(Sender: TObject);
var
   Text: string;
   SelStart: Integer;
begin
   // Update items
   if cboValueDynamicLoad.Tag=1 then begin
      cboValueDynamicLoad.Tag:=0;
      SelStart:=cboValueDynamicLoad.SelStart;
      Text:=cboValueDynamicLoad.Text;
      if cboValueDynamicLoad.DroppedDown then begin
         UpdateComboLookupDynamicLoad;
      end else begin
         cboValueDynamicLoad.DroppedDown:=True;
      end;
      cboValueDynamicLoad.Text:=Text;
      cboValueDynamicLoad.SelStart:=SelStart;
   {end else begin
      try
         Screen.Cursor:=crHourglass;
         // Update variable
         if (cboValueDynamicLoad.ItemIndex<>-1) and (cboValueDynamicLoad.Items.Count>0) then begin
            UpdateVar_VendedorRep:=POID(FArrayLookupIdVendedorRep[cboValueDynamicLoad.ItemIndex]);
         end else begin
            UpdateVar_VendedorRep:=NullOID;
         end;
      finally
         Screen.Cursor:=crDefault;
      end;}
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.txtValueKeyPress
//************************************************************************
procedure TfrmGeneralSearch.txtValueKeyPress(Sender: TObject;
  var Key: Char);
begin
   // Check [ENTER]
   if Key=#13 then begin
      Key:=#0;
      cmdInsertCriteriaClick(Self);
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdValueClick
//************************************************************************
procedure TfrmGeneralSearch.cmdValueClick(Sender: TObject);
var
   i: Integer;
   SearchFieldEntry: TP2SBFSearchFieldEntry;
   SubSearchForm: TfrmGeneralSearch;
   SubCriteriaList: TP2SBFCriteriaList;
   SubCriteriaDescList: TStringList;
   SubSearchClass: TP2SBFAbsPerBizClass;
   ResultSet: TList;
begin
   // Get search field entry
   SearchFieldEntry:=TP2SBFSearchFieldEntry(FSearchFieldList.Items[cboField.ItemIndex]);
   // Create sub search form
   SubSearchForm:=TfrmGeneralSearch.Create(Self);
   SubSearchForm.Position:=poDesigned;
   SubSearchForm.Left:=Self.Left+16;
   SubSearchForm.Top:=Self.Top+16;
   // Create criteria list objects
   SubCriteriaList:=TP2SBFCriteriaList.Create;
   SubCriteriaDescList:=TStringList.Create;
   // Open form
   if SubSearchForm.Open(SearchFieldEntry.SubSearchFormId,SubCriteriaList,SubCriteriaDescList) then begin
      Screen.Cursor:=crHourglass;
      SubSearchClass:=gP2SBFClassRegistry.GetClassBySearchFormId(SearchFieldEntry.SubSearchFormId);
      ResultSet:=TList.Create;
      // Query objects
      gP2SBFObjRepos.QueryPersistentObjects(SubSearchClass,SubCriteriaList,ResultSet,'',False);
      // Add objects to the internal object list criteria
      FObjectListCriteria.Clear;
      for i:=0 to ResultSet.Count-1 do begin
         FObjectListCriteria.Add(TP2SBFAbsPerBizObj(ResultSet.Items[i]));
      end;
      ResultSet.Free;
      lblOtherResults.Visible:=True;
      Screen.Cursor:=crDefault;
   end;
   // Free objects
   SubSearchForm.Free;
   SubCriteriaList.Free;
   SubCriteriaDescList.Free;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdInsertCriteriaClick
//************************************************************************
procedure TfrmGeneralSearch.cmdInsertCriteriaClick(Sender: TObject);
var
   i: Integer;
   NewCriteria,MergeCriteria: TP2SBFCriteria;
   CriteriaDesc: string;
   PossibleMergeCriteriaList: TP2SBFCriteriaList;
   PossibleMergeCriteriaListDesc: TStringList;
   OriginalIndexArray: array of Integer;
   MergeCriteriaIndex: Integer;
   FlagCanceled: Boolean;
begin
   NewCriteria:=TP2SBFCriteria.Create;
   if GetCriteriaToInsert(NewCriteria,CriteriaDesc) then begin
      PossibleMergeCriteriaList:=TP2SBFCriteriaList.Create;
      PossibleMergeCriteriaListDesc:=TStringList.Create;
      SetLength(OriginalIndexArray,0);
      try
         FlagCanceled:=False;
         // Check if there are criterias that could be merged with an "OR"
         for i:=0 to FInternalCriteriaList.Count-1 do begin
            if (NewCriteria.PropName=TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropName) and
               (NewCriteria.Operator=TP2SBFCriteria(FInternalCriteriaList.Items[i]).Operator) and
               (NewCriteria.PropValue.VariableType=TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.VariableType) then begin
               // Possible criteria to merge
               PossibleMergeCriteriaList.Add(TP2SBFCriteria(FInternalCriteriaList.Items[i]));
               PossibleMergeCriteriaListDesc.Add(lstCriteriaList.Items.Strings[i]);
               SetLength(OriginalIndexArray,High(OriginalIndexArray)+2);
               OriginalIndexArray[High(OriginalIndexArray)]:=i;
            end;
         end;
         // Is there any of them?
         if PossibleMergeCriteriaList.Count>0 then begin
            // Yes: user must choose which one he/she wants to merge, or even choose none of them.
            Application.CreateForm(TfrmGeneralSearchMergeCriteriaSelection,frmGeneralSearchMergeCriteriaSelection);
            if frmGeneralSearchMergeCriteriaSelection.OpenForCriteriaSelection(PossibleMergeCriteriaList,PossibleMergeCriteriaListDesc,MergeCriteriaIndex) then begin
               if MergeCriteriaIndex<>-1 then begin
                  MergeCriteria:=TP2SBFCriteria(PossibleMergeCriteriaList.Items[MergeCriteriaIndex]);
               end else begin
                  MergeCriteria:=nil;
               end;
            end else begin
               FlagCanceled:=True;
            end;
         end else begin
            // No possible criterias to merge
            MergeCriteria:=nil;
         end;
         if not FlagCanceled then begin
            if MergeCriteria=nil then begin
               // If there is no criteria to merge, add the new criteria to the list, normally
               FInternalCriteriaList.Add(NewCriteria);
               lstCriteriaList.Items.Add(CriteriaDesc);
               SetHorizontalScrollBar(lstCriteriaList);
            end else begin
               // Merge
               MergeCriteria.Merge(NewCriteria);
               // Merge description
               lstCriteriaList.Items.Strings[OriginalIndexArray[MergeCriteriaIndex]]:=lstCriteriaList.Items.Strings[OriginalIndexArray[MergeCriteriaIndex]]+' OU '+CriteriaDesc;
               SetHorizontalScrollBar(lstCriteriaList);
               NewCriteria.Free;
            end;
         end;
      finally
         PossibleMergeCriteriaList.Free;
         PossibleMergeCriteriaListDesc.Free;
      end;
   end else begin
      NewCriteria.Free;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdDeleteCriteriaClick
//************************************************************************
procedure TfrmGeneralSearch.cmdDeleteCriteriaClick(Sender: TObject);
var
   Criteria: TP2SBFCriteria;
begin
   if lstCriteriaList.ItemIndex<>-1 then begin
      if Application.MessageBox('Confirma a exclusão do critério selecionado?','Confirmação',MB_ICONQUESTION+MB_OKCANCEL)=IDOK then begin
         Criteria:=TP2SBFCriteria(FInternalCriteriaList.Items[lstCriteriaList.ItemIndex]);
         FInternalCriteriaList.Remove(Criteria);
         Criteria.Free;
         lstCriteriaList.DeleteSelected;
         SetHorizontalScrollBar(lstCriteriaList);
      end;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdOpenClick
//************************************************************************
procedure TfrmGeneralSearch.cmdOpenClick(Sender: TObject);
var
   MemStream: TMemoryStream;
   StrList: TStringList;
begin
   if dlgOpen.Execute then begin
      Screen.Cursor:=crHourglass;
      MemStream:=TMemoryStream.Create;
      StrList:=TStringList.Create;
      try
         StrList.LoadFromFile(dlgOpen.FileName);
         StrList.SaveToStream(MemStream);
         MemStream.Position:=0;
         LoadInternalCriteriaListFromStream(MemStream);
      finally
         StrList.Free;
         MemStream.Free;
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdSaveClick
//************************************************************************
procedure TfrmGeneralSearch.cmdSaveClick(Sender: TObject);
var
   MemStream: TMemoryStream;
   StrList: TStringList;
begin
   if dlgSave.Execute then begin
      Screen.Cursor:=crHourglass;
      MemStream:=TMemoryStream.Create;
      StrList:=TStringList.Create;
      try
         SaveInternalCriteriaListToStream(MemStream);
         StrList.LoadFromStream(MemStream);
         StrList.SaveToFile(dlgSave.FileName);
         Screen.Cursor:=crDefault;
         Application.MessageBox('Pesquisa gravada com sucesso.','Aviso',MB_ICONINFORMATION);
      finally
         StrList.Free;
         MemStream.Free;
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdOkClick
//************************************************************************
procedure TfrmGeneralSearch.cmdOkClick(Sender: TObject);
begin
   ModalResult:=mrOk;
end;

//************************************************************************
//* TfrmGeneralSearch.cmdCancelClick
//************************************************************************
procedure TfrmGeneralSearch.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmGeneralSearch.LoadItemsComboLookupDynamicLoad
//************************************************************************
procedure TfrmGeneralSearch.LoadItemsComboLookupDynamicLoad(AText: string);
var
   SearchFieldEntry: TP2SBFSearchFieldEntry;
   PropertyClass: TP2SBFAbsBizClass;
   DescriptionList: TStringList;
   Criteria: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
begin
   // Get Search Field Entry
   SearchFieldEntry:=TP2SBFSearchFieldEntry(FSearchFieldList.Items[cboField.ItemIndex]);
   // Get Property Class
   PropertyClass:=gP2SBFClassRegistry.GetObjectPropertyClass(FClass,SearchFieldEntry.PropName);
   if PropertyClass=nil then begin
      PropertyClass:=gP2SBFClassRegistry.Get1NObjectPropertyClass(FClass,SearchFieldEntry.PropName);
   end;
   if PropertyClass<>nil then begin
      DescriptionList:=TStringList.Create;
      Criteria:=TP2SBFCriteria.Create;
      CriteriaList:=TP2SBFCriteriaList.Create;
      try
         CriteriaList.Assign(SearchFieldEntry.LookupComboCriteriaList);
         Criteria.PropName:=SearchFieldEntry.LookupComboPropName;
         Criteria.Operator:=ocoLikes;
         Criteria.PropValue.AsString:=AText+'%';
         CriteriaList.Add(Criteria);
         SetLength(FArrayIdLookupComboDynamicLoad,0);
         gP2SBFObjRepos.QueryDescriptionsOfPersistentObjects(TP2SBFAbsPerBizClass(PropertyClass),CriteriaList,FArrayIdLookupComboDynamicLoad,DescriptionList,SearchFieldEntry.LookupComboPropName,True);
         cboValueDynamicLoad.Items.Clear;
         cboValueDynamicLoad.Items.AddStrings(DescriptionList);
      finally
         CriteriaList.Free;
         Criteria.Free;
         DescriptionList.Free;
      end;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.UpdateComboLookupDynamicLoad
//************************************************************************
procedure TfrmGeneralSearch.UpdateComboLookupDynamicLoad;
begin
   if Trim(cboValueDynamicLoad.Text)<>'' then begin
      Screen.Cursor:=crHourglass;
      LoadItemsComboLookupDynamicLoad(cboValueDynamicLoad.Text);
      Screen.Cursor:=crDefault;
   end else begin
      cboValueDynamicLoad.Items.Clear;
      SetLength(FArrayIdLookupComboDynamicLoad,0);
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.Open
//************************************************************************
function TfrmGeneralSearch.Open(ASearchFormId: string; ACriteriaList: TP2SBFCriteriaList; ACriteriaListDesc: TStringList): Boolean;
var
   i,j: Integer;
   SwapAux: TP2SBFSearchFieldEntry;
   NewCriteria: TP2SBFCriteria;
begin
   FClass:=gP2SBFClassRegistry.GetClassBySearchFormId(ASearchFormId);
   FSearchFormId:=ASearchFormId;
   // Get list of search fields
   gP2SBFClassRegistry.GetSearchFieldListBySearchFormId(ASearchFormId,FSearchFieldList);
   // Order by field name
   for i:=0 to FSearchFieldList.Count-2 do begin
      for j:=i+1 to FSearchFieldList.Count-1 do begin
         if UpperCase(TP2SBFSearchFieldEntry(FSearchFieldList.Items[i]).PresentationName)>UpperCase(TP2SBFSearchFieldEntry(FSearchFieldList.Items[j]).PresentationName) then begin
            SwapAux:=TP2SBFSearchFieldEntry(FSearchFieldList.Items[i]);
            FSearchFieldList.Items[i]:=FSearchFieldList.Items[j];
            FSearchFieldList.Items[j]:=SwapAux;
         end;
      end;
   end;
   // Setup search fields combo
   SetupSearchFieldsCombo;
   // Setup criteria list
   lstCriteriaList.Items.Clear;
   for i:=0 to ACriteriaListDesc.Count-1 do begin
      lstCriteriaList.Items.Add(ACriteriaListDesc.Strings[i]);
   end;
   SetHorizontalScrollBar(lstCriteriaList);
   // Copy criteria list to internal criteria list
   for i:=0 to FInternalCriteriaList.Count-1 do begin
      TP2SBFCriteria(FInternalCriteriaList.Items[i]).Free;
   end;
   FInternalCriteriaList.Clear;
   for i:=0 to ACriteriaList.Count-1 do begin
      NewCriteria:=TP2SBFCriteria.Create;
      NewCriteria.Assign(TP2SBFCriteria(ACriteriaList.Items[i]));
      FInternalCriteriaList.Add(NewCriteria);
   end;
   // Show
   if ShowModal=mrOk then begin
      // Copy internal criteria list to criteria list
      for i:=0 to ACriteriaList.Count-1 do begin
         TP2SBFCriteria(ACriteriaList.Items[i]).Free;
      end;
      ACriteriaList.Clear;
      for i:=0 to FInternalCriteriaList.Count-1 do begin
         NewCriteria:=TP2SBFCriteria.Create;
         NewCriteria.Assign(TP2SBFCriteria(FInternalCriteriaList.Items[i]));
         ACriteriaList.Add(NewCriteria);
      end;
      // Copy internal criteria description list to description list
      ACriteriaListDesc.Clear;
      for i:=0 to lstCriteriaList.Items.Count-1 do begin
         ACriteriaListDesc.Add(lstCriteriaList.Items[i]);
      end;
      Result:=True;
   end else begin
      Result:=False;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.SetupSearchFieldsCombo
//************************************************************************
procedure TfrmGeneralSearch.SetupSearchFieldsCombo;
var
   i: Integer;
begin
   cboField.Items.Clear;
   for i:=0 to FSearchFieldList.Count-1 do begin
      cboField.Items.Add(TP2SBFSearchFieldEntry(FSearchFieldList.Items[i]).PresentationName);
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.GetCriteriaToInsert
//************************************************************************
function TfrmGeneralSearch.GetCriteriaToInsert(ACriteria: TP2SBFCriteria; var ACriteriaDesc: string): Boolean;
var
   i: Integer;
   SearchFieldEntry: TP2SBFSearchFieldEntry;
   StrListAux: TStringList;
begin
   Result:=False;
   if cboField.ItemIndex<>-1 then begin
      if cboOperator.ItemIndex<>-1 then begin
         // Check validity of criteria
         SearchFieldEntry:=TP2SBFSearchFieldEntry(FSearchFieldList.Items[cboField.ItemIndex]);
         case SearchFieldEntry.PresentationControl of
            fpcEdit: begin
               if SearchFieldEntry.PropType=optString then begin
                  ACriteria.PropName:=SearchFieldEntry.PropName;
                  ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                  if cboOperator.ItemIndex=2 then begin
                     ACriteria.PropValue.AsString:=txtValue.Text+'%';
                  end else if cboOperator.ItemIndex=3 then begin
                     ACriteria.PropValue.AsString:='%'+txtValue.Text+'%';
                  end else begin
                     ACriteria.PropValue.AsString:=txtValue.Text;
                  end;
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+txtValue.Text+'"';
                  Result:=True;
               end else if SearchFieldEntry.PropType=optInteger then begin
                  // Integer Test
                  try
                     StrToInt(txtValue.Text);
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsInteger:=StrToInt(txtValue.Text);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' '+txtValue.Text;
                     Result:=True;
                  except
                     Application.MessageBox('O valor digitado deve ser um número inteiro.','Erro',MB_ICONEXCLAMATION);
                     txtValue.SetFocus;
                     txtValue.SelectAll;
                  end;
               end else if SearchFieldEntry.PropType=optDouble then begin
                  // Double Test
                  try
                     StrToFloat(txtValue.Text);
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsDouble:=StrToFloat(txtValue.Text);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' '+txtValue.Text;
                     Result:=True;
                  except
                     Application.MessageBox('O valor digitado deve ser numérico.','Erro',MB_ICONEXCLAMATION);
                     txtValue.SetFocus;
                     txtValue.SelectAll;
                  end;
               end;
            end;
            fpcCombo: begin
               ACriteria.PropName:=SearchFieldEntry.PropName;
               ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
               if cboOperator.ItemIndex=2 then begin
                  ACriteria.PropValue.AsString:=cboValue.Text+'%';
               end else if cboOperator.ItemIndex=3 then begin
                  ACriteria.PropValue.AsString:='%'+cboValue.Text+'%';
               end else begin
                  ACriteria.PropValue.AsString:=cboValue.Text;
               end;
               ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValue.Text+'"';
               Result:=True;
            end;
            fpcComboFixed: begin
               if cboValue.ItemIndex=-1 then begin
                  if SearchFieldEntry.PropType=optString then begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsString:='';
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValue.Text+'"';
                     Result:=True;
                  end else if SearchFieldEntry.PropType=optInteger then begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsInteger:=0;
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValue.Text+'"';
                     Result:=True;
                  end;
               end else begin
                  // Get list of "real" values of the fixed combo
                  StrListAux:=TStringList.Create;
                  StrListAux.Text:=SearchFieldEntry.ComboValuesList;
                  if SearchFieldEntry.PropType=optString then begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsString:=StrListAux.Strings[cboValue.ItemIndex];
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValue.Text+'"';
                     Result:=True;
                  end else if SearchFieldEntry.PropType=optInteger then begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsInteger:=StrToInt(StrListAux.Strings[cboValue.ItemIndex]);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValue.Text+'"';
                     Result:=True;
                  end;
                  StrListAux.Free;
               end;
            end;
            fpcComboLookup: begin
               if not SearchFieldEntry.LookupComboDynamicLoad then begin
                  if cboValue.ItemIndex=-1 then begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsObjectOID:=NullOID;
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (nenhum)';
                     Result:=True;
                  end else begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsObjectOID:=POID(FArrayIdLookupCombo[cboValue.ItemIndex]);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValue.Text+'"';
                     Result:=True;
                  end;
               end else begin
                  if (cboValueDynamicLoad.ItemIndex=-1) or (cboValueDynamicLoad.Items.Count=0) then begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsObjectOID:=NullOID;
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (nenhum)';
                     Result:=True;
                  end else begin
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsObjectOID:=POID(FArrayIdLookupComboDynamicLoad[cboValueDynamicLoad.ItemIndex]);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+cboValueDynamicLoad.Text+'"';
                     Result:=True;
                  end;
               end;
            end;
            fpcEMail: begin
               ACriteria.PropName:=SearchFieldEntry.PropName;
               ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
               if cboOperator.ItemIndex=2 then begin
                  ACriteria.PropValue.AsString:=txtValue.Text+'%';
               end else if cboOperator.ItemIndex=3 then begin
                  ACriteria.PropValue.AsString:='%'+txtValue.Text+'%';
               end else begin
                  ACriteria.PropValue.AsString:=txtValue.Text;
               end;
               ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+txtValue.Text+'"';
               Result:=True;
            end;
            fpcDate: begin
               if txtValue.Text<>'  /  /    ' then begin
                  try
                     StrToDate(txtValue.Text);
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsDouble:=StrToDate(txtValue.Text);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' '+txtValue.Text;
                     Result:=True;
                  except
                     Application.MessageBox('O valor digitado deve ser uma data válida.','Erro',MB_ICONEXCLAMATION);
                     txtValue.SetFocus;
                     txtValue.SelectAll;
                  end;
               end else begin
                  ACriteria.PropName:=SearchFieldEntry.PropName;
                  ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                  ACriteria.PropValue.AsDouble:=0.0;
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (vazio)';
               end;
            end;
            fpcTime: begin
               if txtValue.Text<>'  :  :  ' then begin
                  try
                     StrToTime(txtValue.Text);
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsDouble:=StrToTime(txtValue.Text);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' '+txtValue.Text;
                     Result:=True;
                  except
                     Application.MessageBox('O valor digitado deve ser um horário válido.','Erro',MB_ICONEXCLAMATION);
                     txtValue.SetFocus;
                     txtValue.SelectAll;
                  end;
               end else begin
                  ACriteria.PropName:=SearchFieldEntry.PropName;
                  ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                  ACriteria.PropValue.AsDouble:=0.0;
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (vazio)';
               end;
            end;
            fpcDateTime: begin
               if txtValue.Text<>'  /  /       :  :  ' then begin
                  try
                     StrToDateTime(txtValue.Text);
                     ACriteria.PropName:=SearchFieldEntry.PropName;
                     ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                     ACriteria.PropValue.AsDouble:=StrToDateTime(txtValue.Text);
                     ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' '+txtValue.Text;
                     Result:=True;
                  except
                     Application.MessageBox('O valor digitado deve conter uma data e horário válidos.','Erro',MB_ICONEXCLAMATION);
                     txtValue.SetFocus;
                     txtValue.SelectAll;
                  end;
               end else begin
                  ACriteria.PropName:=SearchFieldEntry.PropName;
                  ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                  ACriteria.PropValue.AsDouble:=0.0;
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (vazio)';
               end;
            end;
            fpcCurrency: begin
               try
                  StrToFloat(txtValue.Text);
                  ACriteria.PropName:=SearchFieldEntry.PropName;
                  ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
                  ACriteria.PropValue.AsDouble:=StrToFloat(txtValue.Text);
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' '+Format('%.2f',[StrToFloat(txtValue.Text)]);
                  Result:=True;
               except
                  Application.MessageBox('O valor digitado deve ser numérico.','Erro',MB_ICONEXCLAMATION);
                  txtValue.SetFocus;
                  txtValue.SelectAll;
               end;
            end;
            fpcMemo: begin
               ACriteria.PropName:=SearchFieldEntry.PropName;
               ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
               if cboOperator.ItemIndex=2 then begin
                  ACriteria.PropValue.AsString:=txtValue.Text+'%';
               end else if cboOperator.ItemIndex=3 then begin
                  ACriteria.PropValue.AsString:='%'+txtValue.Text+'%';
               end else begin
                  ACriteria.PropValue.AsString:=txtValue.Text;
               end;
               ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "'+txtValue.Text+'"';
               Result:=True;
            end;
            fpcCheck: begin
               ACriteria.PropName:=SearchFieldEntry.PropName;
               ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
               ACriteria.PropValue.AsBoolean:=chkValue.Checked;
               if chkValue.Checked then begin
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "Sim"';
               end else begin
                  ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' "Não"';
               end;
               Result:=True;
            end;
            fpcFormButton: begin
               ACriteria.PropName:=SearchFieldEntry.PropName;
               ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
               ACriteria.PropValue.SetArrayLength(FObjectListCriteria.Count,optObject);
               for i:=0 to FObjectListCriteria.Count-1 do begin
                  ACriteria.PropValue.AsObjectOIDElem[i]:=TP2SBFAbsPerBizObj(FObjectListCriteria.Items[i]).OID;
               end;
               ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (Outros Resultados)';
               Result:=True;
            end;
            fpcPartsGrid: begin
               ACriteria.PropName:=SearchFieldEntry.PropName;
               ACriteria.Operator:=FOperatorList[cboOperator.ItemIndex];
               ACriteria.PropValue.SetArrayLength(FObjectListCriteria.Count,optObject);
               for i:=0 to FObjectListCriteria.Count-1 do begin
                  ACriteria.PropValue.AsObjectOIDElem[i]:=TP2SBFAbsPerBizObj(FObjectListCriteria.Items[i]).OID;
               end;
               ACriteriaDesc:=SearchFieldEntry.PresentationName+' '+cboOperator.Text+' (Outros Resultados)';
               Result:=True;
            end;
         end;
      end else begin
         // Operator not selected
         Application.MessageBox('Critério inválido: nenhum operador selecionado.','Erro',MB_ICONEXCLAMATION);
         cboOperator.SetFocus;
         Result:=False;
      end;
   end else begin
      // Field not selected
      Application.MessageBox('Critério inválido: nenhum campo selecionado.','Erro',MB_ICONEXCLAMATION);
      cboField.SetFocus;
      Result:=False;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.SaveInternalCriteriaListToStream
//************************************************************************
procedure TfrmGeneralSearch.SaveInternalCriteriaListToStream(AStream: TStream);

   function _OperatorToString(AOperator: TP2SBFCritOp): string;
   begin
      case AOperator of
         ocoEquals:            Result:='eq';
         ocoNotEqual:          Result:='neq';
         ocoLikes:             Result:='lk';
         ocoGreaterThan:       Result:='gt';
         ocoLessThan:          Result:='lt';
         ocoGreaterEqualThan:  Result:='get';
         ocoLessEqualThan:     Result:='let';
         ocoContainsObject:    Result:='co';
         else                  Result:='';
      end;
   end;

   function _VariableTypeToString(AType: TP2SBFType): string;
   begin
      case AType of
         optUnknown:        Result:='unknown';
         optString:         Result:='string';
         optInteger:        Result:='integer';
         optDouble:         Result:='double';
         optBoolean:        Result:='boolean';
         optObjectOrBlob:   Result:='objectorblob';
         optBlob:           Result:='blob';
         optObject:         Result:='object';
         else               Result:='';
      end;
   end;

var
   i,j: Integer;
   StrList: TStringList;
begin
   StrList:=TStringList.Create;
   try
      StrList.Add('[Main]');
      StrList.Add('SearchFormId='+FSearchFormId);
      StrList.Add('NumberOfItems='+IntToStr(FInternalCriteriaList.Count));
      for i:=0 to FInternalCriteriaList.Count-1 do begin
         StrList.Add('[Criteria'+IntToStr(i+1)+']');
         StrList.Add('Description='+lstCriteriaList.Items[i]);
         StrList.Add('PropName='+TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropName);
         StrList.Add('Operator='+_OperatorToString(TP2SBFCriteria(FInternalCriteriaList.Items[i]).Operator));
         StrList.Add('VariableType='+_VariableTypeToString(TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.VariableType));
         if TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.FlagArray then begin
            StrList.Add('Array=1');
            StrList.Add('ArrayLength='+IntToStr(TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.ArrayLength));
            for j:=0 to TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.ArrayLength-1 do begin
               if TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.VariableType=optObject then begin
                  StrList.Add('PropValue_'+IntToStr(j)+'='+OIDToStr(TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.AsObjectOIDElem[j]));
               end else begin
                  StrList.Add('PropValue_'+IntToStr(j)+'='+TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.AsStringElem[j]);
               end;
            end;
         end else begin
            StrList.Add('Array=0');
            if TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.VariableType=optObject then begin
               StrList.Add('PropValue='+OIDToStr(TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.AsObjectOID));
            end else begin
               StrList.Add('PropValue='+TP2SBFCriteria(FInternalCriteriaList.Items[i]).PropValue.AsString);
            end;
         end;
      end;
      AStream.Size:=0;
      StrList.SaveToStream(AStream);
      AStream.Position:=0;
   finally
      StrList.Free;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.LoadInternalCriteriaListFromStream
//************************************************************************
procedure TfrmGeneralSearch.LoadInternalCriteriaListFromStream(AStream: TStream);

   function _StringToOperator(AOperatorStr: string): TP2SBFCritOp;
   begin
      if AOperatorStr='eq' then begin
         Result:=ocoEquals;
      end else if AOperatorStr='neq' then begin
         Result:=ocoNotEqual;
      end else if AOperatorStr='lk' then begin
         Result:=ocoLikes;
      end else if AOperatorStr='gt' then begin
         Result:=ocoGreaterThan;
      end else if AOperatorStr='lt' then begin
         Result:=ocoLessThan;
      end else if AOperatorStr='get' then begin
         Result:=ocoGreaterEqualThan;
      end else if AOperatorStr='let' then begin
         Result:=ocoLessEqualThan;
      end else if AOperatorStr='co' then begin
         Result:=ocoContainsObject;
      end else begin
         // Default
         Result:=ocoEquals;
      end;
   end;

   function _StringToVariableType(ATypeStr: string): TP2SBFType;
   begin
      if ATypeStr='unknown' then begin
         Result:=optUnknown;
      end else if ATypeStr='string' then begin
         Result:=optString;
      end else if ATypeStr='integer' then begin
         Result:=optInteger;
      end else if ATypeStr='double' then begin
         Result:=optDouble;
      end else if ATypeStr='boolean' then begin
         Result:=optBoolean;
      end else if ATypeStr='objectorblob' then begin
         Result:=optObjectOrBlob;
      end else if ATypeStr='blob' then begin
         Result:=optBlob;
      end else if ATypeStr='object' then begin
         Result:=optObject;
      end;
   end;

var
   i,j: Integer;
   IniFile: TMemIniFile;
   StrList: TStringList;
   NumItems: Integer;
   SectionName: string;
   NewCriteria: TP2SBFCriteria;
begin
   IniFile:=TMemIniFile.Create('');
   StrList:=TStringList.Create;
   try
      AStream.Position:=0;
      StrList.LoadFromStream(AStream);
      IniFile.SetStrings(StrList);

      // Check if the stream corresponds to FSearchFormId
      if UpperCase(IniFile.ReadString('Main','SearchFormId',''))<>UpperCase(FSearchFormId) then begin
         raise Exception.Create('Pesquisa não corresponde a esta tela.');
         Exit;
      end;

      // Yes, go ahead.
      NumItems:=IniFile.ReadInteger('Main','NumberOfItems',0);

      // Copy criteria list to internal criteria list
      for i:=0 to FInternalCriteriaList.Count-1 do begin
         TP2SBFCriteria(FInternalCriteriaList.Items[i]).Free;
      end;
      FInternalCriteriaList.Clear;
      lstCriteriaList.Items.Clear;
      for i:=0 to NumItems-1 do begin
         SectionName:='Criteria'+IntToStr(i+1);
         NewCriteria:=TP2SBFCriteria.Create;
         NewCriteria.PropName:=IniFile.ReadString(SectionName,'PropName','');
         NewCriteria.Operator:=_StringToOperator(IniFile.ReadString(SectionName,'Operator',''));
         if IniFile.ReadInteger(SectionName,'Array',0)<>1 then begin
            if _StringToVariableType(IniFile.ReadString(SectionName,'VariableType',''))=optObject then begin
               NewCriteria.PropValue.AsObjectOID:=StrToOID(IniFile.ReadString(SectionName,'PropValue',''));
            end else begin
               NewCriteria.PropValue.AsString:=IniFile.ReadString(SectionName,'PropValue','');
            end;
         end else begin
            NewCriteria.PropValue.SetArrayLength(IniFile.ReadInteger(SectionName,'ArrayLength',0),_StringToVariableType(IniFile.ReadString(SectionName,'VariableType','')));
            for j:=0 to NewCriteria.PropValue.ArrayLength-1 do begin
               if _StringToVariableType(IniFile.ReadString(SectionName,'VariableType',''))=optObject then begin
                  NewCriteria.PropValue.AsObjectOIDElem[j]:=StrToOID(IniFile.ReadString(SectionName,'PropValue_'+IntToStr(j),''));
               end else begin
                  NewCriteria.PropValue.AsStringElem[j]:=IniFile.ReadString(SectionName,'PropValue_'+IntToStr(j),'');
               end;
            end;
         end;
         NewCriteria.PropValue.VariableType:=_StringToVariableType(IniFile.ReadString(SectionName,'VariableType',''));
         FInternalCriteriaList.Add(NewCriteria);
         lstCriteriaList.Items.Add(IniFile.ReadString(SectionName,'Description',''));
      end;
      SetHorizontalScrollBar(lstCriteriaList);
   finally
      StrList.Free;
      Inifile.Free;
   end;
end;

//************************************************************************
//* TfrmGeneralSearch.SetHorizontalScrollBar
//************************************************************************
procedure TfrmGeneralSearch.SetHorizontalScrollBar(lb: TListBox) ;
var
   j, MaxWidth: integer;
begin
   MaxWidth := 0;
   for j := 0 to lb.Items.Count - 1 do begin
      if MaxWidth < lb.Canvas.TextWidth(lb.Items[j]) then begin
         MaxWidth := lb.Canvas.TextWidth(lb.Items[j]);
      end;
   end;
   SendMessage(lb.Handle,
               LB_SETHORIZONTALEXTENT,
               MaxWidth + 5, 0) ;
end;

end.
