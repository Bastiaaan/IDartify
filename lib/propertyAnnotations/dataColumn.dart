
class DataColumn {
  const DataColumn(this.columnName, this.dataType, [this.isNullable = true]);

  final String columnName;

  final Type dataType;

  final bool isNullable;
}