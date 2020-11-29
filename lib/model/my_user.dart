

class MyUser {
  String _fullName, _email, _avatarUrl, _phone;
  bool _isEcollector;

  MyUser.complete(
      this._fullName,
      this._email,
      this._phone,
      this._avatarUrl,
      this._isEcollector) {

  }

  MyUser.partial(
    this._fullName, 
    this._email){

  }

  // getUserToken() async {
  //   if (this.tokenFuture != null) {
  //     this.token = await this.tokenFuture;
  //   }
  // }

  // factory MyUser.fromJson(Map<String, dynamic> map) {
  //   return MyUser(map['id'] ?? 1,
  //     firstName: map['firstName'] ?? "beto",
  //     lastName: map['lastName'] ?? "sicardi",
  //     email: map['email'] ?? "beto@gmail.com",
  //     type: map['type'] ?? "regular",
  //     token: map['token'] ?? 0,
  //   );
  // }

  toJSON() {
    return {'userType': "ecollector", 'lastName': "TERMEKH"};
  }
}
