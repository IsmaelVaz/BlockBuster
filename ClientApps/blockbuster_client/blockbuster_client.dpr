//$$** SECTION: UNIT_CLIENT_PROJECT
program blockbuster_client;

uses
   Forms,
   SysUtils,
   uModelClient in '..\uModelClient.pas',   {Model}
   uSingletonsClient in '..\uSingletonsClient.pas',   {Singletons}
   uMisc in '..\..\Common\uMisc.pas',   {Miscellaneous}
   ufrmClientMain_blockbuster_client in 'ufrmClientMain_blockbuster_client.pas',   {Main form}
   ufrmLogin in '..\ufrmLogin.pas',   {Login form}
   ufrmGeneralSearch in '..\ufrmGeneralSearch.pas',   {General Search form}
   ufrmGeneralSearchMergeCriteriaSelection in '..\ufrmGeneralSearchMergeCriteriaSelection.pas',   {General Search Merge Criteria Selection form}
   ufrmGeneralSelectionDialog in '..\ufrmGeneralSelectionDialog.pas',   {General Selection dialog}
   ufrmColumnSelection in '..\ufrmColumnSelection.pas',   {Column Selection dialog}
   uCRUDFormUtils in '..\uCRUDFormUtils.pas',   {CRUD Form utils}
   uComboBoxRoutines in '..\uComboBoxRoutines.pas',   {ComboBox Routines unit}
   uClientGeneralReports in '..\uClientGeneralReports.pas',   {General Reports unit}
   uDocumentsCommons in '..\uDocumentsCommons.pas'   {Documents Commons unit}
   ,ufrmCRUDFilme in '..\CRUDForms\ufrmCRUDFilme.pas'   {Cadastro de Filmes}
   ,ufrmDataFilme in '..\DataForms\ufrmDataFilme.pas'   {Dados do Filme}
   ,ufrmCRUDSocio in '..\CRUDForms\ufrmCRUDSocio.pas'   {Cadastro de Sócios}
   ,ufrmDataSocio in '..\DataForms\ufrmDataSocio.pas'   {Dados do Sócio}
   ,ufrmCRUDDiretor in '..\CRUDForms\ufrmCRUDDiretor.pas'   {Cadastro de Diretores}
   ,ufrmDataDiretor in '..\DataForms\ufrmDataDiretor.pas'   {Dados do Diretor}
   ,ufrmCRUDLog in '..\CRUDForms\ufrmCRUDLog.pas'   {Cadastro de Logs}
   ,ufrmDataLog in '..\DataForms\ufrmDataLog.pas'   {Dados do Log}
   ,ufrmCRUDLocacao in '..\CRUDForms\ufrmCRUDLocacao.pas'   {Cadastro de Locação}
   ,ufrmDataLocacao in '..\DataForms\ufrmDataLocacao.pas'   {Dados da Locação}
   ,ufrmCRUDNotaDebito in '..\CRUDForms\ufrmCRUDNotaDebito.pas'   {Cadastro de Notas de Débito}
   ,ufrmDataNotaDebito in '..\DataForms\ufrmDataNotaDebito.pas'   {Dados Nota de Débito}
   ,ufrmCRUDOrdemCompra in '..\CRUDForms\ufrmCRUDOrdemCompra.pas'   {Cadastro de Ordens de Compra}
   ,ufrmDataOrdemCompra in '..\DataForms\ufrmDataOrdemCompra.pas'   {Dados da Ordem de Compra}
   ,ufrmDataEndereco in '..\DataForms\ufrmDataEndereco.pas'   {Endereço}
   ,ufrmDataLocacaoItem in '..\DataForms\ufrmDataLocacaoItem.pas'   {Locação Item}
   ,ufrmDataOrdemCompraItem in '..\DataForms\ufrmDataOrdemCompraItem.pas'   {Itens da Ordem de Compra}
   ,uFichaLocacao in '..\DocumentUnits\uFichaLocacao.pas'   {FichaLocacao}
   ;

{$R *.res}

begin
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}DecimalSeparator:=',';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ThousandSeparator:='.';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ShortDateFormat:='d/m/y';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}ShortTimeFormat:='hh:mm';
   {$IF CompilerVersion >= 22}FormatSettings.{$IFEND}LongTimeFormat:='hh:mm:ss';
   Application.Initialize;
   Application.Title:='BlockBuster Client';
   Application.CreateForm(TfrmClientMain_blockbuster_client,frmClientMain_blockbuster_client);
   Application.Run;
end.
