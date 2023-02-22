


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{

    String _apiKey      = 'b4b44333678b34388f28450ef0799dbc';
    String _baseUrl     = 'api.themoviedb.org';
    String _languaje    = 'es-ES';

    List<Movie> onDisplayMovies = [];
    List<Movie> popularMovies   = [];

    Map<int, List<Cast>> movieCast = {};

    int _popularPage = 0;

    MoviesProvider(){
        this.getOnDisplayMovies();
        this.getPopularMovies();
    }

    Future<String> _getJsonData(String endpoint, [int page = 1]) async{
        var url =
        Uri.https(_baseUrl, endpoint, {
            'api_key': _apiKey,
            'languaje': _languaje,
            'page': '$page'
        });

        // Await the http get response, then decode the json-formatted response.
        final response = await http.get(url);
        return response.body;
    }

    getOnDisplayMovies() async {
        final jsonData = await this._getJsonData('3/movie/now_playing');
        
        final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

        //print(nowPlayingResponse.results[0].title);
        onDisplayMovies = nowPlayingResponse.results;

        notifyListeners();
    }

    getPopularMovies() async {
        _popularPage++;
        
        final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
        final popularResponse = PopularResponse.fromJson(jsonData); 

        //print(nowPlayingResponse.results[0].title);
        popularMovies = [ ...popularMovies, ...popularResponse.results ];

        notifyListeners();
    }

    Future<List<Cast>> getMovieCast( int movieId ) async {
        //TODO: revisar el mapa
        print('pidiendo info al servidor - Cast');
        final jsonData = await this._getJsonData('3/movie/$movieId/credits');
        final creditsResponse = CreditsResponse.fromJson(jsonData);

        movieCast[movieId] = creditsResponse.cast;
        return creditsResponse.cast;
    }

}