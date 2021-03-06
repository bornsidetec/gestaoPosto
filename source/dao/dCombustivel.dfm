object dmCombustivel: TdmCombustivel
  OldCreateOrder = False
  Height = 165
  Width = 349
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'DELETE FROM COMBUSTIVEIS'
      'WHERE Id = :Id')
    Left = 224
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryAlterar: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'UPDATE COMBUSTIVEIS'
      'SET Descricao = :Descricao, Valor = :Valor, Imposto = :Imposto'
      'WHERE Id = :Id')
    Left = 160
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
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
        Name = 'IMPOSTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO COMBUSTIVEIS'
      '(ID, DESCRICAO, VALOR, IMPOSTO)'
      'VALUES (:Id, :Descricao, :Valor, :Imposto)')
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
        Name = 'DESCRICAO'
        DataType = ftString
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
        Name = 'IMPOSTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryImpostos: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Impostos'
      'ORDER BY Id')
    Left = 288
    Top = 16
  end
  object qryCombustivel: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT Combustiveis.Id, Combustiveis.Descricao,'
      '   Combustiveis.Valor, '
      '   Impostos.Aliquota Imposto'
      'FROM Combustiveis'
      '   INNER JOIN Impostos ON Impostos.Id = Combustiveis.Imposto'
      'WHERE Combustiveis.Descricao like :descricao')
    Left = 32
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object dspCombustivel: TDataSetProvider
    DataSet = qryCombustivel
    Left = 32
    Top = 64
  end
  object cdsCombustivel: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'DESCRICAO'
        ParamType = ptInput
      end>
    ProviderName = 'dspCombustivel'
    Left = 32
    Top = 112
    object cdsCombustivelId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Required = True
    end
    object cdsCombustivelDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 50
    end
    object cdsCombustivelValor: TFloatField
      FieldName = 'Valor'
    end
    object cdsCombustivelImposto: TFloatField
      DisplayLabel = 'Imposto %'
      FieldName = 'Imposto'
      ReadOnly = True
      DisplayFormat = '#0.00'
    end
  end
end
