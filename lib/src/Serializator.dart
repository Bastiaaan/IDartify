
//import 'dart:io';
import 'dart:mirrors';
//import 'package:reflectable/reflectable.dart';
import 'package:cli/dbModels/Vehicle.dart';
import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'Reflector.dart';
import 'db/DataTable.dart';

class Serializator {
  static Map<String, dynamic> _jsonObj;
  static Map<String, dynamic> get jsonObj  => _jsonObj;
  static set jsonObj(Map<String, dynamic> input) { _jsonObj = input; }

  Serializator();

  void toJSON(dynamic _class) {
    if(_jsonObj == null) {
      jsonObj = Map<String, dynamic>();
    }    
    var foundProperties = Reflector.mapPropertyNamesByIndex(_class.runtimeType);  
    var reflected = reflect(_class);
    for(var i = 0; i < foundProperties.length; i++) {
      var current = foundProperties[i];
      jsonObj[current] = reflected.getField(Symbol(current)).reflectee;
    }    
  }

  dynamic fromJSON<T extends MotherModel>(Map<String, dynamic> json) {
    var tees = List<T>();

    for(var row in json.entries) {
      var reflected = reflect(Reflector.getInstance(T));
      // returns an instance of the T-parameter who has the capabilities of setting hard-defined properties
      var usee = reflected.reflectee;
      Reflector.mapPropertyNamesByIndex(T).forEach((element) {
        dynamic actualValue = row.value[element];
        var symbol = Symbol(element);
        if(actualValue is String) {
          DateTime.tryParse(actualValue) is DateTime
            ? reflected.setField(symbol, DateTime.parse(actualValue))
            : reflected.setField(symbol, actualValue);
        } else {
          reflected.setField(symbol, actualValue);
        }
      });
      tees.add(usee);
    }
    
    return tees;
  }

  Map<String, dynamic> getJsonValues() {
    return jsonObj;
  }

  void clearJsonObj() {
    jsonObj.clear();
  }
}

final Serializator serializator = Serializator();