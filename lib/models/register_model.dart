class RegisterModel {
  String? name;
  String? email;
  String? cpf;
  String? phone;
  String? role;
  String? password;
  Map<String, dynamic>? address;
  Map<String, dynamic>? secondaryData;

  RegisterModel({
    this.name,
    this.email,
    this.cpf,
    this.phone,
    this.role,
    this.password,
    this.address,
    this.secondaryData,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    final entries = [
      MapEntry('name', name?.toLowerCase()),
      MapEntry('email', email?.toLowerCase()),
      MapEntry('cpf', cpf),
      MapEntry('phone', phone),
      MapEntry('role', role),
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
