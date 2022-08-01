import 'package:equb/api/api.dart';
import 'package:equb/api/apiEndPoint.dart';
import 'package:equb/api/apiHelper.dart';
import 'package:equb/user/domain/models/dropTicketModel.dart';
import 'package:equb/user/domain/models/ticketModel.dart';
import 'package:equb/user/domain/models/updateTicktModel.dart';

class TicketRepo {
  dropTicket(DropTicketModel data) async {
    String url = Api.Customeurl + ApiEndPoints.createDropTickets;
    try {
      final response = await apiUtils.post(url: url, data: data.toMap());
      return response.data;
    } catch (e) {
      return apiUtils.handleError(e);
    }
  }

  dropTicketForClint(DropTicketModel data) async {
    try {
      String url = Api.Customeurl + ApiEndPoints.dropTicketForClient;

      final response = await apiUtils.post(url: url, data: data.toMap());

      return response.data;
    } catch (e) {
      return apiUtils.handleError(e);
    }
  }

  updateTicket(UpdateTicketModel data) async {
    try {
      String url = Api.Customeurl + ApiEndPoints.updateTicketDate;

      final response = await apiUtils.post(url: url, data: data.toJson());

      return response.data;
    } catch (e) {
      return apiUtils.handleError(e);
    }
  }

  Future<List<TicketModel>> getMyLotto(String id) async {
    String url = Api.Customeurl + ApiEndPoints.getCreatedTickets + id;

    final response = await apiUtils.get(url: url);

    List<TicketModel> res = List<TicketModel>.from(
        response.data.map((x) => TicketModel.fromMap(x)));

    return res;
  }
}
