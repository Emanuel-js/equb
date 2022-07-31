import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equb/api/api.dart';
import 'package:equb/api/apiEndPoint.dart';
import 'package:equb/api/apiHelper.dart';
import 'package:equb/commen/models/userDetailModel.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/utils/messageHander.dart';

class SalesRepo {
  Future registerAgent(UserModel data, File? image) async {
    String url = Api.baseUrl + ApiEndPoints.addNewAgent;

    try {
      var request = {
        ...data.toMap(),
        "fileupload": await MultipartFile.fromFile(image!.path),
      };

      FormData formData = FormData.fromMap(request);

      final response = await apiUtils.post(url: url, data: formData);
      log(response.data.toString());
      return response.data;
    } catch (e) {
      return apiUtils.handleError(e);
    }
  }

  Future registerUser(UserModel data, File? image) async {
    String url = Api.baseUrl + ApiEndPoints.addClient;

    try {
      var request = {
        ...data.toMap(),
        "fileupload": await MultipartFile.fromFile(image!.path),
      };

      FormData formData = FormData.fromMap(request);

      final response = await apiUtils.post(url: url, data: formData);

      return response.data;
    } catch (e) {
      return apiUtils.handleError(e);
    }
  }

  Future<UserDetailModel> searchUser(String phoneOrEmail) async {
    String url = Api.baseUrl +
        ApiEndPoints.searchUser +
        "phoneNumberOrEmail=$phoneOrEmail";

    final response = await apiUtils.get(url: url);
    if (response.data["success"] == false) {
      MessageHandler()
          .displayMessage(title: "Message", msg: response.data["message"]);
      return response.data["message"];
    }

    return UserDetailModel.fromMap(response.data);
  }
}
