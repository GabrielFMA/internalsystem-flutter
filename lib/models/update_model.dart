class UpdateModel {
  String? name;
  String? email;
  String? role;
  bool? isAdmin;
  Map<String, dynamic>? permissions;
  Map<String, dynamic>? address;

  UpdateModel({
    this.name,
    this.email,
    this.role,
    this.isAdmin,
    this.permissions,
    this.address,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    final entries = [
      MapEntry('name', name?.toLowerCase()),
      MapEntry('email', email?.toLowerCase()),
      MapEntry('role', role),
      MapEntry('isAdmin', isAdmin),
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
