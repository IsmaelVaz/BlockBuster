unit ufrmGroupPermissions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids,
  uP2SBFSystemModelClient;

type
  TfrmGroupPermissions = class(TForm)
    grpPermissions: TGroupBox;
    grdPermissions: TStringGrid;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    cmdOk: TBitBtn;
    cmdCancel: TBitBtn;
    imgUnchecked: TImage;
    imgChecked: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure grdPermissionsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdPermissionsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FObject: TSysGroup;
    procedure UpdateObject;
    procedure UpdateScreen;
    function  ValidateScreen: Boolean;
    function  FindPermission(APermissionId: Integer): TSysPermission;
  public
    { Public declarations }
    function Open(AObject: TSysGroup): Boolean;
  end;

var
  frmGroupPermissions: TfrmGroupPermissions;

implementation

{$R *.dfm}

uses uPermissions;

//************************************************************************
//* TfrmGroupPermissions.FormCreate
//************************************************************************
procedure TfrmGroupPermissions.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   // Initialize window
   WindowState:=wsMaximized;
   // Initialize grid
   grdPermissions.Cells[0,0]:='Permissão';
   grdPermissions.Cells[1,0]:='Vis';
   grdPermissions.Cells[2,0]:='Lst';
   grdPermissions.Cells[3,0]:='Ins';
   grdPermissions.Cells[4,0]:='Exc';
   grdPermissions.Cells[5,0]:='Edt';
   if High(_gPermissionDefinitionArray)>=0 then begin
      grdPermissions.RowCount:=High(_gPermissionDefinitionArray)+2;
      for i:=0 to High(_gPermissionDefinitionArray) do begin
         grdPermissions.Cells[0,i+1]:=_gPermissionDefinitionArray[i].Title;
      end;
   end else begin
      grdPermissions.RowCount:=2;
      grdPermissions.Cells[0,1]:='';
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.FormDestroy
//************************************************************************
procedure TfrmGroupPermissions.FormDestroy(Sender: TObject);
begin
//
end;

//************************************************************************
//* TfrmGroupPermissions.FormKeyDown
//************************************************************************
procedure TfrmGroupPermissions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   i: Integer;
   Permission: TSysPermission;
begin
   if (Key=VK_F8) or (Key=VK_F9) then begin
      Screen.Cursor:=crHourglass;
      try
         for i:=0 to High(_gPermissionDefinitionArray) do begin
            Permission:=FindPermission(_gPermissionDefinitionArray[i].PermissionId);
            if Permission=nil then begin
               Permission:=TSysPermission.Create;
               Permission.PermissionId:=_gPermissionDefinitionArray[i].PermissionId;
               Permission.ViewValue:=False;
               Permission.ListValue:=False;
               Permission.InsertValue:=False;
               Permission.DeleteValue:=False;
               Permission.UpdateValue:=False;
               FObject.Permissions.Add(Permission);
            end;
            if Key=VK_F8 then begin
               // Select all
               if _gPermissionDefinitionArray[i].HasView then begin
                  Permission.ViewValue:=True;
               end;
               if _gPermissionDefinitionArray[i].HasList then begin
                  Permission.ListValue:=True;
               end;
               if _gPermissionDefinitionArray[i].HasInsert then begin
                  Permission.InsertValue:=True;
               end;
               if _gPermissionDefinitionArray[i].HasDelete then begin
                  Permission.DeleteValue:=True;
               end;
               if _gPermissionDefinitionArray[i].HasUpdate then begin
                  Permission.UpdateValue:=True;
               end;
            end else begin
               // Unselect all
               if _gPermissionDefinitionArray[i].HasView then begin
                  Permission.ViewValue:=False;
               end;
               if _gPermissionDefinitionArray[i].HasList then begin
                  Permission.ListValue:=False;
               end;
               if _gPermissionDefinitionArray[i].HasInsert then begin
                  Permission.InsertValue:=False;
               end;
               if _gPermissionDefinitionArray[i].HasDelete then begin
                  Permission.DeleteValue:=False;
               end;
               if _gPermissionDefinitionArray[i].HasUpdate then begin
                  Permission.UpdateValue:=False;
               end;
            end;
         end;
      finally
         grdPermissions.Refresh;
         Screen.Cursor:=crDefault;
      end;
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.FormResize
//************************************************************************
procedure TfrmGroupPermissions.FormResize(Sender: TObject);
const
   cCheckColWidth = 64;
var
   FirstColWidth: Integer;
begin
   // Resize group box
   grpPermissions.Width:=ClientWidth-(grpPermissions.Left*2);
   grpPermissions.Height:=ClientHeight-pnlBottom.Height-(grpPermissions.Top*2);
   // Resize grid
   grdPermissions.Width:=grpPermissions.ClientWidth-(grdPermissions.Left*2);
   grdPermissions.Height:=grpPermissions.ClientHeight-(grdPermissions.Top*2);
   // Resize grid columns
   FirstColWidth:=grdPermissions.ClientWidth-(5*cCheckColWidth)-5;
   if FirstColWidth<200 then FirstColWidth:=200;
   grdPermissions.ColWidths[0]:=FirstColWidth;
   grdPermissions.ColWidths[1]:=cCheckColWidth;
   grdPermissions.ColWidths[2]:=cCheckColWidth;
   grdPermissions.ColWidths[3]:=cCheckColWidth;
   grdPermissions.ColWidths[4]:=cCheckColWidth;
   grdPermissions.ColWidths[5]:=cCheckColWidth;
end;

//************************************************************************
//* TfrmGroupPermissions.grdPermissionsDrawCell
//************************************************************************
procedure TfrmGroupPermissions.grdPermissionsDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   Grid: TStringGrid;
   Permission: TSysPermission;
begin
   Grid:=TStringGrid(Sender);
   Grid.Canvas.Font.Name:='Tahoma';
   if (ARow=0) or (ACol=0) then begin
      if ARow=0 then begin
         Grid.Canvas.Font.Style:=[fsBold];
         Grid.Canvas.Brush.Color:=clBtnFace;
      end else begin
         Grid.Canvas.Font.Style:=[];
         Grid.Canvas.Brush.Color:=Grid.Color;
      end;
      Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,Grid.Cells[ACol,ARow]);
   end else begin
      Grid.Canvas.Brush.Color:=Grid.Color;
      Grid.Canvas.FillRect(Rect);
      if High(_gPermissionDefinitionArray)>=0 then begin
         // Find permission. If it does not exist, create one
         Permission:=FindPermission(_gPermissionDefinitionArray[ARow-1].PermissionId);
         if Permission=nil then begin
            Permission:=TSysPermission.Create;
            Permission.PermissionId:=_gPermissionDefinitionArray[ARow-1].PermissionId;
            Permission.ViewValue:=False;
            Permission.ListValue:=False;
            Permission.InsertValue:=False;
            Permission.DeleteValue:=False;
            Permission.UpdateValue:=False;
            FObject.Permissions.Add(Permission);
         end;
         // View
         if (_gPermissionDefinitionArray[ARow-1].HasView) and (ACol=1) then begin
            if Permission.ViewValue then begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgChecked.Width) div 2,(Rect.Top+Rect.Bottom-imgChecked.Height) div 2,imgChecked.Picture.Bitmap);
            end else begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgUnchecked.Width) div 2,(Rect.Top+Rect.Bottom-imgUnchecked.Height) div 2,imgUnchecked.Picture.Bitmap);
            end;
         end;
         // List
         if (_gPermissionDefinitionArray[ARow-1].HasList) and (ACol=2) then begin
            if Permission.ListValue then begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgChecked.Width) div 2,(Rect.Top+Rect.Bottom-imgChecked.Height) div 2,imgChecked.Picture.Bitmap);
            end else begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgUnchecked.Width) div 2,(Rect.Top+Rect.Bottom-imgUnchecked.Height) div 2,imgUnchecked.Picture.Bitmap);
            end;
         end;
         // Insert
         if (_gPermissionDefinitionArray[ARow-1].HasInsert) and (ACol=3) then begin
            if Permission.InsertValue then begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgChecked.Width) div 2,(Rect.Top+Rect.Bottom-imgChecked.Height) div 2,imgChecked.Picture.Bitmap);
            end else begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgUnchecked.Width) div 2,(Rect.Top+Rect.Bottom-imgUnchecked.Height) div 2,imgUnchecked.Picture.Bitmap);
            end;
         end;
         // Delete
         if (_gPermissionDefinitionArray[ARow-1].HasDelete) and (ACol=4) then begin
            if Permission.DeleteValue then begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgChecked.Width) div 2,(Rect.Top+Rect.Bottom-imgChecked.Height) div 2,imgChecked.Picture.Bitmap);
            end else begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgUnchecked.Width) div 2,(Rect.Top+Rect.Bottom-imgUnchecked.Height) div 2,imgUnchecked.Picture.Bitmap);
            end;
         end;
         // Update
         if (_gPermissionDefinitionArray[ARow-1].HasUpdate) and (ACol=5) then begin
            if Permission.UpdateValue then begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgChecked.Width) div 2,(Rect.Top+Rect.Bottom-imgChecked.Height) div 2,imgChecked.Picture.Bitmap);
            end else begin
               Grid.Canvas.Draw((Rect.Left+Rect.Right-imgUnchecked.Width) div 2,(Rect.Top+Rect.Bottom-imgUnchecked.Height) div 2,imgUnchecked.Picture.Bitmap);
            end;
         end;
      end;
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.grdPermissionsMouseDown
//************************************************************************
procedure TfrmGroupPermissions.grdPermissionsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   Grid: TStringGrid;
   Col,Row: Integer;
   Permission: TSysPermission;
begin
   Grid:=TStringGrid(Sender);
   Grid.MouseToCell(X,Y,Col,Row);
   if (Row>0) and (Col>0) and (High(_gPermissionDefinitionArray)>=0) then begin
      Permission:=FindPermission(_gPermissionDefinitionArray[Row-1].PermissionId);
      if Permission<>nil then begin
         case Col of
            1: Permission.ViewValue:=not Permission.ViewValue;
            2: Permission.ListValue:=not Permission.ListValue;
            3: Permission.InsertValue:=not Permission.InsertValue;
            4: Permission.DeleteValue:=not Permission.DeleteValue;
            5: Permission.UpdateValue:=not Permission.UpdateValue;
         end;
         Grid.Refresh;
      end;
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.UpdateObject
//************************************************************************
procedure TfrmGroupPermissions.UpdateObject;
begin
//
end;

//************************************************************************
//* TfrmGroupPermissions.UpdateScreen
//************************************************************************
procedure TfrmGroupPermissions.UpdateScreen;
begin
   grpPermissions.Caption:=FObject.Name;
end;

//************************************************************************
//* TfrmGroupPermissions.ValidateScreen
//************************************************************************
function  TfrmGroupPermissions.ValidateScreen: Boolean;
begin
   Result:=True;
end;

//************************************************************************
//* TfrmGroupPermissions.FindPermission
//************************************************************************
function  TfrmGroupPermissions.FindPermission(APermissionId: Integer): TSysPermission;
var
   i: Integer;
begin
   Result:=nil;
   for i:=0 to FObject.Permissions.Count-1 do begin
      if TSysPermission(FObject.Permissions.Items[i]).PermissionId=APermissionId then begin
         Result:=TSysPermission(FObject.Permissions.Items[i]);
         Break;
      end;
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.Open
//************************************************************************
function  TfrmGroupPermissions.Open(AObject: TSysGroup): Boolean;
begin
   Screen.Cursor:=crHourglass;
   FObject:=AObject;
   UpdateScreen;
   Screen.Cursor:=crDefault;
   if ShowModal=mrOk then begin
      Screen.Cursor:=crHourglass;
      UpdateObject;
      FObject.Save;
      Result:=True;
      Screen.Cursor:=crDefault;
   end else begin
      Result:=False;
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.cmdOkClick
//************************************************************************
procedure TfrmGroupPermissions.cmdOkClick(Sender: TObject);
begin
   if ValidateScreen then begin
      ModalResult:=mrOk;
   end;
end;

//************************************************************************
//* TfrmGroupPermissions.cmdCancelClick
//************************************************************************
procedure TfrmGroupPermissions.cmdCancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

end.
