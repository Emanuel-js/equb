import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equb/api/api.dart';
import 'package:equb/api/apiEndPoint.dart';
import 'package:equb/api/apiHelper.dart';
import 'package:equb/commen/models/userMode.dart';

class AgentRepo {
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
}
