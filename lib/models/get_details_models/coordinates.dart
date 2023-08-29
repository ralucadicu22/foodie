class CustomCoordinates {
  final double latitude;
  final double longitude;
  CustomCoordinates({required this.latitude, required this.longitude});
  static CustomCoordinates fromJson(Map<String, dynamic> json) {
    return CustomCoordinates(
        latitude: json['latitude'] ?? 0.0, longitude: json['longitude'] ?? 0.0);
  }

  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}
