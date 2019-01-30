unit uClientGeneralReports;

interface

uses SysUtils,Graphics,Grids,Forms,Controls,Printers,EasyDocument,ExcelXP;

type

TDocumentOutput = (doScreen, doPrinter, doFile);

//************************************************************************
//* TClientReportGenerator
//************************************************************************
TClientReportGenerator = class(TObject)
   private
      FGrid: TStringGrid;
      FTitle: string;
      FSubTitle: string;
      FSummaryNotes: string;
      FDateTimeOnFooter: Boolean;
      FBooleanCol: Integer;
      FPrintNumRecords: Boolean;
      FArrayTotalCols: array of Integer;
      FArrayTotalDecimalDigits: array of Integer;
      FArrayTotalThousandSeparators: array of Boolean;
      FArrayRightAlignmentCols: array of Integer;
      FArrayPctColWidths: array of Double;
      FFileName: string;
   protected
      procedure DocumentDrawProc(DrawObject: TDrawObject);
      procedure DrawHeaderAndFooter(DrawObject: TDrawObject; APageNumber: Integer; var YStart: Double; var YEnd: Double); virtual;
   public
      property FileName: string read FFileName write FFileName;

      procedure GenerateReportFromGrid(AGrid: TStringGrid; ATitle: string; ASubTitle: string; AArrayTotalCols: array of Integer; AArrayTotalDecimalDigits: array of Integer; AArrayTotalThousandSeparators: array of Boolean; AArrayRightAlignmentCols: array of Integer; AOrientation: TPrinterOrientation = poPortrait; ADateTimeOnFooter: Boolean = True; ASummaryNotes: string = ''; ADocumentOutput: TDocumentOutput = doScreen; ABooleanCol: Integer = -1; APrintNumRecords: Boolean = True);
      procedure ExportGridToExcel(AGrid: TStringGrid; ATitle: string; ASubTitle: string; ABooleanCol: Integer = -1);
end;

implementation

uses uP2SBFSystemModelClientForms,uDocumentsCommons;

const
   ucLeftMargin = 0.05;
   ucRightMargin = 0.05;

//************************************************************************
//* TClientReportGenerator.DocumentDrawProc
//************************************************************************
procedure TClientReportGenerator.DocumentDrawProc(DrawObject: TDrawObject);

   function _FloatToStrWithThousandSep(ANum: Double): string;
   var
      p,i: Integer;
   begin
      Result:=FloatToStr(ANum);
      p:=Pos({$IF CompilerVersion >= 22}FormatSettings.{$IFEND}DecimalSeparator,Result);
      if p<=0 then p:=Length(Result)+1;
      p:=p-1;
      i:=0;
      while (p>=1) do begin
         if (i mod 3 = 0) and (i<>0) then begin
            Result:=Copy(Result,1,p)+{$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator+Copy(Result,p+1,Length(Result)-p);
         end;
         i:=i+1;
         p:=p-1;
      end;
   end;

var
   i,j,k,l,p: Integer;
   Y,YEnd,X,W,H: Double;
   MaxTextHeight: Double;
   FlagNewPage: Boolean;
   ArrayTotals: array of Double;
   RightAlignment: Boolean;
   vTextWidth: Double;
   FinalText: string;
begin
   Screen.Cursor:=crHourglass;
   with DrawObject do begin
      SetLength(ArrayTotals,High(FArrayTotalCols)+1);
      for i:=0 to High(ArrayTotals) do begin
         ArrayTotals[i]:=0.0;
      end;
      FlagNewPage:=True;
      i:=1;
      p:=0;
      while i<=FGrid.RowCount-1 do begin
         if FGrid.RowHeights[i]>0 then begin
            if FlagNewPage then begin
               NewPage;
               p:=p+1;
               // Initialize font
               Font.Name:='Verdana';
               Font.Size:=7;
               Font.Style:=[];
               DrawHeaderAndFooter(DrawObject,p,Y,YEnd);
               FlagNewPage:=False;
            end;
            // Calculate MaxTextHeight
            MaxTextHeight:=0.0;
            X:=ucLeftMargin;
            for j:=0 to FGrid.ColCount-1 do begin
               W:=((1.0-ucLeftMargin-ucRightMargin)*FArrayPctColWidths[j])-0.01;
               if FArrayPctColWidths[j]>0 then begin
                  if Assigned(FGrid.OnDrawCell) then begin
                     FGrid.Canvas.Brush.Assign(FGrid.Brush);
                     FGrid.Canvas.Pen.Color:=clBlack;
                     FGrid.Canvas.Font.Assign(FGrid.Font);
                     FGrid.OnDrawCell(FGrid,j,i,FGrid.CellRect(j,i),[]);
                     Brush.Assign(FGrid.Canvas.Brush);
                     Pen.Assign(FGrid.Canvas.Pen);
                     Font.Color:=FGrid.Canvas.Font.Color;
                     Font.Style:=FGrid.Canvas.Font.Style;
                  end;
                  H:=DrawObject.TextHeight(X,X+W,FGrid.Cells[j,i]);
               end else begin
                  H:=0;
               end;
               if H>MaxTextHeight then MaxTextHeight:=H;
               X:=X+W+0.01;
            end;
            // Draw next detail line
            if Y+MaxTextHeight>=YEnd then begin
               FlagNewPage:=True;
               Continue;
            end else begin
               X:=ucLeftMargin;
               for j:=0 to FGrid.ColCount-1 do begin
                  W:=((1.0-ucLeftMargin-ucRightMargin)*FArrayPctColWidths[j])-0.01;
                  if FArrayPctColWidths[j]>0 then begin
                     if Assigned(FGrid.OnDrawCell) then begin
                        FGrid.Canvas.Brush.Assign(FGrid.Brush);
                        FGrid.Canvas.Pen.Color:=clBlack;
                        FGrid.Canvas.Font.Assign(FGrid.Font);
                        FGrid.OnDrawCell(FGrid,j,i,FGrid.CellRect(j,i),[]);
                        Brush.Assign(FGrid.Canvas.Brush);
                        Pen.Assign(FGrid.Canvas.Pen);
                        Font.Color:=FGrid.Canvas.Font.Color;
                        Font.Style:=FGrid.Canvas.Font.Style;
                     end;
                     RightAlignment:=False;
                     for k:=0 to High(FArrayRightAlignmentCols) do begin
                        if FArrayRightAlignmentCols[k]=j then begin
                           RightAlignment:=True;
                           Break;
                        end;
                     end;
                     if j<>FBooleanCol then begin
                        if not RightAlignment then begin
                           DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,FGrid.Cells[j,i],DrawObject.Font.Size,False,False);
                        end else begin
                           vTextWidth:=DrawObject.TextWidth(FGrid.Cells[j,i],DrawObject.Font.Size);
                           DrawObject.TextOut(Y,X+W-vTextWidth,FGrid.Cells[j,i],DrawObject.Font.Size);
                        end;
                     end else begin
                        if UpperCase(FGrid.Cells[j,i])='T' then begin
                           if not RightAlignment then begin
                              DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,'X',DrawObject.Font.Size,False,False);
                           end else begin
                              vTextWidth:=DrawObject.TextWidth('X',DrawObject.Font.Size);
                              DrawObject.TextOut(Y,X+W-vTextWidth,'X',DrawObject.Font.Size);
                           end;
                        end;
                     end;
                  end;
                  for k:=0 to High(FArrayTotalCols) do begin
                     if FArrayTotalCols[k]=j then begin
                        ArrayTotals[k]:=ArrayTotals[k]+StrToFloatDef(StringReplace(FGrid.Cells[j,i],{$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator,'',[rfReplaceAll]),0.0);
                     end;
                  end;
                  X:=X+W+0.01;
               end;
               //Y:=Y+MaxTextHeight+0.01;
               Y:=Y+MaxTextHeight+0.005;
               i:=i+1;
            end;
         end else begin
            i:=i+1;
         end;
      end;
      if FGrid.RowCount>=2 then begin
         Font.Style:=[];
         Brush.Color:=clWhite;
         Font.Color:=clBlack;
      end;
      // Totals
      if High(FArrayTotalCols)>=0 then begin
         // Calculate MaxTextHeight
         MaxTextHeight:=0.0;
         X:=ucLeftMargin;
         for j:=0 to FGrid.ColCount-1 do begin
            W:=((1.0-ucLeftMargin-ucRightMargin)*FArrayPctColWidths[j])-0.01;
            if FArrayPctColWidths[j]>0 then begin
               for k:=0 to High(FArrayTotalCols) do begin
                  if FArrayTotalCols[k]=j then begin
                     if FArrayTotalDecimalDigits[k]<0 then begin
                        if not FArrayTotalThousandSeparators[k] then begin
                           H:=DrawObject.TextHeight(X,X+W,FloatToStr(ArrayTotals[k]));
                        end else begin
                           H:=DrawObject.TextHeight(X,X+W,_FloatToStrWithThousandSep(ArrayTotals[k]));
                        end;
                     end else begin
                        if not FArrayTotalThousandSeparators[k] then begin
                           H:=DrawObject.TextHeight(X,X+W,Format('%.'+IntToStr(FArrayTotalDecimalDigits[k])+'f',[ArrayTotals[k]]));
                        end else begin
                           H:=DrawObject.TextHeight(X,X+W,Format('%.'+IntToStr(FArrayTotalDecimalDigits[k])+'n',[ArrayTotals[k]]));
                        end;
                     end;
                     if H>MaxTextHeight then MaxTextHeight:=H;
                  end;
               end;
            end;
            X:=X+W+0.01;
         end;
         MaxTextHeight:=MaxTextHeight+0.005;
         // Draw next detail line
         if Y+MaxTextHeight>=YEnd then begin
            NewPage;
            p:=p+1;
            // Initialize font
            Font.Name:='Verdana';
            Font.Size:=8;
            Font.Style:=[];
            DrawHeaderAndFooter(DrawObject,p,Y,YEnd);
         end;
         DrawObject.MoveTo(Y,0.05);
         DrawObject.LineTo(Y,0.95);
         Y:=Y+MaxTextHeight+0.005;
         X:=ucLeftMargin;
         for j:=0 to FGrid.ColCount-1 do begin
            W:=((1.0-ucLeftMargin-ucRightMargin)*FArrayPctColWidths[j])-0.01;
            if FArrayPctColWidths[j]>0 then begin
               for k:=0 to High(FArrayTotalCols) do begin
                  if FArrayTotalCols[k]=j then begin
                     RightAlignment:=False;
                     for l:=0 to High(FArrayRightAlignmentCols) do begin
                        if FArrayRightAlignmentCols[l]=j then begin
                           RightAlignment:=True;
                           Break;
                        end;
                     end;
                     if FArrayTotalDecimalDigits[k]<0 then begin
                        if not FArrayTotalThousandSeparators[k] then begin
                           FinalText:=FloatToStr(ArrayTotals[k]);
                           //DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,FloatToStr(ArrayTotals[k]),DrawObject.Font.Size,False,False);
                        end else begin
                           FinalText:=_FloatToStrWithThousandSep(ArrayTotals[k]);
                           //DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,_FloatToStrWithThousandSep(ArrayTotals[k]),DrawObject.Font.Size,False,False);
                        end;
                     end else begin
                        if not FArrayTotalThousandSeparators[k] then begin
                           FinalText:=Format('%.'+IntToStr(FArrayTotalDecimalDigits[k])+'f',[ArrayTotals[k]]);
                           //DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,Format('%.'+IntToStr(FArrayTotalDecimalDigits[k])+'f',[ArrayTotals[k]]),DrawObject.Font.Size,False,False);
                        end else begin
                           FinalText:=Format('%.'+IntToStr(FArrayTotalDecimalDigits[k])+'n',[ArrayTotals[k]]);
                           //DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,Format('%.'+IntToStr(FArrayTotalDecimalDigits[k])+'n',[ArrayTotals[k]]),DrawObject.Font.Size,False,False);
                        end;
                     end;
                     if not RightAlignment then begin
                        DrawObject.TextOutArea(Y,X,Y+MaxTextHeight,X+W,FinalText,DrawObject.Font.Size,False,False);
                     end else begin
                        vTextWidth:=DrawObject.TextWidth(FinalText,DrawObject.Font.Size);
                        DrawObject.TextOut(Y,X+W-vTextWidth,FinalText,DrawObject.Font.Size);
                     end;
                  end;
               end;
            end;
            X:=X+W+0.01;
         end;
         //Y:=Y+MaxTextHeight+0.01;
         Y:=Y+MaxTextHeight+0.005;
      end;
      // Summary Notes
      if FSummaryNotes<>'' then begin
         H:=DrawObject.TextHeight(ucLeftMargin,(1.0-ucRightMargin),FSummaryNotes);
         if Y+H>=YEnd then begin
            NewPage;
            p:=p+1;
            // Initialize font
            Font.Name:='Verdana';
            Font.Size:=8;
            Font.Style:=[];
            DrawHeaderAndFooter(DrawObject,p,Y,YEnd);
         end;
         DrawObject.TextOutArea(Y,ucLeftMargin,Y+H,(1.0-ucRightMargin),FSummaryNotes,Font.Size,False,False);
      end;
   end;
   Screen.Cursor:=crDefault;
end;

//************************************************************************
//* TClientReportGenerator.DrawHeaderAndFooter
//************************************************************************
procedure TClientReportGenerator.DrawHeaderAndFooter(DrawObject: TDrawObject; APageNumber: Integer; var YStart: Double; var YEnd: Double);
var
   Params: TDocumentHeaderFooterParams;
   i,j: Integer;
   Y,X,W,H: Double;
   MaxTextHeight: Double;
   OldFont: TFont;
   RightAlignment: Boolean;
   vTextWidth: Double;
begin
   // Setup of parameters
   Params.Title:=FTitle;
   Params.SubTitle:=FSubTitle;
   Params.ShowDateTime:=True;
   Params.PageNumber:=APageNumber;
   Params.ShowNumberOfRecords:=FPrintNumRecords;
   Params.NumberOfRecords:=FGrid.RowCount-1;
   // Draw header and footer
   TDocumentsCommons.DrawHeader(DrawObject,YStart,Params);
   TDocumentsCommons.DrawFooter(DrawObject,YEnd,Params);
   //
   with DrawObject do begin
      // Save font
      OldFont:=TFont.Create;
      OldFont.Assign(Font);
      // Initialize font
      Font.Style:=[];
      // Start
      Y:=YStart;
      // Calculate MaxTextHeight
      MaxTextHeight:=0.0;
      X:=ucLeftMargin;
      for i:=0 to FGrid.ColCount-1 do begin
         W:=((1.0-ucLeftMargin-ucRightMargin)*FArrayPctColWidths[i])-0.01;
         if FArrayPctColWidths[i]>0 then begin
            H:=TextHeight(X,X+W,FGrid.Cells[i,0]);
         end else begin
            H:=0;
         end;
         if H>MaxTextHeight then MaxTextHeight:=H;
         X:=X+W+0.01;
      end;
      X:=ucLeftMargin;
      for i:=0 to FGrid.ColCount-1 do begin
         W:=((1.0-ucLeftMargin-ucRightMargin)*FArrayPctColWidths[i])-0.01;
         if FArrayPctColWidths[i]>0 then begin
            RightAlignment:=False;
            for j:=0 to High(FArrayRightAlignmentCols) do begin
               if FArrayRightAlignmentCols[j]=i then begin
                  RightAlignment:=True;
                  Break;
               end;
            end;
            if not RightAlignment then begin
               TextOutArea(Y,X,Y+MaxTextHeight,X+W,FGrid.Cells[i,0],Font.Size,False,True);
            end else begin
               vTextWidth:=TextWidth(FGrid.Cells[i,0],Font.Size);
               TextOut(Y,X+W-vTextWidth,FGrid.Cells[i,0],Font.Size);
            end;
         end;
         X:=X+W+0.01;
      end;
      Y:=Y+MaxTextHeight+0.01;
      Pen.Width:=2;
      Pen.Color:=clBlack;
      MoveTo(Y,ucLeftMargin);
      LineTo(Y,1.0-ucRightMargin);
      Y:=Y+0.01;
      YStart:=Y;
      // Restore font
      Font.Assign(OldFont);
      OldFont.Free;
   end;
end;

//************************************************************************
//* TClientReportGenerator.GenerateReportFromGrid
//************************************************************************
procedure TClientReportGenerator.GenerateReportFromGrid(AGrid: TStringGrid; ATitle: string; ASubTitle: string; AArrayTotalCols: array of Integer; AArrayTotalDecimalDigits: array of Integer; AArrayTotalThousandSeparators: array of Boolean; AArrayRightAlignmentCols: array of Integer; AOrientation: TPrinterOrientation = poPortrait; ADateTimeOnFooter: Boolean = True; ASummaryNotes: string = ''; ADocumentOutput: TDocumentOutput = doScreen; ABooleanCol: Integer = -1; APrintNumRecords: Boolean = True);
var
   i: Integer;
   SumColWidths: Integer;
   esdDocument: TEasyDocument;
begin
   // Setup members
   FGrid:=AGrid;
   FTitle:=ATitle;
   FSubTitle:=ASubTitle;
   FSummaryNotes:=ASummaryNotes;
   FDateTimeOnFooter:=ADateTimeOnFooter;
   FBooleanCol:=ABooleanCol;
   FPrintNumRecords:=APrintNumRecords;
   SetLength(FArrayTotalCols,High(AArrayTotalCols)+1);
   for i:=0 to High(AArrayTotalCols) do begin
      FArrayTotalCols[i]:=AArrayTotalCols[i];
   end;
   SetLength(FArrayTotalDecimalDigits,High(AArrayTotalDecimalDigits)+1);
   for i:=0 to High(AArrayTotalDecimalDigits) do begin
      FArrayTotalDecimalDigits[i]:=AArrayTotalDecimalDigits[i];
   end;
   SetLength(FArrayTotalThousandSeparators,High(AArrayTotalThousandSeparators)+1);
   for i:=0 to High(AArrayTotalThousandSeparators) do begin
      FArrayTotalThousandSeparators[i]:=AArrayTotalThousandSeparators[i];
   end;
   SetLength(FArrayRightAlignmentCols,High(AArrayRightAlignmentCols)+1);
   for i:=0 to High(AArrayRightAlignmentCols) do begin
      FArrayRightAlignmentCols[i]:=AArrayRightAlignmentCols[i];
   end;
   SumColWidths:=0;
   for i:=0 to AGrid.ColCount-1 do begin
      SumColWidths:=SumColWidths+AGrid.ColWidths[i];
   end;
   if SumColWidths=0 then SumColWidths:=100;   // Use a default SumColWidth if it is 0.
   SetLength(FArrayPctColWidths,AGrid.ColCount);
   for i:=0 to AGrid.ColCount-1 do begin
      FArrayPctColWidths[i]:=AGrid.ColWidths[i]/SumColWidths;
   end;
   // Create Easy Document Object
   esdDocument:=TEasyDocument.Create(nil);
   esdDocument.Caption:=ATitle;
   esdDocument.Title:=ATitle;
   esdDocument.Orientation:=AOrientation;
   esdDocument.onDraw:=DocumentDrawProc;
   if ADocumentOutput=doScreen then begin
      esdDocument.Show;
   end else if ADocumentOutput=doPrinter then begin
      esdDocument.Print;
   end else if ADocumentOutput=doFile then begin
      esdDocument.SaveToPDF(Self.FileName);
   end;
   // Free mem
   esdDocument.Free;
end;

//************************************************************************
//* TClientReportGenerator.ExportGridToExcel
//************************************************************************
procedure TClientReportGenerator.ExportGridToExcel(AGrid: TStringGrid; ATitle: string; ASubTitle: string; ABooleanCol: Integer = -1);

   function _IsNumber(AStr: string): Boolean;
   begin
      try
         StrToFloat(StringReplace(AStr,{$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator,'',[rfReplaceAll]));
         Result:=True;
      except
         Result:=False;
      end;
   end;

   function _ContaBarras(AStr: string): Integer;
   var
      i: Integer;
   begin
      Result:=0;
      for i:=1 to Length(AStr) do begin
         if Copy(AStr,i,1)='/' then begin
            Result:=Result+1;
         end;
      end;
   end;

   function _IsDate(AStr: string): Boolean;
   begin
      try
         StrToDate(AStr);
         if _ContaBarras(AStr)<=1 then begin
            Result:=False;
         end else begin
            Result:=True;
         end;
      except
         Result:=False;
      end;
   end;

   function _DateToStrMMDDYYYY(ADate: TDateTime): string;
   begin
      Result:=FormatDateTime('mm/dd/yyyy',ADate);
   end;

var
   i,j,LineNumber,ColNumber: Integer;
   ExcelApplication: TExcelApplication;
   ExcelWorksheet: TExcelWorksheet;
   SumColWidths: Integer;
begin
   ExcelApplication:=TExcelApplication.Create(nil);
   ExcelWorksheet:=TExcelWorksheet.Create(nil);
   try
      // Connect to Excel
      ExcelApplication.Connect;

      // Create a worksheet
      ExcelApplication.WorkBooks.Add(xlWBatWorkSheet,0);
      ExcelWorksheet.ConnectTo(ExcelApplication.Sheets[1] as _WorkSheet);

      with ExcelWorksheet do begin
         // Worksheet name
         //Name:=ATitle;     // Commented to avoid invalid characters
         Name:='PrimeStart';

         // Global attributes
         Columns.Font.Name:='Arial';
         Columns.Font.Size:=8;
         Columns.HorizontalAlignment:=xlHAlignLeft;
         Columns.VerticalAlignment:=xlVAlignCenter;
         Columns.WrapText:=True;

         SumColWidths:=0;
         for i:=0 to AGrid.ColCount-1 do begin
            if AGrid.ColWidths[i]>0 then begin
               SumColWidths:=SumColWidths+AGrid.ColWidths[i];
            end;
         end;

         // Set columns widths
         {ColNumber:=1;
         for i:=0 to AGrid.ColCount-1 do begin
            if AGrid.ColWidths[i]>0 then begin
               //Cells.Item[1,i+1].ColumnWidth:=17.0;
               Cells.Item[1,ColNumber].ColumnWidth:=(AGrid.ColWidths[i]/SumColWidths)*100.0;
               ColNumber:=ColNumber+1;
            end;
         end;}

         // Titles
         Cells.Item[1,1]:=ATitle;
         Cells.Item[1,1].Font.Bold:=True;
         Cells.Item[1,1].WrapText:=False;
         Cells.Item[2,1]:=ASubTitle;
         Cells.Item[2,1].WrapText:=False;
         ColNumber:=1;
         for i:=0 to AGrid.ColCount-1 do begin
            if AGrid.ColWidths[i]>0 then begin
               Cells.Item[4,ColNumber]:=AGrid.Cells[i,0];
               Cells.Item[4,ColNumber].HorizontalAlignment:=xlHAlignCenter;
               Cells.Item[4,ColNumber].Font.Bold:=True;
               ColNumber:=ColNumber+1;
            end;
         end;

         LineNumber:=5;
         // Scan lines
         for i:=1 to AGrid.RowCount-1 do begin
            if AGrid.RowHeights[i]>0 then begin
               ColNumber:=1;
               for j:=0 to AGrid.ColCount-1 do begin
                  // Copy from grid to Excel
                  if AGrid.ColWidths[j]>0 then begin
                     //Cells.Item[LineNumber,ColNumber].NumberFormat:='';
                     if AGrid.Cells[j,i]='' then begin
                        Cells.Item[LineNumber,ColNumber].Value:='';
                     end else if _IsDate(AGrid.Cells[j,i]) then begin
                        try
                           Cells.Item[LineNumber,ColNumber].NumberFormat:='dd/mm/aaaa';  // Date
                        except
                           Cells.Item[LineNumber,ColNumber].NumberFormat:='dd/mm/yyyy';  // Date
                        end;
                        Cells.Item[LineNumber,ColNumber].Value:=_DateToStrMMDDYYYY(StrToDate(AGrid.Cells[j,i]));
                     end else if _IsNumber(AGrid.Cells[j,i]) then begin
                        Cells.Item[LineNumber,ColNumber].Value:=StringReplace(StringReplace(AGrid.Cells[j,i],{$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator,'',[rfReplaceAll]),{$IF CompilerVersion >= 22}FormatSettings.{$IFEND}DecimalSeparator,'.',[rfReplaceAll]);
                        if Length(AGrid.Cells[j,i])>3 then begin
                           if AGrid.Cells[j,i][Length(AGrid.Cells[j,i])-2]={$IF CompilerVersion >= 22}FormatSettings.{$IFEND}DecimalSeparator then begin
                              try
                                 Cells.Item[LineNumber,ColNumber].NumberFormat:='0,00';  // Number
                              except
                                 Cells.Item[LineNumber,ColNumber].NumberFormat:='0.00';  // Number
                              end;
                              Cells.Item[LineNumber,ColNumber].HorizontalAlignment:=xlHAlignRight;
                           end;
                        end;
                     end else begin
                        //Cells.Item[LineNumber,ColNumber].NumberFormat:='@';  // Text
                        if _ContaBarras(AGrid.Cells[j,i])=1 then begin  // Para evitar problema com o campo "Parcela" do financeiro. Ele é numérico e possui apenas uma barra no meio. O Excel pensa que é data e traz formatação errada.
                           Cells.Item[LineNumber,ColNumber].Value:=#39+AGrid.Cells[j,i];
                        end else begin
                           Cells.Item[LineNumber,ColNumber].Value:=AGrid.Cells[j,i];
                        end;
                     end;
                     ColNumber:=ColNumber+1;
                  end;
               end;
               // Next line
               LineNumber:=LineNumber+1;
            end;
         end;

         {LineNumber:=LineNumber+1;

         Range['H1','H'+IntToStr(LineNumber)].HorizontalAlignment:=xlHAlignRight;
         Range['H2','H'+IntToStr(LineNumber)].NumberFormat := '0'+DecimalSeparator+'00';

         Cells.Item[LineNumber,1]:='TOTAL';
         Cells.Item[LineNumber,1].Font.Bold:=True;
         Cells.Item[LineNumber,8].Formula:='=SUM(H2:H'+IntToStr(LineNumber-2)+')';
         }

         // Auto set columns widths
         //Columns.AutoFit;
         ColNumber:=1;
         for i:=0 to AGrid.ColCount-1 do begin
            if AGrid.ColWidths[i]>0 then begin
               Cells.Item[1,ColNumber].ColumnWidth:=100;
               Cells.Item[1,ColNumber].EntireColumn.AutoFit;
               ColNumber:=ColNumber+1;
            end;
         end;

         // Auto set row widths
         for i:=1 to LineNumber do begin
            Cells.Item[i,1].RowHeight:=50;
            Cells.Item[i,1].EntireRow.AutoFit;
         end;
      end;
      ExcelApplication.Visible[0]:=True;
      ExcelApplication.Disconnect;
   finally
      ExcelWorksheet.Free;
      ExcelApplication.Free;
   end;
end;

end.

