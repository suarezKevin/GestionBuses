import 'package:mobil_app_bus/src/models/seating.dart';

class BusFrecuencies {
  BusFrecuencies({
    this.idBus,
    this.cooperativeName,
    this.image,
    this.origin,
    this.destiny,
    this.price,
    this.vipPrice,
    this.type,
    this.brand,
    this.model,
    this.plate,
    this.chassis,
    this.minutes,
    this.hours,
    this.departureTime,
    this.busNumber,
    this.stops,
    this.seating,
  });

  String? idBus;
  String? cooperativeName;
  String? image;
  String? origin;
  String? destiny;
  double? price;
  double? vipPrice;
  String? type;
  String? brand;
  String? model;
  String? plate;
  String? chassis;
  int? minutes;
  int? hours;
  String? departureTime;
  int? busNumber;
  List<dynamic>? stops;
  List<Seating>? seating;

  factory BusFrecuencies.fromJson(Map<String, dynamic> json) => BusFrecuencies(
        idBus: json["id_bus"],
        cooperativeName: json["cooperative_name"],
        image: json["image"],
        origin: json["origin"],
        destiny: json["destiny"],
        price: json["price"]?.toDouble(),
        vipPrice: json["vip_price"]?.toDouble(),
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        plate: json["plate"],
        chassis: json["chassis"],
        minutes: json["minutes"],
        hours: json["hours"],
        departureTime: json["departureTime"],
        busNumber: json["busNumber"],
        stops: List<String>.from(json["stops"].map((x) => x)),
        seating:
            List<Seating>.from(json["seating"].map((x) => Seating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_bus": idBus,
        "cooperative_name": cooperativeName,
        "image": image,
        "origin": origin,
        "destiny": destiny,
        "price": price,
        "vip_price": vipPrice,
        "type": type,
        "brand": brand,
        "model": model,
        "plate": plate,
        "chassis": chassis,
        "minutes": minutes,
        "hours": hours,
        "departureTime": departureTime,
        "busNumber": busNumber,
        "stops": List<dynamic>.from(stops!.map((x) => x)),
        "seating": List<dynamic>.from(seating!.map((x) => x.toJson())),
      };
}
