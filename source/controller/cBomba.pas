unit cBomba;

interface

uses
  mBomba, dBomba, System.SysUtils;

type
  TBombaController = class
  public
    procedure Pesquisar(sDescricao: string);
    procedure CarregarBomba(oBomba: TBomba; iId: Integer);
    function Inserir(oBomba: TBomba; var sErro: string): Boolean;
    function Alterar(oBomba: TBomba; var sErro: string): Boolean;
    function Excluir(iId: Integer; var sErro: string): Boolean;
    procedure ListarTanques;
  end;

implementation

{ TBombaController }

function TBombaController.Alterar(oBomba: TBomba;
  var sErro: string): Boolean;
begin
  Result := dmBomba.Alterar(oBomba, sErro);
end;

procedure TBombaController.CarregarBomba(oBomba: TBomba;
  iId: Integer);
begin
  dmBomba.CarregarBomba(oBomba, iId);
end;

function TBombaController.Excluir(iId: Integer;
  var sErro: string): Boolean;
begin
  Result := dmBomba.Excluir(iId, sErro);
end;

function TBombaController.Inserir(oBomba: TBomba;
  var sErro: string): Boolean;
begin
  Result := dmBomba.Inserir(oBomba, sErro);
end;

procedure TBombaController.ListarTanques;
begin
  dmBomba.ListarTanques;
end;

procedure TBombaController.Pesquisar(sDescricao: string);
begin
  dmBomba.Pesquisar(sDescricao);
end;


end.
