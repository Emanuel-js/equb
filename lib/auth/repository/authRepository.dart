import 'dart:developer';

import 'package:equb/api/api.dart';
import 'package:equb/api/apiEndPoint.dart';
import 'package:equb/api/apiHelper.dart';
import 'package:equb/auth/model/authModel.dart';
import 'package:equb/commen/models/userDetailModel.dart';

class AuthRepo {
  Future login(AuthModel data) async {
    log(data.toJson().toString());
    // final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   return AuthResponse.withError(
    //       success: false, msg: apiUtils.getNetworkError());
    // }

    String url = Api.baseUrl + ApiEndPoints.login;
    try {
      final response = await apiUtils.post(url: url, data: data);

      return response.data;
    } catch (e) {
      return apiUtils.handleError(e);
    }
  }

  Future<List<UserDetailModel>> getMyUsers() async {
    String url = Api.baseUrl + ApiEndPoints.getMyUsers;

    final response = await apiUtils.get(url: url);

    List<UserDetailModel> result = List<UserDetailModel>.from(response.data.map(
      (res) => UserDetailModel.fromMap(res),
    ));

    return result;
  }
}
