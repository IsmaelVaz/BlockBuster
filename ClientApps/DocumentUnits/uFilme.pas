unit uFilme;

interface

uses SysUtils,Classes,Printers,EasyDocument,Graphics,Math,IdSMTP,
     uModelClient,uP2SBFAbsModelTypes,uP2SBFSystemModelClientForms;

type

//************************************************************************
//* TFilme
//************************************************************************
TFilme = class(TP2SBFClientDocument)
   protected
      procedure DocumentCustomSetup; override;
      procedure NewPage(DrawObject: TDrawObject; var YStart: Double; var YEnd: Double); override;
      procedure DrawHeader(ADrawObject: TDrawObject; var Y: Double); override;
      procedure DrawFooter(ADrawObject: TDrawObject; var Y: Double); override;
      procedure DrawDocument(DrawObject: TDrawObject); override;
end;

implementation

//$$** SECTION: IMPLEMENTATION_USES

uses uDocumentsCommons;

//$$** ENDSECTION

//************************************************************************
//* TFilme.DocumentCustomSetup
//************************************************************************
procedure TFilme.DocumentCustomSetup;
//$$** SECTION: DOCUMENTCUSTOMSETUP_FULLIMPL
begin
   inherited DocumentCustomSetup;
   TDocumentsCommons.SetupEMail(FEasyDocument);
end;
//$$** ENDSECTION

//************************************************************************
//* TFilme.NewPage
//************************************************************************
procedure TFilme.NewPage(DrawObject: TDrawObject; var YStart: Double; var YEnd: Double);
//$$** SECTION: NEWPAGE_FULLIMPL
begin
   FParams.Title:=FEasyDocument.Title;
   FParams.SubTitle:='';
   FParams.ShowDateTime:=True;
   FParams.ShowNumberOfRecords:=False;
   FParams.NumberOfRecords:=0;
   inherited NewPage(DrawObject,YStart,YEnd);
end;
//$$** ENDSECTION

//************************************************************************
//* TFilme.DrawHeader
//************************************************************************
procedure TFilme.DrawHeader(ADrawObject: TDrawObject; var Y: Double);
//$$** SECTION: DRAWHEADER_FULLIMPL
begin
   TDocumentsCommons.DrawHeader(ADrawObject,Y,FParams);
end;
//$$** ENDSECTION

//************************************************************************
//* TFilme.DrawFooter
//************************************************************************
procedure TFilme.DrawFooter(ADrawObject: TDrawObject; var Y: Double);
//$$** SECTION: DRAWFOOTER_FULLIMPL
begin
   TDocumentsCommons.DrawFooter(ADrawObject,Y,FParams);
end;
//$$** ENDSECTION

//************************************************************************
//* TFilme.DrawDocument
//************************************************************************
procedure TFilme.DrawDocument(DrawObject: TDrawObject);
//$$** SECTION: DRAWDOCUMENT_FULLIMPL
begin
//
end;
//$$** ENDSECTION

end.
