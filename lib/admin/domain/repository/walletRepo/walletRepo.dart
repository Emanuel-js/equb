import 'package:equb/admin/domain/models/refund/refundModel.dart';
import 'package:equb/admin/domain/models/refund/refundRequestModel.dart';
import 'package:equb/admin/domain/models/savingAccount/savingAccountModel.dart';
import 'package:equb/admin/domain/models/transaction/transactionModel.dart';
import 'package:equb/admin/domain/models/transaction/transactionResponceModel.dart';
import 'package:equb/admin/domain/models/wallet/walletModel.dart';
import 'package:equb/api/api.dart';
import 'package:equb/api/apiEndPoint.dart';
import 'package:equb/api/apiHelper.dart';

class WalletRepo {
  transferToUser(TransactionModel data) async {
    String url = Api.baseUrl + ApiEndPoints.transferMoney;

    final response = await apiUtils.post(url: url, data: data.toMap());
    return response.data;
  }

  topUpWallet(TransactionModel data) async {
    String url = Api.baseUrl + ApiEndPoints.transferWalletToSales;

    final response = await apiUtils.post(url: url, data: data.toMapTopUp());
    return response.data;
  }

  Future<WalletModel> getWalletAccount(String id) async {
    String url = Api.baseUrl + ApiEndPoints.getUserWalletAccount + "/$id";

    final response = await apiUtils.get(url: url);
    return WalletModel.fromMap(response.data!);
  }

  Future<List<TransactionResponseModel>> getTransactionHistory(
      String id) async {
    String url = Api.baseUrl + ApiEndPoints.transactionHistory + "/$id";

    final response = await apiUtils.get(url: url);

    List<TransactionResponseModel> res = List<TransactionResponseModel>.from(
        response.data.map((x) => TransactionResponseModel.fromMap(x)));

    return res;
  }

  Future<SavingAccountModel> getSavingBalance(String id) async {
    String url = Api.baseUrl + ApiEndPoints.savingAccount + "/$id";

    final response = await apiUtils.get(url: url);

    return SavingAccountModel.fromMap(response.data);
  }

  requestReFund(RefundResponseModel data) async {
    String url = Api.baseUrl + ApiEndPoints.requestRefund;

    final response = await apiUtils.post(url: url, data: data.toMap());
    return response.data;
  }

  Future<List<RefundModel>> getReqRefund() async {
    String url = Api.baseUrl + ApiEndPoints.getReqRefund;

    final response = await apiUtils.get(url: url);
    List<RefundModel> result = List<RefundModel>.from(response.data.map(
      (res) => RefundModel.fromMap(res),
    ));

    return result;
  }

  // requestReFundApproval(RefundRequestApprovedModel data) async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     MessageHandler().displayMessage(
  //         msg: apiUtils.getNetworkError(), title: "Network Error");
  //   }

  //   String url = Api.baseUrl + ApiEndPoints.requestApprove;

  //   final response = await apiUtils.post(url: url, data: data.toMap());
  //   return response.data;
  // }
}
