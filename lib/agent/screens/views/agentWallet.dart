import 'package:equb/admin/domain/models/transaction/transactionModel.dart';
import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/theme/appColor.dart';
import 'package:equb/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AgentWallet extends StatefulWidget {
  const AgentWallet({Key? key}) : super(key: key);

  @override
  State<AgentWallet> createState() => _MainCollectorWalletScreenState();
}

class _MainCollectorWalletScreenState extends State<AgentWallet> {
  final _walletService = Get.find<WalletService>();
  final _authService = Get.find<AuthService>();

  final _amountController = TextEditingController();

  final _phoneController = TextEditingController();

  final _remarkController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _walletService.getTransactionHistory(_authService.userInfo!.id.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: "transferto",
          backgroundColor: AppColor.primaryColor,
          child: Icon(
            FontAwesomeIcons.moneyBillTransfer,
            color: AppColor.white,
          ),
          onPressed: () {
            transfer();
          }),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.darkBlue,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    )),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.33,
                child: AppBar(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  )),
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
                  backgroundColor: AppColor.darkBlue,
                  elevation: 0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 30.0, right: 15.0, top: Get.height * 0.18),
                child: TextWidget(
                  label: "ገንዘብን ወደ ሻጭ ያስተላልፉ",
                  color: AppColor.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: Get.height * 0.23),
                child: Column(
                  children: [
                    Obx(
                      () => _cards(
                        title: "ጠቅላላ የተላለፈ ገንዘብ",
                        data: _walletService.myWallet!.balance.toString() +
                            "" +
                            "ETB".tr,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: TextWidget(
              label: "የግብይት መዝገቦች",
              color: AppColor.black,
            ),
          ),
          Obx(() => Expanded(
              child: ListView.builder(
                  itemCount: _walletService.myTransaction?.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    var transaction = _walletService.myTransaction![index];
                    return _transactionList(
                        id: transaction.receiverAccount,
                        phone: "09191919",
                        amount: transaction.amount,
                        date: transaction.transactionDate,
                        Trnsactiontype: transaction.transactionType);
                  }))),
        ],
      ),
    );
  }

  transfer() {
    Get.bottomSheet(SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Container(
            color: _authService.isDarkMode
                ? AppTheme.darkTheme.backgroundColor
                : AppTheme.lightTheme.backgroundColor,
            height: Get.height * 0.5,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  height: 10,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Container(
                  margin: EdgeInsets.only(left: Get.width * 0.057),
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    label: "ግብይት",
                    color: AppColor.black,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: inputField(
                      controller: _phoneController,
                      hint: "መለያ ቁጥር",
                      icon: Icons.account_balance_rounded),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: inputField(
                      controller: _amountController,
                      keytype: TextInputType.number,
                      hint: "የገንዘብ መጠን",
                      icon: FontAwesomeIcons.moneyBillWave),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                // SizedBox(
                //   width: Get.width * 0.9,
                //   child: inputField(
                //       controller: _remarkController,
                //       hint: "Remark",
                //       icon: FontAwesomeIcons.noteSticky),
                // ),
                // SizedBox(
                //   height: Get.height * 0.05,
                // ),
                SizedBox(
                  width: Get.width * 0.9,
                  child: Obx(
                    () => _walletService.isLoading
                        ? SizedBox(
                            height: Get.height * 0.05,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ))
                        : ElevatedButton.icon(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: Get.height * 0.01,
                                        vertical: 15)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                _walletService.transferToUser(TransactionModel(
                                  amount: double.parse(_amountController.text),
                                  receiverAccount: _phoneController.text,
                                  senderAccount:
                                      _walletService.myWallet!.account,
                                ));
                              }
                              if (_walletService.isRefund) {
                                _amountController.clear();
                                _phoneController.clear();
                                Get.back();
                                _walletService.isRefund = false;
                              }
                            },
                            label: TextWidget(
                              label: "ይላኩ",
                              size: 16,
                            ),
                            icon: const Icon(FontAwesomeIcons.dollarSign),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget inputField(
      {required String hint,
      required TextEditingController controller,
      IconData? icon,
      TextInputType keytype = TextInputType.text}) {
    return TextFormField(
      style: const TextStyle(fontSize: 16),
      controller: controller,
      keyboardType: keytype,
      validator: (v) {
        if (v!.isEmpty) {
          return "አስፈላጊውን ፋይል ያስገቡ";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Container(
            padding: const EdgeInsets.only(left: 10), child: Icon(icon)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        labelText: hint,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
      ),
    );
  }

  Widget _transactionList(
      {String? phone,
      double? amount,
      String? date,
      String? Trnsactiontype,
      int? id}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  )),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: TextWidget(
                            label: phone.toString(),
                            size: 14,
                            color: AppColor.black,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          child: TextWidget(
                            label: id == _authService.userInfo!.id
                                ? "- " + amount.toString()
                                : "+ " + amount.toString(),
                            color: AppColor.black,
                            size: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: TextWidget(
                            label: date.toString(),
                            color: AppColor.darkGray,
                            size: 12,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          child: TextWidget(
                            label: Trnsactiontype.toString(),
                            color: _authService.userInfo!.id == id
                                ? AppColor.black
                                : AppColor.purple,
                            size: 12,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _cards({
    required String title,
    required String data,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        color: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.all(50),
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
                width: Get.width * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
