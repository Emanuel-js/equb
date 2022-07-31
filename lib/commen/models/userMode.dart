import 'dart:convert';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phoneNumber;
  String? alternatePhoneNumber;
  double? latitude;
  double? longitude;
  String? city;
  DateTime? yearBorn;
  String? gender;
  String? initialBalance;
  String? idCardImageUrl;
  String? avatarImageUrl;
  String? residentLocation;
  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.phoneNumber,
      this.latitude,
      this.longitude,
      this.city,
      this.yearBorn,
      this.gender,
      this.alternatePhoneNumber,
      this.initialBalance,
      this.idCardImageUrl,
      this.residentLocation,
      this.avatarImageUrl});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (yearBorn != null) {
      result.addAll({'yearBorn': yearBorn!.millisecondsSinceEpoch});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }

    return result;
  }

  Map<String, dynamic> toMapUser() {
    final result = <String, dynamic>{};

    if (firstName != null) {
      result.addAll({'firstName': firstName});
    }
    if (lastName != null) {
      result.addAll({'lastName': lastName});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (yearBorn != null) {
      result.addAll({'yearBorn': yearBorn!.millisecondsSinceEpoch});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (initialBalance != null) {
      result.addAll({'initialBalance': initialBalance});
    }

    return result;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];

    firstName = map['firstName'];
    lastName = map['lastName'];

    email = map['email'];
    phoneNumber = map['phoneNumber'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    city = map['city'];
    // yearBorn = DateTime.parse(map['yearBorn']);
    gender = map['gender'];
    idCardImageUrl = map['idCardImageUrl'];
    avatarImageUrl = map['avatarImageUrl'];
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
