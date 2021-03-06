program GestaoPostoApp;

uses
  Vcl.Forms,
  vMain in 'view\vMain.pas' {fMain},
  mImposto in 'model\mImposto.pas',
  cImposto in 'controller\cImposto.pas',
  dConexao in 'dao\dConexao.pas' {dmConexao: TDataModule},
  dImposto in 'dao\dImposto.pas' {dmImposto: TDataModule},
  vCadastro in 'view\vCadastro.pas' {fCadastro},
  vImpostos in 'view\vImpostos.pas' {fImpostos},
  hEdit in 'helper\hEdit.pas',
  mCombustivel in 'model\mCombustivel.pas',
  dCombustivel in 'dao\dCombustivel.pas' {dmCombustivel: TDataModule},
  cCombustivel in 'controller\cCombustivel.pas',
  vCombustiveis in 'view\vCombustiveis.pas' {fCombustiveis},
  mTanque in 'model\mTanque.pas',
  dTanque in 'dao\dTanque.pas' {dmTanque: TDataModule},
  cTanque in 'controller\cTanque.pas',
  vTanques in 'view\vTanques.pas' {fTanques},
  hComboBox in 'helper\hComboBox.pas',
  mBomba in 'model\mBomba.pas',
  dBomba in 'dao\dBomba.pas' {dmBomba: TDataModule},
  vBombas in 'view\vBombas.pas' {fBombas},
  cBomba in 'controller\cBomba.pas',
  uCalculos in 'unit\uCalculos.pas',
  vAbastecimentos in 'view\vAbastecimentos.pas' {fAbastecimentos},
  dAbastecimento in 'dao\dAbastecimento.pas' {dmAbastecimento: TDataModule},
  mAbastecimento in 'model\mAbastecimento.pas',
  cAbastecimento in 'controller\cAbastecimento.pas',
  vRelatorio in 'view\vRelatorio.pas' {fRelatorio},
  vRelAbastecimentos in 'view\vRelAbastecimentos.pas' {fRelAbastecimentos},
  dReports in 'dao\dReports.pas' {dmReports: TDataModule},
  rAbastecimentos in 'report\rAbastecimentos.pas' {fReportAbastecimentos},
  uValidacoes in 'unit\uValidacoes.pas',
  vSobre in 'view\vSobre.pas' {fSobre};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TdmConexao, dmConexao);
  if dmConexao.Conexao.Connected then
    Application.Run
  else
    Application.Terminate;

end.
