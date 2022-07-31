import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/theme/appColor.dart';
import 'package:equb/utils/localizationHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesProfile extends StatelessWidget {
  const SalesProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = Get.find<AuthService>();
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: CircleAvatar(
                      backgroundColor: AppColor.secondaryColor,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.white,
                        ),
                      ),
                    )),
                // profile
                Container(
                  child: TextWidget(label: "Profile"),
                ),

                //settings
                Container(
                  child: IconButton(
                      icon: const Icon(Icons.settings), onPressed: () {}),
                )
              ],
            ),
            //image
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.06),
              child: Hero(
                tag: "profile",
                child: Container(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColor.secondaryColor,
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          NetworkImage("https://i.pravatar.cc/300"),
                    ),
                  ),
                ),
              ),
            ),
            //name
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextWidget(
                  size: 25, label: _authService.userInfo!.username.toString()),
            ),
            //phone
            Container(
              child: TextWidget(
                  size: 20, label: _authService.userInfo!.email.toString()),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            //setting
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            // language
            GestureDetector(
              onTap: () => {_lang()},
              child: ListTile(
                leading: const Icon(Icons.language),
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(label: "Language".tr),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    _lang();
                  },
                ),
              ),
            ),

            //
            // theme
            GestureDetector(
              onTap: () => {},
              child: ListTile(
                leading: Container(
                  child: Obx(
                    () => Container(
                      child: _authService.isDarkMode
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode),
                    ),
                  ),
                ),
                title: Container(
                  alignment: Alignment.topLeft,
                  child: TextWidget(label: "Theme".tr),
                ),
                trailing: Obx(
                  () => Switch(
                    activeColor: AppColor.secondaryColor,
                    value: _authService.isDarkMode,
                    onChanged: (value) {
                      _authService.isDarkMode = value;
                    },
                  ),
                ),
              ),
            ),
            // // about us
            GestureDetector(
              onTap: () => {},
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(label: "About us".tr),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
            ),
            // contact us
            GestureDetector(
              onTap: () => {},
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(label: "Contact us".tr),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
            ),
            //withdrawal

            GestureDetector(
              onTap: () => {_authService.logOut()},
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(label: "Logout".tr),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    _authService.logOut();
                  },
                ),
              ),
            ),
            // logout
          ],
        ),
      )),
    );
  }

  _lang() {
    Get.dialog(Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(),
            Container(
              margin: const EdgeInsets.all(20),
              // color: AppColor().lightYellow,
              child: TextWidget(
                label: "Select Language".tr,
                size: 16,
              ),
            ),
            ...LocalizationService.instance.supportedLocales
                .map((Map<String, dynamic> localeInfo) => PopupMenuItem(
                    onTap: () async {
                      if (LocalizationService.instance.currentLocaleLangCode !=
                          localeInfo['languageCode']) {
                        LocalizationService.instance
                            .changeLocale(localeInfo['languageCode']);
                      }
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localeInfo['name'],
                        ))))
                .toList(),
            const Divider(
              height: 10,
            )
          ],
        ),
      ),
    ));
  }
}
