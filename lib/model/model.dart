class loadapi {
  String? name;
  String? country;

  loadapi({
    required this.name,
    required this.country,
  });

  factory loadapi.fromJson(Map<String, dynamic> json) {
    return loadapi(
      name: json['name'],
      country: json['country'],
    );
  }
}
