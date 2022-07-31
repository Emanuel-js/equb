import 'package:equb/admin/domain/models/refund/refundRequestModel.dart';
import 'package:equb/admin/domain/models/savingAccount/savingAccountModel.dart';
import 'package:equb/admin/domain/models/wallet/walletModel.dart';
import 'package:equb/commen/models/userMode.dart';

class RefundModel {
  RefundResponseModel? refundForm;
  WalletModel? wallet;
  SavingAccountModel? accumulatedBalance;
  UserModel? userProfile;
  RefundModel({
    this.refundForm,
    this.wallet,
    this.accumulatedBalance,
    this.userProfile,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refundForm': refundForm?.toMap(),
      'wallet': wallet?.toMap(),
      'accumulatedBalance': accumulatedBalance?.toMap(),
      'userProfile': userProfile?.toMap(),
    };
  }

  RefundModel.fromMap(Map<String, dynamic> map) {
    refundForm = RefundResponseModel.fromMap(map['refundForm']);
    wallet = WalletModel.fromMap(map['wallet']);

    accumulatedBalance = SavingAccountModel.fromMap(map['accumulatedBalance']);

    userProfile = UserModel.fromMap(map['userProfile']);
  }
}
