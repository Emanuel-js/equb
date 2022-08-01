import 'package:equb/admin/domain/services/adminService.dart';
import 'package:equb/admin/screens/views/adminProfileScreen.dart';
import 'package:equb/admin/screens/views/adminWallet.dart';
import 'package:equb/admin/screens/views/notification/refundNotification/refundReqest.dart';
import 'package:equb/admin/screens/views/userList/adminRegisterd.dart';
import 'package:equb/admin/screens/views/registration/salesRegister.dart';
import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key}) : super(key: key);
  final _autController = Get.find<AuthService>();
  final _walletController = Get.find<WalletService>();
  final _adminController = Get.find<AdminService>();
  @override
  Widget build(BuildContext context) {
    _autController.getMyUsers();
    _walletController.getReqRefunds();
    _adminController.getAnalytics();
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'.tr),
              content: Text('Do you want to exit an App'.tr),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), //<-- SEE HERE
                  child: Text('No'.tr),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // <-- SEE HERE
                  child: Text('Yes'.tr),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                        onPressed: () {
                          //todo admin notification
                          Get.to(() => const AdminNotification());
                        },
                      ),
                    ),
                    Hero(
                      tag: "profile",
                      child: GestureDetector(
                        onTap: () {
                          //todo admin profile
                          Get.to(() => const AdminProfileScreen());
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
                          label: "Welcome".tr,
                          // color: AppColor.white,
                          ftw: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      TextWidget(
                        label: _autController.userInfo!.username.toString(),
                        // color: AppColor.white,
                        ftw: FontWeight.bold,
                        size: 30,
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: Get.height * 0.23),
                child: GridView.count(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: Get.height * 0.02,
                  crossAxisSpacing: Get.width * 0.02,
                  children: [
                    Obx(
                      () => _cards(
                          onPressed: () {},
                          data: _adminController.analitics.NumberOfClients
                              .toString(),
                          icon: FontAwesomeIcons.receipt,
                          subtitle: "Total users account".tr,
                          title: "Saving account".tr,
                          color: AppColor.lightBlue),
                    ),
                    Obx(
                      () => _cards(
                          onPressed: () {
                            //todo addmin register sales
                            Get.to(() => const AdminRegistered());
                          },
                          //
                          data: _adminController.analitics.NumberOfSubCollectors
                              .toString(),
                          icon: FontAwesomeIcons.userGroup,
                          subtitle: "Total Collector Account".tr,
                          title: "Collectors".tr,
                          color: AppColor.darkGray),
                    ),
                    Obx(
                      //
                      () => _cards(
                          onPressed: () {},
                          data: _adminController.analitics.NumberOfSubCollectors
                              .toString(),
                          icon: FontAwesomeIcons.personCirclePlus,
                          subtitle: "Salesperson user account".tr,
                          title: "Sales".tr,
                          color: AppColor.darkGray),
                    ),
                    Obx(
                      //,
                      () => _cards(
                          onPressed: () {},
                          data: _adminController
                              .analitics.NumberOfRefundFormRequest
                              .toString(),
                          icon: FontAwesomeIcons.moneyBill,
                          subtitle: "ጠቅላላ የተመላሽ ገንዘብ ጥያቄ",
                          title: "የተመላሽ ጥያቄ",
                          color: AppColor.lightBlue),
                    ),
                    Obx(
                      () => _cards(
                          //
                          onPressed: () {},
                          data: _adminController
                              .analitics.NumberOfRefundFormRequestAccepted
                              .toString(),
                          icon: FontAwesomeIcons.personWalking,
                          subtitle: "አቆርጦ የወጣ እቁብ ጣይ",
                          title: "አቆርጦ የወጣ",
                          color: AppColor.lightBlue),
                    ),
                    Obx(
                      //
                      () => _cards(
                          onPressed: () {},
                          data: _adminController
                              .analitics.NumberOFLottoTicketsCreated
                              .toString(),
                          icon: FontAwesomeIcons.moneyBill,
                          subtitle: "ጠቅላላ የተጣለ እጣ",
                          title: " የተጣለ እጣ",
                          color: AppColor.darkGray),
                    ),
                    _cards(
                        onPressed: () {},
                        data: "5",
                        icon: FontAwesomeIcons.moneyCheck,
                        subtitle: "እቁብ የወጣለት ብዛት",
                        title: "እቁብ የደረሰው",
                        color: AppColor.darkGray),
                  ],
                ),
              )
            ],
          ),
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
            Get.to(() => const RegisterSales());
          },
          label: 'Register Sales'.tr,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          // labelBackgroundColor: const Color(0xFF801E48),
        ),
        // FAB 2
        SpeedDialChild(
          child: const Icon(FontAwesomeIcons.moneyBillTransfer),
          backgroundColor: AppColor.primaryColor,
          onTap: () {
            Get.to(() => const AdminWallet());
          },
          label: 'Transfer'.tr,
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
      required Color color,
      required Function onPressed,
      required String subtitle}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: Get.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Container(
                child: TextWidget(
                  label: title,
                  size: 16,
                  ftw: FontWeight.w600,
                ),
              ), //subtitle
              Container(
                child: Row(
                  children: [
                    Container(
                      child: TextWidget(
                        label: data,
                        ftw: FontWeight.w200,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Icon(
                      icon,
                      color: AppColor.white,
                      size: 25,
                    )
                  ],
                ),
              ),
              Container(
                child: TextWidget(
                  label: subtitle,
                  size: 11,
                ),
              )
              //sub
            ],
          ),
        ),
      ),
    );
  }
}
