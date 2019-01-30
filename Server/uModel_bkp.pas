//$$** SECTION: UNIT_HEADER
unit uModel;

interface

uses Types,SyncObjs,
     uP2SBFAbsModelTypes,uP2SBFAbsModel,uP2SBFClassRegistry,uP2SBFObjRepos,
     uP2SBFOrbServerTypes,uP2SBFBizEventManager,uP2SBFUtils,uP2SBFSystemModel,
     uP2SBFOrbServerUIManager,uP2SBFParams,uP2SBFLicenseChecker,uP2SBFOrbServer,
//$$** SECTION: UNIT_HEADER_USER
     Classes,SysUtils;

//$$** SECTION: INTERFACE_TYPE
type

TSocio = class;
TFilme = class;
TPessoa = class;
TDiretor = class;
TEndereco = class;
TLocacaoItem = class;
TLocacao = class;
TLog = class;

ITPessoa = interface(IInvokable)
end;

TPessoa = class(TP2SBFAbsPerBizObj,ITPessoa)
   private
      FNomeExibicao: string;
      FNomeCompleto: string;
   protected
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property NomeExibicao: string read FNomeExibicao write FNomeExibicao;
      property NomeCompleto: string read FNomeCompleto write FNomeCompleto;
end;

ITSocio = interface(ITPessoa)
end;

TSocio = class(TPessoa,ITSocio)
   private
      FNumeroCarteira: string;
      FTemLocPendente: Boolean;
   protected
      _FDVTLocacao_TSocio: TP2SBFDeleteVerification;
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property _DVTLocacao_TSocio: TP2SBFDeleteVerification read _FDVTLocacao_TSocio;
      property NumeroCarteira: string read FNumeroCarteira write FNumeroCarteira;
      property TemLocPendente: Boolean read FTemLocPendente write FTemLocPendente;
end;

ITFilme = interface(IInvokable)
end;

TFilme = class(TP2SBFAbsPerBizObj,ITFilme)
   private
      FNome: string;
      FSinopse: string;
      FAnoLancamento: Integer;
      FDiretor: TP2SBFBizObjReference;
   protected
      _FDTTFilme_TDiretor: TP2SBFReferenceTrigger;
      _FDVTLocacaoItem_TFilme: TP2SBFDeleteVerification;
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property _DTTFilme_TDiretor: TP2SBFReferenceTrigger read _FDTTFilme_TDiretor;
      property _DVTLocacaoItem_TFilme: TP2SBFDeleteVerification read _FDVTLocacaoItem_TFilme;
      property Nome: string read FNome write FNome;
      property Sinopse: string read FSinopse write FSinopse;
      property AnoLancamento: Integer read FAnoLancamento write FAnoLancamento;
      property Diretor: TP2SBFBizObjReference read FDiretor write FDiretor;
end;

ITDiretor = interface(ITPessoa)
end;

TDiretor = class(TPessoa,ITDiretor)
   private
      FDataNascimento: Double;
      FEndereco: TEndereco;
   protected
      _FDVTFilme_TDiretor: TP2SBFDeleteVerification;
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property _DVTFilme_TDiretor: TP2SBFDeleteVerification read _FDVTFilme_TDiretor;
      property DataNascimento: Double read FDataNascimento write FDataNascimento;
      property Endereco: TEndereco read FEndereco write FEndereco;
end;

ITEndereco = interface(IInvokable)
end;

TEndereco = class(TP2SBFAbsPerBizObj,ITEndereco)
   private
      FEndereco: string;
      FNumero: string;
      FComplemento: string;
      FBairro: string;
      FCidade: string;
      FEstado: string;
   protected
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property Endereco: string read FEndereco write FEndereco;
      property Numero: string read FNumero write FNumero;
      property Complemento: string read FComplemento write FComplemento;
      property Bairro: string read FBairro write FBairro;
      property Cidade: string read FCidade write FCidade;
      property Estado: string read FEstado write FEstado;
end;

ITLocacaoItem = interface(IInvokable)
end;

TLocacaoItem = class(TP2SBFAbsPerBizObj,ITLocacaoItem)
   private
      FFilme: TP2SBFBizObjReference;
   protected
      _FDTTLocacaoItem_TFilme: TP2SBFReferenceTrigger;
      _FDTTLocacao_TLocacaoItem: TP2SBFReferenceTrigger;
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property _DTTLocacaoItem_TFilme: TP2SBFReferenceTrigger read _FDTTLocacaoItem_TFilme;
      property _DTTLocacao_TLocacaoItem: TP2SBFReferenceTrigger read _FDTTLocacao_TLocacaoItem;
      property Filme: TP2SBFBizObjReference read FFilme write FFilme;
end;

ITLocacao = interface(IInvokable)
   function GenerateNumero(AConnectionData: TP2SBFConnectionData): Integer stdcall;
end;

TLocacao = class(TP2SBFAbsPerBizObj,ITLocacao)
   private
      FDataInicial: Double;
      FDataFinal: Double;
      FValorFinal: Double;
      FItens: TP2SBFRelationship1N;
      FNumero: Integer;
      FSocio: TP2SBFBizObjReference;
      FStatusLocacao: string;
   protected
      _FDTTLocacao_TSocio: TP2SBFReferenceTrigger;
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property _DTTLocacao_TSocio: TP2SBFReferenceTrigger read _FDTTLocacao_TSocio;
      function GenerateNumero(AConnectionData: TP2SBFConnectionData): Integer stdcall; virtual;
      property DataInicial: Double read FDataInicial write FDataInicial;
      property DataFinal: Double read FDataFinal write FDataFinal;
      property ValorFinal: Double read FValorFinal write FValorFinal;
      property Itens: TP2SBFRelationship1N read FItens write FItens;
      property Numero: Integer read FNumero write FNumero;
      property Socio: TP2SBFBizObjReference read FSocio write FSocio;
      property StatusLocacao: string read FStatusLocacao write FStatusLocacao;
end;

ITLog = interface(IInvokable)
end;

TLog = class(TP2SBFAbsPerBizObj,ITLog)
   private
      FDataLog: Double;
      FHoraLog: Double;
      FAcao: string;
      FTela: string;
      FLoginUsuario: string;
      FOidObject: Integer;
      FReferencia: string;
   protected
      procedure BeforeDelete(AConnectionData: TP2SBFConnectionData); override;
      procedure AfterDelete(AConnectionData: TP2SBFConnectionData); override;
      function  CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean; override;
      procedure BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean); override;
      procedure AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState); override;
      procedure CreateAttributes(AConnectionData: TP2SBFConnectionData); override;
      procedure CreateAttributesForRetrieve; override;
      procedure DestroyAttributes(AConnectionData: TP2SBFConnectionData); override;
   public
      constructor Create(AConnectionData: TP2SBFConnectionData); override;
   published
      property DataLog: Double read FDataLog write FDataLog;
      property HoraLog: Double read FHoraLog write FHoraLog;
      property Acao: string read FAcao write FAcao;
      property Tela: string read FTela write FTela;
      property LoginUsuario: string read FLoginUsuario write FLoginUsuario;
      property OidObject: Integer read FOidObject write FOidObject;
      property Referencia: string read FReferencia write FReferencia;
end;

//$$** SECTION: INTERFACE_VAR
var
   gAllSingletonsCreatedEvent: TEvent;

//$$** SECTION: IMPLEMENTATION_HEADER
implementation

//$$** SECTION: IMPLEMENTATION_HEADER_USER

// Put your "uses" here.

//$$** SECTION: CREATEATTRIBUTES_1
procedure TSocio.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
   _FDVTLocacao_TSocio:=TP2SBFDeleteVerification.Create(Self,TSocio,TLocacao,'TLocacao_TSocio',nil,'Socio');
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_1
procedure TSocio.CreateAttributesForRetrieve;
begin
   inherited;
   _FDVTLocacao_TSocio:=TP2SBFDeleteVerification.Create(Self,TSocio,TLocacao,'TLocacao_TSocio',nil,'Socio');
end;

//$$** SECTION: DESTROYATTRIBUTES_1
procedure TSocio.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   _FDVTLocacao_TSocio.Free;
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTES_2
procedure TFilme.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
   FDiretor:=TP2SBFBizObjReference.Create;
   _FDTTFilme_TDiretor:=TP2SBFReferenceTrigger.Create(Self,TDiretor,TFilme,'TFilme_TDiretor','',Diretor);
   _FDVTLocacaoItem_TFilme:=TP2SBFDeleteVerification.Create(Self,TFilme,TLocacaoItem,'TLocacaoItem_TFilme',nil,'Filme');
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_2
procedure TFilme.CreateAttributesForRetrieve;
begin
   inherited;
   FDiretor:=TP2SBFBizObjReference.Create;
   _FDTTFilme_TDiretor:=TP2SBFReferenceTrigger.Create(Self,TDiretor,TFilme,'TFilme_TDiretor','',Diretor);
   _FDVTLocacaoItem_TFilme:=TP2SBFDeleteVerification.Create(Self,TFilme,TLocacaoItem,'TLocacaoItem_TFilme',nil,'Filme');
end;

//$$** SECTION: DESTROYATTRIBUTES_2
procedure TFilme.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   FDiretor.Free;
   _FDTTFilme_TDiretor.Free;
   _FDVTLocacaoItem_TFilme.Free;
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTES_4
procedure TPessoa.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_4
procedure TPessoa.CreateAttributesForRetrieve;
begin
   inherited;
end;

//$$** SECTION: DESTROYATTRIBUTES_4
procedure TPessoa.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTES_6
procedure TDiretor.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
   FEndereco:=TEndereco.Create(AConnectionData);
   _FDVTFilme_TDiretor:=TP2SBFDeleteVerification.Create(Self,TDiretor,TFilme,'TFilme_TDiretor',nil,'Diretor');
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_6
procedure TDiretor.CreateAttributesForRetrieve;
begin
   inherited;
   FEndereco:=TEndereco.CreateForRetrieve(NullOID);
   _FDVTFilme_TDiretor:=TP2SBFDeleteVerification.Create(Self,TDiretor,TFilme,'TFilme_TDiretor',nil,'Diretor');
end;

//$$** SECTION: DESTROYATTRIBUTES_6
procedure TDiretor.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   _FDVTFilme_TDiretor.Free;
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: BUSINESSRULES_SEPARATOR

//********************************************************************************
//********************************************************************************
//* BUSINESS RULES
//********************************************************************************
//********************************************************************************

//$$** SECTION: CREATE_DECL_1

//********************************************************************************
//* TSocio.Create
//********************************************************************************
constructor TSocio.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_1

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_1
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_1

// Put your code here.

//$$** SECTION: CREATE_END_1
end;
//$$** SECTION: BEFOREDELETE_DECL_1

//********************************************************************************
//* TSocio.BeforeDelete
//********************************************************************************
procedure TSocio.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_1

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_1
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_1

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_1
end;
//$$** SECTION: AFTERDELETE_DECL_1

//********************************************************************************
//* TSocio.AfterDelete
//********************************************************************************
procedure TSocio.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_1

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_1
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_1

// Put your code here.

//$$** SECTION: AFTERDELETE_END_1
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_1

//********************************************************************************
//* TSocio.CustomCanDelete
//********************************************************************************
function TSocio.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_1

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_1
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_1

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_1
end;
//$$** SECTION: BEFORESAVE_DECL_1

//********************************************************************************
//* TSocio.BeforeSave
//********************************************************************************
procedure TSocio.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_1

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_1
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_1

// Put your code here.

//$$** SECTION: BEFORESAVE_END_1
end;
//$$** SECTION: AFTERSAVE_DECL_1

//********************************************************************************
//* TSocio.AfterSave
//********************************************************************************
procedure TSocio.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_1

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_1
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_1

// Put your code here.

//$$** SECTION: AFTERSAVE_END_1
end;
//$$** SECTION: CREATE_DECL_2

//********************************************************************************
//* TFilme.Create
//********************************************************************************
constructor TFilme.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_2

// Put your variables here.


//$$** SECTION: CREATE_BEGIN_2
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_2

// Put your code here.

//$$** SECTION: CREATE_END_2
end;
//$$** SECTION: BEFOREDELETE_DECL_2

//********************************************************************************
//* TFilme.BeforeDelete
//********************************************************************************
procedure TFilme.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_2

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_2
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_2

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_2
end;
//$$** SECTION: AFTERDELETE_DECL_2

//********************************************************************************
//* TFilme.AfterDelete
//********************************************************************************
procedure TFilme.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_2

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_2
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_2

// Put your code here.

//$$** SECTION: AFTERDELETE_END_2
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_2

//********************************************************************************
//* TFilme.CustomCanDelete
//********************************************************************************
function TFilme.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_2

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_2
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_2

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_2
end;
//$$** SECTION: BEFORESAVE_DECL_2

//********************************************************************************
//* TFilme.BeforeSave
//********************************************************************************
procedure TFilme.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_2

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_2
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_2

// Put your code here.

//$$** SECTION: BEFORESAVE_END_2
end;
//$$** SECTION: AFTERSAVE_DECL_2

//********************************************************************************
//* TFilme.AfterSave
//********************************************************************************
procedure TFilme.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_2

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_2
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_2

// Put your code here.

//$$** SECTION: AFTERSAVE_END_2
end;
//$$** SECTION: CREATE_DECL_4

//********************************************************************************
//* TPessoa.Create
//********************************************************************************
constructor TPessoa.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_4

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_4
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_4

// Put your code here.

//$$** SECTION: CREATE_END_4
end;
//$$** SECTION: BEFOREDELETE_DECL_4

//********************************************************************************
//* TPessoa.BeforeDelete
//********************************************************************************
procedure TPessoa.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_4

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_4
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_4

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_4
end;
//$$** SECTION: AFTERDELETE_DECL_4

//********************************************************************************
//* TPessoa.AfterDelete
//********************************************************************************
procedure TPessoa.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_4

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_4
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_4

// Put your code here.

//$$** SECTION: AFTERDELETE_END_4
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_4

//********************************************************************************
//* TPessoa.CustomCanDelete
//********************************************************************************
function TPessoa.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_4

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_4
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_4

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_4
end;
//$$** SECTION: BEFORESAVE_DECL_4

//********************************************************************************
//* TPessoa.BeforeSave
//********************************************************************************
procedure TPessoa.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_4

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_4
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_4

// Put your code here.

//$$** SECTION: BEFORESAVE_END_4
end;
//$$** SECTION: AFTERSAVE_DECL_4

//********************************************************************************
//* TPessoa.AfterSave
//********************************************************************************
procedure TPessoa.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_4

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_4
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_4

// Put your code here.

//$$** SECTION: AFTERSAVE_END_4
end;
//$$** SECTION: CREATE_DECL_6

//********************************************************************************
//* TDiretor.Create
//********************************************************************************
constructor TDiretor.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_6

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_6
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_6

// Put your code here.

//$$** SECTION: CREATE_END_6
end;
//$$** SECTION: BEFOREDELETE_DECL_6

//********************************************************************************
//* TDiretor.BeforeDelete
//********************************************************************************
procedure TDiretor.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_6

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_6
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_6

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_6
end;
//$$** SECTION: AFTERDELETE_DECL_6

//********************************************************************************
//* TDiretor.AfterDelete
//********************************************************************************
procedure TDiretor.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_6

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_6
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_6

// Put your code here.

//$$** SECTION: AFTERDELETE_END_6
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_6

//********************************************************************************
//* TDiretor.CustomCanDelete
//********************************************************************************
function TDiretor.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_6

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_6
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_6

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_6
end;
//$$** SECTION: BEFORESAVE_DECL_6

//********************************************************************************
//* TDiretor.BeforeSave
//********************************************************************************
procedure TDiretor.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_6

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_6
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_6

// Put your code here.

    if self.PersistentState <> psNew then
    begin
    //
    end;

//$$** SECTION: BEFORESAVE_END_6
end;
//$$** SECTION: AFTERSAVE_DECL_6

//********************************************************************************
//* TDiretor.AfterSave
//********************************************************************************
procedure TDiretor.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_6

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_6
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_6



// Put your code here.

//$$** SECTION: AFTERSAVE_END_6
end;
//$$** SECTION: CREATEATTRIBUTES_9
procedure TEndereco.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_9
procedure TEndereco.CreateAttributesForRetrieve;
begin
   inherited;
end;

//$$** SECTION: DESTROYATTRIBUTES_9
procedure TEndereco.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATE_DECL_9

//********************************************************************************
//* TEndereco.Create
//********************************************************************************
constructor TEndereco.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_9

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_9
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_9

// Put your code here.

//$$** SECTION: CREATE_END_9
end;
//$$** SECTION: BEFOREDELETE_DECL_9

//********************************************************************************
//* TEndereco.BeforeDelete
//********************************************************************************
procedure TEndereco.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_9

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_9
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_9

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_9
end;
//$$** SECTION: AFTERDELETE_DECL_9

//********************************************************************************
//* TEndereco.AfterDelete
//********************************************************************************
procedure TEndereco.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_9

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_9
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_9

// Put your code here.

//$$** SECTION: AFTERDELETE_END_9
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_9

//********************************************************************************
//* TEndereco.CustomCanDelete
//********************************************************************************
function TEndereco.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_9

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_9
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_9

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_9
end;
//$$** SECTION: BEFORESAVE_DECL_9

//********************************************************************************
//* TEndereco.BeforeSave
//********************************************************************************
procedure TEndereco.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_9

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_9
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_9

// Put your code here.

//$$** SECTION: BEFORESAVE_END_9
end;
//$$** SECTION: AFTERSAVE_DECL_9

//********************************************************************************
//* TEndereco.AfterSave
//********************************************************************************
procedure TEndereco.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_9

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_9
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_9

// Put your code here.

//$$** SECTION: AFTERSAVE_END_9
end;
//$$** SECTION: CREATEATTRIBUTES_10
procedure TLocacaoItem.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
   FFilme:=TP2SBFBizObjReference.Create;
   _FDTTLocacaoItem_TFilme:=TP2SBFReferenceTrigger.Create(Self,TFilme,TLocacaoItem,'TLocacaoItem_TFilme','',Filme);
   _FDTTLocacao_TLocacaoItem:=TP2SBFReferenceTrigger.Create(Self,TLocacao,TLocacaoItem,'TLocacao_TLocacaoItem','Itens',nil);
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_10
procedure TLocacaoItem.CreateAttributesForRetrieve;
begin
   inherited;
   FFilme:=TP2SBFBizObjReference.Create;
   _FDTTLocacaoItem_TFilme:=TP2SBFReferenceTrigger.Create(Self,TFilme,TLocacaoItem,'TLocacaoItem_TFilme','',Filme);
   _FDTTLocacao_TLocacaoItem:=TP2SBFReferenceTrigger.Create(Self,TLocacao,TLocacaoItem,'TLocacao_TLocacaoItem','Itens',nil);
end;

//$$** SECTION: DESTROYATTRIBUTES_10
procedure TLocacaoItem.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   FFilme.Free;
   _FDTTLocacaoItem_TFilme.Free;
   _FDTTLocacao_TLocacaoItem.Free;
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTES_11
procedure TLocacao.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
   FItens:=TP2SBFRelationship1N.Create(Self,TLocacao,TLocacaoItem,'TLocacao_TLocacaoItem',False,'');
   FSocio:=TP2SBFBizObjReference.Create;
   _FDTTLocacao_TSocio:=TP2SBFReferenceTrigger.Create(Self,TSocio,TLocacao,'TLocacao_TSocio','',Socio);
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_11
procedure TLocacao.CreateAttributesForRetrieve;
begin
   inherited;
   FItens:=TP2SBFRelationship1N.Create(Self,TLocacao,TLocacaoItem,'TLocacao_TLocacaoItem',False,'');
   FSocio:=TP2SBFBizObjReference.Create;
   _FDTTLocacao_TSocio:=TP2SBFReferenceTrigger.Create(Self,TSocio,TLocacao,'TLocacao_TSocio','',Socio);
end;

//$$** SECTION: DESTROYATTRIBUTES_11
procedure TLocacao.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   FItens.Free;
   FSocio.Free;
   _FDTTLocacao_TSocio.Free;
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATE_DECL_10

//********************************************************************************
//* TLocacaoItem.Create
//********************************************************************************
constructor TLocacaoItem.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_10

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_10
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_10

// Put your code here.

//$$** SECTION: CREATE_END_10
end;
//$$** SECTION: BEFOREDELETE_DECL_10

//********************************************************************************
//* TLocacaoItem.BeforeDelete
//********************************************************************************
procedure TLocacaoItem.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_10

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_10
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_10

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_10
end;
//$$** SECTION: AFTERDELETE_DECL_10

//********************************************************************************
//* TLocacaoItem.AfterDelete
//********************************************************************************
procedure TLocacaoItem.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_10

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_10
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_10

// Put your code here.

//$$** SECTION: AFTERDELETE_END_10
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_10

//********************************************************************************
//* TLocacaoItem.CustomCanDelete
//********************************************************************************
function TLocacaoItem.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_10

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_10
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_10

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_10
end;
//$$** SECTION: BEFORESAVE_DECL_10

//********************************************************************************
//* TLocacaoItem.BeforeSave
//********************************************************************************
procedure TLocacaoItem.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_10

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_10
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_10

// Put your code here.

//$$** SECTION: BEFORESAVE_END_10
end;
//$$** SECTION: AFTERSAVE_DECL_10

//********************************************************************************
//* TLocacaoItem.AfterSave
//********************************************************************************
procedure TLocacaoItem.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_10

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_10
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_10

// Put your code here.

//$$** SECTION: AFTERSAVE_END_10
end;
//$$** SECTION: CREATE_DECL_11

//********************************************************************************
//* TLocacao.Create
//********************************************************************************
constructor TLocacao.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_11

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_11
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_11

// Put your code here.

//$$** SECTION: CREATE_END_11
end;
//$$** SECTION: BEFOREDELETE_DECL_11

//********************************************************************************
//* TLocacao.BeforeDelete
//********************************************************************************
procedure TLocacao.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_11

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_11
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_11

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_11
end;
//$$** SECTION: AFTERDELETE_DECL_11

//********************************************************************************
//* TLocacao.AfterDelete
//********************************************************************************
procedure TLocacao.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_11

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_11
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_11

// Put your code here.

//$$** SECTION: AFTERDELETE_END_11
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_11

//********************************************************************************
//* TLocacao.CustomCanDelete
//********************************************************************************
function TLocacao.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_11

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_11
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_11

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_11
end;
//$$** SECTION: BEFORESAVE_DECL_11

//********************************************************************************
//* TLocacao.BeforeSave
//********************************************************************************
procedure TLocacao.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_11

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_11
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_11

// Put your code here.

//$$** SECTION: BEFORESAVE_END_11
end;
//$$** SECTION: AFTERSAVE_DECL_11

//********************************************************************************
//* TLocacao.AfterSave
//********************************************************************************
procedure TLocacao.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_11

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_11
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_11

// Put your code here.

//$$** SECTION: AFTERSAVE_END_11
end;
//$$** SECTION: METHOD_DECL_11_1

//********************************************************************************
//* TLocacao.GenerateNumero
//********************************************************************************
function TLocacao.GenerateNumero(AConnectionData: TP2SBFConnectionData): Integer stdcall;
//$$** SECTION: METHOD_VAR_11_1

// Put your variables here.

//$$** SECTION: METHOD_BEGIN_11_1
begin
//$$** SECTION: METHOD_IMPL_11_1

// Put your code here.

//$$** SECTION: METHOD_END_11_1
end;

//$$** SECTION: CREATEATTRIBUTES_12
procedure TLog.CreateAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited CreateAttributes(AConnectionData);
end;

//$$** SECTION: CREATEATTRIBUTESFORRETRIEVE_12
procedure TLog.CreateAttributesForRetrieve;
begin
   inherited;
end;

//$$** SECTION: DESTROYATTRIBUTES_12
procedure TLog.DestroyAttributes(AConnectionData: TP2SBFConnectionData);
begin
   inherited DestroyAttributes(AConnectionData);
end;

//$$** SECTION: CREATE_DECL_12

//********************************************************************************
//* TLog.Create
//********************************************************************************
constructor TLog.Create(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: CREATE_VAR_12

// Put your variables here.

//$$** SECTION: CREATE_BEGIN_12
begin
   inherited Create(AConnectionData);
//$$** SECTION: CREATE_IMPL_12

// Put your code here.

//$$** SECTION: CREATE_END_12
end;
//$$** SECTION: BEFOREDELETE_DECL_12

//********************************************************************************
//* TLog.BeforeDelete
//********************************************************************************
procedure TLog.BeforeDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: BEFOREDELETE_VAR_12

// Put your variables here.

//$$** SECTION: BEFOREDELETE_BEGIN_12
begin
   inherited BeforeDelete(AConnectionData);
//$$** SECTION: BEFOREDELETE_IMPL_12

// Put your code here.

//$$** SECTION: BEFOREDELETE_END_12
end;
//$$** SECTION: AFTERDELETE_DECL_12

//********************************************************************************
//* TLog.AfterDelete
//********************************************************************************
procedure TLog.AfterDelete(AConnectionData: TP2SBFConnectionData);
//$$** SECTION: AFTERDELETE_VAR_12

// Put your variables here.

//$$** SECTION: AFTERDELETE_BEGIN_12
begin
   inherited AfterDelete(AConnectionData);
//$$** SECTION: AFTERDELETE_IMPL_12

// Put your code here.

//$$** SECTION: AFTERDELETE_END_12
end;
//$$** SECTION: CUSTOMCANDELETE_DECL_12

//********************************************************************************
//* TLog.CustomCanDelete
//********************************************************************************
function TLog.CustomCanDelete(AConnectionData: TP2SBFConnectionData; var AReason: string): Boolean;
//$$** SECTION: CUSTOMCANDELETE_VAR_12

// Put your variables here.

//$$** SECTION: CUSTOMCANDELETE_BEGIN_12
begin
   Result := inherited CustomCanDelete(AConnectionData,AReason);
//$$** SECTION: CUSTOMCANDELETE_IMPL_12

// Put your code here.

//$$** SECTION: CUSTOMCANDELETE_END_12
end;
//$$** SECTION: BEFORESAVE_DECL_12

//********************************************************************************
//* TLog.BeforeSave
//********************************************************************************
procedure TLog.BeforeSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean);
//$$** SECTION: BEFORESAVE_VAR_12

// Put your variables here.

//$$** SECTION: BEFORESAVE_BEGIN_12
begin
   inherited BeforeSave(AConnectionData,ANew);
//$$** SECTION: BEFORESAVE_IMPL_12
    self.LoginUsuario:= AConnectionData.Login;
// Put your code here.

//$$** SECTION: BEFORESAVE_END_12
end;
//$$** SECTION: AFTERSAVE_DECL_12

//********************************************************************************
//* TLog.AfterSave
//********************************************************************************
procedure TLog.AfterSave(AConnectionData: TP2SBFConnectionData; ANew: Boolean; AChangedState: TP2SBFChangedState);
//$$** SECTION: AFTERSAVE_VAR_12

// Put your variables here.

//$$** SECTION: AFTERSAVE_BEGIN_12
begin
   inherited AfterSave(AConnectionData,ANew,AChangedState);
//$$** SECTION: AFTERSAVE_IMPL_12

// Put your code here.


//$$** SECTION: AFTERSAVE_END_12
end;

procedure Init1;
begin
   // Register Classes, Interfaces and Proxy Properties
   gP2SBFClassRegistry.RegisterClass(TSocio,TypeInfo(ITSocio),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TSocio,'NumeroCarteira');
   gP2SBFClassRegistry.RegisterProxyProperty(TSocio,'TemLocPendente');
   gP2SBFClassRegistry.RegisterClass(TFilme,TypeInfo(ITFilme),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'Nome');
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'Sinopse');
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'AnoLancamento');
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'Diretor');
   gP2SBFClassRegistry.RegisterClass(TPessoa,TypeInfo(ITPessoa),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TPessoa,'NomeExibicao');
   gP2SBFClassRegistry.RegisterProxyProperty(TPessoa,'NomeCompleto');
   gP2SBFClassRegistry.RegisterClass(TDiretor,TypeInfo(ITDiretor),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TDiretor,'DataNascimento');
   gP2SBFClassRegistry.RegisterClass(TEndereco,TypeInfo(ITEndereco),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Endereco');
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Numero');
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Complemento');
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Bairro');
   gP2SBFClassRegistry.RegisterClass(TLocacaoItem,TypeInfo(ITLocacaoItem),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacaoItem,'Filme');
   gP2SBFClassRegistry.RegisterClass(TLocacao,TypeInfo(ITLocacao),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'DataInicial');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'DataFinal');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'ValorFinal');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'Numero');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'Socio');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'StatusLocacao');
   gP2SBFClassRegistry.RegisterClass(TLog,TypeInfo(ITLog),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'DataLog');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'HoraLog');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'Acao');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'Tela');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'LoginUsuario');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'OidObject');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'Referencia');
   gP2SBFClassRegistry.SortProxyPropList;
end;

procedure Init2_1;
begin
   // Register Object Properties (Reference and Part)
   gP2SBFClassRegistry.RegisterObjectProperty(TFilme,'Diretor',TDiretor,'TFilme_TDiretor');
   gP2SBFClassRegistry.RegisterObjectProperty(TDiretor,'Endereco',TEndereco,'TDiretor_TEndereco');
   gP2SBFClassRegistry.RegisterObjectProperty(TLocacaoItem,'Filme',TFilme,'TLocacaoItem_TFilme');
   gP2SBFClassRegistry.RegisterObjectProperty(TLocacao,'Socio',TSocio,'TLocacao_TSocio');
end;

procedure Init3;
begin
   // Register 1-N Object Properties (References and Parts)
   gP2SBFClassRegistry.Register1NObjectProperty(TLocacao,'Itens',TLocacaoItem,'TLocacao_TLocacaoItem');
end;

procedure Init4;
begin
   // Register Class Registries and their classes
end;

procedure Init5_1;
begin
   // Register Search Forms and Fields
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDFilme',TFilme);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Nome','Nome',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Sinopse','Sinopse',optString,fpcMemo,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','AnoLancamento','Ano de Lançamento',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Diretor','Diretor',optObject,fpcComboLookup,'','','','NomeExibicao',True);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDSocio',TSocio);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NumeroCarteira','Número da Carteira',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDDiretor',TDiretor);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','DataNascimento','Data de Nascimento',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDPessoa',TPessoa);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDPessoa','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDPessoa','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDLocacao',TLocacao);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','DataInicial','Data Inicial',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','DataFinal','DataFinal',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','ValorFinal','Valor Final',optDouble,fpcCurrency,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Numero','Número',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Socio','Sócio',optObject,fpcComboLookup,'','','','NomeExibicao',True);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','StatusLocacao','Status',optString,fpcComboFixed,'','Em Preparação'+#13#10+'Aprovado'+#13#10+'Em Locação'+#13#10+'Finalizado','P'+#13#10+'A'+#13#10+'L'+#13#10+'F','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDLog',TLog);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','DataLog','Data do Log',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','HoraLog','Hora do Log',optDouble,fpcTime,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Acao','Ação',optString,fpcComboFixed,'','Update'+#13#10+'Delete'+#13#10+'Cancel'+#13#10+'Create','U'+#13#10+'D'+#13#10+'C'+#13#10+'CR','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Tela','Tela',optString,fpcComboFixed,'','Diretor'+#13#10+'Filme'+#13#10+'Locação'+#13#10+'Socio','D'+#13#10+'F'+#13#10+'L'+#13#10+'S','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','LoginUsuario','Login',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','OidObject','Oid Objeto',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Referencia','Referência',optString,fpcMemo,'','','','',False);
end;

procedure Init6;
begin
   // Create Business Process Manager Objects
end;

procedure Init7;
begin
   // Register Business Process Transitions Events
end;

procedure Init8;
begin
   // Dummy calls to force the linker to include the methods into the EXE
end;

procedure Init9;
begin
   // Create Singletons
   gAllSingletonsCreatedEvent:=TEvent.Create(nil,True,False,'PS_AllSingletonsCreated');
   gAllSingletonsCreatedEvent.SetEvent;
end;

//$$** SECTION: METHOD_DECL_12_1

//********************************************************************************
//* TLog.CreateLog
//********************************************************************************
procedure TLog.CreateLog(AConnectionData: TP2SBFConnectionData; AAcao: string; ATela: string; AReferencia: string; AObject: Integer) stdcall;
//$$** SECTION: METHOD_VAR_12_1

// Put your variables here.

//$$** SECTION: METHOD_BEGIN_12_1
begin
//$$** SECTION: METHOD_IMPL_12_1
  

// Put your code here.

//$$** SECTION: METHOD_END_12_1
end;


procedure Init1;
begin
   // Register Classes, Interfaces and Proxy Properties
   gP2SBFClassRegistry.RegisterClass(TSocio,TypeInfo(ITSocio),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TSocio,'NumeroCarteira');
   gP2SBFClassRegistry.RegisterProxyProperty(TSocio,'TemLocPendente');
   gP2SBFClassRegistry.RegisterClass(TFilme,TypeInfo(ITFilme),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'Nome');
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'Sinopse');
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'AnoLancamento');
   gP2SBFClassRegistry.RegisterProxyProperty(TFilme,'Diretor');
   gP2SBFClassRegistry.RegisterClass(TPessoa,TypeInfo(ITPessoa),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TPessoa,'NomeExibicao');
   gP2SBFClassRegistry.RegisterProxyProperty(TPessoa,'NomeCompleto');
   gP2SBFClassRegistry.RegisterClass(TDiretor,TypeInfo(ITDiretor),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TDiretor,'DataNascimento');
   gP2SBFClassRegistry.RegisterClass(TEndereco,TypeInfo(ITEndereco),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Endereco');
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Numero');
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Complemento');
   gP2SBFClassRegistry.RegisterProxyProperty(TEndereco,'Bairro');
   gP2SBFClassRegistry.RegisterClass(TLocacaoItem,TypeInfo(ITLocacaoItem),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacaoItem,'Filme');
   gP2SBFClassRegistry.RegisterClass(TLocacao,TypeInfo(ITLocacao),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'DataInicial');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'DataFinal');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'ValorFinal');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'Numero');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'Socio');
   gP2SBFClassRegistry.RegisterProxyProperty(TLocacao,'StatusLocacao');
   gP2SBFClassRegistry.RegisterClass(TLog,TypeInfo(ITLog),'',False);
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'DataLog');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'HoraLog');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'Acao');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'Tela');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'LoginUsuario');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'OidObject');
   gP2SBFClassRegistry.RegisterProxyProperty(TLog,'Referencia');
   gP2SBFClassRegistry.SortProxyPropList;
end;

procedure Init2_1;
begin
   // Register Object Properties (Reference and Part)
   gP2SBFClassRegistry.RegisterObjectProperty(TFilme,'Diretor',TDiretor,'TFilme_TDiretor');
   gP2SBFClassRegistry.RegisterObjectProperty(TDiretor,'Endereco',TEndereco,'TDiretor_TEndereco');
   gP2SBFClassRegistry.RegisterObjectProperty(TLocacaoItem,'Filme',TFilme,'TLocacaoItem_TFilme');
   gP2SBFClassRegistry.RegisterObjectProperty(TLocacao,'Socio',TSocio,'TLocacao_TSocio');
end;

procedure Init3;
begin
   // Register 1-N Object Properties (References and Parts)
   gP2SBFClassRegistry.Register1NObjectProperty(TLocacao,'Itens',TLocacaoItem,'TLocacao_TLocacaoItem');
end;

procedure Init4;
begin
   // Register Class Registries and their classes
end;

procedure Init5_1;
begin
   // Register Search Forms and Fields
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDFilme',TFilme);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Nome','Nome',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Sinopse','Sinopse',optString,fpcMemo,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','AnoLancamento','Ano de Lançamento',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDFilme','Diretor','Diretor',optObject,fpcComboLookup,'','','','NomeExibicao',True);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDSocio',TSocio);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NumeroCarteira','Número da Carteira',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDSocio','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDDiretor',TDiretor);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','DataNascimento','Data de Nascimento',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDDiretor','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDPessoa',TPessoa);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDPessoa','NomeExibicao','Nome Exibição',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDPessoa','NomeCompleto','Nome Completo',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDLocacao',TLocacao);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','DataInicial','Data Inicial',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','DataFinal','DataFinal',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','ValorFinal','Valor Final',optDouble,fpcCurrency,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Numero','Número',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','Socio','Sócio',optObject,fpcComboLookup,'','','','NomeExibicao',True);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLocacao','StatusLocacao','Status',optString,fpcComboFixed,'','Em Preparação'+#13#10+'Aprovado'+#13#10+'Em Locação'+#13#10+'Finalizado','P'+#13#10+'A'+#13#10+'L'+#13#10+'F','',False);
   gP2SBFClassRegistry.RegisterSearchForm('frmCRUDLog',TLog);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','DataLog','Data do Log',optDouble,fpcDate,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','HoraLog','Hora do Log',optDouble,fpcTime,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Acao','Ação',optString,fpcComboFixed,'','Update'+#13#10+'Delete'+#13#10+'Cancel'+#13#10+'Create','U'+#13#10+'D'+#13#10+'C'+#13#10+'CR','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Tela','Tela',optString,fpcComboFixed,'','Diretor'+#13#10+'Filme'+#13#10+'Locação'+#13#10+'Socio','D'+#13#10+'F'+#13#10+'L'+#13#10+'S','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','LoginUsuario','Login',optString,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','OidObject','Oid Objeto',optInteger,fpcEdit,'','','','',False);
   gP2SBFClassRegistry.RegisterSearchField('frmCRUDLog','Referencia','Referência',optString,fpcMemo,'','','','',False);
end;

procedure Init6;
begin
   // Create Business Process Manager Objects
end;

procedure Init7;
begin
   // Register Business Process Transitions Events
end;

procedure Init8;
begin
   // Dummy calls to force the linker to include the methods into the EXE
end;

procedure Init9;
begin
   // Create Singletons
   gAllSingletonsCreatedEvent:=TEvent.Create(nil,True,False,'PS_AllSingletonsCreated');
   gAllSingletonsCreatedEvent.SetEvent;
end;

//$$** SECTION: INITIALIZATION
initialization
   Init1;
   Init2_1;
   Init3;
   Init4;
   Init5_1;
   Init6;
   Init7;
   Init8;
   Init9;
   gP2SBFOrbServer.CheckMaxConnections:=False;
//$$** SECTION: UNIT_END
end.
