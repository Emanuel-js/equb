import 'dart:io';
import 'package:equb/admin/domain/services/adminService.dart';
import 'package:equb/admin/screens/views/registration/salesDoucoment.dart';
import 'package:equb/admin/screens/views/registration/searchSalesAddress.dart';
import 'package:equb/commen/models/userMode.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class SalesDetailInformation extends StatefulWidget {
  const SalesDetailInformation({Key? key}) : super(key: key);

  @override
  State<SalesDetailInformation> createState() => _SalesDetailInformationState();
}

class _SalesDetailInformationState extends State<SalesDetailInformation> {
  final _globalKey = GlobalKey<FormState>();
  final _adminController = Get.find<AdminService>();

  final _residentLocationController = TextEditingController();
  final _cityController = TextEditingController();
  final _yearBornController = TextEditingController();
  String _genderController = "Male";

  DateTime selectedDate = DateTime.now();
  late File _filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _globalKey,
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                controller: _cityController,
                hint: "?????????",
                icon: FontAwesomeIcons.city,
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: Container(
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.date_range,
                    color: AppColor.darkGray,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColor.lightBlue),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  onPressed: () {
                    {
                      _selectDate(context);
                    }
                  },
                  label: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10),
                    child: TextWidget(
                      label: "??????????????? ??????" " " +
                          selectedDate.year.toString() +
                          "/" +
                          selectedDate.month.toString() +
                          "/" +
                          selectedDate.day.toString(),
                      color: AppColor.darkGray,
                      txa: TextAlign.start,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(
              child: GenderPickerWithImage(
                verticalAlignedText: false,

                selectedGender: Gender.Male,
                selectedGenderTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                unSelectedGenderTextStyle: const TextStyle(
                    color: Colors.transparent, fontWeight: FontWeight.normal),
                onChanged: (Gender? gender) {
                  _genderController =
                      gender.toString().replaceAll("Gender.", "");
                },
                equallyAligned: true,
                animationDuration: const Duration(milliseconds: 300),
                isCircular: true,
                // default : true,
                opacityOfGradient: 0.4,
                padding: const EdgeInsets.all(3),
                size: 50, //default : 40
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: Container(
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.location_on,
                    color: AppColor.darkGray,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColor.lightBlue),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  onPressed: () {
                    {
                      Get.to(() => const SalesSearchPlacesScreen());
                    }
                  },
                  label: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10),
                    child: Obx(() => TextWidget(
                          label: _adminController.lat != 0.0
                              ? "?????? ???????????????"
                              : "?????? ????????????",
                          color: AppColor.darkGray,
                          txa: TextAlign.start,
                          size: 16,
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(
              child: Obx(() => _adminController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColor.secondaryColor,
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: Get.height * 0.02),
                          width: Get.width * 0.5,
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
                              if (_globalKey.currentState!.validate() &&
                                  _adminController.lat != 0.0) {
                                _adminController.salesReq = UserModel(
                                  city: _cityController.text,
                                  yearBorn: selectedDate,
                                  gender: _genderController,
                                  longitude: _adminController.lat,
                                  latitude: _adminController.long,
                                  firstName:
                                      _adminController.salesReq!.firstName,
                                  lastName: _adminController.salesReq!.lastName,
                                  email: _adminController.salesReq!.email,
                                  phoneNumber:
                                      _adminController.salesReq!.phoneNumber,
                                  alternatePhoneNumber: _adminController
                                      .salesReq!.alternatePhoneNumber,
                                );

                                Get.to(() => const SalesUploadDocument());
                              }
                              if (_adminController.lat == 0.0) {
                                Get.snackbar(
                                  "????????????",
                                  "?????? ????????????",
                                  backgroundColor: AppColor.darkBlue,
                                  colorText: AppColor.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            },
                            child: TextWidget(
                              label: "?????????",
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    )),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
          validator: (v) {
            if (v!.isEmpty) {
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
