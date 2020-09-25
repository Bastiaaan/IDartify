import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'modelFormers/MotherModel.dart';
import 'Vehicle.dart';

@Table('Vendor')
class Vendor extends MotherModel {  

  @DataColumn('name', String)
  String name;

  @DataColumn('address', String, true)
  String address;
  
  List<Vehicle> vehicles;  
}