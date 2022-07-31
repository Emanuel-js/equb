import 'package:get/get.dart';

class NavigationService extends GetxController {
  final _navIndex = 0.obs;

  get navIndex => _navIndex.value;
  set navIndex(val) => _navIndex.value = val;
}
