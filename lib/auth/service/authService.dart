import 'dart:developer';

import 'package:equb/auth/model/authModel.dart';
import 'package:equb/auth/repository/authRepository.dart';
import 'package:equb/commen/models/userAccountModel.dart';
import 'package:equb/commen/models/userDetailModel.dart';
import 'package:equb/commen/screens/views/welcomeScreen.dart';
import 'package:equb/commen/screens/widgets/getRole.dart';
import 'package:equb/commen/screens/widgets/loadingScreen.dart';
import 'package:equb/constants/appconst.dart';
import 'package:equb/utils/localStorageHelper.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  late String _signedInUser;

  final _isDarkMode = true.obs;

  final _userInfo = UserAccountModel().obs;
  final _userDetail = <UserDetailModel>[].obs;

  late String _signRole;
  final _isLogged = false.obs;
  final _isLoading = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(val) => _isDarkMode.value = val;

  String get signedInUser => _signedInUser;
  String get signdRole => _signRole;

  UserAccountModel? get userInfo => _userInfo.value;

  List<UserDetailModel>? get userDetail => _userDetail.value;
  set userDetail(val) => _userDetail.value = val;

  bool get isLoading => _isLoading.value;
  bool get isLogged => _isLogged.value;

  void setLoading(bool show) {
    _isLoading.value = show;
    // _isLoading(true);
  }

  void login(AuthModel data, ctx) async {
    LoadingScreen.loading(ctx);
    setLoading(true);
    try {
      final result = await AuthRepo().login(data);

      log(result.toString());

      if (result[AppConst.APP_ACCESS_TOKEN] != null) {
        LoadingScreen.closeLoading(ctx);
        await LocalStorageService.instance.addNew(
            AppConst.APP_ACCESS_TOKEN, result[AppConst.APP_ACCESS_TOKEN]);
        await LocalStorageService.instance
            .addNew(AppConst.USER_ROLE, result["roles"]["name"]);

        _signedInUser = result[AppConst.APP_ACCESS_TOKEN];
        _signRole = result["roles"]["name"];

        _userInfo.value =
            UserAccountModel.fromMap(result["loggedInUserProfileData"]);
        GetRole.getRole(signdRole);
      } else {
        LoadingScreen.closeLoading(ctx);
      }
    } catch (e) {
      LoadingScreen.closeLoading(ctx);
    }
  }

  void getMyUsers() async {
    try {
      final result = await AuthRepo().getMyUsers();
      log("=====m=====" + result.toList().toString());
      _userDetail.value = result;
    } catch (e) {
      setLoading(false);
    }
  }

  void logOut() {
    _isLogged.value = false;
    LocalStorageService.instance.remove(AppConst.USER_ROLE);
    LocalStorageService.instance.remove(AppConst.APP_ACCESS_TOKEN);
    Get.offAll(() => const WelcomeScreen());
  }
}
