class MyUser {
  String _fullName, _email, _avatarUrl, _phone;
  bool _isEcollector;

  MyUser.complete(this._fullName, this._email, this._phone, this._avatarUrl,
      this._isEcollector);

  MyUser.partial(this._fullName, this._email);

  MyUser.fromJson(Map<String, dynamic> map) {
    this._fullName = map['fullName'];
    this._email = map['id'] ?? map['email'] ?? null;
    this._isEcollector =
        map['userType'].toString().toLowerCase() == 'ecollector';
    this._avatarUrl = map['avatarUrl'];
    this._phone = map['phone'];
  }

  toJson() {
    return {
      'isEcollector': _isEcollector,
      'fullName': _fullName,
      'avatarUrl': _avatarUrl,
      'email': _email,
      'phone': _phone
    };
  }

  setIsEcollector(bool isEcollector) {
    this._isEcollector = isEcollector;
  }

  String get fullName => _fullName;

  String get email => _email;

  bool get isEcollector => _isEcollector;

  String get phone => _phone;

  String get avatarUrl => _avatarUrl;
}
