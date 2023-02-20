


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

    String _apiKey      = 'b4b44333678b34388f28450ef0799dbc';
    String _baseUrl     = 'api.themoviedb.org';
    String _languaje    = 'es-ES';

    MoviesProvider(){
        print('MoviesProvider inicializado');
        this.getOnDisplayMovies();
    }

    getOnDisplayMovies() async {
        var url =
        Uri.https(_baseUrl, '3/movie/now_playing', {
            'api_key': _apiKey,
            'languaje': _languaje,
            'page': '1'
        });

        // Await the http get response, then decode the json-formatted response.
        final response = await http.get(url);
        final Map<String, dynamic> decodeData = json.decode(response.body);

        print(decodeData);
    }

}