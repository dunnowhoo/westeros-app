import 'package:flutter/material.dart';
import 'package:westeros/models/episode_model.dart';
import 'package:westeros/services/tmdb_service.dart';
import 'package:westeros/widgets/episode_card.dart';
import 'package:westeros/screens/detail_episode.dart';

class CategoryEpisodeScreen extends StatefulWidget {
  final String category;

  const CategoryEpisodeScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryEpisodeScreen> createState() => _CategoryEpisodeScreenState();
}

class _CategoryEpisodeScreenState extends State<CategoryEpisodeScreen> {
  final TMDBService _tmdbService = TMDBService();
  List<EpisodeDetail> episodes = [];
  bool isLoading = true;

@override
  void initState() {
    super.initState();
      final seasonNum = int.tryParse(widget.category.split(" ")[1]) ?? 1;
      fetchEpisodesForSeason(seasonNum).then((fetchedEpisodes) {
        setState(() {
          episodes = fetchedEpisodes;
          isLoading = false;
        });
      });

  }

Future<List<EpisodeDetail>> fetchEpisodesForSeason(int season) async {
    final data = await _tmdbService.getSeasonEpisodes(season);
    final episodesJson = data['episodes'] as List;
    return episodesJson.map((json) => EpisodeDetail.fromJson(json)).toList();
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true, 
        title: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 8.0), 
          child: Image.asset(
            "assets/images/${widget.category.toLowerCase().replaceAll(' ', '')}.png",
            width: 180, 
            height: 60,
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : episodes.isEmpty
              ? const Center(
                  child: Text(
                    "No episodes found",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ListView.separated(
                    itemCount: episodes.length,
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.white24),
                    itemBuilder: (context, index) {
                      final episode = episodes[index];
                      return EpisodeCard(
                        episode: episode,
                        onTap: () async {
                          final seasonNum = episode.seasonNumber;
                          final epNum = episode.episodeNumber;
                          try {
                            final detail = await _tmdbService.getEpisodeDetail(
                                seasonNum, epNum);
                            final images = await _tmdbService.getEpisodeImages(
                                seasonNum, epNum);

                            final EpisodeDetail detailObj = EpisodeDetail(
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

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EpisodeDetailScreen(
                                    episodeDetail: detailObj),
                              ),
                            );
                          } catch (e) {
                            print("Error fetching episode detail: $e");
                          }
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
