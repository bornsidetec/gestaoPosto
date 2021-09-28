object dmImposto: TdmImposto
  OldCreateOrder = False
  Height = 166
  Width = 285
  object qryImposto: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'SELECT * FROM Impostos'
      'WHERE Descricao like :descricao')
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
  object dspImposto: TDataSetProvider
    DataSet = qryImposto
    Left = 32
    Top = 64
  end
  object cdsImposto: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'DESCRICAO'
        ParamType = ptInput
      end>
    ProviderName = 'dspImposto'
    Left = 32
    Top = 112
    object cdsImpostoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Required = True
    end
    object cdsImpostoDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Required = True
      Size = 50
    end
    object cdsImpostoAliquota: TFloatField
      DisplayLabel = 'Al'#237'quota %'
      FieldName = 'Aliquota'
      Required = True
      DisplayFormat = '0.00'
    end
  end
  object qryInserir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'INSERT INTO IMPOSTOS'
      '(ID, DESCRICAO, ALIQUOTA)'
      'VALUES (:Id, :Descricao, :Aliquota)')
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
        Name = 'ALIQUOTA'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryAlterar: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'UPDATE IMPOSTOS'
      'SET Descricao = :Descricao, Aliquota = :Aliquota'
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
        Name = 'ALIQUOTA'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryExcluir: TFDQuery
    Connection = dmConexao.Conexao
    SQL.Strings = (
      'DELETE FROM IMPOSTOS'
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
end
