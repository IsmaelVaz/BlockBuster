unit ufrmGeneralSearchMergeCriteriaSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  uP2SBFParams, StdCtrls;

type
  TfrmGeneralSearchMergeCriteriaSelection = class(TForm)
    grpCriteriaSelection: TGroupBox;
    lblCriteriaSelection: TLabel;
    lstCriteriaList: TListBox;
    cmdYes: TButton;
    cmdNo: TButton;
    cmdCancel: TButton;
    procedure cmdYesClick(Sender: TObject);
    procedure cmdNoClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function OpenForCriteriaSelection(ACriteriaList: TP2SBFCriteriaList; ACriteriaListDesc: TStringList; var ACriteriaIndex: Integer): Boolean;
  end;

var
  frmGeneralSearchMergeCriteriaSelection: TfrmGeneralSearchMergeCriteriaSelection;

implementation

{$R *.dfm}

//************************************************************************
//* TfrmGeneralSearchMergeCriteriaSelection.cmdYesClick
//************************************************************************
procedure TfrmGeneralSearchMergeCriteriaSelection.cmdYesClick(
  Sender: TObject);
begin
   ModalResult:=mrYes;
end;

//************************************************************************
//* TfrmGeneralSearchMergeCriteriaSelection.cmdNoClick
//************************************************************************
procedure TfrmGeneralSearchMergeCriteriaSelection.cmdNoClick(
  Sender: TObject);
begin
   ModalResult:=mrNo;
end;

//************************************************************************
//* TfrmGeneralSearchMergeCriteriaSelection.cmdCancelClick
//************************************************************************
procedure TfrmGeneralSearchMergeCriteriaSelection.cmdCancelClick(
  Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmGeneralSearchMergeCriteriaSelection.OpenForCriteriaSelection
//************************************************************************
function TfrmGeneralSearchMergeCriteriaSelection.OpenForCriteriaSelection(ACriteriaList: TP2SBFCriteriaList; ACriteriaListDesc: TStringList; var ACriteriaIndex: Integer): Boolean;
var
   i: Integer;
   r: TModalResult;
begin
   // Setup criteria list
   lstCriteriaList.Items.Clear;
   for i:=0 to ACriteriaListDesc.Count-1 do begin
      lstCriteriaList.Items.Add(ACriteriaListDesc.Strings[i]);
   end;
   if lstCriteriaList.Count>0 then begin
      // Select the first item as a default value
      lstCriteriaList.ItemIndex:=0;
   end;
   // Show
   r:=ShowModal;
   // Verify result
   case r of
      mrYes:
         begin
            ACriteriaIndex:=lstCriteriaList.ItemIndex;
            Result:=True;
         end;
      mrNo:
         begin
            ACriteriaIndex:=-1;
            Result:=True;
         end;
      else
         begin
            Result:=False;
         end;
   end;
end;

end.
