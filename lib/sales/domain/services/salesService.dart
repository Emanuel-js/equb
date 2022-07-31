import 'dart:io';

import 'package:equb/commen/models/userDetailModel.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/commen/screens/widgets/loadingScreen.dart';
import 'package:equb/sales/domain/repository/salesRepo.dart';
import 'package:equb/sales/screens/views/salesHomeScreen.dart';
import 'package:equb/utils/messageHander.dart';
import 'package:get/get.dart';

class SalesService extends GetxController {
  final _isLoading = false.obs;
  final _isRegisterd = false.obs;
  final _imagFile = Rxn<File>();
  final _agentReq = Rxn<UserModel>();
  final _searchResult = Rxn<UserDetailModel>();
  final _lat = 0.0.obs;
  final _long = 0.0.obs;

  double? get lat => _lat.value;
  set lat(val) => _lat.value = val;

  double? get long => _long.value;
  set long(val) => _long.value = val;

  bool get isLoading => _isLoading.value;

  bool get isRegisterd => _isRegisterd.value;
  set isRegisterd(val) => _isRegisterd.value = val;

  UserModel? get agentReq => _agentReq.value;
  set agentReq(val) => _agentReq.value = val;

  UserDetailModel? get searchResult => _searchResult.value;
  set searchResult(val) => _searchResult.value = val;

  File? get imageFile => _imagFile.value;
  set imageFile(val) => _imagFile.value = val;

  void setLoading(bool show) {
    _isLoading.value = show;
  }

  registerAgent(UserModel data, File? image, ctx) async {
    LoadingScreen.loading(ctx);

    try {
      final res = await SalesRepo().registerAgent(data, image);

      if (res["userProfile"] != null) {
        _isRegisterd.value = true;
        LoadingScreen.closeLoading(ctx);
        Get.to(() => const SalesHomeScreen());
        MessageHandler().displayMessage(title: "መልክት", msg: "በተሳካ ሁኔታ ተመዝግቧል");
      }
    } catch (e) {
      _isRegisterd.value = false;
      LoadingScreen.closeLoading(ctx);
    }
  }

  registerUser(UserModel data, File? image, ctx) async {
    LoadingScreen.loading(ctx);

    try {
      final res = await SalesRepo().registerUser(data, image);

      if (res["userProfile"] != null) {
        _isRegisterd.value = true;
        LoadingScreen.closeLoading(ctx);
        Get.to(() => const SalesHomeScreen());
        MessageHandler().displayMessage(title: "መልክት", msg: "በተሳካ ሁኔታ ተመዝግቧል");
      }
    } catch (e) {
      _isRegisterd.value = false;
      LoadingScreen.closeLoading(ctx);
    }
  }

  searchUser(String phone) async {
    try {
      final result = await SalesRepo().searchUser(phone);
      if (result != null) {
        _searchResult.value = result;
      } else {
        _searchResult.value = null;
      }
    } catch (e) {}
  }
}
