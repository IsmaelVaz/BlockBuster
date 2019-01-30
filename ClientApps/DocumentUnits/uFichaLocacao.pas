unit uFichaLocacao;

interface

uses SysUtils,Classes,Printers,EasyDocument,Graphics,Math,IdSMTP,
     uModelClient,uP2SBFAbsModelTypes,uP2SBFSystemModelClientForms;

type

//************************************************************************
//* TFichaLocacao
//************************************************************************
TFichaLocacao = class(TP2SBFClientDocument)
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
//* TFichaLocacao.DocumentCustomSetup
//************************************************************************
procedure TFichaLocacao.DocumentCustomSetup;
//$$** SECTION: DOCUMENTCUSTOMSETUP_FULLIMPL
begin
   inherited DocumentCustomSetup;
   TDocumentsCommons.SetupEMail(FEasyDocument);
end;
//$$** ENDSECTION

//************************************************************************
//* TFichaLocacao.NewPage
//************************************************************************
procedure TFichaLocacao.NewPage(DrawObject: TDrawObject; var YStart: Double; var YEnd: Double);
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
//* TFichaLocacao.DrawHeader
//************************************************************************
procedure TFichaLocacao.DrawHeader(ADrawObject: TDrawObject; var Y: Double);
//$$** SECTION: DRAWHEADER_FULLIMPL
begin
   TDocumentsCommons.DrawHeader(ADrawObject,Y,FParams);
end;
//$$** ENDSECTION

//************************************************************************
//* TFichaLocacao.DrawFooter
//************************************************************************
procedure TFichaLocacao.DrawFooter(ADrawObject: TDrawObject; var Y: Double);
//$$** SECTION: DRAWFOOTER_FULLIMPL
begin
   TDocumentsCommons.DrawFooter(ADrawObject,Y,FParams);
end;
//$$** ENDSECTION

//************************************************************************
//* TFichaLocacao.DrawDocument
//************************************************************************
procedure TFichaLocacao.DrawDocument(DrawObject: TDrawObject);
//$$** SECTION: DRAWDOCUMENT_FULLIMPL
begin
//
end;
//$$** ENDSECTION

end.
