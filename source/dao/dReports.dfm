object dmReports: TdmReports
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryAbastecimentos: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT '
      '   strftime('#39'%d/%m/%Y'#39', Abastecimentos.Data) Data, '
      '   Combustiveis.Descricao Combustivel,'
      '   Tanques.Id TanqueId, Tanques.Descricao Tanque,'
      '   Bombas.Id BombaId, Bombas.Descricao Bomba,'
      '   Abastecimentos.TotalPagar, Abastecimentos.ValorImposto'
      'FROM Abastecimentos'
      '   INNER JOIN Bombas ON Bombas.Id = Abastecimentos.Bomba'
      '   INNER JOIN Tanques ON Tanques.Id = Bombas.Tanque'
      
        '   INNER JOIN Combustiveis ON Combustiveis.Id = Tanques.Combusti' +
        'vel'
      'WHERE '
      '   Abastecimentos.Data BETWEEN :ini and :fim'
      'ORDER BY '
      '   strftime('#39'%Y-%m-%d'#39', Abastecimentos.Data),'
      '   Tanques.Id, '
      '   Bombas.Id')
    Left = 40
    Top = 16
    ParamData = <
      item
        Name = 'INI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FIM'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object qryAbastecimentosData: TWideStringField
      FieldName = 'Data'
      Origin = 'Data'
      Size = 32767
    end
    object qryAbastecimentosCombustivel: TStringField
      FieldName = 'Combustivel'
      Origin = 'Combustivel'
      Required = True
      Size = 50
    end
    object qryAbastecimentosTanqueId: TIntegerField
      FieldName = 'TanqueId'
      Origin = 'TanqueId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryAbastecimentosTanque: TStringField
      FieldName = 'Tanque'
      Origin = 'Tanque'
      Size = 50
    end
    object qryAbastecimentosBombaId: TIntegerField
      FieldName = 'BombaId'
      Origin = 'BombaId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryAbastecimentosBomba: TStringField
      FieldName = 'Bomba'
      Origin = 'Bomba'
      Size = 50
    end
    object qryAbastecimentosTotalPagar: TFloatField
      FieldName = 'TotalPagar'
      Origin = 'TotalPagar'
    end
    object qryAbastecimentosValorImposto: TFloatField
      FieldName = 'ValorImposto'
      Origin = 'ValorImposto'
    end
  end
end
