class UserData {
  static final UserData _singleton = UserData._internal();

  String? id;
  String? name;
  String? email;
  String? pfp;

  UserData._internal();

  factory UserData() {
    return _singleton;
  }

  void setUser(String id, String name, String email,String pfp) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.pfp=pfp;
  }

  void deleteUser() {
    id = null;
    name = null;
    email = null;
    pfp=null;
  }

}
