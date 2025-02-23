/// A field in an abi */
class Field {
  /// Field name */
  String name;

  /// Type name in string form */
  String typeName;

  /// Type of the field */
  Type? type;

  Field({required this.name, required this.type, required this.typeName});

  @override
  String toString() {
    return "{name: $name, typeName: $typeName}";
  }
}

class Type {
  String name;

  String aliasOfName;

  Type? arrayOf;

  Type? optionalOf;

  Type? extensionOf;

  String baseName;

  Type? base;

  List<Field> fields;

  Function? serialize;

//  void Function(Type self,SerialBuffer buffer, Object data, {SerializerState state,bool allowExtensions}) serialize;

  Function? deserialize;

  Type({
    required this.name,
    required this.aliasOfName,
    required this.arrayOf,
    required this.optionalOf,
    required this.extensionOf,
    required this.baseName,
    required this.base,
    required this.fields,
    required this.serialize,
    required this.deserialize,
  });
}

class Contract {
  Map<String, Type> actions;

  Map<String, Type> types;

  Contract(this.types, this.actions);
}

/// Structural representation of a symbol */
class Symbol {
  /// Name of the symbol, not including precision */
  final String name;

  /// Number of digits after the decimal point */
  final int precision;

  Symbol({required this.name, required this.precision});
}
