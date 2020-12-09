class User {
  String _fullName;
  String _email;
  String _avatarUrl;
  String _phone;
  bool _isEcollector;

  User(this._fullName, this._email, this._avatarUrl, this._phone,
      this._isEcollector);

  String get fullName => _fullName;

  String get email => _email;

  bool get isEcollector => _isEcollector;

  String get phone => _phone;

  String get avatarUrl => _avatarUrl;
}
