import 'package:flutter/material.dart';
import 'package:westeros/models/episode_model.dart';
import 'package:westeros/models/episode_images_model.dart';
import 'package:hive/hive.dart';

class EpisodeDetailScreen extends StatefulWidget {
  final EpisodeDetail episodeDetail;

  const EpisodeDetailScreen({Key? key, required this.episodeDetail})
      : super(key: key);

  @override
  State<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  late PageController _pageController;
  int _currentImageIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    checkFavoriteStatus();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> checkFavoriteStatus() async {
    final box = await Hive.openBox('favorites');
    setState(() {
      isFavorite = box.containsKey(widget.episodeDetail.id);
    });
  }

Future<void> toggleFavorite() async {
    final box = await Hive.openBox('favorites');
    final episodeId = widget.episodeDetail.id;
    if (box.containsKey(episodeId)) {
      await box.delete(episodeId);
      setState(() => isFavorite = false);
      Navigator.pop(context, true);
    } else {
      await box.put(episodeId, widget.episodeDetail.toJson());
      setState(() => isFavorite = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final episode = widget.episodeDetail;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), 
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Carousel Foto Episode
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount:
                        episode.images.stills.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final Still still = episode.images.stills[index];
                      return Image.network(
                        "https://image.tmdb.org/t/p/w500${still.filePath}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),

                  // Indikator Carousel
                  Positioned(
                    bottom: 8,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          episode.images.stills.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == entry.key
                                ? Colors.white
                                : Colors.white24,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Tombol Favorite
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: toggleFavorite,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black54,
                        child: Icon(
                          isFavorite ? Icons.bookmark_add : Icons.bookmark_border,
                          color: isFavorite ? Colors.yellow : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Judul + Info Episode
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "S${episode.seasonNumber} E${episode.episodeNumber}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      episode.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            /// Rating, Durasi, dan Air Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// RATING
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        final double halfStars = episode.voteAverage / 2;
                        final int filledStars = halfStars.floor();
                        return Icon(
                          index < filledStars ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 25,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        "${episode.voteAverage.toStringAsFixed(2)}/10",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  /// DURASI 
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${episode.runtime}m",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  /// AIR DATE 
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        episode.airDate,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                episode.overview,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),

            const SizedBox(height: 16),

            /// Guest Stars (Crew)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Guest Stars",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Daftar Guest Stars Horizontal
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: episode.guestStars.length,
                separatorBuilder: (context, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final guest = episode.guestStars[index];
                  return SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${guest.profilePath}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey,
                                child: const Icon(Icons.person,
                                    color: Colors.white),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          guest.originalName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          guest.character,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
