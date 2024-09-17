class ApiErrorResponse {
  String status;
  String message;
  Errors errors;

  ApiErrorResponse({
    required this.status,
    required this.message,
    required this.errors,
  });
}

class Errors {
  String? password;
  String? email;

  Errors({
    this.password,
    this.email,
  });
}
