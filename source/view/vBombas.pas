unit vBombas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, vCadastro, Data.DB, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, cBomba, dBomba, mBomba,
  hComboBox;

type
  TfBombas = class(TfCadastro)
    Label2: TLabel;
    Label4: TLabel;
    edtDescricao: TEdit;
    cboTanque: TComboBox;
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
  fBombas: TfBombas;

implementation

{$R *.dfm}

procedure TfBombas.actAlterarExecute(Sender: TObject);
begin
  inherited;
  HabilitarEdits(acAltera);
end;

procedure TfBombas.actCancelarExecute(Sender: TObject);
begin
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfBombas.actDetalharExecute(Sender: TObject);
begin
  Carregar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfBombas.actExcluirExecute(Sender: TObject);
begin
  Excluir;
end;

procedure TfBombas.actInserirExecute(Sender: TObject);
begin
  inherited;
  Limpar;
  HabilitarEdits(acInsere);
end;

procedure TfBombas.actPesquisarExecute(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfBombas.actSalvarExecute(Sender: TObject);
begin
  Salvar;
  HabilitarEdits(acLista);
  inherited;
end;

procedure TfBombas.Alterar;
var
  oBomba: TBomba;
  oBombaController: TBombaController;
  sErro: string;
begin

  oBomba := TBomba.Create;
  oBombaController := TBombaController.Create;

  try

    oBomba.Id := StrToInt(edtId.Text);
    oBomba.Descricao := edtDescricao.Text;
    oBomba.Tanque := cboTanque.Id(cboTanque.Text, '-');

    if not oBombaController.Alterar(oBomba, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oBombaController);
    FreeAndNil(oBomba);
  end;

end;

procedure TfBombas.Carregar;
var
  oBomba: TBomba;
  oBombaController: TBombaController;
begin

  oBomba := TBomba.Create;
  oBombaController := TBombaController.Create;
  try
    oBombaController.CarregarBomba(oBomba, dsPesquisa.DataSet.FieldByName('Id')
      .AsInteger);
    edtId.Text := IntToStr(oBomba.Id);
    edtDescricao.Text := oBomba.Descricao;
    cboTanque.ItemIndex := cboTanque.IdOf(cboTanque, oBomba.Tanque, '-');
  finally
    FreeAndNil(oBombaController);
    FreeAndNil(oBomba);
  end;

end;

procedure TfBombas.CarregarLista(cbLista: TComboBox);
var
  oBombaController: TBombaController;
begin

  oBombaController := TBombaController.Create;
  try
    oBombaController.ListarTanques;

    cbLista.Items.Clear;
    while not dmBomba.qryTanques.Eof do
    begin
      cbLista.Items.Add(dmBomba.qryTanques.FieldByName('Id').AsString + '-' +
        dmBomba.qryTanques.FieldByName('Descricao').AsString);
      dmBomba.qryTanques.Next;
    end;

  finally
    FreeAndNil(oBombaController);
  end;

end;

procedure TfBombas.Excluir;
var
  oBombaController: TBombaController;
  sErro: string;
begin

  oBombaController := TBombaController.Create;
  try
    if (dmBomba.cdsBomba.Active) and (dmBomba.cdsBomba.RecordCount > 0) then
    begin
      if MessageDlg('Confirma a exclus�o?', mtConfirmation, [mbYes, mbNo], 0) = IDYES
      then
      begin
        if oBombaController.Excluir(dmBomba.cdsBombaId.AsInteger, sErro) = False
        then
          raise Exception.Create(sErro);
        Pesquisar;
      end;
    end
    else
      raise Exception.Create('Nenhum registro selecionado');

  finally
    FreeAndNil(oBombaController);
  end;

end;

procedure TfBombas.FormCreate(Sender: TObject);
begin
  inherited;
  dmBomba := TdmBomba.Create(nil);
end;

procedure TfBombas.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dmBomba);
  inherited;
end;

procedure TfBombas.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
  CarregarLista(cboTanque);
end;

procedure TfBombas.HabilitarEdits(aAcao: TAcao);
begin

  case aAcao of
    acInsere, acAltera:
      begin
        edtDescricao.ReadOnly := False;
        cboTanque.Enabled := True;
      end;
    acLista:
      begin
        edtDescricao.ReadOnly := True;
        cboTanque.Enabled := False;
      end;
  end;

end;

procedure TfBombas.Inserir;
var
  oBomba: TBomba;
  oBombaController: TBombaController;
  sErro: string;
begin

  oBomba := TBomba.Create;
  oBombaController := TBombaController.Create;

  try
    oBomba.Descricao := edtDescricao.Text;
    oBomba.Tanque := cboTanque.Id(cboTanque.Text, '-');

    if not oBombaController.Inserir(oBomba, sErro) then
      raise Exception.Create(sErro);

  finally
    FreeAndNil(oBombaController);
    FreeAndNil(oBomba);
  end;

end;

procedure TfBombas.Limpar;
begin

  case FAcao of
    acInsere:
      begin
        edtId.Clear;
        edtDescricao.Clear;
        cboTanque.ItemIndex := -1;
        edtDescricao.SetFocus;
      end;
  end;

end;

procedure TfBombas.Pesquisar;
var
  oBombaController: TBombaController;
begin

  oBombaController := TBombaController.Create;
  try
    oBombaController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oBombaController);
  end;

end;

procedure TfBombas.Salvar;
var
  oBombaController: TBombaController;
begin

  oBombaController := TBombaController.Create;

  try
    case FAcao of
      acInsere:
        Inserir;
      acAltera:
        Alterar;
    end;
    oBombaController.Pesquisar(edtPesquisar.Text);
  finally
    FreeAndNil(oBombaController);
  end;

end;

end.
