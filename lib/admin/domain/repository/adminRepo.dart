import 'dart:io';
import 'package:dio/dio.dart';
import 'package:equb/admin/domain/models/analyticsModel.dart';
import 'package:equb/api/api.dart';
import 'package:equb/api/apiEndPoint.dart';
import 'package:equb/api/apiHelper.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/utils/messageHander.dart';

class AdminRepo {
  Future registerSales(UserModel data, File? image) async {
    String url = Api.baseUrl + ApiEndPoints.adminAddSales;

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

  Future<AnalyticsModel> getAnalytics() async {
    String url = Api.baseUrl + ApiEndPoints.analytics;

    final response = await apiUtils.get(url: url);
    if (response.data["success"] == false) {
      MessageHandler()
          .displayMessage(title: "Message", msg: response.data["message"]);
      return response.data["message"];
    }

    return AnalyticsModel.fromMap(response.data);
  }
}
