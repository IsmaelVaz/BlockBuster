unit ufrmGeneralSelectionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmGeneralSelectionDialog = class(TForm)
    rdgOptions: TRadioGroup;
    pnlBottom: TPanel;
    cmdOk: TBitBtn;
    cmdCancel: TBitBtn;
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Select(AItems: TStringList; var ASelectedIndex: Integer): Boolean; virtual;
  end;

var
  frmGeneralSelectionDialog: TfrmGeneralSelectionDialog;

implementation

{$R *.dfm}

//************************************************************************
//* TfrmGeneralSelectionDialog.cmdOkClick
//************************************************************************
procedure TfrmGeneralSelectionDialog.cmdOkClick(Sender: TObject);
begin
   if rdgOptions.ItemIndex=-1 then begin
      Application.MessageBox('É necessário selecionar uma opção.','Aviso',MB_ICONINFORMATION);
      rdgOptions.SetFocus;
      Exit;
   end;
   ModalResult:=mrOk;
end;

//************************************************************************
//* TfrmGeneralSelectionDialog.cmdCancelClick
//************************************************************************
procedure TfrmGeneralSelectionDialog.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

//************************************************************************
//* TfrmGeneralSelectionDialog.Select
//************************************************************************
function TfrmGeneralSelectionDialog.Select(AItems: TStringList; var ASelectedIndex: Integer): Boolean;
var
   i: Integer;
begin
   // Fill Radio Group with Options
   rdgOptions.Items.Clear;
   for i:=0 to AItems.Count-1 do begin
      rdgOptions.Items.Add(AItems.Strings[i]);
   end;
   // Resize Radio Group to fit all Radio Buttons
   rdgOptions.Height:=40*rdgOptions.Items.Count;
   ClientHeight:=rdgOptions.Top+rdgOptions.Height+8+pnlBottom.Height;
   // The first item is the default option
   if rdgOptions.Items.Count>0 then begin
      rdgOptions.ItemIndex:=0;
   end;
   // Show form
   if ShowModal=mrOk then begin
      ASelectedIndex:=rdgOptions.ItemIndex;
      Result:=True;
   end else begin
      Result:=False;
   end;
end;

end.
