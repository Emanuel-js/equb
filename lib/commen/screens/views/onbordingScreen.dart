import 'package:equb/commen/screens/views/welcomeScreen.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listPage = [
      PageViewModel(
        title: "ቆጥቡ",
        body: "save the many and get the many billon times",
        image: Center(
          child: Image(
            image: const AssetImage("assets/imgs/onbord1.png"),
            width: Get.width * 0.8,
          ),
        ),
      ),
      PageViewModel(
        title: "Keep Your Wallet",
        body: "save the many and get the many billon times",
        image: Center(
          child: Image(
            image: const AssetImage("assets/imgs/onboard2.png"),
            width: Get.width * 0.8,
          ),
        ),
      ),
      PageViewModel(
        title: "Win a Prize",
        body: "save the many and get the many billon times",
        image: Center(
          child: Image(
            image: const AssetImage("assets/imgs/onboard3.png"),
            width: Get.width * 0.8,
          ),
        ),
      ),
    ];
    return Scaffold(
        backgroundColor: AppColor.white,
        body: IntroductionScreen(
          pages: listPage,
          onDone: () {
            Get.to(() => const WelcomeScreen());
          },
          showBackButton: false,
          showSkipButton: true,
          next: const Icon(Icons.arrow_forward_ios_outlined),
          back: const Icon(Icons.arrow_back_ios),
          skip: TextWidget(
            label: "skip",
            color: AppColor.secondaryColor,
          ),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        ));
  }
}
