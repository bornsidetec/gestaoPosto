object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o de Postos de Combust'#237'veis'
  ClientHeight = 510
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 491
    Width = 833
    Height = 19
    Panels = <
      item
        Text = 'Banco de Dados:'
        Width = 100
      end
      item
        Width = 200
      end>
    ExplicitTop = 455
  end
  object MainMenu: TMainMenu
    Left = 392
    Top = 8
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Bombas1: TMenuItem
        Action = actBombas
      end
      object Combustveis1: TMenuItem
        Action = actCombustiveis
      end
      object Impostos1: TMenuItem
        Action = actImpostos
      end
      object anques1: TMenuItem
        Action = actTanques
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Abastecimentos1: TMenuItem
        Action = actAbastecimentos
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object Abastecimentos2: TMenuItem
        Action = actRelAbastecimentos
      end
    end
    object Ajuda1: TMenuItem
      Caption = 'Ajuda'
      object Sobre1: TMenuItem
        Action = actSobre
      end
    end
  end
  object ActionList: TActionList
    Left = 464
    Top = 8
    object actImpostos: TAction
      Caption = '&Impostos'
      OnExecute = actImpostosExecute
    end
    object actCombustiveis: TAction
      Caption = '&Combustiveis'
      OnExecute = actCombustiveisExecute
    end
    object actTanques: TAction
      Caption = '&Tanques'
      OnExecute = actTanquesExecute
    end
    object actBombas: TAction
      Caption = '&Bombas'
      OnExecute = actBombasExecute
    end
    object actAbastecimentos: TAction
      Caption = '&Abastecimentos'
      OnExecute = actAbastecimentosExecute
    end
    object actRelAbastecimentos: TAction
      Caption = '&Abastecimentos'
      OnExecute = actRelAbastecimentosExecute
    end
    object actSobre: TAction
      Caption = '&Sobre'
      OnExecute = actSobreExecute
    end
  end
end
