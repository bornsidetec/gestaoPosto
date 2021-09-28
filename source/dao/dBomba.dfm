object dmBomba: TdmBomba
  OldCreateOrder = False
  Height = 165
  Width = 349
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'DELETE FROM Bombas'
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
      'UPDATE Bombas'
      'SET Descricao = :Descricao, Tanque = :Tanque'
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
        Name = 'TANQUE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO Bombas'
      '(ID, DESCRICAO, Tanque)'
      'VALUES (:Id, :Descricao, :Tanque)')
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
        Name = 'TANQUE'
        ParamType = ptInput
      end>
  end
  object qryTanques: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Tanques'
      'ORDER BY Id')
    Left = 288
    Top = 16
  end
  object qryBomba: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT Bombas.Id, Bombas.Descricao, '
      '   Tanques.Descricao Tanque '
      'FROM Bombas'
      '   inner join Tanques on Tanques.Id = Bombas.Tanque'
      'WHERE Bombas.Descricao like :descricao')
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
  object dspBomba: TDataSetProvider
    DataSet = qryBomba
    Left = 32
    Top = 64
  end
  object cdsBomba: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'DESCRICAO'
        ParamType = ptInput
      end>
    ProviderName = 'dspBomba'
    Left = 32
    Top = 112
    object cdsBombaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Required = True
    end
    object cdsBombaDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 50
    end
    object cdsBombaTanque: TStringField
      FieldName = 'Tanque'
      ReadOnly = True
      Size = 50
    end
  end
end
