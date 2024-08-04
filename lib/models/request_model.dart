class TemplateRequestModel {
  final String name = 'none';
  final String email = 'none';
  final String role = 'client';
  final bool isAdmin = false;
}

class RequestModel {
  final String? name;
  final String? email;
  final String? role;
  final bool? isAdmin;

  RequestModel({
    this.name,
    this.email,
    this.role,
    this.isAdmin,
  });

  factory RequestModel.fromMap(Map<String, dynamic> data) {
    return RequestModel(
      name: data.containsKey('name') ? data['name'] as String? : TemplateRequestModel().name,
      email: data.containsKey('email') ? data['email'] as String? : TemplateRequestModel().email,
      role: data.containsKey('role') ? data['role'] as String? : TemplateRequestModel().role,
      isAdmin: data.containsKey('isAdmin') ? data['isAdmin'] as bool? : TemplateRequestModel().isAdmin,
    );
  }
}
