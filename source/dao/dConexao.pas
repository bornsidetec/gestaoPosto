unit dConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TdmConexao = class(TDataModule)
    Conexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Conectar;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmConexao }

{ TdmConexao }

procedure TdmConexao.Conectar;
var
  slAcesso: TStringList;
begin

  slAcesso := TStringList.Create;

  if FileExists('acesso.config') then
    slAcesso.LoadFromFile('acesso.config')
  else
  begin
    slAcesso.Add('..\..\bd\Posto.db');
    slAcesso.SaveToFile('acesso.config');
  end;

  try
    if FileExists(slAcesso[0]) then
    begin
      Conexao.Params.Database := slAcesso[0];
      try
        Conexao.Connected := True;
      except
        on E: Exception do
        begin
          raise Exception.Create(E.Message);
        end;

      end;
    end
    else
      raise Exception.Create('Banco de Dados n�o encontrado');
  finally
    FreeAndNil(slAcesso);
  end;

end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  Conexao.Connected := False;
  Conectar;
end;

end.
