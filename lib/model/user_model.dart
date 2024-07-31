class UserModel {
  String? id;
  String? name;
  String? email;
  String? username;
  String? password;
  String? phone;
  String? token;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.password,
      this.phone,
      this.token});

  // String toString() {
  //   return 'UserModel( name: $name, email: $email,username: $username, password: $password, phone: $phone,)';
  // }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    username = json['username'].toString();
    password = json['password'].toString();
    token = json['token'].toString();
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}
