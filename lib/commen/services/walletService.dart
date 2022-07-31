import 'dart:developer';

import 'package:equb/admin/domain/models/refund/refundModel.dart';
import 'package:equb/admin/domain/models/refund/refundRequestModel.dart';
import 'package:equb/admin/domain/models/savingAccount/savingAccountModel.dart';
import 'package:equb/admin/domain/models/transaction/transactionModel.dart';
import 'package:equb/admin/domain/models/transaction/transactionResponceModel.dart';
import 'package:equb/admin/domain/models/wallet/walletModel.dart';
import 'package:equb/admin/domain/repository/walletRepo/walletRepo.dart';
import 'package:equb/auth/service/authService.dart';
import 'package:equb/utils/messageHander.dart';
import 'package:get/get.dart';

class WalletService extends GetxController {
  final _myWallet = WalletModel().obs;
  final _mySavingBalance = SavingAccountModel().obs;
  final _myTransaction = <TransactionResponseModel>[].obs;
  final _refundController = <RefundModel>[].obs;
  final _authService = Get.find<AuthService>();
  final _isRefund = false.obs;
  final _isLoading = false.obs;

  WalletModel? get myWallet => _myWallet.value;
  SavingAccountModel? get mySavingBalance => _mySavingBalance.value;

  List<TransactionResponseModel>? get myTransaction => _myTransaction;

  List<RefundModel>? get refundController => _refundController;

  bool get isLoading => _isLoading.value;
  bool get isRefund => _isRefund.value;

  set isRefund(bool value) => _isRefund.value = value;

  void setLoading(bool show) {
    _isLoading.value = show;
    // _isLoading(true);
  }

  void transferToUser(TransactionModel data) async {
    setLoading(true);
    try {
      final result = await WalletRepo().transferToUser(data);
      if (result != null) {
        MessageHandler()
            .displayMessage(msg: "Transaction is Done", title: "Transaction");
        setLoading(false);
        getWalletAccount(_authService.userInfo!.id.toString());

        _isRefund.value = true;
      } else {
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  void topUpWallet(TransactionModel data) async {
    setLoading(true);
    try {
      final result = await WalletRepo().topUpWallet(data);

      if (result["transactionType"] != null) {
        MessageHandler()
            .displayMessage(msg: "Transaction is Done", title: "Transaction");
        _isRefund.value = true;
        setLoading(false);
        getWalletAccount(_authService.userInfo!.id.toString());
        getSavingBalance(_authService.userInfo!.id.toString());
      } else {
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  void getWalletAccount(String id) async {
    try {
      final result = await WalletRepo().getWalletAccount(id);

      _myWallet.value = result;
    } catch (e) {
      log("message$e");
    }
  }

  void getTransactionHistory(String id) async {
    try {
      final result = await WalletRepo().getTransactionHistory(id);

      _myTransaction.value = result;
    } catch (e) {
      log("message$e");
    }
  }

  void getSavingBalance(String id) async {
    try {
      final result = await WalletRepo().getSavingBalance(id);

      _mySavingBalance.value = result;
    } catch (e) {
      log("message$e");
    }
  }

  void requestRefund(RefundResponseModel data) async {
    setLoading(true);
    try {
      final result = await WalletRepo().requestReFund(data);

      if (result["id"].toString().isNotEmpty) {
        MessageHandler()
            .displayMessage(msg: "Request Refund is Done!", title: "Request");
        setLoading(false);
        _isRefund.value = true;
      } else {
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  void getReqRefunds() async {
    try {
      final result = await WalletRepo().getReqRefund();

      _refundController.value = result;
    } catch (e) {
      log("message$e");
    }
  }

  // void requestRefundApproval(RefundRequestApprovedModel data) async {
  //   setLoading(true);
  //   Get.defaultDialog(
  //       title: "Approve Refund", content: TextWidget(label: "Approving..."));
  //   try {
  //     final result = await WalletRepo().requestReFundApproval(data);
  //     log(result.toString());
  //     if (result["id"] != null) {
  //       MessageHandler()
  //           .displayMessage(msg: "Refund Approved!", title: "Request");
  //       setLoading(false);
  //       Get.back();
  //       _isRefund.value = true;
  //     } else {
  //       setLoading(false);
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //   }
  // }
}
