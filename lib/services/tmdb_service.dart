import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tmdb_config.dart'; 
import '../models/episode_model.dart'; 
import '../models/episode_images_model.dart';


class TMDBService {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<EpisodeDetail> getEpisodeDetail(int season, int episodeNumber) async {
    final url =
        '$baseUrl/tv/$tvSeriesId/season/$season/episode/$episodeNumber?api_key=$tmdbApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EpisodeDetail.fromJson(data);
    } else {
      throw Exception('Failed to load episode details');
    }
  }
  
  Future<EpisodeImages> getEpisodeImages(int season, int episodeNumber) async {
    final url =
        '$baseUrl/tv/$tvSeriesId/season/$season/episode/$episodeNumber/images?api_key=$tmdbApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EpisodeImages.fromJson(data);
    } else {
      throw Exception('Failed to load episode images');
    }
  }

  Future<Map<String, dynamic>> getSeasonEpisodes(int season) async {
    final url = '$baseUrl/tv/$tvSeriesId/season/$season?api_key=$tmdbApiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load season $season episodes');
    }
  }

  Future<List<EpisodeDetail>> fetchEpisodesForSeason(int season) async {
    final data = await getSeasonEpisodes(season);
    final episodesJson = data['episodes'] as List;
    return episodesJson.map((json) => EpisodeDetail.fromJson(json)).toList();
  }

  Future<List<EpisodeDetail>> fetchAllEpisodes() async {
    List<EpisodeDetail> allEpisodes = [];
    for (int season = 1; season <= 8; season++) {
      final seasonEpisodes = await fetchEpisodesForSeason(season);
      allEpisodes.addAll(seasonEpisodes);
    }
    return allEpisodes;
  }

  Future<List<EpisodeDetail>> getNewestEpisodesAll() async {
    List<EpisodeDetail> episodes = await fetchAllEpisodes();
    episodes.sort((a, b) =>
        DateTime.parse(b.airDate).compareTo(DateTime.parse(a.airDate)));
    return episodes;
  }

  Future<List<EpisodeDetail>> getPopularEpisodesAll() async {
    List<EpisodeDetail> episodes = await fetchAllEpisodes();
    episodes.sort((a, b) => (b.voteAverage).compareTo(a.voteAverage));
    return episodes;
  }

}
