import 'package:equb/commen/models/roleModel.dart';

class UserAccountModel {
  int? id;
  String? username;
  String? email;
  String? lockTime;
  int? failedAttempt;
  bool? accountNonLocked;
  String? createdBy;
  RoleModel? role;
  UserAccountModel(
      {this.username,
      this.email,
      this.lockTime,
      this.failedAttempt,
      this.accountNonLocked,
      this.createdBy,
      this.id,
      this.role});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (username != null) {
      result.addAll({'username': username});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (lockTime != null) {
      result.addAll({'lockTime': lockTime});
    }
    if (failedAttempt != null) {
      result.addAll({'failedAttempt': failedAttempt});
    }
    if (accountNonLocked != null) {
      result.addAll({'accountNonLocked': accountNonLocked});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }

    return result;
  }

  factory UserAccountModel.fromMap(Map<String, dynamic> map) {
    return UserAccountModel(
      username: map['username'],
      id: map['id'],
      email: map['email'],
      lockTime: map['lockTime'],
      failedAttempt: map['failedAttempt'],
      accountNonLocked: map['accountNonLocked'],
      createdBy: map['createdBy'],
      role: RoleModel.fromMap(map['role']),
    );
  }
}
