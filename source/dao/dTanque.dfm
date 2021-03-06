object dmTanque: TdmTanque
  OldCreateOrder = False
  Height = 166
  Width = 351
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO Tanques'
      '(ID, DESCRICAO, Combustivel)'
      'VALUES (:Id, :Descricao, :Combustivel)')
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
        Name = 'COMBUSTIVEL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryAlterar: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'UPDATE Tanques'
      'SET Descricao = :Descricao, Combustivel = :Combustivel'
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
        Name = 'COMBUSTIVEL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'DELETE FROM Tanques'
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
  object qryCombustivel: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Combustiveis'
      'ORDER BY Id')
    Left = 288
    Top = 16
  end
  object qryTanque: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT Tanques.Id, Tanques.Descricao,'
      '   Combustiveis.Descricao Combustivel'
      'FROM Tanques'
      
        '   INNER JOIN Combustiveis ON Combustiveis.Id = Tanques.Combusti' +
        'vel'
      'WHERE Tanques.Descricao like :descricao')
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
  object dspTanque: TDataSetProvider
    DataSet = qryTanque
    Left = 32
    Top = 64
  end
  object cdsTanque: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'DESCRICAO'
        ParamType = ptInput
      end>
    ProviderName = 'dspTanque'
    Left = 32
    Top = 112
    object cdsTanqueId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Required = True
    end
    object cdsTanqueDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 50
    end
    object cdsTanqueCombustivel: TStringField
      FieldName = 'Combustivel'
      ReadOnly = True
      Size = 50
    end
  end
end
