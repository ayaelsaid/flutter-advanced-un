import 'dart:convert';
import 'package:bloc_filejson_un/models/person.dart';
import 'package:flutter/services.dart';

class PersonRepository {
  Future<List<Person>?> getPersons() async {
    try {
      final result = await rootBundle.loadString('assets/data.json');
      print('JSON file content: $result');
      final List<dynamic> personData = json.decode(result);
      return personData.map((json) => Person().fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }
}



// class PlaylistRepostory {
//   Future<List<Artist>?> getPlaylists() async {
//     try {
//       var result = rootBundle.loadString('assets/file_json/data.json');
//       var playlist = json.decode(result as String);
//       return List<Artist>.from(
//           playlist.map((json) => Artist.fromJson(json)).toList());
//     } catch (e) {
//       return null;
//     }
//   }
// }
