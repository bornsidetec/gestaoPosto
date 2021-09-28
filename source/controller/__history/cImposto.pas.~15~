unit cImposto;

interface

uses
  mImposto, dImposto, System.SysUtils;

type
  TImpostoController = class
  public
    procedure Pesquisar(sDescricao: string);
    procedure CarregarImposto(oImposto: TImposto; iId: Integer);
    function Inserir(oImposto: TImposto; var sErro: string): Boolean;
    function Alterar(oImposto: TImposto; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
  end;

implementation

{ TImpostoController }

function TImpostoController.Alterar(oImposto: TImposto;
  var sErro: string): Boolean;
begin
  Result := dmImposto.Alterar(oImposto, sErro);
end;

procedure TImpostoController.CarregarImposto(oImposto: TImposto; iId: Integer);
begin
  dmImposto.CarregarImposto(oImposto, iId);
end;

function TImpostoController.Excluir(iId: Integer; var sErro: string): Boolean;
begin
  Result := dmImposto.Excluir(iId, sErro);
end;

function TImpostoController.Inserir(oImposto: TImposto;
  var sErro: string): Boolean;
begin
  Result := dmImposto.Inserir(oImposto, sErro);
end;

procedure TImpostoController.Pesquisar(sDescricao: string);
begin
  dmImposto.Pesquisar(sDescricao);
end;

end.
