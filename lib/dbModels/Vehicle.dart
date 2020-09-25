import 'package:cli/propertyAnnotations/stringLength.dart';
import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'mechanicant.dart';
import 'modelFormers/MotherModel.dart';
//import 'enums.dart';

@Table('Vehicle')
class Vehicle extends MotherModel {

  @StringLength(10, 40, "The input isn't matching the requirements")
  @DataColumn('name', String)
  String name;
  //String get name => _name;
  //set name(String input) => input ?? name;

  @DataColumn('vehicleType', int, true)
  int vehicleType;
  //int get vehicleType => _vehicleType;
  //set vehicleType(int input) => input ?? vehicleType;

  @DataColumn('amountOfWheels', int, true)
  int amountOfWheels;
  //int get amountOfWheels => _amountOfWheels;
  //set amountOfWheels(int input) => amountOfWheels ?? input;

  @DataColumn('vendorId', int, true)
  int vendorId;
  //int get vendorId => _vendorId;
  //set vendorId(int input) => input ?? vendorId;

  @DataColumn('amountOfSales', int, true)
  int amountOfSales;
  //int get amountOfSales => _amountOfSales;
  //set amountOfSales(int input) => input ?? amountOfSales;

  List<Mechanicant> maintenancedBy;
}

//get => _;
//set ( input) => input ?? ;