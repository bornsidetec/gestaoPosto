inherited fTanques: TfTanques
  Caption = 'Cadastro de Tanques'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    inherited PageControl: TPageControl
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
          Width = 58
          Height = 13
          Caption = 'Combust'#237'vel'
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
        object cboCombustivel: TComboBox
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
    DataSet = dmTanque.cdsTanque
  end
end
