class UserLogin {
  UserLogin({
    required this.fullName,
    required this.phone,
    required this.city,
    required this.email,
  });

  String fullName;
  String phone;
  String city;
  String email;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
      fullName: json["full_name"],
      phone: json["phone"],
      city: json["city"],
      email: json["email"]);

  Map<String, dynamic> toJson() =>
      {"full_name": fullName, "phone": phone, "city": city, "email": email};

  String? get getFullName => this.fullName;
  String? get getPhone => this.phone;
  String? get getCity => this.city;
  String? get getEmail => this.email;
}
