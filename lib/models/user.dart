class User {
  String username;
  String email;
  String password;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this.username = map['username'];
    this.email = map['email'];
    this.password = map['password'];
  }
}
