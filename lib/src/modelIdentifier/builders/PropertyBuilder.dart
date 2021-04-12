

class PropertyBuilder {

  PropertyBuilder() {

  }

  Future<void> column<TData>(String propertyName) async {

  }

  Future<bool> removeColumn(String propertyName) async {
    return false;
  }

  Future<bool> alterColumn(String currentColumnName, String newColumnName, Type columnType) async {
    return false;
  }
}