class UpdateModel {
  String? name;
  String? email;
  String? role;
  Map<String, dynamic>? permissions;
  Map<String, dynamic>? address;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    final entries = [
      MapEntry('name', name?.toLowerCase()),
      MapEntry('email', email?.toLowerCase()),
      MapEntry('role', role),
      MapEntry('permissions', permissions),
      MapEntry('address', address),
    ];

    for (var entry in entries) {
      if (entry.value != null) {
        result[entry.key] = entry.value;
      }
    }

    return result;
  }
}
