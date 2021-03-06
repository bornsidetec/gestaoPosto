unit cAbastecimento;

interface

uses mAbastecimento, dAbastecimento;

type
  TAbastecimentoController = class
  public
    procedure Pesquisar(dData: TDateTime);
    procedure CarregarAbastecimento(oAbastecimento: TAbastecimento; iId: Integer);
    function Inserir(oAbastecimento: TAbastecimento; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
    procedure ListarBombas;
  end;

implementation

{ TAbastecimentoController }

procedure TAbastecimentoController.CarregarAbastecimento(
  oAbastecimento: TAbastecimento; iId: Integer);
begin
  dmAbastecimento.CarregarAbastecimento(oAbastecimento, iId);
end;

function TAbastecimentoController.Excluir(iId: Integer;
  var sErro: string): Boolean;
begin
  Result := dmAbastecimento.Excluir(iId, sErro);
end;

function TAbastecimentoController.Inserir(oAbastecimento: TAbastecimento;
  var sErro: string): Boolean;
begin
  Result := dmAbastecimento.Inserir(oAbastecimento, sErro);
end;

procedure TAbastecimentoController.ListarBombas;
begin
  dmAbastecimento.ListarBombas;
end;

procedure TAbastecimentoController.Pesquisar(dData: TDateTime);
begin
  dmAbastecimento.Pesquisar(dData);
end;

end.
