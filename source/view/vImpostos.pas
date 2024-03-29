unit vImpostos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, vCadastro, Data.DB, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  cImposto, mImposto, dImposto, hEdit;

type
  TfImpostos = class(TfCadastro)
    Label2: TLabel;
    edtDescricao: TEdit;
    edtAliquota: TEdit;
    Label3: TLabel;
    procedure actPesquisarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDetalharExecute(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtAliquotaKeyPress(Sender: TObject; var Key: Char);
    procedure actAlterarExecute(Sender: TObject);
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
  public
    { Public declarations }
  end;

var
  fImpostos: TfImpostos;

implementation

{$R *.dfm}

{ TfImpostos }

procedure TfImpostos.actAlterarExecute(Sender: TObject);
begin
  inherited;
  HabilitarEdits(acAltera);
end;

procedure TfImpostos.actCancelarExecute(Sender: TObject);
begin
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfImpostos.actDetalharExecute(Sender: TObject);
begin
  Carregar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfImpostos.actExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfImpostos.actInserirExecute(Sender: TObject);
begin
  inherited;
  Limpar;
  HabilitarEdits(acInsere);
end;

procedure TfImpostos.actPesquisarExecute(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfImpostos.actSalvarExecute(Sender: TObject);
begin
  Salvar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfImpostos.Alterar;
var
  oImposto: TImposto;
  oImpostoController: TImpostoController;
  sErro: string;
begin

  oImposto := TImposto.Create;
  oImpostoController := TImpostoController.Create;

  try

    oImposto.Id := StrToInt(edtId.Text);
    oImposto.Descricao := edtDescricao.Text;
    oImposto.Aliquota := StrToFloat(edtAliquota.Text);

    if not oImpostoController.Alterar(oImposto, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oImpostoController);
    FreeAndNil(oImposto);
  end;

end;

procedure TfImpostos.Carregar;
var
  oImposto: TImposto;
  oImpostoController: TImpostoController;
begin

  oImposto := TImposto.Create;
  oImpostoController := TImpostoController.Create;
  try
    oImpostoController.CarregarImposto(oImposto,
      dsPesquisa.DataSet.FieldByName('Id').AsInteger);
    edtId.Text := IntToStr(oImposto.Id);
    edtDescricao.Text := oImposto.Descricao;
    edtAliquota.Text := FormatFloat('#0.00', oImposto.Aliquota);
  finally
    FreeAndNil(oImpostoController);
    FreeAndNil(oImposto);
  end;

end;

procedure TfImpostos.edtAliquotaKeyPress(Sender: TObject; var Key: Char);
begin
  edtAliquota.KeyPress(Key, edtAliquota.Text, edtAliquota.SelStart, 2, 2);
end;

procedure TfImpostos.Excluir;
var
  oImpostoController: TImpostoController;
  sErro: string;
begin

  oImpostoController := TImpostoController.Create;
  try
    if (dmImposto.cdsImposto.Active) and (dmImposto.cdsImposto.RecordCount > 0)
    then
    begin
      if MessageDlg('Confirma a exclus�o?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oImpostoController.Excluir(dmImposto.cdsImpostoId.AsInteger, sErro) = False
        then
          raise Exception.Create(sErro);
        Pesquisar;
      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oImpostoController);
  end;

end;

procedure TfImpostos.FormCreate(Sender: TObject);
begin
  inherited;
  dmImposto := TdmImposto.Create(nil);
end;

procedure TfImpostos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmImposto);
  inherited;
end;

procedure TfImpostos.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfImpostos.HabilitarEdits(aAcao: TAcao);
begin
  case aAcao of
    acInsere, acAltera:
      begin
        edtDescricao.ReadOnly := False;
        edtAliquota.ReadOnly := False;
      end;
    acLista:
      begin
        edtDescricao.ReadOnly := True;
        edtAliquota.ReadOnly := True;
      end;
  end;
end;

procedure TfImpostos.Inserir;
var
  oImposto: TImposto;
  oImpostoController: TImpostoController;
  sErro: string;
begin

  oImposto := TImposto.Create;
  oImpostoController := TImpostoController.Create;

  try
    oImposto.Descricao := edtDescricao.Text;
    oImposto.Aliquota := StrToFloat(edtAliquota.Text);

    if not oImpostoController.Inserir(oImposto, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oImpostoController);
    FreeAndNil(oImposto);
  end;

end;

procedure TfImpostos.Limpar;
begin
  case FAcao of
    acInsere:
      begin
        edtId.Clear;
        edtDescricao.Clear;
        edtAliquota.Clear;
        edtDescricao.SetFocus;
      end;
  end;
end;

procedure TfImpostos.Pesquisar;
var
  oImpostoController: TImpostoController;
begin
  oImpostoController := TImpostoController.Create;
  try
    oImpostoController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oImpostoController);
  end;
end;

procedure TfImpostos.Salvar;
var
  oImpostoController: TImpostoController;
begin
  oImpostoController := TImpostoController.Create;

  try
    case FAcao of
      acInsere:
        Inserir;
      acAltera:
        Alterar;
    end;
    oImpostoController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oImpostoController);
  end;
end;

end.
