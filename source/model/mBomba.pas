unit mBomba;

interface

uses
  System.SysUtils;

type
  TBomba = class
  private
    FDescricao: string;
    FId: Integer;
    FTanque: Integer;
    procedure SetDescricao(const Value: string);

  public
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write SetDescricao;
    property Tanque: Integer read FTanque write FTanque;

  end;

implementation

{ TBomba }

procedure TBomba.SetDescricao(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Descri��o n�o informada');

  FDescricao := Value;
end;

end.
