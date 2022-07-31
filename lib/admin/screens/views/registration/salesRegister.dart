import 'package:equb/admin/domain/services/adminService.dart';
import 'package:equb/admin/screens/views/registration/salesInformation.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegisterSales extends StatefulWidget {
  const RegisterSales({Key? key}) : super(key: key);

  @override
  State<RegisterSales> createState() => _RegisterSalesState();
}

class _RegisterSalesState extends State<RegisterSales> {
  final _globalKey = GlobalKey<FormState>();
  final _adminController = Get.find<AdminService>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNameController = TextEditingController();

  final _passwordNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _alternatePhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
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
        ),
        body: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColor.secondaryColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Container(
                      height: 10,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Container(
                      height: 10,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30, bottom: 30),
                  child: TextWidget(
                    label: "Register New Sales".tr,
                    color: AppColor.black,
                    ftw: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: inputField(
                    controller: _firstNameController,
                    hint: "FirstName".tr,
                    icon: FontAwesomeIcons.user,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: inputField(
                    controller: _lastNameController,
                    hint: "LastName".tr,
                    icon: FontAwesomeIcons.user,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: TextFormField(
                      style: const TextStyle(fontSize: 16),
                      controller: _phoneNameController,
                      keyboardType: TextInputType.phone,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Please insert your phone number".tr;
                        }
                        if (!text.isPhoneNumber) {
                          return "Please insert valid phone number".tr;
                        }
                        return null;
                      },
                      decoration: inputStyles(
                          hint: "Phone Number".tr,
                          icon: FontAwesomeIcons.phone)),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: TextFormField(
                      style: const TextStyle(fontSize: 16),
                      controller: _alternatePhoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: inputStyles(
                          hint: "PhoneNumber(Optional)".tr,
                          icon: FontAwesomeIcons.phone)),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                    width: Get.width * 0.9,
                    child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please insert required filed".tr;
                          }
                          if (!v.isEmail) {
                            return "Your Email is not correct".tr;
                          }
                          return null;
                        },
                        decoration:
                            inputStyles(hint: "Email".tr, icon: Icons.email))),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  child: Obx(
                    () => _adminController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            padding: EdgeInsets.only(bottom: Get.height * 0.02),
                            width: Get.width * 0.9,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.darkBlue),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)))),
                              onPressed: () {
                                if (_globalKey.currentState!.validate()) {
                                  _adminController.salesReq = UserModel(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email: _emailController.text,
                                      phoneNumber: _phoneNameController.text,
                                      alternatePhoneNumber:
                                          _alternatePhoneNumberController.text);
                                  Get.to(() => const SalesDetailInformation());
                                }

                                if (_adminController.isLoading) {
                                  _firstNameController.clear();
                                  _lastNameController.clear();
                                  _emailController.clear();

                                  _phoneNameController.clear();
                                  _alternatePhoneNumberController.clear();
                                }
                              },
                              child: TextWidget(
                                label: "Next".tr,
                                size: 16,
                              ),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget inputField(
      {required String hint,
      required TextEditingController controller,
      IconData? icon,
      bool secure = false,
      TextInputType keytype = TextInputType.text}) {
    return SizedBox(
      width: Get.width * 0.7,
      child: TextFormField(
          obscureText: secure,
          style: const TextStyle(fontSize: 16),
          controller: controller,
          keyboardType: keytype,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please insert required filed";
            }
            return null;
          },
          decoration: inputStyles(hint: hint, icon: icon)),
    );
  }

  InputDecoration inputStyles({required String hint, required var icon}) {
    return InputDecoration(
      prefixIcon: Container(
          padding: const EdgeInsets.only(left: 10), child: Icon(icon)),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      labelText: hint,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(20.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
    );
  }
}
