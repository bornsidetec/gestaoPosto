unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls;

type
  TfMain = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Bombas1: TMenuItem;
    Combustveis1: TMenuItem;
    Impostos1: TMenuItem;
    anques1: TMenuItem;
    Movimentao1: TMenuItem;
    Abastecimentos1: TMenuItem;
    Relatrios1: TMenuItem;
    Abastecimentos2: TMenuItem;
    ActionList: TActionList;
    actImpostos: TAction;
    actCombustiveis: TAction;
    actTanques: TAction;
    actBombas: TAction;
    actAbastecimentos: TAction;
    actRelAbastecimentos: TAction;
    StatusBar: TStatusBar;
    actSobre: TAction;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    procedure actImpostosExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCombustiveisExecute(Sender: TObject);
    procedure actTanquesExecute(Sender: TObject);
    procedure actBombasExecute(Sender: TObject);
    procedure actAbastecimentosExecute(Sender: TObject);
    procedure actRelAbastecimentosExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSobreExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirForm(T: TFormClass; F: TForm);
    procedure CaminhoBD;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses vImpostos, vCombustiveis, vTanques, vBombas, vAbastecimentos,
  vRelAbastecimentos, vSobre;

procedure TfMain.AbrirForm(T: TFormClass; F: TForm);
begin
  if not Assigned(F) then
    Application.CreateForm(T, F);
  F.Show;
end;

procedure TfMain.actAbastecimentosExecute(Sender: TObject);
begin
  AbrirForm(TFAbastecimentos, FAbastecimentos);
end;

procedure TfMain.actBombasExecute(Sender: TObject);
begin
  AbrirForm(TFBombas, FBombas)
end;

procedure TfMain.actCombustiveisExecute(Sender: TObject);
begin
  AbrirForm(TFCombustiveis, FCombustiveis)
end;

procedure TfMain.actImpostosExecute(Sender: TObject);
begin
  AbrirForm(TFImpostos, FImpostos)
end;

procedure TfMain.actRelAbastecimentosExecute(Sender: TObject);
begin
  AbrirForm(TfRelAbastecimentos, fRelAbastecimentos);
end;

procedure TfMain.actSobreExecute(Sender: TObject);
begin
  AbrirForm(TfSobre, fSobre);
end;

procedure TfMain.actTanquesExecute(Sender: TObject);
begin
  AbrirForm(TFTanques, FTanques)
end;

procedure TfMain.CaminhoBD;
var
  slAcesso: TStringList;
begin
  slAcesso := TStringList.Create;
  try
    slAcesso.LoadFromFile('acesso.config');
    StatusBar.Panels[1].Text := slAcesso[0];
  finally
    FreeAndNil(slAcesso);
  end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].close;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  CaminhoBD;
end;

end.
