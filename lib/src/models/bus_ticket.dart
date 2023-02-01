class BusTicket {
  BusTicket({
    this.cooperative,
    this.client_id,
    this.busNumber,
    this.price,
    this.departureTime,
    this.origen,
    this.destiny,
    this.seatings,
  });

  String? cooperative;
  String? client_id;
  int? busNumber;
  double? price;
  String? departureTime;
  String? origen;
  String? destiny;
  List<int>? seatings;

  factory BusTicket.fromJson(Map<String, dynamic> json) => BusTicket(
        cooperative: json["cooperative"],
        client_id: json["client_id"],
        busNumber: json["busNumber"],
        price: json["price"]?.toDouble(),
        departureTime: json["departureTime"],
        origen: json["origen"],
        destiny: json["destiny"],
        seatings: List<int>.from(json["seatings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cooperative": cooperative,
        "client_id": client_id,
        "busNumber": busNumber,
        "price": price,
        "departureTime": departureTime,
        "origen": origen,
        "destiny": destiny,
        "seatings": List<dynamic>.from(seatings!.map((x) => x)),
      };
}
