
class DataColumn {
  const DataColumn(this.columnName, this.dataType, [this.notNull = true]);

  final String columnName;

  final Type dataType;

  final bool notNull;
}