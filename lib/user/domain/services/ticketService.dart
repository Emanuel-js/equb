import 'dart:developer';

import 'package:equb/auth/service/authService.dart';
import 'package:equb/commen/screens/widgets/loadingScreen.dart';
import 'package:equb/user/domain/models/dropTicketModel.dart';
import 'package:equb/user/domain/models/ticketModel.dart';
import 'package:equb/user/domain/models/updateTicktModel.dart';
import 'package:equb/user/domain/repository/ticketRepo.dart';
import 'package:equb/utils/messageHander.dart';
import 'package:get/get.dart';

class TicketService extends GetxController {
  final _mylotto = <TicketModel>[].obs;
  final _authService = Get.find<AuthService>();

  final _isLoading = false.obs;

  final _isDrop = false.obs;
  List<TicketModel>? get myLotto => _mylotto;

  bool get isLoading => _isLoading.value;
  bool get isDrop => _isDrop.value;
  set isDrop(val) => _isDrop.value = val;

  void setLoading(bool show) {
    _isLoading.value = show;
    // _isLoading(true);
  }

  void dropTicket(DropTicketModel data, ctx) async {
    LoadingScreen.loading(ctx);
    try {
      final result = await TicketRepo().dropTicket(data);

      if (result != null) {
        MessageHandler().displayMessage(msg: "drop success", title: "Drop");
        _isDrop.value = true;
        getMyTicket(_authService.userInfo!.id.toString());
        LoadingScreen.closeLoading(ctx);
      } else {
        LoadingScreen.closeLoading(ctx);
      }
    } catch (e) {
      LoadingScreen.closeLoading(ctx);
    }
  }

  void dropTicketForClient(DropTicketModel data, ctx) async {
    LoadingScreen.loading(ctx);
    try {
      final result = await TicketRepo().dropTicketForClint(data);
      log(result.toString());
      if (result != null) {
        _isDrop.value = true;
        MessageHandler().displayMessage(msg: "drop success", title: "Drop");
        LoadingScreen.closeLoading(ctx);
      } else {
        LoadingScreen.closeLoading(ctx);
      }
    } catch (e) {
      LoadingScreen.closeLoading(ctx);
    }
  }

  void getMyTicket(String id) async {
    try {
      final result = await TicketRepo().getMyLotto(id);

      _mylotto.value = result;
    } catch (e) {
      log("message$e");
    }
  }

  void updateTicket(UpdateTicketModel data, ctx) async {
    // LoadingScreen.loading(ctx);
    try {
      final result = await TicketRepo().updateTicket(data);

      if (result != null) {
        _isDrop.value = true;
        getMyTicket(data.userId.toString());
        MessageHandler().displayMessage(
            msg: "Ticket Date Updated to ${data.updatedDropDate}",
            title: "Drop");
        // LoadingScreen.closeLoading(ctx);
      } else {
        LoadingScreen.closeLoading(ctx);
      }
    } catch (e) {
      // LoadingScreen.closeLoading(ctx);
    }
  }
}
