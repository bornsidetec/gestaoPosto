unit vAbastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, dAbastecimento, cAbastecimento,
  Vcl.DBCtrls, hComboBox, hEdit, uCalculos, mAbastecimento;

type
  TTipoPesquisa = (tpHoje, tpTodos);
  TAcao = (acInsere, acLista);

  TfAbastecimentos = class(TForm)
    pnlTop: TPanel;
    ImageList: TImageList;
    pnlBotom: TPanel;
    btnFechar: TBitBtn;
    pnlDados: TPanel;
    pnlGrid: TPanel;
    pnlAcoesGrid: TPanel;
    btnExcluir: TBitBtn;
    pnlAcoes: TPanel;
    Label4: TLabel;
    cboBomba: TComboBox;
    Label1: TLabel;
    edtData: TMaskEdit;
    Label2: TLabel;
    edtQuantidade: TEdit;
    Label3: TLabel;
    edtValor: TEdit;
    DBGrid1: TDBGrid;
    dsPesquisa: TDataSource;
    rbHoje: TRadioButton;
    rbTodos: TRadioButton;
    dsDados: TDataSource;
    Label5: TLabel;
    edtCombustivel: TDBEdit;
    Label6: TLabel;
    edtAliquota: TDBEdit;
    Label8: TLabel;
    edtValorImposto: TEdit;
    Label7: TLabel;
    edtValorTotal: TEdit;
    Label9: TLabel;
    edtTotalPagar: TEdit;
    btnInserir: TBitBtn;
    ActionList: TActionList;
    actFechar: TAction;
    actInserir: TAction;
    actExcluir: TAction;
    actSalvar: TAction;
    actCancelar: TAction;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExcluirExecute(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure rbHojeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure cboBombaChange(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtDataKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Pesquisar(tp: TTipoPesquisa);
    procedure Excluir;
    procedure Limpar;
    procedure LimparCalculos;
    procedure SugerirDados;
    procedure BuscarDados;
    procedure Calcular;
    procedure Agora;
    procedure Salvar;
    procedure Inserir;
    procedure Validar;
    procedure HabilitarAcoes(aAcao: TAcao);

    procedure CarregarLista(cbLista: TComboBox);
  public
    { Public declarations }
    FTipoPesquisa: TTipoPesquisa;
    FAcao: TAcao;
  end;

var
  fAbastecimentos: TfAbastecimentos;

implementation

{$R *.dfm}

procedure TfAbastecimentos.actCancelarExecute(Sender: TObject);
begin
  HabilitarAcoes(acLista);
end;

procedure TfAbastecimentos.actExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfAbastecimentos.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfAbastecimentos.actInserirExecute(Sender: TObject);
begin
  FAcao := acInsere;
  HabilitarAcoes(acInsere);
  Limpar;
end;

procedure TfAbastecimentos.actSalvarExecute(Sender: TObject);
begin
  Validar;
  Salvar;
  HabilitarAcoes(acLista);
end;

procedure TfAbastecimentos.Agora;
begin
  edtData.Text := FormatDateTime('DD/MM/YYYY HH:MM', now);
end;

procedure TfAbastecimentos.BuscarDados;
begin
  dmAbastecimento.cdsDados.Close;
  dmAbastecimento.cdsDados.Params[0].AsInteger :=
    cboBomba.Id(cboBomba.Text, '-');
  dmAbastecimento.cdsDados.Open;
end;

procedure TfAbastecimentos.Calcular;
var
  dQuantidade, dAliquota, dValor: Double;
  dValorTotal, dImposto, dTotal: Double;

begin

  dQuantidade := StrToFloat(edtQuantidade.Text);
  dAliquota := dmAbastecimento.cdsDadosAliquota.AsFloat;
  dValor := StrToFloat(edtValor.Text);

  dValorTotal := TCalculos.Valor(dQuantidade, dValor);
  dImposto := TCalculos.Imposto(dAliquota, dValorTotal);
  dTotal := TCalculos.Total(dAliquota, dValorTotal);

  edtValorTotal.Text := FormatFloat('#0.00', dValorTotal);
  edtValorImposto.Text := FormatFloat('#0.00', dImposto);
  edtTotalPagar.Text := FormatFloat('#0.00', dTotal);
end;

procedure TfAbastecimentos.CarregarLista(cbLista: TComboBox);
var
  oAbastecimentoController: TAbastecimentoController;
begin

  oAbastecimentoController := TAbastecimentoController.Create;
  try
    oAbastecimentoController.ListarBombas;

    cbLista.Items.Clear;
    while not dmAbastecimento.qryBomba.Eof do
    begin
      cbLista.Items.Add(dmAbastecimento.qryBomba.FieldByName('Id').AsString + '-'
        + dmAbastecimento.qryBomba.FieldByName('Descricao').AsString);
      dmAbastecimento.qryBomba.Next;
    end;

  finally
    FreeAndNil(oAbastecimentoController);
  end;

end;

procedure TfAbastecimentos.cboBombaChange(Sender: TObject);
begin
  SugerirDados;
end;

procedure TfAbastecimentos.edtDataKeyPress(Sender: TObject; var Key: Char);
begin
  edtData.Agora(Key, edtData);
end;

procedure TfAbastecimentos.edtQuantidadeExit(Sender: TObject);
begin
  if (not string(edtQuantidade.Text).IsEmpty) and
    (not string(edtValor.Text).IsEmpty) then

  Calcular;
end;

procedure TfAbastecimentos.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  edtQuantidade.KeyPress(Key, edtQuantidade.Text, edtQuantidade.SelStart, 2, 2);
end;

procedure TfAbastecimentos.edtValorExit(Sender: TObject);
begin
  Calcular;
end;

procedure TfAbastecimentos.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  edtValor.KeyPress(Key, edtValor.Text, edtValor.SelStart, 5, 2);
end;

procedure TfAbastecimentos.Excluir;
var
  oAbastecimentoController: TAbastecimentoController;
  sErro: string;
begin

  oAbastecimentoController := TAbastecimentoController.Create;
  try
    if (dmAbastecimento.cdsAbastecimento.Active) and
      (dmAbastecimento.cdsAbastecimento.RecordCount > 0) then
    begin
      if MessageDlg('Confirma a exclusão?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oAbastecimentoController.Excluir
          (dmAbastecimento.cdsAbastecimentoId.AsInteger, sErro) = False then
          raise Exception.Create(sErro);
        Pesquisar(FTipoPesquisa);
      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oAbastecimentoController);
  end;

end;

procedure TfAbastecimentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Self := nil;
end;

procedure TfAbastecimentos.FormCreate(Sender: TObject);
begin
  dmAbastecimento := TdmAbastecimento.Create(nil);
  Agora;
end;

procedure TfAbastecimentos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmAbastecimento);
end;

procedure TfAbastecimentos.FormShow(Sender: TObject);
begin
  HabilitarAcoes(acLista);
  Pesquisar(FTipoPesquisa);
end;

procedure TfAbastecimentos.HabilitarAcoes(aAcao: TAcao);
begin

  case aAcao of
    acInsere:
      begin
        btnFechar.Enabled := False;
        btnExcluir.Enabled := False;
        btnInserir.Enabled := False;
        pnlDados.Visible := True;
        btnSalvar.Enabled := True;
        btnCancelar.Enabled := True;
        CarregarLista(cboBomba);
      end;
    acLista:
      begin
        btnFechar.Enabled := True;
        btnExcluir.Enabled := True;
        btnInserir.Enabled := True;
        pnlDados.Visible := False;
        btnSalvar.Enabled := False;
        btnCancelar.Enabled := False;
      end;
  end;

end;

procedure TfAbastecimentos.Inserir;
var
  oAbastecimento: TAbastecimento;
  oAbastecimentoController: TAbastecimentoController;
  sErro: string;
begin

  oAbastecimento := TAbastecimento.Create;
  oAbastecimentoController := TAbastecimentoController.Create;

  try
    oAbastecimento.Bomba := cboBomba.Id(cboBomba.Text, '-');
    oAbastecimento.Data := StrToDateTime(edtData.Text);
    oAbastecimento.Quantidade := StrToFloat(edtQuantidade.Text);
    oAbastecimento.Valor := StrToFloat(edtValor.Text);
    oAbastecimento.ValorTotal := StrToFloat(edtValorTotal.Text);
    oAbastecimento.Aliquota := dmAbastecimento.cdsDadosAliquota.AsFloat;
    oAbastecimento.ValorImposto := StrToFloat(edtValorImposto.Text);
    oAbastecimento.TotalPagar := StrToFloat(edtTotalPagar.Text);

    if not oAbastecimentoController.Inserir(oAbastecimento, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oAbastecimentoController);
    FreeAndNil(oAbastecimento);
  end;

end;

procedure TfAbastecimentos.Limpar;
begin

  cboBomba.ItemIndex := -1;
  cboBomba.SetFocus;
  edtData.Clear;
  edtQuantidade.Clear;
  edtValor.Clear;

  dmAbastecimento.cdsDados.Close;

  LimparCalculos;

end;

procedure TfAbastecimentos.LimparCalculos;
begin

  edtValorImposto.Clear;
  edtValorTotal.Clear;
  edtTotalPagar.Clear;

end;

procedure TfAbastecimentos.Pesquisar(tp: TTipoPesquisa);
var
  oAbastecimentoController: TAbastecimentoController;
begin

  oAbastecimentoController := TAbastecimentoController.Create;
  try
    case tp of
      tpHoje:
        oAbastecimentoController.Pesquisar(StrToDateTime(edtData.Text));
      tpTodos:
        oAbastecimentoController.Pesquisar(0);
    end;
  finally
    FreeAndNil(oAbastecimentoController);
  end;
end;

procedure TfAbastecimentos.rbHojeClick(Sender: TObject);
begin
  if rbHoje.Checked then
    FTipoPesquisa := tpHoje
  else if rbTodos.Checked then
    FTipoPesquisa := tpTodos;

  Pesquisar(FTipoPesquisa);
end;

procedure TfAbastecimentos.Salvar;
var
  oAbastecimentoController: TAbastecimentoController;
begin

  oAbastecimentoController := TAbastecimentoController.Create;

  try
    Inserir;
    rbHoje.Checked;
    Pesquisar(tpHoje);
  finally
    FreeAndNil(oAbastecimentoController);
  end;

end;

procedure TfAbastecimentos.SugerirDados;
begin

  BuscarDados;
  Agora;
  edtValor.Text := FormatFloat('#0.00', dmAbastecimento.cdsDadosValor.AsFloat);

  LimparCalculos;

  edtQuantidade.SetFocus;

end;

procedure TfAbastecimentos.Validar;
begin
  if (edtData.Text = '  /  /       :  ') or
    (string(edtValor.Text).IsEmpty) or
    (string(edtQuantidade.Text).IsEmpty) then
    raise Exception.Create('Dados Incorretos');
end;

end.
