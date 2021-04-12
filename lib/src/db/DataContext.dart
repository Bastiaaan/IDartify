//import 'dart:io';

import 'dart:collection';
import 'package:dart_mssql/dart_mssql.dart';

class DataContext {  

  final String _host = 'DESKTOP-ROV0CNI';
  final String _database = 'IDartify';
  final String _user = 'localGuide001';
  final String _pw = 'zkcn4xttbvHaywX6';

  Queue<String> _queryQueue;

  SqlConnection _sqlConnection;
  void _initConnection() => _sqlConnection = SqlConnection(host: _host, db: _database, user: _user, password: _pw);
  
  DataContext() {
    _queryQueue = Queue<String>();
    _initConnection(); // connecting to Database.
    var execQuery = '''
    DECLARE @dbname nvarchar(128)
    SET @dbname = '${_database}'

    IF(
	    NOT EXISTS(
		    SELECT name FROM master.dbo.sysdatabases WHERE (
		    '[' + name + ']' = @dbname OR name = @dbname)
	    )
    )    
    CREATE DATABASE ${_database}
    ''';
    _sqlConnection.execute(execQuery);    
  }

  void enqueueQuery(String query) {
    _queryQueue.add(query);
  }

  int saveChanges() {
    var successfulExecutions = 0;
    _queryQueue.forEach((query) {
      try {
        var execResult = _sqlConnection.execute(query);
        successfulExecutions+=execResult.rowsAffected;
        print('Query: '+query+'\nSuccessfully executed.');
      } on Error {
        throw('Something went wrong: ');
      }
    });
    if(successfulExecutions == _queryQueue.length) {
       _queryQueue.clear(); 
    }
    return successfulExecutions;
  }

  void execRange(List<String> queries) {
    queries.forEach((element) {
      _sqlConnection.execute(element);
    });
  }

  SqlResult exec(String query) {
    return _sqlConnection.execute(query);
  }
}

final dataContext = DataContext();