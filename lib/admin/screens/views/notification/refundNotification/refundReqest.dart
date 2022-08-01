import 'package:equb/admin/domain/models/refund/refundModel.dart';
import 'package:equb/admin/screens/views/notification/refundNotification/adminRefundNotificationDetail.dart';
import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/circleTabIndicator.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/commen/services/walletService.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({Key? key}) : super(key: key);

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification>
    with TickerProviderStateMixin {
  final _authService = Get.find<AuthService>();
  final _walletService = Get.find<WalletService>();
  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 3, vsync: this);
    _walletService.getReqRefunds();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Notification'),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                child: TextWidget(
                  label: 'Today',
                  ftw: FontWeight.bold,
                  size: 25,
                ),
              ),
              Container(
                child: TextWidget(
                  label: DateTime.now().month.toString() +
                      "-" +
                      DateTime.now().day.toString() +
                      "-" +
                      DateTime.now().year.toString(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    unselectedLabelColor: _authService.isDarkMode
                        ? AppColor.darkGray
                        : AppColor.purple,
                    labelColor: _authService.isDarkMode
                        ? AppColor.white
                        : AppColor.primaryColor,
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    indicator: CircleTabIndicator(
                        _authService.isDarkMode
                            ? AppColor.secondaryColor
                            : AppColor.black,
                        4),
                    tabs: [
                      TextWidget(
                        label: "ዛሬ",
                        // color: AppColor.black,
                        size: 16,
                      ),
                      TextWidget(
                        label: "ወርሃዊ",
                        // color: AppColor.black,
                        size: 16,
                      ),
                      TextWidget(
                        label: "የሁልጊዜ",
                        size: 16,
                        // color: AppColor.black,
                      ),
                    ]),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.5,
                  child: TabBarView(controller: _tabController, children: [
                    Container(
                        child: ListView.builder(
                            itemCount: _walletService.refundController!.length,
                            itemBuilder: (context, index) {
                              RefundModel refund =
                                  _walletService.refundController![index];

                              return _withdrwalList(refund);
                            })),
                    Container(
                        child: ListView(
                      children: const [],
                    )),
                    Container(
                        child: ListView(
                      children: const [],
                    ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Widget _withdrwalList(RefundModel refund) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AdminRefundNotificationDetail(), arguments: refund);
      },
      child: Container(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                leading: Container(
                  // tag: refund.refundForm!.refundUniqueId.toString(),
                  child: Container(
                    child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200")),
                  ),
                ),
                title: Container(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      label: "${refund.refundForm!.fullName} request refund",
                      size: 15,
                    )),
                subtitle: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          label: "${refund.refundForm!.amount} ETB",
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                          label: "${refund.refundForm!.refundMeStatus}"),
                    ),
                  ],
                ),
              ),
            )

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Container(
            //       child: ElevatedButton.icon(
            //           onPressed: () {},
            //           icon: const Icon(Icons.check),
            //           label: const Text("Accept")),
            //     ),
            //     SizedBox(
            //       height: Get.width * 0.05,
            //     ),
            //     Container(
            //       child: ElevatedButton.icon(
            //         onPressed: () {},
            //         icon: const Icon(Icons.close),
            //         label: const Text("reject"),
            //         style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all(Colors.red),
            //         ),
            //       ),
            //     )
            //   ],
            // )

            ),
      ),
    );
  }
}



                // Container(
                //   child: TextWidget(label: "you received a refund request"),
                // )

              