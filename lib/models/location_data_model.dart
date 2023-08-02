class LocationData {
  late String address1;
  LocationData({required this.address1});
  LocationData.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'] ?? '';
  }
}
