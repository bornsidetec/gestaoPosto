unit dImposto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient,
  Datasnap.Provider, dConexao, mImposto;

type
  TdmImposto = class(TDataModule)
    qryImposto: TFDQuery;
    dspImposto: TDataSetProvider;
    cdsImposto: TClientDataSet;
    qryInserir: TFDQuery;
    qryAlterar: TFDQuery;
    qryExcluir: TFDQuery;
    cdsImpostoId: TIntegerField;
    cdsImpostoDescricao: TStringField;
    cdsImpostoAliquota: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarId: Integer;
    procedure Pesquisar(sDescricao: string);
    procedure CarregarImposto(oImposto: TImposto; iId: Integer);
    function Inserir(oImposto: TImposto; out sErro: string): Boolean;
    function Alterar(oImposto: TImposto; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
  end;

var
  dmImposto: TdmImposto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
{ TDmImposto }

function TdmImposto.Alterar(oImposto: TImposto; out sErro: string): Boolean;
begin

  qryAlterar.Params[0].AsInteger := oImposto.Id;
  qryAlterar.Params[1].AsString := oImposto.Descricao;
  qryAlterar.Params[2].AsFloat := oImposto.Aliquota;

  try
    qryAlterar.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao alterar Imposto: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmImposto.CarregarImposto(oImposto: TImposto; iId: Integer);
var
  qryCarregaImposto: TFDQuery;
begin
  qryCarregaImposto := TFDQuery.Create(nil);
  try
    qryCarregaImposto.Connection := dmConexao.Conexao;
    qryCarregaImposto.SQL.Add('SELECT * FROM Impostos WHERE Id = :id');
    qryCarregaImposto.ParamByName('id').AsInteger := iId;
    qryCarregaImposto.Open;

    oImposto.Id := qryCarregaImposto.FieldByName('Id').AsInteger;
    oImposto.Descricao := qryCarregaImposto.FieldByName('Descricao').AsString;
    oImposto.Aliquota := qryCarregaImposto.FieldByName('Aliquota').AsFloat;
  finally
    FreeAndNil(qryCarregaImposto);
  end;
end;

function TdmImposto.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.Params[0].AsInteger := iId;

  try
    qryExcluir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao excluir Imposto: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmImposto.GerarId: Integer;
var
  qrySeq: TFDQuery;
begin

  qrySeq := TFDQuery.Create(nil);
  try
    qrySeq.Connection := dmConexao.Conexao;
    qrySeq.SQL.Add('SELECT IFNULL(max(id), 0) + 1 as Seq FROM Impostos');
    qrySeq.Open;
    Result := qrySeq.FieldByName('Seq').AsInteger;
  finally
    FreeAndNil(qrySeq);
  end;

end;

function TdmImposto.Inserir(oImposto: TImposto; out sErro: string): Boolean;
begin

  qryInserir.Params[0].AsInteger := GerarId;
  qryInserir.Params[1].AsString := oImposto.Descricao;
  qryInserir.Params[2].AsFloat := oImposto.Aliquota;

  try
    qryInserir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao inserir Imposto: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmImposto.Pesquisar(sDescricao: string);
begin
  if cdsImposto.Active then
    cdsImposto.Close;

  cdsImposto.Params[0].AsString := '%' + sDescricao + '%';
  cdsImposto.Open;
  cdsImposto.First;
end;

end.
