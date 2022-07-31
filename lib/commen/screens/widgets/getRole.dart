import 'package:equb/admin/screens/views/adminHomeScreen.dart';
import 'package:equb/agent/screens/views/agentHomeScreen.dart';
import 'package:equb/constants/role.dart';
import 'package:equb/sales/screens/views/salesHomeScreen.dart';
import 'package:equb/user/screens/views/userMainScreen.dart';
import 'package:get/get.dart';

class GetRole {
  static getRole(String role) {
    switch (role) {
      case Role.ROlE_ADMIN:
        return Get.to(() => AdminHomeScreen());
        break;
      case Role.ROLE_SALES:
        return Get.to(() => const SalesHomeScreen());
        break;
      case Role.ROLE_AGENT:
        return Get.to(() => const AgentHomeScreen());
        break;
      case Role.ROlE_USER:
        return Get.to(() => const UserMainScreen());
        break;
      default:
        return;
        break;
    }
  }
}
