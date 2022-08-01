class UpdateTicketModel {
  int? id;
  int? userId;
  String? ticketNumber;
  String? updatedDropDate;

  UpdateTicketModel(
      {this.id, this.userId, this.ticketNumber, this.updatedDropDate});
  factory UpdateTicketModel.fromJson(Map<String, dynamic> json) =>
      UpdateTicketModel(
        id: json["id"],
        userId: json["userId"],
        ticketNumber: json["ticketNumber"],
        updatedDropDate: json["updatedDropDate"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "ticketNumber": ticketNumber,
        "updatedDropDate": updatedDropDate,
      };
}
