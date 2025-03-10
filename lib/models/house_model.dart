class House {
  final String url;
  final String name;
  final String words;
  final List<String> swornMembers;

  House({
    required this.url,
    required this.name,
    required this.words,
    required this.swornMembers,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      words: json['words'] ?? '',
      swornMembers: (json['swornMembers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'words': words,
      'swornMembers': swornMembers,
    };
  }
}
