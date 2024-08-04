class Address {
  late String street;
  late String city;
  late String state;
  late String zipCode;

  Address();

  Address fromJson(Map<String, dynamic> data) {
    street = data['street'] ?? '';
    city = data['city'] ?? '';
    state = data['state'] ?? '';
    zipCode = data['zipCode'] ?? '';
    return this;
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }
}
