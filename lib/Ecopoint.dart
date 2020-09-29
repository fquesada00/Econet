class Ecopoint{
  String userEmail;
  double latitude,longitude;

  Ecopoint({this.userEmail,this.latitude,this.longitude});

  factory Ecopoint.fromJson(Map<String, dynamic> json) {
    return Ecopoint(
      userEmail: json['userEmail'],
      latitude: json['position']['geopoint']['_latitude'] as double,
      longitude: json['position']['geopoint']['_longitude'] as double,
    );
  }

  @override
  String toString() {
    return 'Ecopoint{userEmail: $userEmail, latitude: $latitude, longitude: $longitude}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ecopoint &&
          runtimeType == other.runtimeType &&
          userEmail == other.userEmail &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      userEmail.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}