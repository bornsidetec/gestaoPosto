unit mTanque;

interface

uses
  System.SysUtils;

type
  TTanque = class
  private
    FDescricao: string;
    FId: Integer;
    FCombustivel: Integer;
    procedure SetDescricao(const Value: string);

  public
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write SetDescricao;
    property Combustivel: Integer read FCombustivel write FCombustivel;

  end;

implementation

{ TCombustivel }

procedure TTanque.SetDescricao(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Descrição não informada');

  FDescricao := Value;
end;

end.
