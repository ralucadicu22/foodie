class LocationDataModel {
  late String address1;
  LocationDataModel({required this.address1});
  LocationDataModel.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'] ?? '';
  }
}
