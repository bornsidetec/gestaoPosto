inherited fBombas: TfBombas
  Caption = 'Cadastro de Bombas'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotom: TPanel
    ExplicitTop = 316
    ExplicitWidth = 645
    inherited btnFechar: TBitBtn
      ExplicitLeft = 558
    end
  end
  inherited pnlClient: TPanel
    ExplicitWidth = 645
    ExplicitHeight = 316
    inherited PageControl: TPageControl
      ExplicitWidth = 645
      ExplicitHeight = 316
      inherited tsDetalhes: TTabSheet
        object Label2: TLabel [1]
          Left = 16
          Top = 64
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object Label4: TLabel [2]
          Left = 442
          Top = 64
          Width = 36
          Height = 13
          Caption = 'Tanque'
        end
        inherited pnlActionsDetail: TPanel
          ExplicitTop = 243
          ExplicitWidth = 637
          inherited btnAlterar: TBitBtn
            ExplicitLeft = 392
          end
          inherited btnSalvar: TBitBtn
            ExplicitLeft = 473
          end
          inherited btnCancelar: TBitBtn
            ExplicitLeft = 554
          end
          inherited btnVoltar: TBitBtn
            ExplicitLeft = 311
          end
        end
        object edtDescricao: TEdit
          Left = 16
          Top = 83
          Width = 409
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          MaxLength = 50
          TabOrder = 2
        end
        object cboTanque: TComboBox
          Left = 440
          Top = 83
          Width = 161
          Height = 21
          Style = csDropDownList
          TabOrder = 3
        end
      end
    end
  end
  inherited ActionList: TActionList
    inherited actPesquisar: TAction
      OnExecute = actPesquisarExecute
    end
    inherited actExcluir: TAction
      OnExecute = actExcluirExecute
    end
  end
  inherited dsPesquisa: TDataSource
    DataSet = dmBomba.cdsBomba
  end
end
