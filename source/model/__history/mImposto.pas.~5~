unit mImposto;

interface

uses
  System.SysUtils;

type
  TImposto = class
  private
    FDescricao: string;
    Fid: Integer;
    FAliquota: Double;
    procedure SetDescricao(const Value: string);
  public
    property Id: Integer read Fid write Fid;
    property Descricao: string read FDescricao write SetDescricao;
    property Aliquota: Double read FAliquota write FAliquota;
  end;

implementation

{ TImposto }

procedure TImposto.SetDescricao(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Descrição não informada');

  FDescricao := Value;
end;

end.
