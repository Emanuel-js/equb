import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/sales/screens/views/lotterList.dart';
import 'package:equb/sales/screens/views/registers/agent/registerAgent.dart';
import 'package:equb/sales/screens/views/registers/user/registerUser.dart';
import 'package:equb/sales/screens/views/salesProfile.dart';
import 'package:equb/sales/screens/views/salesWallet.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SalesHomeScreen extends StatelessWidget {
  const SalesHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthService>();
    final _walletController = Get.find<WalletService>();

    _authController.getMyUsers();
    _walletController.getWalletAccount(_authController.userInfo!.id.toString());
    _walletController
        .getTransactionHistory(_authController.userInfo!.id.toString());
    return Scaffold(
      floatingActionButton: _getFAB(),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.33,
              child: AppBar(
                leading: Container(),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                backgroundColor: AppColor.darkBlue,
                elevation: 0,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Hero(
                    tag: "profile",
                    child: GestureDetector(
                      onTap: () {
                        //todo sales profile
                        Get.to(() => const SalesProfile());
                      },
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: AppColor.secondaryColor,
                          radius: 40,
                          child: Container(
                            child: const CircleAvatar(
                              radius: 24,
                              backgroundImage:
                                  NetworkImage("https://i.pravatar.cc/300"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: TextWidget(
                        label: "???????????? ????????? ??????",
                        color: AppColor.white,
                        ftw: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    TextWidget(
                      label: _authController.userInfo!.username.toString(),
                      color: AppColor.white,
                      ftw: FontWeight.bold,
                      size: 30,
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: Get.height * 0.23),
              child: Column(
                children: [
                  Obx(
                    () => _cards(
                        data: _authController.userDetail!.length.toString(),
                        icon: FontAwesomeIcons.peopleGroup,
                        title: "???????????? ??????",
                        onPress: () {
                          //todo
                          Get.to(const LotterRegisteredList());
                        }),
                  ),
                  //
                  Obx(
                    () => _cards(
                        data:
                            "${_walletController.myWallet!.balance.toString()} ETB",
                        icon: FontAwesomeIcons.wallet,
                        title: "???????????? ????????????",
                        onPress: () {
                          Get.to(const SalesWallet());
                        }),
                  ),
                  _cards(
                      data: "20K ETB",
                      icon: FontAwesomeIcons.moneyBill,
                      title: "Total Earning",
                      onPress: () {
                        // Get.to(() => const SubCollectorProfile());
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: AppColor.darkBlue,
          onTap: () {
            Get.to(() => const RegisterAgentScreen());
          },
          label: 'Register Agent',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          // labelBackgroundColor: const Color(0xFF801E48),
        ),
        // FAB 2
        SpeedDialChild(
          child: const Icon(Icons.people_sharp),
          backgroundColor: AppColor.primaryColor,
          onTap: () {
            Get.to(() => const RegisterUserScreen());
          },
          label: 'Register User',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          // labelBackgroundColor: const Color(0xFF801E48),
        )
      ],
    );
  }

  Widget _cards(
      {required String title,
      required String data,
      required IconData icon,
      required Function onPress}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          onPress();
        },
        child: Card(
          color: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 1,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: TextWidget(
                          label: title,
                          size: 16,
                        ),
                      ),
                      Container(
                        child: TextWidget(
                          label: data,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.25,
                ),
                Container(
                  child: Icon(
                    icon,
                    color: AppColor.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
