//$$** SECTION: UNIT_MODELCLIENT
unit uModelClient;

interface

uses Types,
     uP2SBFAbsModelTypes,uP2SBFAbsModelClient,uP2SBFClassRegistryClient,
     uP2SBFObjReposClient,uP2SBFParams,uP2SBFOrbClient,uP2SBFUtils,
     uP2SBFSystemModelClient;

type

TSocio = class;
TFilme = class;
TPessoa = class;
TDiretor = class;
TEndereco = class;
TLocacaoItem = class;
TLocacao = class;
TLog = class;
TNotaDebito = class;
TMovimentacaoFilme = class;
TOrdemCompra = class;
TOrdemCompraItem = class;

TPessoa = class(TP2SBFAbsPerBizObj)
   private
      FNomeExibicao: string;
      FNomeCompleto: string;
      FisNew: Boolean;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property NomeExibicao: string read FNomeExibicao write FNomeExibicao;
      property NomeCompleto: string read FNomeCompleto write FNomeCompleto;
      property isNew: Boolean read FisNew write FisNew;
end;

TSocio = class(TPessoa)
   private
      FNumeroCarteira: string;
      FTemLocPendente: Boolean;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property NumeroCarteira: string read FNumeroCarteira write FNumeroCarteira;
      property TemLocPendente: Boolean read FTemLocPendente write FTemLocPendente;
end;

TFilme = class(TP2SBFAbsPerBizObj)
   private
      FNome: string;
      FSinopse: string;
      FAnoLancamento: Integer;
      FDiretor: TP2SBFBizObjReference;
      FQuantidadeEstoque: Integer;
      FQuantidadeReservada: Integer;
      FQuantidadeLocacao: Integer;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property Nome: string read FNome write FNome;
      property Sinopse: string read FSinopse write FSinopse;
      property AnoLancamento: Integer read FAnoLancamento write FAnoLancamento;
      property Diretor: TP2SBFBizObjReference read FDiretor write FDiretor;
      property QuantidadeEstoque: Integer read FQuantidadeEstoque write FQuantidadeEstoque;
      property QuantidadeReservada: Integer read FQuantidadeReservada write FQuantidadeReservada;
      property QuantidadeLocacao: Integer read FQuantidadeLocacao write FQuantidadeLocacao;
end;

TDiretor = class(TPessoa)
   private
      FDataNascimento: Double;
      FEndereco: TEndereco;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property DataNascimento: Double read FDataNascimento write FDataNascimento;
      property Endereco: TEndereco read FEndereco write FEndereco;
end;

TEndereco = class(TP2SBFAbsPerBizObj)
   private
      FEndereco: string;
      FNumero: string;
      FComplemento: string;
      FBairro: string;
      FCidade: string;
      FEstado: string;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property Endereco: string read FEndereco write FEndereco;
      property Numero: string read FNumero write FNumero;
      property Complemento: string read FComplemento write FComplemento;
      property Bairro: string read FBairro write FBairro;
      property Cidade: string read FCidade write FCidade;
      property Estado: string read FEstado write FEstado;
end;

TMovimentacaoFilme = class(TP2SBFAbsPerBizObj)
   private
      FFilme: TP2SBFBizObjReference;
      FQuantidadePositiva: Integer;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property Filme: TP2SBFBizObjReference read FFilme write FFilme;
      property QuantidadePositiva: Integer read FQuantidadePositiva write FQuantidadePositiva;
end;

TLocacaoItem = class(TMovimentacaoFilme)
   private
      FValorTotal: Double;
      FValorUnitario: Double;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property ValorTotal: Double read FValorTotal write FValorTotal;
      property ValorUnitario: Double read FValorUnitario write FValorUnitario;
end;

TLocacao = class(TP2SBFAbsPerBizObj)
   private
      FDataInicial: Double;
      FDataFinal: Double;
      FValorFinal: Double;
      FNumero: Integer;
      FSocio: TP2SBFBizObjReference;
      FStatusLocacao: string;
      FDesconto: Double;
      FAcrescimo: Double;
      FValorTotal: Double;
      FNumeroRef: string;
      FItens: TP2SBFRelationship1N;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      function GenerateNumero: Integer; virtual;
      procedure FaturarLocacao(ADataReferencia: Double; AValorParaFaturar: Double); virtual;
      procedure GetArrayNotaDebito(var AArrayNotaDebito: TP2SBFAbsBizObjDynArray; AOrder: string); virtual;
      property DataInicial: Double read FDataInicial write FDataInicial;
      property DataFinal: Double read FDataFinal write FDataFinal;
      property ValorFinal: Double read FValorFinal write FValorFinal;
      property Numero: Integer read FNumero write FNumero;
      property Socio: TP2SBFBizObjReference read FSocio write FSocio;
      property StatusLocacao: string read FStatusLocacao write FStatusLocacao;
      property Desconto: Double read FDesconto write FDesconto;
      property Acrescimo: Double read FAcrescimo write FAcrescimo;
      property ValorTotal: Double read FValorTotal write FValorTotal;
      property NumeroRef: string read FNumeroRef write FNumeroRef;
      property Itens: TP2SBFRelationship1N read FItens write FItens;
end;

TLog = class(TP2SBFAbsPerBizObj)
   private
      FDataLog: Double;
      FHoraLog: Double;
      FAcao: string;
      FTela: string;
      FLoginUsuario: string;
      FOidObject: Integer;
      FReferencia: string;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property DataLog: Double read FDataLog write FDataLog;
      property HoraLog: Double read FHoraLog write FHoraLog;
      property Acao: string read FAcao write FAcao;
      property Tela: string read FTela write FTela;
      property LoginUsuario: string read FLoginUsuario write FLoginUsuario;
      property OidObject: Integer read FOidObject write FOidObject;
      property Referencia: string read FReferencia write FReferencia;
end;

TNotaDebito = class(TP2SBFAbsPerBizObj)
   private
      FDescricao: string;
      FLocacao: TP2SBFBizObjReference;
      FNumero: Integer;
      FValorTotal: Double;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      function GenerateNumero: Integer; virtual;
      property Descricao: string read FDescricao write FDescricao;
      property Locacao: TP2SBFBizObjReference read FLocacao write FLocacao;
      property Numero: Integer read FNumero write FNumero;
      property ValorTotal: Double read FValorTotal write FValorTotal;
end;

TOrdemCompra = class(TP2SBFAbsPerBizObj)
   private
      FDataEntrada: Double;
      FNumero: Integer;
      FItens: TP2SBFRelationship1N;
      FValorFinal: Double;
      FStatusOC: string;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      function GenerateNumero: Integer; virtual;
      property DataEntrada: Double read FDataEntrada write FDataEntrada;
      property Numero: Integer read FNumero write FNumero;
      property Itens: TP2SBFRelationship1N read FItens write FItens;
      property ValorFinal: Double read FValorFinal write FValorFinal;
      property StatusOC: string read FStatusOC write FStatusOC;
end;

TOrdemCompraItem = class(TMovimentacaoFilme)
   private
      FValorTotal: Double;
   protected
      procedure CreateAttributes; override;
      procedure DestroyAttributes; override;
   published
      property ValorTotal: Double read FValorTotal write FValorTotal;
end;

var
   _gSysAccessControl: TSysAccessControl;

implementation

procedure TSocio.CreateAttributes;
begin
   inherited;
end;

procedure TSocio.DestroyAttributes;
begin
   inherited;
end;

procedure TFilme.CreateAttributes;
begin
   inherited;
   FDiretor:=TP2SBFBizObjReference.Create;
end;

procedure TFilme.DestroyAttributes;
begin
   FDiretor.Free;
   inherited;
end;

procedure TPessoa.CreateAttributes;
begin
   inherited;
end;

procedure TPessoa.DestroyAttributes;
begin
   inherited;
end;

procedure TDiretor.CreateAttributes;
begin
   inherited;
   FEndereco:=TEndereco.CreateLocal;
end;

procedure TDiretor.DestroyAttributes;
begin
   inherited;
end;

procedure TEndereco.CreateAttributes;
begin
   inherited;
end;

procedure TEndereco.DestroyAttributes;
begin
   inherited;
end;

procedure TLocacaoItem.CreateAttributes;
begin
   inherited;
end;

procedure TLocacaoItem.DestroyAttributes;
begin
   inherited;
end;

procedure TLocacao.CreateAttributes;
begin
   inherited;
   FSocio:=TP2SBFBizObjReference.Create;
   FItens:=TP2SBFRelationship1N.Create(Self,TLocacao,'Itens',TLocacaoItem,False,'');
end;

procedure TLocacao.DestroyAttributes;
begin
   FSocio.Free;
   FItens.Free;
   inherited;
end;

procedure TLog.CreateAttributes;
begin
   inherited;
end;

procedure TLog.DestroyAttributes;
begin
   inherited;
end;

procedure TNotaDebito.CreateAttributes;
begin
   inherited;
   FLocacao:=TP2SBFBizObjReference.Create;
end;

procedure TNotaDebito.DestroyAttributes;
begin
   FLocacao.Free;
   inherited;
end;

procedure TMovimentacaoFilme.CreateAttributes;
begin
   inherited;
   FFilme:=TP2SBFBizObjReference.Create;
end;

procedure TMovimentacaoFilme.DestroyAttributes;
begin
   FFilme.Free;
   inherited;
end;

procedure TOrdemCompra.CreateAttributes;
begin
   inherited;
   FItens:=TP2SBFRelationship1N.Create(Self,TOrdemCompra,'Itens',TOrdemCompraItem,False,'');
end;

procedure TOrdemCompra.DestroyAttributes;
begin
   FItens.Free;
   inherited;
end;

procedure TOrdemCompraItem.CreateAttributes;
begin
   inherited;
end;

procedure TOrdemCompraItem.DestroyAttributes;
begin
   inherited;
end;


//********************************************************************************
//********************************************************************************
//* PUBLISHED METHODS WRAPPERS
//********************************************************************************
//********************************************************************************


//********************************************************************************
//* TLocacao.GenerateNumero
//********************************************************************************
function TLocacao.GenerateNumero: Integer;
var
   ParamList: TP2SBFParamList;
   NewParam: TP2SBFParam;
   OIDArrayToLoad: TOIDArray;
   ResultVar: TP2SBFVariable;
begin
   ParamList:=TP2SBFParamList.Create;
   // Invoke
   ResultVar:=TP2SBFVariable.Create;
   gP2SBFOrbClient.InvokeMethod(TP2SBFAbsBizClass(Self.ClassType),Self,'GenerateNumero',ParamList,ResultVar);
   // Retrieve all referenced objects
   SetLength(OIDArrayToLoad,0);
   gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,True);
   ParamList.Free;
   // Result
   Result:=ResultVar.AsInteger;
   ResultVar.Free
end;

//********************************************************************************
//* TLocacao.FaturarLocacao
//********************************************************************************
procedure TLocacao.FaturarLocacao(ADataReferencia: Double; AValorParaFaturar: Double);
var
   ParamList: TP2SBFParamList;
   NewParam: TP2SBFParam;
   OIDArrayToLoad: TOIDArray;
begin
   ParamList:=TP2SBFParamList.Create;
   // ADataReferencia
   NewParam:=TP2SBFParam.Create;
   NewParam.ParamName:='ADataReferencia';
   NewParam.ParamValue.AsDouble:=ADataReferencia;
   ParamList.Add(NewParam);
   // AValorParaFaturar
   NewParam:=TP2SBFParam.Create;
   NewParam.ParamName:='AValorParaFaturar';
   NewParam.ParamValue.AsDouble:=AValorParaFaturar;
   ParamList.Add(NewParam);
   // Invoke
   gP2SBFOrbClient.InvokeMethod(TP2SBFAbsBizClass(Self.ClassType),Self,'FaturarLocacao',ParamList,nil);
   // Retrieve all referenced objects
   SetLength(OIDArrayToLoad,0);
   gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,True);
   ParamList.Free;
end;

//********************************************************************************
//* TLocacao.GetArrayNotaDebito
//********************************************************************************
procedure TLocacao.GetArrayNotaDebito(var AArrayNotaDebito: TP2SBFAbsBizObjDynArray; AOrder: string);
var
   ParamList: TP2SBFParamList;
   NewParam: TP2SBFParam;
   OIDArrayToLoad: TOIDArray;
   i: Integer;
   j: Integer;
begin
   ParamList:=TP2SBFParamList.Create;
   // AArrayNotaDebito
   NewParam:=TP2SBFParam.Create;
   NewParam.ParamName:='AArrayNotaDebito';
   NewParam.ParamValue.SetArrayLength(High(AArrayNotaDebito)+1,optObject);
   for j:=0 to High(AArrayNotaDebito) do begin
      if AArrayNotaDebito[j]<>nil then NewParam.ParamValue.AsObjectOIDElem[j]:=AArrayNotaDebito[j].OID else NewParam.ParamValue.AsObjectOIDElem[j]:=NullOID;
   end;
   ParamList.Add(NewParam);
   // AOrder
   NewParam:=TP2SBFParam.Create;
   NewParam.ParamName:='AOrder';
   NewParam.ParamValue.AsString:=AOrder;
   ParamList.Add(NewParam);
   // Invoke
   gP2SBFOrbClient.InvokeMethod(TP2SBFAbsBizClass(Self.ClassType),Self,'GetArrayNotaDebito',ParamList,nil);
   // Retrieve all referenced objects
   SetLength(OIDArrayToLoad,0);
   for i:=0 to ParamList.Count-1 do begin
      if TP2SBFParam(ParamList.Items[i]).ParamName='AArrayNotaDebito' then begin
         for j:=0 to TP2SBFParam(ParamList.Items[i]).ParamValue.ArrayLength-1 do begin
            if TP2SBFParam(ParamList.Items[i]).ParamValue.AsObjectOIDElem[j].ID<>0 then begin
               SetLength(OIDArrayToLoad,Length(OIDArrayToLoad)+1);
               OIDArrayToLoad[High(OIDArrayToLoad)]:=TP2SBFParam(ParamList.Items[i]).ParamValue.AsObjectOIDElem[j];
            end;
         end;
      end;
   end;
   gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,True);
   // Outputs
   for i:=0 to ParamList.Count-1 do begin
      if TP2SBFParam(ParamList.Items[i]).ParamName='AArrayNotaDebito' then begin
         SetLength(AArrayNotaDebito,TP2SBFParam(ParamList.Items[i]).ParamValue.ArrayLength);
         for j:=0 to TP2SBFParam(ParamList.Items[i]).ParamValue.ArrayLength-1 do begin
            AArrayNotaDebito[j]:=gP2SBFObjRepos.Retrieve(TP2SBFParam(ParamList.Items[i]).ParamValue.AsObjectOIDElem[j],False);
         end;
      end;
   end;
   ParamList.Free;
end;

//********************************************************************************
//* TNotaDebito.GenerateNumero
//********************************************************************************
function TNotaDebito.GenerateNumero: Integer;
var
   ParamList: TP2SBFParamList;
   NewParam: TP2SBFParam;
   OIDArrayToLoad: TOIDArray;
   ResultVar: TP2SBFVariable;
   j: Integer;
begin
   ParamList:=TP2SBFParamList.Create;
   // Invoke
   ResultVar:=TP2SBFVariable.Create;
   gP2SBFOrbClient.InvokeMethod(TP2SBFAbsBizClass(Self.ClassType),Self,'GenerateNumero',ParamList,ResultVar);
   // Retrieve all referenced objects
   SetLength(OIDArrayToLoad,0);
   gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,True);
   ParamList.Free;
   // Result
   Result:=ResultVar.AsInteger;
   ResultVar.Free
end;

//********************************************************************************
//* TOrdemCompra.GenerateNumero
//********************************************************************************
function TOrdemCompra.GenerateNumero: Integer;
var
   ParamList: TP2SBFParamList;
   NewParam: TP2SBFParam;
   OIDArrayToLoad: TOIDArray;
   ResultVar: TP2SBFVariable;
   j: Integer;
begin
   ParamList:=TP2SBFParamList.Create;
   // Invoke
   ResultVar:=TP2SBFVariable.Create;
   gP2SBFOrbClient.InvokeMethod(TP2SBFAbsBizClass(Self.ClassType),Self,'GenerateNumero',ParamList,ResultVar);
   // Retrieve all referenced objects
   SetLength(OIDArrayToLoad,0);
   gP2SBFObjRepos.RetrieveMany(OIDArrayToLoad,True);
   ParamList.Free;
   // Result
   Result:=ResultVar.AsInteger;
   ResultVar.Free
end;

procedure Init1;
begin
   // Register Classes
   gP2SBFClassRegistry.RegisterClass(TSocio);
   gP2SBFClassRegistry.RegisterClass(TFilme);
   gP2SBFClassRegistry.RegisterClass(TPessoa);
   gP2SBFClassRegistry.RegisterClass(TDiretor);
   gP2SBFClassRegistry.RegisterClass(TEndereco);
   gP2SBFClassRegistry.RegisterClass(TLocacaoItem);
   gP2SBFClassRegistry.RegisterClass(TLocacao);
   gP2SBFClassRegistry.RegisterClass(TLog);
   gP2SBFClassRegistry.RegisterClass(TNotaDebito);
   gP2SBFClassRegistry.RegisterClass(TMovimentacaoFilme);
   gP2SBFClassRegistry.RegisterClass(TOrdemCompra);
   gP2SBFClassRegistry.RegisterClass(TOrdemCompraItem);
end;

procedure Init2_1;
begin
   // Register Object Properties (Reference and Part)
   gP2SBFClassRegistry.RegisterObjectProperty(TFilme,'Diretor',TDiretor,'TFilme_TDiretor');
   gP2SBFClassRegistry.RegisterObjectProperty(TDiretor,'Endereco',TEndereco,'TDiretor_TEndereco');
   gP2SBFClassRegistry.RegisterObjectProperty(TLocacao,'Socio',TSocio,'TLocacao_TSocio');
   gP2SBFClassRegistry.RegisterObjectProperty(TNotaDebito,'Locacao',TLocacao,'TNotaDebito_TLocacao');
   gP2SBFClassRegistry.RegisterObjectProperty(TMovimentacaoFilme,'Filme',TFilme,'TMovFilme_TFilme');
end;

procedure Init3;
begin
   // Register 1-N Object Properties (References and Parts)
   gP2SBFClassRegistry.Register1NObjectProperty(TLocacao,'Itens',TLocacaoItem,'TLocacao_TLocacaoItem');
   gP2SBFClassRegistry.Register1NObjectProperty(TOrdemCompra,'Itens',TOrdemCompraItem,'TOrdemCompra_TOrdemCompraItem');
end;

procedure Init4;
begin
   // Register Class Registries and their classes
end;

procedure Init5_1;
var
   CriteriaFilter: TP2SBFCriteria;
   CriteriaList: TP2SBFCriteriaList;
   NewEntry: TP2SBFSearchFieldEntry;
begin
   // Register Search Forms and Fields
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDFilme',TFilme);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Nome','Nome',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Sinopse','Sinopse',optString,fpcMemo,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','AnoLancamento','Ano de Lançamento',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Diretor','Diretor',optObject,fpcComboLookup,'','','','NomeExibicao',True);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','QuantidadeEstoque','Quantidade em Estoque',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','QuantidadeReservada','Quantidade Reservada',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','QuantidadeLocacao','Quantidade em Locação',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDSocio',TSocio);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NumeroCarteira','Número da Carteira',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDDiretor',TDiretor);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','DataNascimento','Data de Nascimento',optDouble,fpcDate,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDPessoa',TPessoa);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDPessoa','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDPessoa','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDLocacao',TLocacao);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','DataInicial','Data Inicial',optDouble,fpcDate,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','DataFinal','DataFinal',optDouble,fpcDate,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','ValorFinal','Valor Final',optDouble,fpcCurrency,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Numero','Número',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Socio','Sócio',optObject,fpcComboLookup,'','','','NomeExibicao',True);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','StatusLocacao','Status',optString,fpcComboFixed,'','Em Preparação'+#13#10+'Aprovado'+#13#10+'Em Locação'+#13#10+'Finalizado','P'+#13#10+'A'+#13#10+'L'+#13#10+'F','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Desconto','Desconto',optDouble,fpcCurrency,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Acrescimo','Acréscimo',optDouble,fpcCurrency,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','ValorTotal','Valor Total',optDouble,fpcCurrency,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDLog',TLog);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','DataLog','Data do Log',optDouble,fpcDate,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','HoraLog','Hora do Log',optDouble,fpcTime,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Acao','Ação',optString,fpcComboFixed,'','Update'+#13#10+'Delete'+#13#10+'Cancel'+#13#10+'Create','U'+#13#10+'D'+#13#10+'C'+#13#10+'CR','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Tela','Tela',optString,fpcComboFixed,'','Diretor'+#13#10+'Filme'+#13#10+'Locação'+#13#10+'Socio','D'+#13#10+'F'+#13#10+'L'+#13#10+'S','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','LoginUsuario','Login',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','OidObject','Oid Objeto',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Referencia','Referência',optString,fpcMemo,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDNotaDebito',TNotaDebito);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDNotaDebito','Descricao','Descrição',optString,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDNotaDebito','Locacao','Locação',optObject,fpcComboLookup,'','','','NumeroRef',True);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDNotaDebito','Numero','Número',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDNotaDebito','ValorTotal','Valor Total',optDouble,fpcCurrency,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDOrdemCompra',TOrdemCompra);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDOrdemCompra','DataEntrada','Data de Entrada',optDouble,fpcDate,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDOrdemCompra','Numero','Número',optInteger,fpcEdit,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDOrdemCompra','ValorFinal','Valor Final',optDouble,fpcCurrency,'','','','',False);
   NewEntry:=gP2SBFClassRegistry.RegisterSearchField('frmCRUDOrdemCompra','StatusOC','Status',optString,fpcComboFixed,'','Em Preparação'+#13#10+'Finalizado','P'+#13#10+'F','',False);
end;

initialization
   Init1;
   Init2_1;
   Init3;
   Init4;
   Init5_1;

end.
