import 'package:equb/admin/domain/services/adminService.dart';
import 'package:equb/agent/domain/services/agentService.dart';
import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/views/onbordingScreen.dart';
import 'package:equb/commen/screens/views/welcomeScreen.dart';
import 'package:equb/commen/services/navigationService.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/constants/appconst.dart';
import 'package:equb/initApp.dart';
import 'package:equb/sales/domain/services/salesService.dart';
import 'package:equb/theme/theme.dart';
import 'package:equb/user/domain/services/ticketService.dart';
import 'package:equb/utils/localStorageHelper.dart';
import 'package:equb/utils/localizationHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await initApp();
  runApp(const MyApp());
//  String? token = await FirebaseMessaging.instance.getToken();
  Get.put(AuthService());
  Get.put(AdminService());
  Get.put(AgentService());
  Get.put(SalesService());
  Get.put(WalletService());
  Get.put(TicketService());
  Get.put(NavigationService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<AuthService>();
    return Obx(
      () => GetMaterialApp(
        translations: LocalizationService.instance,
        locale: LocalizationService.instance.currentLocale,
        fallbackLocale: LocalizationService.instance.fallbackLocale,
        debugShowCheckedModeBanner: false,
        title: 'እቁብ',
        theme:
            _controller.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
        themeMode: ThemeMode.dark,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getPage(),
      ),
    );
  }

  Widget getPage() {
    if (LocalStorageService.instance.get(AppConst.APP_ACCESS_TOKEN) != null) {
      return const WelcomeScreen();
    }
    return const OnboardingScreen();
  }
}
