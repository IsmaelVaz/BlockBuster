unit uCRUDFormUtils;

interface

uses SysUtils, Classes,
     uP2SBFUtils;

type

//************************************************************************
//* TCRUDFormAvailableColumn
//************************************************************************
TCRUDFormAvailableColumn = class(TObject)
   protected
      FPropertyName: string;
      FPropertyDescription: string;
      FPropertyType: TP2SBFType;
      FPropertyFieldSize: Integer;
      FColumnWidth: Double;
      FCanOrderBy: Boolean;
      FVisible: Boolean;
      FOrder: Integer;
   public
      procedure Assign(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn); virtual;

      property PropertyName: string read FPropertyName write FPropertyName;
      property PropertyDescription: string read FPropertyDescription write FPropertyDescription;
      property PropertyType: TP2SBFType read FPropertyType write FPropertyType;
      property PropertyFieldSize: Integer read FPropertyFieldSize write FPropertyFieldSize;
      property ColumnWidth: Double read FColumnWidth write FColumnWidth;
      property CanOrderBy: Boolean read FCanOrderBy write FCanOrderBy;
      property Visible: Boolean read FVisible write FVisible;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList
//************************************************************************
TCRUDFormAvailableColumnList = class(TObject)
   protected
      FList: TList;
      procedure ClearList; virtual;
      function GetItem(AIndex: Integer): TCRUDFormAvailableColumn; virtual;
      function GetCount: Integer; virtual;
      function GetVisibleColumnsCount: Integer; virtual;
   public
      constructor Create; virtual;
      destructor Destroy; override;
      procedure Clear; virtual;
      procedure Add(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn); virtual;
      procedure MoveUp(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn); virtual;
      procedure MoveDown(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn); virtual;
      procedure SetOrder(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn; AOrder: Integer); virtual;
      function  IndexOf(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn): Integer; virtual;
      function  IndexByName(AColumnName: string): Integer; virtual;
      function  ItemByName(AColumnName: string): TCRUDFormAvailableColumn; virtual;
      function  VisibleIndexOf(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn): Integer; virtual;
      procedure Assign(ACRUDFormAvailableColumnList: TCRUDFormAvailableColumnList); virtual;

      property Count: Integer read GetCount;
      property VisibleColumnsCount: Integer read GetVisibleColumnsCount;
      property Items[AIndex: Integer]: TCRUDFormAvailableColumn read GetItem;
end;

implementation

//************************************************************************
//* TCRUDFormAvailableColumnList.Assign
//************************************************************************
procedure TCRUDFormAvailableColumn.Assign(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn);
begin
   Self.PropertyName:=ACRUDFormAvailableColumn.PropertyName;
   Self.PropertyDescription:=ACRUDFormAvailableColumn.PropertyDescription;
   Self.PropertyType:=ACRUDFormAvailableColumn.PropertyType;
   Self.PropertyFieldSize:=ACRUDFormAvailableColumn.PropertyFieldSize;
   Self.ColumnWidth:=ACRUDFormAvailableColumn.ColumnWidth;
   Self.CanOrderBy:=ACRUDFormAvailableColumn.CanOrderBy;
   Self.Visible:=ACRUDFormAvailableColumn.Visible;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.Create
//************************************************************************
constructor TCRUDFormAvailableColumnList.Create;
begin
   FList:=TList.Create;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.Destroy
//************************************************************************
destructor TCRUDFormAvailableColumnList.Destroy;
begin
   Self.ClearList;
   FList.Free;
   inherited Destroy;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.Clear
//************************************************************************
procedure TCRUDFormAvailableColumnList.Clear;
begin
   Self.ClearList;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.ClearList
//************************************************************************
procedure TCRUDFormAvailableColumnList.ClearList;
var
   CRUDFormAvailableColumn: TCRUDFormAvailableColumn;
begin
   while FList.Count>0 do begin
      CRUDFormAvailableColumn:=TCRUDFormAvailableColumn(FList.Items[0]);
      FList.Remove(CRUDFormAvailableColumn);
      CRUDFormAvailableColumn.Free;
   end;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.GetItem
//************************************************************************
function TCRUDFormAvailableColumnList.GetItem(AIndex: Integer): TCRUDFormAvailableColumn;
begin
   Result:=TCRUDFormAvailableColumn(FList.Items[AIndex]);
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.GetCount
//************************************************************************
function TCRUDFormAvailableColumnList.GetCount: Integer;
begin
   Result:=FList.Count;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.GetVisibleColumnsCount
//************************************************************************
function TCRUDFormAvailableColumnList.GetVisibleColumnsCount: Integer;
var
   i: Integer;
begin
   Result:=0;
   for i:=0 to Self.Count-1 do begin
      if Self.Items[i].Visible then begin
         Result:=Result+1;
      end;
   end;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.Add
//************************************************************************
procedure TCRUDFormAvailableColumnList.Add(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn);
begin
   FList.Add(ACRUDFormAvailableColumn);
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.MoveUp
//************************************************************************
procedure TCRUDFormAvailableColumnList.MoveUp(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn);
var
   Index: Integer;
begin
   Index:=FList.IndexOf(ACRUDFormAvailableColumn);
   if Index>0 then begin
      FList.Remove(ACRUDFormAvailableColumn);
      FList.Insert(Index-1,ACRUDFormAvailableColumn);
   end;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.MoveDown
//************************************************************************
procedure TCRUDFormAvailableColumnList.MoveDown(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn);
var
   Index: Integer;
begin
   Index:=FList.IndexOf(ACRUDFormAvailableColumn);
   if Index<FList.Count-1 then begin
      FList.Remove(ACRUDFormAvailableColumn);
      FList.Insert(Index+1,ACRUDFormAvailableColumn);
   end;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.SetOrder
//************************************************************************
procedure TCRUDFormAvailableColumnList.SetOrder(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn; AOrder: Integer);
begin
   if AOrder>FList.Count-1 then AOrder:=FList.Count-1;   // Minus 1 because one column will be removed.
   if AOrder<0 then AOrder:=0;
   FList.Remove(ACRUDFormAvailableColumn);
   FList.Insert(AOrder,ACRUDFormAvailableColumn);
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.IndexOf
//************************************************************************
function TCRUDFormAvailableColumnList.IndexOf(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn): Integer;
begin
   Result:=FList.IndexOf(ACRUDFormAvailableColumn);
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.IndexByName
//************************************************************************
function TCRUDFormAvailableColumnList.IndexByName(AColumnName: string): Integer;
var
   i: Integer;
   Column: TCRUDFormAvailableColumn;
begin
   Result:=-1;
   for i:=0 to Self.Count-1 do begin
      Column:=Self.Items[i];
      if LowerCase(Column.PropertyName)=LowerCase(AColumnName) then begin
         Result:=i;
         Break;
      end;
   end;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.ItemByName
//************************************************************************
function TCRUDFormAvailableColumnList.ItemByName(AColumnName: string): TCRUDFormAvailableColumn;
begin
   Result:=Self.Items[Self.IndexByName(AColumnName)];
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.VisibleIndexOf
//************************************************************************
function TCRUDFormAvailableColumnList.VisibleIndexOf(ACRUDFormAvailableColumn: TCRUDFormAvailableColumn): Integer;
var
   i,c: Integer;
   Column: TCRUDFormAvailableColumn;
begin
   Result:=-1;
   c:=0;
   for i:=0 to Self.Count-1 do begin
      Column:=Self.Items[i];
      if Column.Visible then begin
         if Column=ACRUDFormAvailableColumn then begin
            Result:=c;
            Break;
         end;
         c:=c+1;
      end;
   end;
end;

//************************************************************************
//* TCRUDFormAvailableColumnList.Assign
//************************************************************************
procedure TCRUDFormAvailableColumnList.Assign(ACRUDFormAvailableColumnList: TCRUDFormAvailableColumnList);
var
   i,l: Integer;
   Column: TCRUDFormAvailableColumn;
begin
   if ACRUDFormAvailableColumnList.Count>=Self.Count then begin
      l:=Self.Count-1;
   end else begin
      l:=ACRUDFormAvailableColumnList.Count-1;
   end;
   for i:=0 to l do begin
      Self.Items[i].Assign(ACRUDFormAvailableColumnList.Items[i]);
   end;
   if ACRUDFormAvailableColumnList.Count>Self.Count then begin
      for i:=l+1 to ACRUDFormAvailableColumnList.Count-1 do begin
         Column:=TCRUDFormAvailableColumn.Create;
         Column.Assign(ACRUDFormAvailableColumnList.Items[i]);
         Self.Add(Column);
      end;
   end else if Self.Count>ACRUDFormAvailableColumnList.Count then begin
      while Self.Count>ACRUDFormAvailableColumnList.Count do begin
         Column:=Self.Items[Self.Count-1];
         FList.Remove(Column);
         Column.Free;
      end;
   end;
end;

end.
