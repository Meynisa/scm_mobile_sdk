class LoginModel {
  final String email;
  final String password;

  LoginModel(this.email, this.password);

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}

class AccountModel {
  final String name;
  final String level;
  final String email;
  final String avatar;

  AccountModel(this.name, this.level, this.email, this.avatar);

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name, 'level': level, 'avatar': avatar};
  }
}
