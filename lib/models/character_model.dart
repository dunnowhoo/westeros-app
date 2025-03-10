class Character {
  final String url;
  final String name;
  final List<String> titles;
  final List<String> allegiances;
  final List<String> tvSeries;
  final List<String> playedBy;

  Character({
    required this.url,
    required this.name,
    required this.titles,
    required this.allegiances,
    required this.tvSeries,
    required this.playedBy,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      titles: (json['titles'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      allegiances: (json['allegiances'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      tvSeries: (json['tvSeries'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      playedBy: (json['playedBy'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'titles': titles,
      'allegiances': allegiances,
      'tvSeries': tvSeries,
      'playedBy': playedBy,
    };
  }
}
