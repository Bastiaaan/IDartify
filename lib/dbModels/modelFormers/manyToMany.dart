
import 'dart:io';

import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'package:cli/propertyAnnotations/dataColumn.dart';

import '../Vehicle.dart';
import '../mechanicant.dart';

abstract class ManyToManyDataModel
<T1 extends MotherModel, T2 extends MotherModel> {

  List<T1> mechanicants;
  List<T2> vehicles;
}

// example below;


class MechanicantVehicle implements ManyToManyDataModel
<Mechanicant, Vehicle> {

  @DataColumn('id', int)
  int id;

  @DataColumn('mechanicantId', int)
  int mechanicantId;
  @DataColumn('vehicleId', int)
  int vehicleId;

  @override
  List<Mechanicant> mechanicants;
  @override
  List<Vehicle> vehicles;
}

