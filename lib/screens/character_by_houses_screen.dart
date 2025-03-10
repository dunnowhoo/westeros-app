import 'package:flutter/material.dart';
import 'package:westeros/models/house_model.dart';
import 'package:westeros/models/character_model.dart';
import 'package:westeros/services/an_api_of_ice_and_fire.dart';

class CharacterByHouseScreen extends StatefulWidget {
  final House house;

  const CharacterByHouseScreen({Key? key, required this.house})
      : super(key: key);

  @override
  State<CharacterByHouseScreen> createState() => _CharacterByHouseScreenState();
}

class _CharacterByHouseScreenState extends State<CharacterByHouseScreen> {
  final IceAndFireService _iceAndFireService = IceAndFireService();
  List<Character> characters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    List<Character> fetchedCharacters = [];
    for (String url in widget.house.swornMembers) {
      // URL format: "https://anapioficeandfire.com/api/characters/583"
      final segments = url.split('/');
      final idStr = segments.last;
      final id = int.tryParse(idStr);
      if (id != null) {
        try {
          final character = await _iceAndFireService.fetchCharacter(id);
          fetchedCharacters.add(character);
        } catch (e) {
          print("Error fetching character with id $id: $e");
        }
      }
    }
    if (mounted) {
      setState(() {
        characters = fetchedCharacters;
        isLoading = false;
      });
    }
  }

  String getSigilName() {
    final parts = widget.house.name.split(" ");
    if (parts.length >= 2) {
      return parts[1].toLowerCase();
    } else {
      return widget.house.name.toLowerCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.house.name,
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/sigil-${getSigilName()}.webp",
                      width: 250,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      widget.house.words.isNotEmpty
                          ? widget.house.words
                          : "No words available",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  characters.isEmpty
                      ? const Text(
                          "No sworn members found",
                          style: TextStyle(color: Colors.white),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: characters.length,
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.white24),
                          itemBuilder: (context, index) {
                            final character = characters[index];
                            return Card(
                              color: const Color(0xFF1B1B1B),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[800],
                                  child: Text(
                                    character.name.isNotEmpty
                                        ? character.name[0]
                                        : "?",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(
                                  character.name.isNotEmpty
                                      ? character.name
                                      : "Unknown",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Titles: " +
                                          (character.titles.isNotEmpty
                                              ? character.titles.join(", ")
                                              : "N/A"),
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Featured: " +
                                          (character.tvSeries.isNotEmpty
                                              ? character.tvSeries.join(", ")
                                              : "N/A"),
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Played by: " +
                                          (character.playedBy.isNotEmpty
                                              ? character.playedBy.join(", ")
                                              : "N/A"),
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
