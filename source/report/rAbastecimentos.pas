unit rAbastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, dReports, Data.DB;

type
  TfReportAbastecimentos = class(TForm)
    RLAbastecimentos: TRLReport;
    dsDados: TDataSource;
    bandHeaderReport: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    rlblFiltros: TRLLabel;
    bandGroup: TRLGroup;
    bandHeaderGroup: TRLBand;
    RLDBText1: TRLDBText;
    bandDetailGroup: TRLBand;
    RLDBText2: TRLDBText;
    bandSummaryReport: TRLBand;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBResult2: TRLDBResult;
    RLLabel2: TRLLabel;
    bandSummaryGroup: TRLBand;
    RLDBResult1: TRLDBResult;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    bandColummHeaderGroup: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel5: TRLLabel;
    bandFooterReport: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel9: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel10: TRLLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RLDBText2BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    dDataIni, dDataFim: TDateTime;
    procedure Imprimir;
    procedure CarregarDados;
  end;

var
  fReportAbastecimentos: TfReportAbastecimentos;

implementation

{$R *.dfm}

procedure TfReportAbastecimentos.CarregarDados;
begin
  if dmReports.qryAbastecimentos.Active then
    dmReports.qryAbastecimentos.Close;

  dmReports.qryAbastecimentos.Params[0].AsDateTime := dDataIni;
  dmReports.qryAbastecimentos.Params[1].AsDateTime := dDataFim;
  dmReports.qryAbastecimentos.Open;

  if dmReports.qryAbastecimentos.IsEmpty then
    raise Exception.Create('Dados n�o encontrados');


end;

procedure TfReportAbastecimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(dmReports);
  Action := caFree;
  Self := nil;
end;

procedure TfReportAbastecimentos.FormCreate(Sender: TObject);
begin
  dmReports := TdmReports.Create(nil);
end;

procedure TfReportAbastecimentos.Imprimir;
begin
  CarregarDados;
  RLAbastecimentos.Preview;
end;

procedure TfReportAbastecimentos.RLDBText2BeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  AText := AText + ' (' + dsDados.DataSet.FieldByName('Combustivel').AsString + ') ';
end;

end.
