import 'package:flutter/material.dart';
import 'package:westeros/models/episode_model.dart'; // Pastikan EpisodeDetail sudah didefinisikan
import 'package:hive/hive.dart';
import 'package:westeros/widgets/episode_card.dart';
import 'package:westeros/screens/detail_episode.dart';
import 'package:westeros/services/tmdb_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TMDBService _tmdbService = TMDBService();
  List<EpisodeDetail> favoriteEpisodes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteEpisodes();
  }

Map<String, dynamic> deepCast(Map<dynamic, dynamic> map) {
    return map.map((key, value) {
      if (value is Map) {
        return MapEntry(
            key.toString(), deepCast(value as Map<dynamic, dynamic>));
      } else if (value is List) {
        return MapEntry(
            key.toString(),
            value.map((e) {
              if (e is Map) {
                return deepCast(e as Map<dynamic, dynamic>);
              }
              return e;
            }).toList());
      }
      return MapEntry(key.toString(), value);
    });
  }

Future<EpisodeDetail> _fetchCompleteDetail(EpisodeDetail episode) async {
    final seasonNum = episode.seasonNumber;
    final epNum = episode.episodeNumber;
    final detail = await _tmdbService.getEpisodeDetail(seasonNum, epNum);
    final images = await _tmdbService.getEpisodeImages(seasonNum, epNum);
    return EpisodeDetail(
      name: detail.name,
      overview: detail.overview,
      runtime: detail.runtime,
      seasonNumber: detail.seasonNumber,
      stillPath: detail.stillPath,
      voteAverage: detail.voteAverage,
      id: detail.id,
      airDate: detail.airDate,
      episodeNumber: detail.episodeNumber,
      guestStars: detail.guestStars,
      images: images,
    );
  }


Future<void> fetchFavoriteEpisodes() async {
    final box = await Hive.openBox('favorites');
    setState(() {
      favoriteEpisodes =
          box.values.where((value) => value is Map).map((jsonData) {
        final castedData = deepCast(jsonData as Map<dynamic, dynamic>);
        return EpisodeDetail.fromJson(castedData);
      }).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favoriteEpisodes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/got_logo.png",
                         width: 300,
                        height: 120, 
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Belum ada favorit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top : 100),
                      child: Center(
                        child: Image.asset(
                          "assets/images/favorite.png",
                          width: 200, 
                          height: 70, 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  Expanded(
                      child: ListView.separated(
                        itemCount: favoriteEpisodes.length,
                        separatorBuilder: (context, index) =>
                            const Divider(color: Colors.white24),
                        itemBuilder: (context, index) {
                          final episode = favoriteEpisodes[index];
                          return FutureBuilder<EpisodeDetail>(
                            future: episode.stillPath.isEmpty
                                ? _fetchCompleteDetail(episode)
                                : Future.value(episode),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.error,
                                      color: Colors.white),
                                );
                              }
                              final completeEpisode = snapshot.data!;
                              return EpisodeCard(
                                episode: completeEpisode,
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EpisodeDetailScreen(
                                          episodeDetail: completeEpisode),
                                    ),
                                  );
                                  if (result == true) {
                                    fetchFavoriteEpisodes();
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),

                  ],
              ),
    );
  }
}
