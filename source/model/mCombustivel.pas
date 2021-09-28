unit mCombustivel;

interface

uses
  System.SysUtils;

type
  TCombustivel = class
  private
    FValor: Double;
    FDescricao: string;
    FId: Integer;
    FImposto: Integer;
    procedure SetDescricao(const Value: string);

  public
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write SetDescricao;
    property Valor: Double read FValor write FValor;
    property Imposto: Integer read FImposto write FImposto;

  end;

implementation

{ TCombustivel }

procedure TCombustivel.SetDescricao(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Descrição não informada');

  FDescricao := Value;
end;

end.
