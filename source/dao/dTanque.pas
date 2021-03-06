unit dTanque;

interface

uses
  System.SysUtils, System.Classes, dConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, mTanque;

type
  TdmTanque = class(TDataModule)
    qryInserir: TFDQuery;
    qryAlterar: TFDQuery;
    qryExcluir: TFDQuery;
    qryCombustivel: TFDQuery;
    qryTanque: TFDQuery;
    dspTanque: TDataSetProvider;
    cdsTanque: TClientDataSet;
    cdsTanqueId: TIntegerField;
    cdsTanqueDescricao: TStringField;
    cdsTanqueCombustivel: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarId: Integer;
    procedure Pesquisar(sDescricao: string);
    procedure CarregarTanque(oTanque: TTanque; iId: Integer);
    function Inserir(oTanque: TTanque; out sErro: string): Boolean;
    function Alterar(oTanque: TTanque; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
    procedure ListarCombustiveis;
  end;

var
  dmTanque: TdmTanque;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmTanque }

function TdmTanque.Alterar(oTanque: TTanque; out sErro: string): Boolean;
begin

  qryAlterar.Params[0].AsInteger := oTanque.Id;
  qryAlterar.Params[1].AsString := oTanque.Descricao;
  qryAlterar.Params[2].AsInteger := oTanque.Combustivel;

  try
    qryAlterar.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao alterar Tanque: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmTanque.CarregarTanque(oTanque: TTanque; iId: Integer);
var
  qryCarregaTanque: TFDQuery;
begin

  qryCarregaTanque := TFDQuery.Create(nil);
  try
    qryCarregaTanque.Connection := dmConexao.Conexao;
    qryCarregaTanque.SQL.Add('SELECT * FROM Tanques WHERE Id = :id');
    qryCarregaTanque.ParamByName('id').AsInteger := iId;
    qryCarregaTanque.Open;

    oTanque.Id := qryCarregaTanque.FieldByName('Id').AsInteger;
    oTanque.Descricao := qryCarregaTanque.FieldByName('Descricao').AsString;
    oTanque.Combustivel := qryCarregaTanque.FieldByName('Combustivel').AsInteger;

  finally
    FreeAndNil(qryCarregaTanque);
  end;

end;

function TdmTanque.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.Params[0].AsInteger := iId;

  try
    qryExcluir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao excluir Tanque: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmTanque.GerarId: Integer;
var
  qrySeq: TFDQuery;
begin

  qrySeq := TFDQuery.Create(nil);
  try
    qrySeq.Connection := dmConexao.Conexao;
    qrySeq.SQL.Add('SELECT IFNULL(max(id), 0) + 1 as Seq FROM Tanques');
    qrySeq.Open;
    Result := qrySeq.FieldByName('Seq').AsInteger;
  finally
    FreeAndNil(qrySeq);
  end;

end;

function TdmTanque.Inserir(oTanque: TTanque; out sErro: string): Boolean;
begin

  qryInserir.Params[0].AsInteger := GerarId;
  qryInserir.Params[1].AsString := oTanque.Descricao;
  qryInserir.Params[2].AsInteger := oTanque.Combustivel;

  try
    qryInserir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao inserir Tanque: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmTanque.ListarCombustiveis;
begin
  if qryCombustivel.Active then
    qryCombustivel.Close;

  qryCombustivel.Open;
  qryCombustivel.First;
end;

procedure TdmTanque.Pesquisar(sDescricao: string);
begin

  if cdsTanque.Active then
    cdsTanque.Close;

  cdsTanque.Params[0].AsString := '%' + sDescricao + '%';
  cdsTanque.Open;
  cdsTanque.First;

end;

end.
