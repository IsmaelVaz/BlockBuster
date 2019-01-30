unit ufrmColumnSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls, Types,
  uModelClient,
  uCRUDFormUtils;

type
  TfrmColumnSelection = class(TForm)
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    cmdOk: TBitBtn;
    cmdCancel: TBitBtn;
    chklstColumns: TCheckListBox;
    pnlRight: TPanel;
    cmdSelectAll: TBitBtn;
    cmdUnselectAll: TBitBtn;
    cmdMoveUp: TBitBtn;
    cmdMoveDown: TBitBtn;
    cmdSave: TButton;
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSelectAllClick(Sender: TObject);
    procedure cmdUnselectAllClick(Sender: TObject);
    procedure cmdMoveUpClick(Sender: TObject);
    procedure cmdMoveDownClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    FFormName: string;
    FColumnList: TCRUDFormAvailableColumnList;
    FWorkColumnList: TCRUDFormAvailableColumnList;

    procedure UpdateScreen; virtual;
    procedure UpdateColumnList; virtual;
  public
    { Public declarations }
    function Open(AFormName: string; AColumnList: TCRUDFormAvailableColumnList): Boolean; virtual;
  end;

var
  frmColumnSelection: TfrmColumnSelection;

implementation

{$R *.dfm}


//************************************************************************
//* TfrmColumnSelection.FormCreate
//************************************************************************
procedure TfrmColumnSelection.FormCreate(Sender: TObject);
begin
   FFormName:='';
   FWorkColumnList:=TCRUDFormAvailableColumnList.Create;
end;

//************************************************************************
//* TfrmColumnSelection.FormDestroy
//************************************************************************
procedure TfrmColumnSelection.FormDestroy(Sender: TObject);
begin
   FWorkColumnList.Free;
end;

//************************************************************************
//* TfrmColumnSelection.cmdSelectAllClick
//************************************************************************
procedure TfrmColumnSelection.cmdSelectAllClick(Sender: TObject);
var
   i: Integer;
begin
   for i:=0 to chklstColumns.Items.Count-1 do begin
      chklstColumns.Checked[i]:=True;
   end;
end;

//************************************************************************
//* TfrmColumnSelection.cmdUnselectAllClick
//************************************************************************
procedure TfrmColumnSelection.cmdUnselectAllClick(Sender: TObject);
var
   i: Integer;
begin
   for i:=0 to chklstColumns.Items.Count-1 do begin
      chklstColumns.Checked[i]:=False;
   end;
end;

//************************************************************************
//* TfrmColumnSelection.cmdMoveUpClick
//************************************************************************
procedure TfrmColumnSelection.cmdMoveUpClick(Sender: TObject);
var
   Column: TCRUDFormAvailableColumn;
begin
   if chklstColumns.Items.Count>0 then begin
      UpdateColumnList;
      Column:=FWorkColumnList.Items[chklstColumns.ItemIndex];
      FWorkColumnList.MoveUp(Column);
      UpdateScreen;
      chklstColumns.ItemIndex:=FWorkColumnList.IndexOf(Column);
   end;
end;

//************************************************************************
//* TfrmColumnSelection.cmdMoveDownClick
//************************************************************************
procedure TfrmColumnSelection.cmdMoveDownClick(Sender: TObject);
var
   Column: TCRUDFormAvailableColumn;
begin
   if chklstColumns.Items.Count>0 then begin
      UpdateColumnList;
      Column:=FWorkColumnList.Items[chklstColumns.ItemIndex];
      FWorkColumnList.MoveDown(Column);
      UpdateScreen;
      chklstColumns.ItemIndex:=FWorkColumnList.IndexOf(Column);
   end;
end;

//************************************************************************
//* TfrmColumnSelection.cmdSaveClick
//************************************************************************
procedure TfrmColumnSelection.cmdSaveClick(Sender: TObject);
var
   i: Integer;
   ArrayColumnName: TStringDynArray;
   ArrayVisible: TBooleanDynArray;
   ArrayColWidth: TDoubleDynArray;
   ArrayOrder: TIntegerDynArray;
   Column: TCRUDFormAvailableColumn;
begin
   if Trim(FFormName)<>'' then begin
      // Prepare parameters
      SetLength(ArrayColumnName,FWorkColumnList.Count);
      SetLength(ArrayVisible,FWorkColumnList.Count);
      SetLength(ArrayColWidth,FWorkColumnList.Count);
      SetLength(ArrayOrder,FWorkColumnList.Count);
      for i:=0 to FWorkColumnList.Count-1 do begin
         Column:=FWorkColumnList.Items[i];
         ArrayColumnName[i]:=Column.PropertyName;
         ArrayVisible[i]:=Column.Visible;
         ArrayColWidth[i]:=Column.ColumnWidth;
         ArrayOrder[i]:=i;
      end;
      // Save under the user configuration
      _gSysAccessControl.SetLoggedUserCRUDFormColumnConfig(FFormName,
                                                           ArrayColumnName,
                                                           ArrayVisible,
                                                           ArrayColWidth,
                                                           ArrayOrder);
   end else begin
      raise Exception.Create('Form name is empty.');
   end;
end;

//************************************************************************
//* TfrmColumnSelection.cmdOkClick
//************************************************************************
procedure TfrmColumnSelection.cmdOkClick(Sender: TObject);
var
   i: Integer;
   FNoSelection: Boolean;
begin
   FNoSelection:=True;
   for i:=0 to chklstColumns.Count-1 do begin
      if chklstColumns.Checked[i] then begin
         FNoSelection:=False;
         Break;
      end;
   end;
   if FNoSelection then begin
      Application.MessageBox('É necessário selecionar pelo menos uma coluna.','Aviso',MB_ICONINFORMATION);
      chklstColumns.SetFocus;
      Exit;
   end;
   ModalResult:=mrOk;
end;

//************************************************************************
//* TfrmColumnSelection.cmdCancelClick
//************************************************************************
procedure TfrmColumnSelection.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmColumnSelection.UpdateScreen
//************************************************************************
procedure TfrmColumnSelection.UpdateScreen;
var
   i: Integer;
   Column: TCRUDFormAvailableColumn;
begin
   chklstColumns.Items.Clear;
   for i:=0 to FWorkColumnList.Count-1 do begin
      Column:=FWorkColumnList.Items[i];
      chklstColumns.Items.Add(Column.PropertyDescription);
      chklstColumns.Checked[i]:=Column.Visible;
   end;
end;

//************************************************************************
//* TfrmColumnSelection.UpdateColumnList
//************************************************************************
procedure TfrmColumnSelection.UpdateColumnList;
var
   i: Integer;
   Column: TCRUDFormAvailableColumn;
begin
   for i:=0 to FWorkColumnList.Count-1 do begin
      Column:=FWorkColumnList.Items[i];
      Column.Visible:=chklstColumns.Checked[i];
   end;
end;

//************************************************************************
//* TfrmColumnSelection.Open
//************************************************************************
function TfrmColumnSelection.Open(AFormName: string; AColumnList: TCRUDFormAvailableColumnList): Boolean;
begin
   FFormName:=AFormName;
   FColumnList:=AColumnList;
   FWorkColumnList.Assign(FColumnList);
   UpdateScreen;
   if ShowModal=mrOk then begin
      UpdateColumnList;
      FColumnList.Assign(FWorkColumnList);
      Result:=True;
   end else begin
      Result:=False;
   end;
end;

end.
