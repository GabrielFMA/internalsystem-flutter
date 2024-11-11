class RegisterModel {
  int? id;
  String? name;
  String? email;
  String? cpf;
  String? phone;
  String? role;
  String? password;
  Map<String, dynamic>? permissions;
  Map<String, dynamic>? address;
  Map<String, dynamic>? secondaryData;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    final entries = [
      MapEntry('id', id),
      MapEntry('name', name?.toLowerCase()),
      MapEntry('email', email?.toLowerCase()),
      MapEntry('cpf', cpf),
      MapEntry('phone', phone),
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