import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatelessWidget {

    final List<Movie> movies;

    const CardSwiper({
        super.key, 
        required this.movies
    });

    @override
    Widget build(BuildContext context) {

        final size = MediaQuery.of(context).size;

        return Container(
            width: double.infinity,
            height: size.height * 0.5,
            child: Swiper(
                //itemCount: 10,
                itemCount: movies.length,
                layout: SwiperLayout.STACK,
                itemWidth: size.width * 0.6,
                itemHeight: size.height * 0.4,
                itemBuilder: ( _ , int index) {
                    final movie =  movies[index];
                    print(movie.fullPosterImg);

                    return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                                placeholder: AssetImage('assets/no-image.jpg'), 
                                //image: NetworkImage('https://via.placeholder.com/300x400'),
                                image: NetworkImage(movie.fullPosterImg),
                                fit: BoxFit.cover,
                            ),
                        ),
                    );
                },
            ),
        );
    }
}