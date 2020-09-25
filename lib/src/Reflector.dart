import 'dart:mirrors';
import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'package:reflectable/reflectable.dart';

import 'Serializator.dart';

class Reflector extends Reflectable {

  const Reflector() : super(
    newInstanceCapability, 
    reflectedTypeCapability, 
    instanceInvokeCapability,
    invokingCapability,
    delegateCapability,
    typeCapability,
    typingCapability,    
  );

  static Map<String, dynamic> mapPropertiesByName(Type type) {
    var reflct = reflect(type).reflectee;

    var baseClassProperties = reflct.superclass.declarations.values.where((m) => m.isPrivate); 
    var currentClassProperties = reflct.declarations.values.where((d) => d.isPrivate);
    var returnObj = Map<String, dynamic>(); // property name, property Type? 

    baseClassProperties.forEach((property) {
      var propName  = MirrorSystem.getName(Symbol(property.simpleName.toString()));
      returnObj[propName.substring(1)] = property;
    });

    currentClassProperties.forEach((property) {
      var propName  = MirrorSystem.getName(Symbol(property.simpleName.toString()));
      //VariableMirror tm = reflct.declarations[#property];
      print(reflct);
      returnObj[propName.substring(1)] = property;
    });
    return returnObj;
  }

  static Iterable<Map<String, Type>> mapPropertyTypes<T extends MotherModel>() sync* {
    try {
      var baseClass = reflectClass(T).superclass;
      // displays the names correct.
      var originalClass = reflectClass(T);
      var returnObj = List<Map<String, Type>>();

      baseClass.declarations.keys.where((element) => element != null).forEach((key) { // Iterating through the baseclass

        if(baseClass.declarations[key].metadata != null) {
          baseClass.declarations[key].metadata.where((element) => element.reflectee is DataColumn).forEach((element) {
            returnObj.add({element.reflectee.columnName: element.reflectee.dataType});
          });
        }
      });

      originalClass.declarations.keys.where((element) => element != null).forEach((key) { // Iterating through the subclass

        if(originalClass.declarations[key].metadata != null) {
          originalClass.declarations[key].metadata.where((element) => element.reflectee is DataColumn).forEach((element) {
            returnObj.add({element.reflectee.columnName: element.reflectee.dataType});
          });
        }
      });

      for(var _prop in returnObj) {
        yield _prop;
      }
      
    } on ArgumentError catch (ex) {
      throw(ex);
    }
  }

  static List<String> mapPropertyNamesByIndex(Type type) {  

    var reflct = reflectClass(type);
    var returnObj = List<String>(); 

    reflct.superclass.declarations.forEach((key, value) {
      if(value.metadata.any((element) => element.reflectee is DataColumn)) {
        returnObj.add(MirrorSystem.getName(value.simpleName));
      }
    }); 

    reflct.declarations.forEach((key, value) {    
      if(value.metadata.any((element) => element.reflectee is DataColumn)) {
        returnObj.add(MirrorSystem.getName(value.simpleName)); 
      }
    });
    
    return returnObj;
  }

  static Map<int, dynamic> mapPropertyValuesByIndex(dynamic _class) {
    var reflected = reflect(_class);    
    
    var testSymbol = Symbol('id');
    var property = reflected.getField(testSymbol);
    print(property.reflectee);
    var returnObj = Map<int, dynamic>();
    return returnObj;
  }

  static dynamic getInstance(dynamic type, [Map<Symbol, dynamic> namedArguments, List<dynamic> paramValues]) {
    try {
      var result = reflectClass(type);
      var symbol = const Symbol('');
      var positionalArguments = const [];
      return result.newInstance(symbol ?? Symbol(''), positionalArguments ?? []).reflectee;
    } on ArgumentError {
      throw ArgumentError('Type "$type" is inconvenient');
    } 
  }
}

Type typeof<T>([T input]) => input ?? T;
