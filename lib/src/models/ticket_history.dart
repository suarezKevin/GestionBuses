import 'package:mobil_app_bus/src/models/seating.dart';

class TicketHistory {
  TicketHistory({
    this.id,
    this.ci,
    this.full_name,
    this.phone,
    this.email,
    this.cooperative,
    this.busNumber,
    this.price,
    this.departureTime,
    this.origen,
    this.destiny,
    this.seatings,
    this.status,
    this.receipt,
    this.qr,
    this.check,
  });

  String? id;
  String? ci;
  String? full_name;
  String? phone;
  String? email;
  String? cooperative;
  int? busNumber;
  double? price;
  String? departureTime;
  String? origen;
  String? destiny;
  List<Seating>? seatings;
  String? status;
  String? receipt;
  String? qr;
  bool? check;

  factory TicketHistory.fromJson(Map<String?, dynamic> json) => TicketHistory(
        id: json["id"],
        ci: json["ci"],
        full_name: json["full_name"],
        phone: json["phone"],
        email: json["email"],
        cooperative: json["cooperative"],
        busNumber: json["busNumber"],
        price: json["price"]?.toDouble(),
        departureTime: json["departureTime"],
        origen: json["origen"],
        destiny: json["destiny"],
        seatings: List<Seating>.from(
            json["seatings"].map((x) => Seating.fromJson(x))),
        status: json["status"],
        receipt: json["receipt"],
        qr: json["qr"],
        check: json["check"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "full_name": full_name,
        "phone": phone,
        "email": email,
        "cooperative": cooperative,
        "busNumber": busNumber,
        "price": price,
        "departureTime": departureTime,
        "origen": origen,
        "destiny": destiny,
        "seatings": List<dynamic>.from(seatings!.map((x) => x.toJson())),
        "status": status,
        "receipt": receipt,
        "qr": qr,
        "check": check,
      };
}
