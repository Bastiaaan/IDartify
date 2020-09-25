
import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'Vehicle.dart';
import 'modelFormers/MotherModel.dart';

@Table('Mechanicant')
class Mechanicant extends MotherModel {  

  @DataColumn('name', String)
  String name;

  List<Vehicle> repairedVehicles;

  
}