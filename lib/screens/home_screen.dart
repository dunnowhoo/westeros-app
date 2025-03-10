import 'package:flutter/material.dart';
import 'package:westeros/models/episode_model.dart'; // Model EpisodeDetail misalnya
import 'package:westeros/services/tmdb_service.dart';
import 'package:westeros/screens/detail_episode.dart';
import 'package:westeros/screens/category_episode_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = [
    "Season 1",
    "Season 2",
    "Season 3",
    "Season 4",
    "Season 5",
    "Season 6",
    "Season 7",
    "Season 8",
  ];

  final TMDBService _tmdbService = TMDBService();

  List<EpisodeDetail> newestEpisodes = [];
  List<EpisodeDetail> popularEpisodes = [];
  bool isLoadingNewest = true;
  bool isLoadingPopular = true;

  @override
  void initState() {
    super.initState();
    fetchNewestEpisodes();
    fetchPopularEpisodes();
  }

  Future<void> fetchNewestEpisodes() async {
    try {
      final episodesData = await _tmdbService.getNewestEpisodesAll();
      setState(() {
        newestEpisodes = episodesData;
        isLoadingNewest = false;
      });
    } catch (e) {
      print("Error fetching newest episodes: $e");
      setState(() {
        isLoadingNewest = false;
      });
    }
  }

  Future<void> fetchPopularEpisodes() async {
    try {
      final episodesData = await _tmdbService.getPopularEpisodesAll();
      setState(() {
        popularEpisodes = episodesData;
        isLoadingPopular = false;
      });
    } catch (e) {
      print("Error fetching popular episodes: $e");
      setState(() {
        isLoadingPopular = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/got_logo.png",
                  width: 300,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Valar Morghulis 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Embrace the epic saga of Westeros",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Avatar
                ],
              ),
              const SizedBox(height: 20),

              /// Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1B1B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white70),
                    hintText: "Search episodes...",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              /// Kategori (Horizontal List)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryEpisodeScreen(
                                category: categories[index]),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1B1B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              /// Newest Episodes Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Newest Episodes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 180,
                child: isLoadingNewest
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: newestEpisodes.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final episode = newestEpisodes[index];
                          return GestureDetector(
                            onTap: () async {
                              final seasonNum = episode.seasonNumber;
                              final epNum = episode.episodeNumber;

                              try {
                                final detail = await _tmdbService
                                    .getEpisodeDetail(seasonNum, epNum);
                                final images = await _tmdbService
                                    .getEpisodeImages(seasonNum, epNum);

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
                                  images:images,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${episode.stillPath}",
                                    width: 226,
                                    height: 128,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 226,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          episode.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        episode.airDate,
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 1),

              /// Most Popular Episodes Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Most Popular Episodes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: isLoadingPopular
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: popularEpisodes.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final episode = popularEpisodes[index];
                          return GestureDetector(
                            onTap: () async {
                              final seasonNum = episode.seasonNumber;
                              final epNum = episode.episodeNumber;

                              try {
                                final detail = await _tmdbService
                                    .getEpisodeDetail(seasonNum, epNum);
                                final images = await _tmdbService
                                    .getEpisodeImages(seasonNum, epNum);

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Poster Episode
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${episode.stillPath}",
                                    width: 226,
                                    height: 128,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 226,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Judul Episode
                                      Expanded(
                                        child: Text(
                                          episode.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Icon Bintang dan Rating
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            episode.voteAverage.toStringAsFixed(2),
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
