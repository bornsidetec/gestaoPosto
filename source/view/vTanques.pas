unit vTanques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, vCadastro, Data.DB, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, dTanque, cTanque,
  mTanque, hComboBox;

type
  TfTanques = class(TfCadastro)
    Label2: TLabel;
    Label4: TLabel;
    edtDescricao: TEdit;
    cboCombustivel: TComboBox;
    procedure actPesquisarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDetalharExecute(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
    procedure Excluir;
    procedure Salvar;
    procedure Inserir;
    procedure Alterar;
    procedure Carregar;
    procedure Limpar;
    procedure HabilitarEdits(aAcao: TAcao);

    procedure CarregarLista(cbLista: TComboBox);
  public
    { Public declarations }
  end;

var
  fTanques: TfTanques;

implementation

{$R *.dfm}

procedure TfTanques.actAlterarExecute(Sender: TObject);
begin
  inherited;
  HabilitarEdits(acAltera);
end;

procedure TfTanques.actCancelarExecute(Sender: TObject);
begin
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfTanques.actDetalharExecute(Sender: TObject);
begin
  Carregar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfTanques.actExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfTanques.actInserirExecute(Sender: TObject);
begin
  inherited;
  Limpar;
  HabilitarEdits(acInsere);
end;

procedure TfTanques.actPesquisarExecute(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfTanques.actSalvarExecute(Sender: TObject);
begin
  Salvar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfTanques.Inserir;
var
  oTanque: TTanque;
  oTanqueController: TTanqueController;
  sErro: string;
begin

  oTanque := TTanque.Create;
  oTanqueController := TTanqueController.Create;

  try
    oTanque.Descricao := edtDescricao.Text;
    oTanque.Combustivel := cboCombustivel.Id(cboCombustivel.Text, '-');

    if not oTanqueController.Inserir(oTanque, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oTanqueController);
    FreeAndNil(oTanque);
  end;

end;

procedure TfTanques.Limpar;
begin

  case FAcao of
    acInsere:
      begin
        edtId.Clear;
        edtDescricao.Clear;
        cboCombustivel.ItemIndex := -1;
        edtDescricao.SetFocus;
      end;
  end;

end;

procedure TfTanques.Excluir;
var
  oTanqueController: TTanqueController;
  sErro: string;
begin

  oTanqueController := TTanqueController.Create;
  try
    if (dmTanque.cdsTanque.Active) and (dmTanque.cdsTanque.RecordCount > 0) then
    begin
      if MessageDlg('Confirma a exclus�o?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oTanqueController.Excluir(dmTanque.cdsTanqueId.AsInteger, sErro) = False
        then
          raise Exception.Create(sErro);
        Pesquisar;
      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oTanqueController);
  end;

end;

procedure TfTanques.FormCreate(Sender: TObject);
begin
  inherited;
  dmTanque := TdmTanque.Create(nil);
end;

procedure TfTanques.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmTanque);
  inherited;
end;

procedure TfTanques.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
  CarregarLista(cboCombustivel);
end;

procedure TfTanques.HabilitarEdits(aAcao: TAcao);
begin

  case aAcao of
    acInsere, acAltera:
      begin
        edtDescricao.ReadOnly := False;
        cboCombustivel.Enabled := True;
      end;
    acLista:
      begin
        edtDescricao.ReadOnly := True;
        cboCombustivel.Enabled := False;
      end;
  end;

end;

procedure TfTanques.Alterar;
var
  oTanque: TTanque;
  oTanqueController: TTanqueController;
  sErro: string;
begin

  oTanque := TTanque.Create;
  oTanqueController := TTanqueController.Create;

  try

    oTanque.Id := StrToInt(edtId.Text);
    oTanque.Descricao := edtDescricao.Text;
    oTanque.Combustivel := cboCombustivel.Id(cboCombustivel.Text, '-');

    if not oTanqueController.Alterar(oTanque, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oTanqueController);
    FreeAndNil(oTanque);
  end;

end;

procedure TfTanques.Carregar;
var
  oTanque: TTanque;
  oTanqueController: TTanqueController;
begin

  oTanque := TTanque.Create;
  oTanqueController := TTanqueController.Create;
  try
    oTanqueController.CarregarTanque(oTanque,
      dsPesquisa.DataSet.FieldByName('Id').AsInteger);
    edtId.Text := IntToStr(oTanque.Id);
    edtDescricao.Text := oTanque.Descricao;
    cboCombustivel.ItemIndex := cboCombustivel.IdOf(cboCombustivel,
      oTanque.Combustivel, '-');
  finally
    FreeAndNil(oTanqueController);
    FreeAndNil(oTanque);
  end;

end;

procedure TfTanques.CarregarLista(cbLista: TComboBox);
var
  oTanqueController: TTanqueController;
begin

  oTanqueController := TTanqueController.Create;
  try
    oTanqueController.ListarCombustiveis;

    cbLista.Items.Clear;
    while not dmTanque.qryCombustivel.Eof do
    begin
      cbLista.Items.Add(dmTanque.qryCombustivel.FieldByName('Id').AsString + '-'
        + dmTanque.qryCombustivel.FieldByName('Descricao').AsString);
      dmTanque.qryCombustivel.Next;
    end;

  finally
    FreeAndNil(oTanqueController);
  end;

end;

procedure TfTanques.Pesquisar;
var
  oTanqueController: TTanqueController;
begin

  oTanqueController := TTanqueController.Create;
  try
    oTanqueController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oTanqueController);
  end;

end;

procedure TfTanques.Salvar;
var
  oTanqueController: TTanqueController;
begin

  oTanqueController := TTanqueController.Create;

  try
    case FAcao of
      acInsere:
        Inserir;
      acAltera:
        Alterar;
    end;
    oTanqueController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oTanqueController);
  end;

end;

end.
