class PassengerAccount {
  PassengerAccount({
    this.ci,
    this.fullName,
    this.phone,
    this.city,
    this.email,
    this.password,
  });

  String? ci;
  String? fullName;
  String? phone;
  String? city;
  String? email;
  String? password;

  factory PassengerAccount.fromJson(Map<String, dynamic> json) =>
      PassengerAccount(
        ci: json["ci"],
        fullName: json["full_name"],
        phone: json["phone"],
        city: json["city"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "ci": ci,
        "full_name": fullName,
        "phone": phone,
        "city": city,
        "email": email,
        "password": password,
      };

  set setCi(String ci) {
    this.ci = ci;
  }

  set setFullName(String full_name) {
    this.fullName = full_name;
  }

  set setPhone(String phone) {
    this.phone = phone;
  }

  set setCity(String city) {
    this.city = city;
  }

  set setEmail(String email) {
    this.email = email;
  }

  set setPassword(String password) {
    this.password = password;
  }

  String? get getPassword => this.password;
}
