import 'dart:convert';

class TransactionModel {
  int? id;
  double? amount;
  String? senderAccount;
  String? receiverAccount;
  String? transactionDate;
  String? transactionType;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  TransactionModel({
    this.id,
    this.amount,
    this.senderAccount,
    this.receiverAccount,
    this.transactionDate,
    this.transactionType,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  TransactionModel copyWith({
    int? id,
    double? amount,
    String? senderAccount,
    String? receiverAccount,
    String? transactionDate,
    String? transactionType,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      senderAccount: senderAccount ?? this.senderAccount,
      receiverAccount: receiverAccount ?? this.receiverAccount,
      transactionDate: transactionDate ?? this.transactionDate,
      transactionType: transactionType ?? this.transactionType,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (senderAccount != null) {
      result.addAll({'senderAccount': senderAccount});
    }
    if (receiverAccount != null) {
      result.addAll({'receiverAccount': receiverAccount});
    }

    return result;
  }

  Map<String, dynamic> toMapTopUp() {
    final result = <String, dynamic>{};

    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (receiverAccount != null) {
      result.addAll({'receiverAccount': receiverAccount});
    }

    return result;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id']?.toInt(),
      amount: map['amount']?.toDouble(),
      senderAccount: map['senderAccount'],
      receiverAccount: map['receiverAccount'],
      transactionDate: map['transactionDate'],
      transactionType: map['transactionType'],
      createdBy: map['createdBy'],
      updatedBy: map['updatedBy'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.amount == amount &&
        other.senderAccount == senderAccount &&
        other.receiverAccount == receiverAccount &&
        other.transactionDate == transactionDate &&
        other.transactionType == transactionType &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        senderAccount.hashCode ^
        receiverAccount.hashCode ^
        transactionDate.hashCode ^
        transactionType.hashCode ^
        createdBy.hashCode ^
        updatedBy.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
