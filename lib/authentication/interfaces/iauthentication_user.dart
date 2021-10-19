abstract class IAuthUserInterface {
  final String email;

  IAuthUserInterface(this.email);

  @override
  String toString() {
    return "User(email: $email)";
  }
}
