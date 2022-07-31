import 'dart:io';

import 'package:equb/admin/domain/models/analyticsModel.dart';
import 'package:equb/admin/domain/repository/adminRepo.dart';
import 'package:equb/admin/screens/views/adminHomeScreen.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/commen/screens/widgets/loadingScreen.dart';
import 'package:equb/utils/messageHander.dart';
import 'package:get/get.dart';

class AdminService extends GetxController {
  final _isLoading = false.obs;
  final _isRegisterd = false.obs;
  final _imagFile = Rxn<File>();
  final _salesReq = Rxn<UserModel>();
  final _lat = 0.0.obs;
  final _long = 0.0.obs;
  final _analitics = AnalyticsModel().obs;

  double? get lat => _lat.value;
  set lat(val) => _lat.value = val;

  double? get long => _long.value;
  set long(val) => _long.value = val;

  bool get isLoading => _isLoading.value;

  bool get isRegisterd => _isRegisterd.value;
  set isRegisterd(val) => _isRegisterd.value = val;

  UserModel? get salesReq => _salesReq.value;
  set salesReq(val) => _salesReq.value = val;

  AnalyticsModel get analitics => _analitics.value;
  set analitics(val) => _analitics.value = val;

  File? get imageFile => _imagFile.value;
  set imageFile(val) => _imagFile.value = val;

  void setLoading(bool show) {
    _isLoading.value = show;
  }

  registerSales(UserModel data, File? image, ctx) async {
    LoadingScreen.loading(ctx);

    try {
      final res = await AdminRepo().registerSales(data, image);

      if (res["userProfile"] != null) {
        _isRegisterd.value = true;
        LoadingScreen.closeLoading(ctx);
        Get.to(() => AdminHomeScreen());
        MessageHandler().displayMessage(title: "መልክት", msg: "በተሳካ ሁኔታ ተመዝግቧል");
      }
    } catch (e) {
      _isRegisterd.value = false;
      LoadingScreen.closeLoading(ctx);
    }
  }

  getAnalytics() async {
    try {
      final result = await AdminRepo().getAnalytics();

      _analitics.value = result;
    } catch (e) {}
  }
}
