class Hours {
  final List<OpenHours> open;
  Hours({required this.open});
  static Hours fromJson(Map<String, dynamic> json) {
    return Hours(
        open: (json['open'] as List)
            .map((openJson) => OpenHours.fromJson(openJson))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'open': open,
      };
}

class OpenHours {
  final String start;
  final String end;
  OpenHours({required this.start, required this.end});
  static OpenHours fromJson(Map<String, dynamic> json) {
    return OpenHours(
      start: json['start'] ?? '',
      end: json['end'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'start': start, 'end': end};
}
