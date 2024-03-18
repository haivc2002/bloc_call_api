class loadapi {
  String? name;
  String? country;
  String? favicon;

  loadapi({
    required this.name,
    required this.country,
    required this.favicon,
  });

  factory loadapi.fromJson(Map<String, dynamic> json) {
    return loadapi(
      name: json['name'],
      country: json['country'],
      favicon: json['favicon'],
    );
  }
}
