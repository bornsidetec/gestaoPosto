object dmAbastecimento: TdmAbastecimento
  OldCreateOrder = False
  Height = 167
  Width = 342
  object qryBomba: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Bombas'
      'ORDER BY Id')
    Left = 224
    Top = 16
  end
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'DELETE FROM Abastecimentos'
      'WHERE Id = :Id')
    Left = 160
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO Abastecimentos'
      '(Id, Bomba, Data,'
      'Quantidade, Valor, ValorTotal, '
      'Aliquota, ValorImposto, TotalPagar)'
      'VALUES (:Id, :Bomba, :Data,'
      ':Quantidade, :Valor, :ValorTotal, '
      ':Aliquota, :ValorImposto, :TotalPagar)')
    Left = 96
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BOMBA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORTOTAL'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ALIQUOTA'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORIMPOSTO'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TOTALPAGAR'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object cdsAbastecimento: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'TODOS'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATA'
        ParamType = ptInput
      end>
    ProviderName = 'dspAbastecimento'
    Left = 32
    Top = 112
    object cdsAbastecimentoId: TIntegerField
      FieldName = 'Id'
      Required = True
    end
    object cdsAbastecimentoBomba: TStringField
      FieldName = 'Bomba'
      ReadOnly = True
      Size = 50
    end
    object cdsAbastecimentoData: TDateTimeField
      FieldName = 'Data'
    end
    object cdsAbastecimentoQuantidade: TFloatField
      FieldName = 'Quantidade'
      Required = True
    end
    object cdsAbastecimentoValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#0.00'
    end
    object cdsAbastecimentoValorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'ValorTotal'
      DisplayFormat = '#0.00'
    end
    object cdsAbastecimentoAliquota: TFloatField
      DisplayLabel = 'Al'#237'quota'
      FieldName = 'Aliquota'
      DisplayFormat = '#0.00'
    end
    object cdsAbastecimentoValorImposto: TFloatField
      DisplayLabel = 'Valor do Imposto'
      FieldName = 'ValorImposto'
      DisplayFormat = '#0.00'
    end
    object cdsAbastecimentoTotalPagar: TFloatField
      DisplayLabel = 'Total a Pagar'
      FieldName = 'TotalPagar'
      DisplayFormat = '#0.00'
    end
  end
  object dspAbastecimento: TDataSetProvider
    DataSet = qryAbastecimento
    Left = 32
    Top = 64
  end
  object qryAbastecimento: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'select '
      '   Abastecimentos.Id, '
      '   Bombas.Descricao as Bomba, '
      '   Data, '
      '   Quantidade, Valor, ValorTotal, '
      '   Aliquota, ValorImposto,'
      '   TotalPagar'
      'from Abastecimentos'
      '   inner join Bombas on Bombas.Id = Abastecimentos.Bomba'
      'where :todos = 1 or Data > :data'
      'order by data desc'
      '')
    Left = 32
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'TODOS'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'DATA'
        DataType = ftDateTime
        ParamType = ptInput
      end>
  end
  object qryDados: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'select '
      '   Bombas.Id, Bombas.Descricao as Bomba,'
      '   Combustiveis.Descricao as Combustivel,'
      '   Combustiveis.Valor,'
      '   Impostos.Aliquota'
      'from Bombas'
      '   inner join Tanques on Tanques.Id = Bombas.Tanque'
      
        '   inner join Combustiveis on Combustiveis.Id = Tanques.Combusti' +
        'vel'
      '   inner join Impostos on Impostos.Id = Combustiveis.Imposto'
      'where Bombas.Id = :BombaId')
    Left = 288
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'BOMBAID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object dspDados: TDataSetProvider
    DataSet = qryDados
    Left = 288
    Top = 64
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'BOMBAID'
        ParamType = ptInput
      end>
    ProviderName = 'dspDados'
    Left = 288
    Top = 112
    object cdsDadosId: TIntegerField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsDadosBomba: TStringField
      FieldName = 'Bomba'
      Origin = 'Descricao'
      Size = 50
    end
    object cdsDadosCombustivel: TStringField
      FieldName = 'Combustivel'
      Origin = 'Descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object cdsDadosValor: TFloatField
      FieldName = 'Valor'
      Origin = 'Valor'
      ProviderFlags = []
      ReadOnly = True
    end
    object cdsDadosAliquota: TFloatField
      FieldName = 'Aliquota'
      Origin = 'Aliquota'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#0.00'
    end
  end
end
