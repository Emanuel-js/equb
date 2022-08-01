import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen {
  static loading(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (c) => Center(
              child: CircleAvatar(
                radius: 50,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), // radius of 10
                      color: AppColor.primaryColor,
                    ),
                    width: Get.width * 0.6,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballTrianglePathColored,

                        /// Required, The loading type of the widget
                        colors: const [Colors.white],

                        /// Optional, The color collections
                        strokeWidth: 1,

                        /// Optional, The stroke of the line, only applicable to widget which contains line
                        backgroundColor: AppColor.primaryColor,

                        /// Optional, Background of the widget
                        pathBackgroundColor: Colors.black

                        /// Optional, the stroke backgroundColor
                        )),
              ),
            ));
  }

  static closeLoading(BuildContext ctx) {
    Navigator.pop(ctx);
  }
}
