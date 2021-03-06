unit dBomba;

interface

uses
  System.SysUtils, System.Classes, dConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, mBomba;

type
  TdmBomba = class(TDataModule)
    qryExcluir: TFDQuery;
    qryAlterar: TFDQuery;
    qryInserir: TFDQuery;
    qryTanques: TFDQuery;
    qryBomba: TFDQuery;
    dspBomba: TDataSetProvider;
    cdsBomba: TClientDataSet;
    cdsBombaId: TIntegerField;
    cdsBombaDescricao: TStringField;
    cdsBombaTanque: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarId: Integer;
    procedure Pesquisar(sDescricao: string);
    procedure CarregarBomba(oBomba: TBomba; iId: Integer);
    function Inserir(oBomba: TBomba; out sErro: string): Boolean;
    function Alterar(oBomba: TBomba; out sErro: string): Boolean;
    function Excluir(iId: Integer; out sErro: string): Boolean;
    procedure ListarTanques;
  end;

var
  dmBomba: TdmBomba;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmBomba }

function TdmBomba.Alterar(oBomba: TBomba; out sErro: string): Boolean;
begin

  qryAlterar.Params[0].AsInteger := oBomba.Id;
  qryAlterar.Params[1].AsString := oBomba.Descricao;
  qryAlterar.Params[2].AsInteger := oBomba.Tanque;

  try
    qryAlterar.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao alterar Bomba: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmBomba.CarregarBomba(oBomba: TBomba; iId: Integer);
var
  qryCarregaBomba: TFDQuery;
begin

  qryCarregaBomba := TFDQuery.Create(nil);
  try
    qryCarregaBomba.Connection := dmConexao.Conexao;
    qryCarregaBomba.SQL.Add('SELECT * FROM Bombas WHERE Id = :id');
    qryCarregaBomba.ParamByName('id').AsInteger := iId;
    qryCarregaBomba.Open;

    oBomba.Id := qryCarregaBomba.FieldByName('Id').AsInteger;
    oBomba.Descricao := qryCarregaBomba.FieldByName('Descricao').AsString;
    oBomba.Tanque := qryCarregaBomba.FieldByName('Tanque').AsInteger;

  finally
    FreeAndNil(qryCarregaBomba);
  end;

end;

function TdmBomba.Excluir(iId: Integer; out sErro: string): Boolean;
begin

  qryExcluir.Params[0].AsInteger := iId;

  try
    qryExcluir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao excluir Bomba: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

function TdmBomba.GerarId: Integer;
var
  qrySeq: TFDQuery;
begin

  qrySeq := TFDQuery.Create(nil);
  try
    qrySeq.Connection := dmConexao.Conexao;
    qrySeq.SQL.Add('SELECT IFNULL(max(id), 0) + 1 as Seq FROM Bombas');
    qrySeq.Open;
    Result := qrySeq.FieldByName('Seq').AsInteger;
  finally
    FreeAndNil(qrySeq);
  end;

end;

function TdmBomba.Inserir(oBomba: TBomba; out sErro: string): Boolean;
begin

  qryInserir.Params[0].AsInteger := GerarId;
  qryInserir.Params[1].AsString := oBomba.Descricao;
  qryInserir.Params[2].AsInteger := oBomba.Tanque;

  try
    qryInserir.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      sErro := 'Erro ao inserir Bomba: ' + sLineBreak + E.Message;
      Result := False;
    end;

  end;

end;

procedure TdmBomba.ListarTanques;
begin

  if qryTanques.Active then
    qryTanques.Close;

  qryTanques.Open;
  qryTanques.First;

end;

procedure TdmBomba.Pesquisar(sDescricao: string);
begin

  if cdsBomba.Active then
    cdsBomba.Close;

  cdsBomba.Params[0].AsString := '%' + sDescricao + '%';
  cdsBomba.Open;
  cdsBomba.First;

end;

end.
