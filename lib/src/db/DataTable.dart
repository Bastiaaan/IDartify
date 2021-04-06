import 'dart:mirrors';
import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'package:cli/src/Reflector.dart';
import 'package:cli/src/db/DataContext.dart';
import 'package:cli/src/Serializator.dart';

class DataTable<T extends MotherModel> {
  T _model;
  T get model => _model;
  set model(T input) => _model = input;

  Map<String, Map<String, dynamic>> _sqlQueryWithParams;
  Map<String, Map<String, dynamic>> get sqlQueriesWithParams => _sqlQueryWithParams;
  set sqlQueriesWithParams(Map<String, Map<String, dynamic>> input) => _sqlQueryWithParams = input;

  List<T> _listOfTees;

  DataTable([T model]) {        
    var sqlString = 'SELECT * FROM ${T.toString()}';
    var json = Map<String, dynamic>();
    var incrementor = 0;
    
    for(var record in dataContext.exec(sqlString).rows) {
      var tableName = '${T.toString()}${incrementor}';
      json[tableName] = Map<String, dynamic>();
      
      Reflector.mapPropertyNamesByIndex(T).forEach((element) {
        var publicProperty = Symbol(element);
        var reflected = reflect(record).getField(publicProperty);
        if(reflected != null) {   
            
          json[tableName].addAll({element: reflected.reflectee});       
        }
      });
      incrementor++;
    }  

    _listOfTees = json.isNotEmpty 
      ? serializator.fromJSON<T>(json) 
      : null;
  }
  
  Iterable<bool> createRange(Iterable<T> rows) sync* {
    for(var row in rows) {      
      yield create(row);
    }
  }

  bool create(T row) {
    serializator.toJSON(row);  
    var sqlFields = 'INSERT INTO ${T.toString()}('; // INSERT INTO [Table](prop1, prop2, prop3) 
    var sqlValues = ') VALUES ('; // VALUES ('val1', 'val2', 'val3')
    var properties = Reflector.mapPropertyNamesByIndex(T); 
    var loopIndex = 0;
    serializator.getJsonValues().forEach((name, value) {
      if(name != 'id' && name != 'editedOn') {
        loopIndex != properties.length - 1 ? sqlFields+=name+', ' : sqlFields+=name;
        switch(value.runtimeType) {
          case String:
            value = "'"+value+"'"; // escape value to a SQL-string
          break; 
          case DateTime:
            value = "CAST(\'"+value.toString()+"\' AS DATETIME2)"; // escape to SQL-string
            break;
          case int:
            value = value as int;
          break;
        }
        var reflectedProperty = reflect(value);
        if(reflectedProperty.type.superclass == reflectClass(MotherModel)) {
          value = (value.id) as int;
        }      
        loopIndex != properties.length - 1 ? sqlValues+=value.toString()+', ' : sqlValues+=value.toString()+')';      
      }
      loopIndex++;
    });
    var fullQuery = sqlFields + sqlValues;
    dataContext.enqueueQuery(fullQuery);
    serializator.clearJsonObj();
    return false;
  }

  bool update(int id, T row) {
    try {
      serializator.toJSON(row);
      var updateString = 'UPDATE ${T.toString()} SET ';
      var jsonResult = serializator.getJsonValues();
      var index = 0;
      
      jsonResult.forEach((name, value) {     
        if(name != 'id' && name != 'addedOn') {        
          switch(value.runtimeType) {
            case String:
              value = "\'"+value+"\'"; // escape value to a SQL-string
            break;
            case DateTime:
              value = "CAST(\'"+value.toString()+"\' AS DATETIME2)"; // escape to a SQL-string             
              break;
            case int:
              value = value as int;
              break;
            case double:
              value = value as double;
              break;
          }   
          
          var reflectedProperty = reflect(value);
          if(reflectedProperty.type.superclass == reflectClass(MotherModel)) {
            value = (value.id) as int;
          }
          index == jsonResult.length - 1 ? updateString+='[${name}] = ${value}' : updateString+='[${name}] = ${value}, ';
        }
        index++;
      });
      updateString+=' WHERE id = ${id}';
      dataContext.enqueueQuery(updateString);
      serializator.clearJsonObj();
      return true; 
    } on Error catch(ex) {
      throw ('Something went wrong ${ex}');
    }
  }

  bool delete(int id) {
    var deleteString = 'DELETE FROM ${T.toString()} WHERE [id] = ${id}';
    dataContext.enqueueQuery(deleteString);
    return false; // temporarily
  }

  Map<String, String> reflectedProperties() {
    return Reflector.mapPropertiesByName(T);
  }

  T get first => _listOfTees[0] ?? Exception('List contains no sequences');

  T get last => _listOfTees[_listOfTees.length - 1] ?? Exception('List contains no sequences');
  
  T elementAt(int index) {
    try {      
      return _listOfTees.elementAt(index);
    } on Error {
      throw Error();
    }
  }

  int get length => _listOfTees.length;
  
  Iterable<T> skip(int count) sync* {
    try {
      for(var i = 0; i < _listOfTees.length; i++) {
        if(i > count) {
          yield _listOfTees[count];
        }
      }
    } on IndexError catch(ex) {
      ex;
    }
  }

  bool any(bool Function(T element) expression) {
    for(var element in _listOfTees) {
      if(expression(element)) return true;
    }
    return false;
  }
  
  Iterable<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }
  
  bool contains(Object element) {
    // TODO: implement contains
    throw UnimplementedError();
  }
  
  bool every(bool Function(T element) expression) {
    var amountOfTrues = 0;
    for(var sequence in _listOfTees) {
      if(expression(sequence) != false) amountOfTrues++;
    }

    return amountOfTrues == length ? true : false;
  }

  Iterable<T> orderBy(dynamic Function(T element) expression, [bool descending = false]) {    
    var previousObj;
    _listOfTees.forEach((element) { 
      var currentObj = expression(element);
      if(previousObj != null) {
        print(currentObj[0] > previousObj[0]);
      }

      previousObj = currentObj;
    });
  }

  T firstWhere(bool Function(T element) test, {T Function() orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }
  
  Iterable<T> followedBy(Iterable<T> other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }
  
  void forEach(void Function(T element) f) {
    
  }
  
  // TODO: implement isEmpty
  bool get isEmpty => length < 1;

  // TODO: implement isNotEmpty
  bool get isNotEmpty => length > 0;

  // TODO: implement iterator
  Iterator<T> get iterator => throw UnimplementedError();

  T lastWhere(bool Function(T element) test, {T Function() orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }
  
  T reduce(T Function(T value, T element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  T get single => throw UnimplementedError();

  T singleWhere(bool Function(T element) test, {T Function() orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  Iterable<T> skipWhile(bool Function(T value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  Iterable<T> take(int count) sync* {
    if(count <= length) {
      for(var i = 0; i < count; i++) {
        yield _listOfTees[i];
      }
    }
  }

  Iterable<T> takeWhile(bool Function(T value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  List<T> toList({bool growable = true}) {
    return _listOfTees.toList();
  }

  Set<T> toSet() {
    var _set = Set();
    _listOfTees.forEach((element) {
      _set.add(element);
    });
    return _set;
  }

  Iterable<T> where(bool Function(T element) test) sync* {
    for(var sequence in _listOfTees) {
      if(test(sequence)) {
        yield sequence;
      }
    }
  }

  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }
  
  Iterable<T> expand<T>(Iterable<T> Function(T element) f) sync* {
    // TODO: implement expand
    throw UnimplementedError();
  }

  T fold<T>(T initialValue, T Function(T previousValue, T element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  } 

  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  Iterable<T> map<T>(T Function(T e) f) => throw UnimplementedError(); 

  //noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}