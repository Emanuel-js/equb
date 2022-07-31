import 'package:equb/agent/domain/services/agentService.dart';
import 'package:equb/agent/screens/views/agentProfile.dart';
import 'package:equb/agent/screens/views/agentWallet.dart';
import 'package:equb/agent/screens/views/register/registerUser.dart';
import 'package:equb/agent/screens/views/userList.dart';
import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AgentHomeScreen extends StatefulWidget {
  const AgentHomeScreen({Key? key}) : super(key: key);

  @override
  State<AgentHomeScreen> createState() => _MainCollectorHomeScreenState();
}

class _MainCollectorHomeScreenState extends State<AgentHomeScreen> {
  final _agentService = Get.find<AgentService>();
  final _authService = Get.find<AuthService>();
  final _walletService = Get.find<WalletService>();
  @override
  Widget build(BuildContext context) {
    _authService.getMyUsers();
    _walletService.getWalletAccount(_authService.userInfo!.id.toString());
    _walletService.getTransactionHistory(_authService.userInfo!.id.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          child: Icon(
            Icons.add,
            color: AppColor.white,
          ),
          onPressed: () {
            Get.to(() => const AgentRegisterUserScreen());
          }),
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
                        Get.to(() => const AgentProfile());
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
                        label: "እንኳን ደህና መጡ",
                        color: AppColor.white,
                        ftw: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    TextWidget(
                      label: _authService.userInfo!.username.toString(),
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
                        data: _authService.userDetail!.length.toString(),
                        icon: FontAwesomeIcons.peopleGroup,
                        title: "ጠቅላላ ቆጣቢዎች",
                        onPress: () {
                          Get.to(UserRegisteredList());
                        }),
                  ),
                  Obx(
                    () => _cards(
                        data: _walletService.myWallet!.balance.toString() +
                            " " +
                            "ETB".tr,
                        icon: FontAwesomeIcons.wallet,
                        title: "የተላለፈ ገንዘብ",
                        onPress: () {
                          Get.to(const AgentWallet());
                        }),
                  ),
                  _cards(
                      data: "20K ብር",
                      icon: FontAwesomeIcons.moneyBill,
                      title: "Total Earning",
                      onPress: () {
                        // Get.to(() => const MainCollectorProfile());
                      })
                ],
              ),
            )
          ],
        ),
      ),
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
                Expanded(
                  child: Container(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColor.secondaryColor,
                      child: Icon(
                        icon,
                        color: AppColor.white,
                      ),
                    ),
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
