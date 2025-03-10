import 'gueststar_model.dart';
import 'episode_images_model.dart';

class EpisodeDetail {
  final String name;
  final String overview;
  final int runtime;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int id;
  final String airDate;
  final int episodeNumber;
  final List<GuestStar> guestStars;
  final EpisodeImages images;

  EpisodeDetail({
    required this.name,
    required this.overview,
    required this.runtime,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.id,
    required this.airDate,
    required this.episodeNumber,
    required this.guestStars,
    required this.images,
  });

  factory EpisodeDetail.fromJson(Map<String, dynamic> json) {
    var guestStarsJson = json['guest_stars'] as List? ?? [];
    return EpisodeDetail(
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      runtime: json['runtime'] ?? 0,
      seasonNumber: json['season_number'] ?? 0,
      stillPath: json['still_path'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      id: json['id'] ?? 0,
      airDate: json['air_date'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      guestStars: guestStarsJson.map((e) => GuestStar.fromJson(e)).toList(),
      images: EpisodeImages(id: 0, stills: []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'overview': overview,
      'runtime': runtime,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
      'id': id,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'guest_stars': guestStars.map((e) => e.toJson()).toList(),
      'images': images.toJson(), 
    };
  }
}
