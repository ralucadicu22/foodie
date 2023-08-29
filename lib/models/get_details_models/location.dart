class CLocation {
  final String address1;
  final String city;
  final String country;
  final String state;
  CLocation(
      {required this.address1,
      required this.city,
      required this.country,
      required this.state});
  static CLocation fromJson(Map<String, dynamic> json) {
    return CLocation(
        address1: json['address1'] ?? '',
        city: json['city'] ?? '',
        country: json['country'] ?? '',
        state: json['state'] ?? '');
  }

  Map<String, dynamic> toJson() =>
      {'address1': address1, 'city': city, 'country': country, 'state': state};
}
