class GuestStar {
  final String character;
  final int gender;
  final int id;
  final String name;
  final String originalName;
  final String profilePath;

  GuestStar({
    required this.character,
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.profilePath,
  });

  factory GuestStar.fromJson(Map<String, dynamic> json) {
    return GuestStar(
      character: json['character'] ?? '',
      gender: json['gender'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      profilePath: json['profile_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character': character,
      'gender': gender,
      'id': id,
      'name': name,
      'original_name': originalName,
      'profile_path': profilePath,
    };
  }
}
