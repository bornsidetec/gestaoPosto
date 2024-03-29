unit vCombustiveis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, vCadastro, Data.DB, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  cCombustivel, mCombustivel, dCombustivel, hEdit,
  hComboBox;

type
  TfCombustiveis = class(TfCadastro)
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    edtValor: TEdit;
    Label4: TLabel;
    cboImposto: TComboBox;
    procedure actPesquisarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDetalharExecute(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure actAlterarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
    procedure Carregar;
    procedure Alterar;
    procedure Excluir;
    procedure Inserir;
    procedure Salvar;
    procedure Limpar;
    procedure HabilitarEdits(aAcao: TAcao);

    procedure CarregarLista(cbLista: TComboBox);

  public
    { Public declarations }
  end;

var
  fCombustiveis: TfCombustiveis;

implementation

{$R *.dfm}
{ TfCombustiveis }

procedure TfCombustiveis.actAlterarExecute(Sender: TObject);
begin
  inherited;
  HabilitarEdits(acAltera);
end;

procedure TfCombustiveis.actCancelarExecute(Sender: TObject);
begin
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfCombustiveis.actDetalharExecute(Sender: TObject);
begin
  Carregar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfCombustiveis.actExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfCombustiveis.actInserirExecute(Sender: TObject);
begin
  inherited;
  Limpar;
  HabilitarEdits(acInsere);
end;

procedure TfCombustiveis.actPesquisarExecute(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfCombustiveis.actSalvarExecute(Sender: TObject);
begin
  Salvar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfCombustiveis.Alterar;
var
  oCombustivel: TCombustivel;
  oCombustivelController: TCombustivelController;
  sErro: string;
begin

  oCombustivel := TCombustivel.Create;
  oCombustivelController := TCombustivelController.Create;

  try

    oCombustivel.Id := StrToInt(edtId.Text);
    oCombustivel.Descricao := edtDescricao.Text;
    oCombustivel.Valor := StrToFloat(edtValor.Text);
    oCombustivel.Imposto := cboImposto.Id(cboImposto.Text, '-');

    if not oCombustivelController.Alterar(oCombustivel, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oCombustivelController);
    FreeAndNil(oCombustivel);
  end;

end;

procedure TfCombustiveis.Carregar;
var
  oCombustivel: TCombustivel;
  oCombustivelController: TCombustivelController;
begin

  oCombustivel := TCombustivel.Create;
  oCombustivelController := TCombustivelController.Create;
  try

    oCombustivelController.CarregarCombustivel(oCombustivel,
      dsPesquisa.DataSet.FieldByName('Id').AsInteger);
    edtId.Text := IntToStr(oCombustivel.Id);
    edtDescricao.Text := oCombustivel.Descricao;
    edtValor.Text := FormatFloat('#0.00', oCombustivel.Valor);
    cboImposto.ItemIndex := cboImposto.IdOf(cboImposto, oCombustivel.Imposto, '-');

  finally
    FreeAndNil(oCombustivelController);
    FreeAndNil(oCombustivel);
  end;

end;

procedure TfCombustiveis.CarregarLista(cbLista: TComboBox);
var
  oCombustivelController: TCombustivelController;
begin

  oCombustivelController := TCombustivelController.Create;
  try
    oCombustivelController.ListarImpostos;

    cbLista.Items.Clear;
    while not dmCombustivel.qryImpostos.Eof do
    begin
      cbLista.Items.Add(dmCombustivel.qryImpostos.FieldByName('Id').AsString + '-' +
        dmCombustivel.qryImpostos.FieldByName('Descricao').AsString);
      dmCombustivel.qryImpostos.Next;
    end;

  finally
    FreeAndNil(oCombustivelController);
  end;

end;

procedure TfCombustiveis.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  edtValor.KeyPress(Key, edtValor.Text, edtValor.SelStart, 5, 2);
end;

procedure TfCombustiveis.Excluir;
var
  oCombustivelController: TCombustivelController;
  sErro: string;
begin

  oCombustivelController := TCombustivelController.Create;
  try
    if (dmCombustivel.cdsCombustivel.Active) and
      (dmCombustivel.cdsCombustivel.RecordCount > 0) then
    begin
      if MessageDlg('Confirma a exclus�o?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oCombustivelController.Excluir
          (dmCombustivel.cdsCombustivelId.AsInteger, sErro) = False then
          raise Exception.Create(sErro);
        Pesquisar;
      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oCombustivelController);
  end;
end;

procedure TfCombustiveis.FormCreate(Sender: TObject);
begin
  inherited;
  dmCombustivel := TdmCombustivel.Create(nil);
end;

procedure TfCombustiveis.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmCombustivel);
  inherited;
end;

procedure TfCombustiveis.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
  CarregarLista(cboImposto);
end;

procedure TfCombustiveis.HabilitarEdits(aAcao: TAcao);
begin
  case aAcao of
    acInsere, acAltera:
      begin
        edtDescricao.ReadOnly := False;
        edtValor.ReadOnly := False;
        cboImposto.Enabled := True;
      end;
    acLista:
      begin
        edtDescricao.ReadOnly := True;
        edtValor.ReadOnly := True;
        cboImposto.Enabled := False;
      end;
  end;
end;

procedure TfCombustiveis.Inserir;
var
  oCombustivel: TCombustivel;
  oCombustivelController: TCombustivelController;
  sErro: string;
begin

  oCombustivel := TCombustivel.Create;
  oCombustivelController := TCombustivelController.Create;

  try
    oCombustivel.Descricao := edtDescricao.Text;
    oCombustivel.Valor := StrToFloat(edtValor.Text);
    oCombustivel.Imposto := cboImposto.Id(cboImposto.Text, '-');

    if not oCombustivelController.Inserir(oCombustivel, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oCombustivelController);
    FreeAndNil(oCombustivel);
  end;

end;

procedure TfCombustiveis.Limpar;
begin
  case FAcao of
    acInsere:
      begin
        edtId.Clear;
        edtDescricao.Clear;
        edtValor.Clear;
        edtDescricao.SetFocus;
      end;
  end;
end;

procedure TfCombustiveis.Pesquisar;
var
  oCombustivelController: TCombustivelController;
begin

  oCombustivelController := TCombustivelController.Create;
  try
    oCombustivelController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oCombustivelController);
  end;

end;

procedure TfCombustiveis.Salvar;
var
  oCombustivelController: TCombustivelController;
begin

  oCombustivelController := TCombustivelController.Create;

  try
    case FAcao of
      acInsere:
        Inserir;
      acAltera:
        Alterar;
    end;
    oCombustivelController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oCombustivelController);
  end;

end;

end.
