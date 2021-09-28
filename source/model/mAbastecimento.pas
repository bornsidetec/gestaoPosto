unit mAbastecimento;

interface

uses
  System.SysUtils;

type
  TAbastecimento = class
  private
    FId: Integer;
    FBomba: Integer;
    FQuantidade: Double;
    FData: TDateTime;
    FValor: Double;
    FValorImposto: Double;
    FValorTotal: Double;
    FAliquota: Double;
    FTotalPagar: Double;
    procedure SetQuantidade(const Value: Double);
    procedure SetValor(const Value: Double);

  public
    property Id: Integer read FId write FId;
    property Bomba: Integer read FBomba write FBomba;
    property Data: TDateTime read FData write FData;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property Valor: Double read FValor write SetValor;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property Aliquota: Double read FAliquota write FAliquota;
    property ValorImposto: Double read FValorImposto write FValorImposto;
    property TotalPagar: Double read FTotalPagar write FTotalPagar;
  end;


implementation

{ TAbastecimento }

{ TAbastecimento }

procedure TAbastecimento.SetQuantidade(const Value: Double);
begin
  if Value <= 0 then
    raise EArgumentException.Create('Quantidade inválida');

  FQuantidade := Value;
end;

procedure TAbastecimento.SetValor(const Value: Double);
begin
  if Value <= 0 then
    raise EArgumentException.Create('Valor inválido');

  FValor := Value;
end;

end.
