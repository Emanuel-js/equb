import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/services/navigationService.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/theme/appColor.dart';
import 'package:equb/user/screens/views/userDropScreen.dart';
import 'package:equb/user/screens/views/userHomeScreen.dart';
import 'package:equb/user/screens/views/userWalletScreen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({Key? key}) : super(key: key);

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  final _authService = Get.find<AuthService>();
  final _walletService = Get.find<WalletService>();
  final _navingationService = Get.find<NavigationService>();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = [
    const UserHomeScreen(),
    const UserWalletScreen(),
    const UserDropScreen()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navingationService.navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _navingationService.navIndex = 0;
    _walletService.getWalletAccount(_authService.userInfo!.id.toString());

    return Scaffold(
      body: Obx(() => _widgetOptions.elementAt(_navingationService.navIndex)),
      bottomNavigationBar: Container(
          child: Container(
        // margin: const EdgeInsets.all(10),
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FancyBottomNavigation(
          circleColor: AppColor.primaryColor,
          activeIconColor: AppColor.white,
          tabs: [
            TabData(iconData: FontAwesomeIcons.house, title: "Home".tr),
            TabData(iconData: FontAwesomeIcons.wallet, title: "Wallet".tr),
            TabData(iconData: FontAwesomeIcons.piggyBank, title: "Drop".tr)
          ],
          onTabChangedListener: (position) {
            _navingationService.navIndex = position;
            _selectedIndex = position;
          },
        ),
      )),
    );
  }
}
