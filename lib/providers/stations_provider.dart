import 'package:dart_radio/models/genre.dart';
import 'package:dart_radio/models/station.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StationsProvider with ChangeNotifier {
  List<Station> _stations;
  List<Station> _favoriteStations;
  List<Genre> _genres;
  String _baseUrl;
  String _stationUrl;
  String _genreUrl;

  StationsProvider() {
    _baseUrl = 'https://api.laut.fm/';
    _stationUrl = 'stations';
    _genreUrl = 'genres';
    _stations = [];
    _genres = [];
  }

  Future<void> getStationsFromApi() async {
    final String url = '$_baseUrl$_stationUrl';

    try {
      final response = await http.get(url);
      final extractedJson = json.decode(response.body) as List<dynamic>;
      if (extractedJson == null) {
        throw Error();
      }

      extractedJson.forEach((element) {
        final station = Station.fromJson(element);
        _stations.add(station);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getGenresFromApi() async {}

  get stations {
    return _stations;
  }

  get favoriteStations {
    return _favoriteStations;
  }

  get genres {
    return _genres;
  }
}
