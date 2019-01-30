unit uDocumentsCommons;

interface

uses SysUtils,Classes,Printers,EasyDocument,Graphics,IdSMTP,
     uP2SBFSystemModelClientForms;

type

//************************************************************************
//* TDocumentsCommons
//************************************************************************
TDocumentsCommons = class(TObject)
   public
      class procedure SetupEMail(AEasyDocument: TEasyDocument); virtual;
      class procedure DrawHeader(ADrawObject: TDrawObject; var Y: Double; AParams: TDocumentHeaderFooterParams); virtual;
      class procedure DrawFooter(ADrawObject: TDrawObject; var Y: Double; AParams: TDocumentHeaderFooterParams); virtual;
end;

implementation

//$$** SECTION: IMPLEMENTATION_USES
//$$** ENDSECTION

const

//$$** SECTION: MARGIN_CONSTANTS

   ucTopMargin = 0.05;
   ucBottomMargin = 0.05;
   ucLeftMargin = 0.05;
   ucRightMargin = 0.05;

//$$** ENDSECTION

//************************************************************************
//* TDocumentsCommons.SetupEMail
//************************************************************************
class procedure TDocumentsCommons.SetupEMail(AEasyDocument: TEasyDocument);
//$$** SECTION: SETUPEMAIL_FULLIMPL
begin
   //
end;
//$$** ENDSECTION

//************************************************************************
//* TDocumentsCommons.DrawHeader
//************************************************************************
class procedure TDocumentsCommons.DrawHeader(ADrawObject: TDrawObject; var Y: Double; AParams: TDocumentHeaderFooterParams);
//$$** SECTION: DRAWHEADER_FULLIMPL
var
   H: Double;
   OldFont: TFont;
begin
   with ADrawObject do begin
      OldFont:=TFont.Create;
      OldFont.Assign(Font);
      // Initialize font
      Font.Name:='Verdana';
      Font.Size:=16;
      Font.Style:=[fsBold];
      Y:=ucTopMargin;
      H:=TextHeight(ucLeftMargin,1.0-ucRightMargin,AParams.Title);
      TextOutArea(Y,ucLeftMargin,Y+H,1.0-ucRightMargin,AParams.Title,Font.Size,True,True);
      Y:=Y+H+0.03;
      if AParams.SubTitle<>'' then begin
         Font.Size:=12;
         Font.Style:=[fsBold];
         H:=TextHeight(ucLeftMargin,1.0-ucRightMargin,AParams.SubTitle);
         TextOutArea(Y,ucLeftMargin,Y+H,1.0-ucRightMargin,AParams.SubTitle,Font.Size,True,True);
         Y:=Y+H+0.015;
      end;
      //Font.Size:=OldFont.Size;
      Font.Size:=8;
      Font.Style:=[];
      // Number of records
      if AParams.ShowNumberOfRecords then begin
         H:=TextHeight(ucLeftMargin,1.0-ucRightMargin,'X');
         TextOutArea(Y,ucLeftMargin,Y+H,1.0-ucRightMargin,IntToStr(AParams.NumberOfRecords)+' registro(s)',Font.Size,True,True);
         Y:=Y+H+0.005;
      end;
      Font.Assign(OldFont);
      OldFont.Free;
   end;

end;
//$$** ENDSECTION

//************************************************************************
//* TDocumentsCommons.DrawFooter
//************************************************************************
class procedure TDocumentsCommons.DrawFooter(ADrawObject: TDrawObject; var Y: Double; AParams: TDocumentHeaderFooterParams);
//$$** SECTION: DRAWFOOTER_FULLIMPL
var
   LineHeight: Double;
   LineWidth: Double;
   DateTimeText: string;
   OldFont: TFont;
   OldPen: TPen;
begin
   with ADrawObject do begin
      OldFont:=TFont.Create;
      OldPen:=TPen.Create;
      OldFont.Assign(Font);
      OldPen.Assign(Pen);
      // Initialize font
      Font.Name:='Verdana';
      Font.Size:=8;
      Font.Style:=[];
      Y:=1.0-ucBottomMargin;
      LineHeight:=TextHeight(ucLeftMargin,1.0-ucRightMargin,'X',8);
      Y:=Y-LineHeight;
      // Date and time
      if AParams.ShowDateTime then begin
         DateTimeText:='Emitido em '+FormatDateTime('dd/mm/yyyy hh:nn:ss',Now);
         TextOutArea(Y,ucLeftMargin,Y+LineHeight,1.0-ucRightMargin,DateTimeText,8,False,False);
      end;
      // Page Number
      LineWidth:=TextWidth(IntToStr(AParams.PageNumber),8);
      TextOutArea(Y,1.0-ucRightMargin-LineWidth-0.01,Y+LineHeight,1.0-ucRightMargin,IntToStr(AParams.PageNumber),8,True,False);
      Y:=Y-0.01;
      // Separator
      Pen.Color:=clBlack;
      Pen.Width:=2;
      MoveTo(Y,ucLeftMargin);
      LineTo(Y,1.0-ucRightMargin);
      Y:=Y-0.02;
      Font.Assign(OldFont);
      Pen.Assign(OldPen);
      OldPen.Free;
      OldFont.Free;
   end;
end;
//$$** ENDSECTION

end.
