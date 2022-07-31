import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen {
  static loading(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (c) => Center(
              child: Container(
                child: Container(
                    color: AppColor.primaryColor,
                    width: Get.width * 0.5,
                    child: Lottie.asset("assets/imgs/loading.json",
                        animate: true, repeat: true)),
              ),
            ));
  }

  static closeLoading(BuildContext ctx) {
    Navigator.pop(ctx);
  }
}
