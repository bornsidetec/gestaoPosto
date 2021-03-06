unit cTanque;

interface

uses
  mTanque, dTanque, System.SysUtils;

type
  TTanqueController = class
  public
    procedure Pesquisar(sDescricao: string);
    procedure CarregarTanque(oTanque: TTanque; iId: Integer);
    function Inserir(oTanque: TTanque; var sErro: string): Boolean;
    function Alterar(oTanque: TTanque; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
    procedure ListarCombustiveis;
  end;

implementation

{ TCombustivelController }

function TTanqueController.Alterar(oTanque: TTanque;
  var sErro: string): Boolean;
begin
  Result := dmTanque.Alterar(oTanque, sErro);
end;

procedure TTanqueController.CarregarTanque(oTanque: TTanque;
  iId: Integer);
begin
  dmTanque.CarregarTanque(oTanque, iId);
end;

function TTanqueController.Excluir(iId: Integer;
  var sErro: string): Boolean;
begin
  Result := dmTanque.Excluir(iId, sErro);
end;

function TTanqueController.Inserir(oTanque: TTanque;
  var sErro: string): Boolean;
begin
  Result := dmTanque.Inserir(oTanque, sErro);
end;

procedure TTanqueController.ListarCombustiveis;
begin
  dmTanque.ListarCombustiveis;
end;

procedure TTanqueController.Pesquisar(sDescricao: string);
begin
  dmTanque.Pesquisar(sDescricao);
end;

end.
