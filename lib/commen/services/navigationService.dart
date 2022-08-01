import 'dart:async';

import 'package:get/get.dart';

class NavigationService extends GetxController {
  final _navIndex = 0.obs;
  final StreamController<int> _streamController = StreamController<int>();

  get navIndex => _navIndex.value;
  set navIndex(val) => {_streamController.add(val), _navIndex.value = val};
  get streamController => _streamController;
  // get streamController => _streamController.stream;
}
