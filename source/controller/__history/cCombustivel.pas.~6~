unit cCombustivel;

interface

uses
  mCombustivel, dCombustivel, System.SysUtils;

type
  TCombustivelController = class
  public
    procedure Pesquisar(sDescricao: string);
    procedure CarregarCombustivel(oCombustivel: TCombustivel; iId: Integer);
    function Inserir(oCombustivel: TCombustivel; var sErro: string): Boolean;
    function Alterar(oCombustivel: TCombustivel; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
    procedure ListarImpostos;
  end;

implementation

{ TCombustivelController }

function TCombustivelController.Alterar(oCombustivel: TCombustivel;
  var sErro: string): Boolean;
begin
  Result := dmCombustivel.Alterar(oCombustivel, sErro);
end;

procedure TCombustivelController.CarregarCombustivel(oCombustivel: TCombustivel;
  iId: Integer);
begin
  dmCombustivel.CarregarCombustivel(oCombustivel, iId);
end;

function TCombustivelController.Excluir(iId: Integer;
  var sErro: string): Boolean;
begin
  Result := dmCombustivel.Excluir(iId, sErro);
end;

function TCombustivelController.Inserir(oCombustivel: TCombustivel;
  var sErro: string): Boolean;
begin
  Result := dmCombustivel.Inserir(oCombustivel, sErro);
end;

procedure TCombustivelController.ListarImpostos;
begin
  dmCombustivel.ListarImpostos;
end;

procedure TCombustivelController.Pesquisar(sDescricao: string);
begin
  dmCombustivel.Pesquisar(sDescricao);
end;

end.
