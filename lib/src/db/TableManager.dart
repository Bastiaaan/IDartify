import 'dart:io';
import 'dart:mirrors';
import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'package:cli/src/Reflector.dart';
import 'package:cli/src/Serializator.dart';
import 'package:cli/src/context.dart';
import 'package:cli/src/db/DataContext.dart';

class TableManager<T extends MotherModel> {
  T _model;
  T get model => _model; 
  set model(T input) => _model = input;

  TableManager([T model]) {
    model == null ? model : T;
  }
  
  Future<bool> initializeTable() async {
    var initialized = false;
    serializator.toJSON(model);
    var sqlString = '''IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.Tables WHERE TABLE_NAME = '${T.toString()}') 
    BEGIN
    CREATE TABLE ${T.toString()}(\n''';
    var classProperties = Reflector.mapPropertyTypes<T>();
    
    for(var columnPair in classProperties) { 
      columnPair.forEach((key, value) {
      if(columnPair.keys.contains('id')) {
        sqlString += '  [${columnPair.keys.first}] INT PRIMARY KEY IDENTITY(1, 1) NOT NULL';
      }      
      else {
        sqlString += '  [${columnPair.keys.first}] ';
        switch(typeof(value)) {
          case String: 
            sqlString += 'NVARCHAR(MAX)';
            break;
          case int:
          case InstanceMirror: 
            sqlString += 'INT';
            break;
          case bool:
            sqlString += 'BIT DEFAULT 0';
            break;
          case DateTime:
            sqlString += 'DATETIME';
            break; 
          case Null:
            sqlString += 'INT NULL';
            break;         
        }

        sqlString += 'NOT NULL';
      }
      sqlString+=','; 
      }); 
    } 
    sqlString += ') END';
    context.enqueueQuery(sqlString);
    return await true; 
  } 

  Future<bool> alterTable() async {
    // TODO: iterating the modelproperties and the db-tables their columns.
    // By noticing any differences in type of existing columns, amount of columns or 
  }

  Future<bool> tableExists() async {
    var success = false;
    var sqlString = '''
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.Tables WHERE TABLE_NAME = '${T.toString()}') 
      BEGIN 
        SELECT * FROM ${T.toString()}
      END''';
    dataContext.enqueueQuery(sqlString);
    //if(result != null) {
      success = true;
    //}
    return success;
  }
}