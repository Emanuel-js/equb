import 'dart:io';

import 'package:equb/agent/domain/repository/agentRepo.dart';
import 'package:equb/agent/screens/views/agentHomeScreen.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/commen/screens/widgets/loadingScreen.dart';
import 'package:equb/utils/messageHander.dart';
import 'package:get/get.dart';

class AgentService extends GetxController {
  final _isLoading = false.obs;
  final _isRegisterd = false.obs;
  final _imagFile = Rxn<File>();
  final _agentReq = Rxn<UserModel>();
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

  File? get imageFile => _imagFile.value;
  set imageFile(val) => _imagFile.value = val;

  void setLoading(bool show) {
    _isLoading.value = show;
  }

  registerUser(UserModel data, File? image, ctx) async {
    LoadingScreen.loading(ctx);

    try {
      final res = await AgentRepo().registerUser(data, image);

      if (res != null) {
        _isRegisterd.value = true;
        LoadingScreen.closeLoading(ctx);
        Get.to(() => const AgentHomeScreen());
        MessageHandler().displayMessage(title: "መልክት", msg: "በተሳካ ሁኔታ ተመዝግቧል");
      }
    } catch (e) {
      _isRegisterd.value = false;
      LoadingScreen.closeLoading(ctx);
    }
  }
}
