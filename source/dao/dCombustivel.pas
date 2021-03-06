unit dCombustivel;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient,
  Datasnap.Provider, dConexao, mCombustivel;

type
  TdmCombustivel = class(TDataModule)
    qryExcluir: TFDQuery;
    qryAlterar: TFDQuery;
    qryInserir: TFDQuery;
    qryImpostos: TFDQuery;
    qryCombustivel: TFDQuery;
    dspCombustivel: TDataSetProvider;
    cdsCombustivel: TClientDataSet;
    cdsCombustivelId: TIntegerField;
    cdsCombustivelDescricao: TStringField;
    cdsCombustivelValor: TFloatField;
    cdsCombustivelImposto: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarId: Integer;
    procedure Pesquisar(sDescricao: string);
    procedure CarregarCombustivel(oCombustivel: TCombustivel; iId: Integer);
    function Inserir(oCombustivel: TCombustivel; out sErro: string): Boolean;
    function Alterar(oCombustivel: TCombustivel; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
    procedure ListarImpostos;
  end;

var
  dmCombustivel: TdmCombustivel;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmCombustivel }

function TdmCombustivel.Alterar(oCombustivel: TCombustivel;
  out sErro: string): Boolean;
begin

  qryAlterar.Params[0].AsInteger := oCombustivel.Id;
  qryAlterar.Params[1].AsString := oCombustivel.Descricao;
  qryAlterar.Params[2].AsFloat := oCombustivel.Valor;
  qryAlterar.Params[3].AsInteger := oCombustivel.Imposto;

  try
    qryAlterar.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao alterar Combustível: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmCombustivel.CarregarCombustivel(oCombustivel: TCombustivel;
  iId: Integer);
var
  qryCarregaCombustivel: TFDQuery;
begin

  qryCarregaCombustivel := TFDQuery.Create(nil);
  try
    qryCarregaCombustivel.Connection := dmConexao.Conexao;
    qryCarregaCombustivel.SQL.Add('SELECT * FROM Combustiveis WHERE Id = :id');
    qryCarregaCombustivel.ParamByName('id').AsInteger := iId;
    qryCarregaCombustivel.Open;

    oCombustivel.Id := qryCarregaCombustivel.FieldByName('Id').AsInteger;
    oCombustivel.Descricao := qryCarregaCombustivel.FieldByName('Descricao').AsString;
    oCombustivel.Valor := qryCarregaCombustivel.FieldByName('Valor').AsFloat;
    oCombustivel.Imposto := qryCarregaCombustivel.FieldByName('Imposto').AsInteger;
  finally
    FreeAndNil(qryCarregaCombustivel);
  end;

end;

function TdmCombustivel.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.Params[0].AsInteger := iId;

  try
    qryExcluir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao excluir Combustível: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmCombustivel.GerarId: Integer;
var
  qrySeq: TFDQuery;
begin

  qrySeq := TFDQuery.Create(nil);
  try
    qrySeq.Connection := dmConexao.Conexao;
    qrySeq.SQL.Add('SELECT IFNULL(max(id), 0) + 1 as Seq FROM Combustiveis');
    qrySeq.Open;
    Result := qrySeq.FieldByName('Seq').AsInteger;
  finally
    FreeAndNil(qrySeq);
  end;

end;

function TdmCombustivel.Inserir(oCombustivel: TCombustivel;
  out sErro: string): Boolean;
begin

  qryInserir.Params[0].AsInteger := GerarId;
  qryInserir.Params[1].AsString := oCombustivel.Descricao;
  qryInserir.Params[2].AsFloat := oCombustivel.Valor;
  qryInserir.Params[3].AsInteger := oCombustivel.Imposto;

  try
    qryInserir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao inserir Combustível: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmCombustivel.ListarImpostos;
begin

  if qryImpostos.Active then
    qryImpostos.Close;

  qryImpostos.Open;
  qryImpostos.First;

end;

procedure TdmCombustivel.Pesquisar(sDescricao: string);
begin

  if cdsCombustivel.Active then
    cdsCombustivel.Close;

  cdsCombustivel.Params[0].AsString := '%' + sDescricao + '%';
  cdsCombustivel.Open;
  cdsCombustivel.First;

end;

end.
