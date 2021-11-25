abstract class IAuthUserInterface {
  final String email;
  final int? id;

  IAuthUserInterface({required this.email, this.id});

  @override
  String toString() {
    return "User(email: $email)";
  }
}
