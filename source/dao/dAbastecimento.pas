unit dAbastecimento;

interface

uses
  System.SysUtils, System.Classes, dConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, mAbastecimento;

type
  TdmAbastecimento = class(TDataModule)
    qryBomba: TFDQuery;
    qryExcluir: TFDQuery;
    qryInserir: TFDQuery;
    cdsAbastecimento: TClientDataSet;
    dspAbastecimento: TDataSetProvider;
    qryAbastecimento: TFDQuery;
    qryDados: TFDQuery;
    cdsAbastecimentoId: TIntegerField;
    cdsAbastecimentoBomba: TStringField;
    cdsAbastecimentoValor: TFloatField;
    cdsAbastecimentoValorTotal: TFloatField;
    cdsAbastecimentoAliquota: TFloatField;
    cdsAbastecimentoValorImposto: TFloatField;
    cdsAbastecimentoTotalPagar: TFloatField;
    dspDados: TDataSetProvider;
    cdsDados: TClientDataSet;
    cdsDadosId: TIntegerField;
    cdsDadosBomba: TStringField;
    cdsDadosCombustivel: TStringField;
    cdsDadosValor: TFloatField;
    cdsDadosAliquota: TFloatField;
    cdsAbastecimentoQuantidade: TFloatField;
    cdsAbastecimentoData: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarId: Integer;
    procedure Pesquisar(dData: TDateTime);
    procedure CarregarAbastecimento(oAbastecimento: TAbastecimento; iId: Integer);
    function Inserir(oAbastecimento: TAbastecimento; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
    procedure ListarBombas;

  end;

var
  dmAbastecimento: TdmAbastecimento;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmAbastecimento }

procedure TdmAbastecimento.CarregarAbastecimento(oAbastecimento: TAbastecimento;
  iId: Integer);
var
  qryCarregaAbastecimento: TFDQuery;

begin

  qryCarregaAbastecimento := TFDQuery.Create(nil);
  try
    qryCarregaAbastecimento.Connection := dmConexao.Conexao;
    qryCarregaAbastecimento.SQL.Add('SELECT * FROM Abastecimentos WHERE Id = :id');
    qryCarregaAbastecimento.ParamByName('id').AsInteger := iId;
    qryCarregaAbastecimento.Open;

    oAbastecimento.Id := qryCarregaAbastecimento.FieldByName('Id').AsInteger;
    oAbastecimento.Bomba := qryCarregaAbastecimento.FieldByName('Bomba').AsInteger;
    oAbastecimento.Data := qryCarregaAbastecimento.FieldByName('Data').AsDateTime;
    oAbastecimento.Quantidade := qryCarregaAbastecimento.FieldByName('Quantidade').AsInteger;
    oAbastecimento.Valor := qryCarregaAbastecimento.FieldByName('Valor').AsFloat;
    oAbastecimento.ValorTotal := qryCarregaAbastecimento.FieldByName('ValorTotal').AsFloat;
    oAbastecimento.Aliquota := qryCarregaAbastecimento.FieldByName('Aliquota').AsFloat;
    oAbastecimento.ValorImposto := qryCarregaAbastecimento.FieldByName('ValorImposto').AsFloat;
    oAbastecimento.TotalPagar := qryCarregaAbastecimento.FieldByName('TotalPagar').AsFloat;

  finally
    FreeAndNil(qryCarregaAbastecimento);
  end;
end;

function TdmAbastecimento.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.Params[0].AsInteger := iId;

  try
    qryExcluir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao excluir Abastecimento: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmAbastecimento.GerarId: Integer;
var
  qrySeq: TFDQuery;
begin

  qrySeq := TFDQuery.Create(nil);
  try
    qrySeq.Connection := dmConexao.Conexao;
    qrySeq.SQL.Add('SELECT IFNULL(max(id), 0) + 1 as Seq FROM Abastecimentos');
    qrySeq.Open;
    Result := qrySeq.FieldByName('Seq').AsInteger;
  finally
    FreeAndNil(qrySeq);
  end;

end;

function TdmAbastecimento.Inserir(oAbastecimento: TAbastecimento;
  out sErro: string): Boolean;
begin

  qryInserir.Params[0].AsInteger := GerarId;
  qryInserir.Params[1].AsInteger := oAbastecimento.Bomba;
  qryInserir.Params[2].AsDateTime := oAbastecimento.Data;
  qryInserir.Params[3].AsFloat := oAbastecimento.Quantidade;
  qryInserir.Params[4].AsFloat := oAbastecimento.Valor;
  qryInserir.Params[5].AsFloat := oAbastecimento.ValorTotal;
  qryInserir.Params[6].AsFloat := oAbastecimento.Aliquota;
  qryInserir.Params[7].AsFloat := oAbastecimento.ValorImposto;
  qryInserir.Params[8].AsFloat := oAbastecimento.TotalPagar;

  try
    qryInserir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao inserir Abastecimento: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmAbastecimento.ListarBombas;
begin
  if qryBomba.Active then
    qryBomba.Close;

  qryBomba.Open;
  qryBomba.First;
end;

procedure TdmAbastecimento.Pesquisar(dData: TDateTime);
begin

  if cdsAbastecimento.Active then
    cdsAbastecimento.Close;

  cdsAbastecimento.Params[1].AsDateTime := Trunc(dData);

  if dData > 0 then
    cdsAbastecimento.Params[0].AsInteger := 0
  else
    cdsAbastecimento.Params[0].AsInteger := 1;

  cdsAbastecimento.Open;
  cdsAbastecimento.First;

end;

end.
