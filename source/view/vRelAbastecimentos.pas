unit vRelAbastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, vRelatorio, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, uValidacoes;

type
  TfRelAbastecimentos = class(TfRelatorio)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    medtDataIni: TMaskEdit;
    Label2: TLabel;
    medtDataFim: TMaskEdit;
    procedure actVisualizarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Imprimir;
    procedure Validar;
  public
    { Public declarations }
    dData1, dData2: TDateTime;
  end;

var
  fRelAbastecimentos: TfRelAbastecimentos;

implementation

uses
  rAbastecimentos;

{$R *.dfm}

procedure TfRelAbastecimentos.actVisualizarExecute(Sender: TObject);
begin
  Validar;
  Imprimir;
end;

procedure TfRelAbastecimentos.Imprimir;
begin
  if not Assigned(fReportAbastecimentos) then
    Application.CreateForm(TfReportAbastecimentos, fReportAbastecimentos);
  try
    fReportAbastecimentos.rlblFiltros.Caption := 'Período: ' + medtDataIni.Text
      + ' até ' + medtDataFim.Text;
    fReportAbastecimentos.dDataIni := dData1;
    fReportAbastecimentos.dDataFim := dData2;

    fReportAbastecimentos.Imprimir;
  finally
    // FreeAndNil(fReportAbastecimentos);
  end;
end;

procedure TfRelAbastecimentos.Validar;
var
  sErro: string;
begin

  if not TValidacoes.ValidaDatas(medtDataIni.Text, medtDataFim.Text, sErro,
    dData1, dData2) then
    raise Exception.Create(sErro);

end;

end.
