class EpisodeImages {
  final int id;
  final List<Still> stills;

  EpisodeImages({
    required this.id,
    required this.stills,
  });

  factory EpisodeImages.fromJson(Map<String, dynamic> json) {
    var stillsJson = json['stills'] as List? ?? [];
    return EpisodeImages(
      id: json['id'] ?? 0,
      stills: stillsJson.map((e) => Still.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stills': stills.map((e) => e.toJson()).toList(),
    };
  }
}

class Still {
  final double aspectRatio;
  final int height;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  Still({
    required this.aspectRatio,
    required this.height,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory Still.fromJson(Map<String, dynamic> json) {
    return Still(
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 0.0,
      height: json['height'] ?? 0,
      iso6391: json['iso_639_1'], // bisa null
      filePath: json['file_path'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      width: json['width'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aspect_ratio': aspectRatio,
      'height': height,
      'iso_639_1': iso6391,
      'file_path': filePath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'width': width,
    };
  }
}
