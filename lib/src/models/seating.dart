class Seating {
  Seating({
    this.number,
    this.type,
    this.status,
  });

  int? number;
  String? type;
  String? status;

  factory Seating.fromJson(Map<String, dynamic> json) => Seating(
        number: json["number"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "type": type,
        "status": status,
      };
}
