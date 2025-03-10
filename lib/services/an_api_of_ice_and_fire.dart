import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:westeros/models/house_model.dart';
import 'package:westeros/models/character_model.dart';

class IceAndFireService {
  static const String baseUrl = "https://anapioficeandfire.com/api";

  Future<House> fetchHouse(int index) async {
    final url = "$baseUrl/houses/$index";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return House.fromJson(jsonData);
    } else {
      throw Exception("Failed to load house with index $index");
    }
  }
  Future<Character> fetchCharacter(int index) async {
    final url = "$baseUrl/characters/$index";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Character.fromJson(jsonData);
    } else {
      throw Exception("Failed to load character with index $index");
    }
  }
}
