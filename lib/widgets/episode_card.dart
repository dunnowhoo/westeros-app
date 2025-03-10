import 'package:flutter/material.dart';
import 'package:westeros/models/episode_model.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeDetail episode;
  final VoidCallback onTap;

  const EpisodeCard({
    Key? key,
    required this.episode,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300, 
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${episode.stillPath}",
                height: 180, 
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    height: 180,
                    width: double.infinity,
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              episode.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // Container untuk Season/Episode
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
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
                // Rating
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  episode.voteAverage.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(width: 8),
                // Air Date
                Text(
                  episode.airDate,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Overview singkat
            Text(
              episode.overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
