class loadapi {
  String? name;
  String? country;
  String? favicon;
  String? url_resolved;

  loadapi({
    required this.name,
    required this.country,
    required this.favicon,
    this.url_resolved,
  });

  factory loadapi.fromJson(Map<String, dynamic> json) {
    return loadapi(
      name: json['name'],
      country: json['country'],
      favicon: json['favicon'],
    );
  }
}

class AudioList {
  String? uri;
  AudioList({
    this.uri,
  });
}
