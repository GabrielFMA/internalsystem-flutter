class TemplateRequestModel {
  final String name = 'none';
  final String email = 'none';
  final String role = 'client';
  final bool isAdmin = false;
  final Map<String, dynamic>? permissions = {};
  final Map<String, dynamic>? address = {};
}

class RequestModel {
  String? name;
  String? email;
  String? role;
  bool? isAdmin;
  Map<String, dynamic>? permissions;
  Map<String, dynamic>? address;
  List<Map<String, dynamic>> sales = [];

  RequestModel({
    this.name,
    this.email,
    this.role,
    this.isAdmin,
    this.permissions,
    this.address,
  });

  factory RequestModel.fromMap(Map<String, dynamic> data) {
    return RequestModel(
      name: data.containsKey('name') ? data['name'] as String? : TemplateRequestModel().name,
      email: data.containsKey('email') ? data['email'] as String? : TemplateRequestModel().email,
      role: data.containsKey('role') ? data['role'] as String? : TemplateRequestModel().role,
      isAdmin: data.containsKey('isAdmin') ? data['isAdmin'] as bool? : TemplateRequestModel().isAdmin,
      permissions: data.containsKey('permissions') ? data['permissions'] : TemplateRequestModel().permissions,
      address: data.containsKey('address') ? data['address'] : TemplateRequestModel().address,
    );
  }
}
