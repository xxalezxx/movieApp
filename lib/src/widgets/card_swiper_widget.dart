import 'package:flutter/material.dart';

import 'package:movie_app/src/models/movies_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        child: Container(
            padding: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: 300.0,
            child: Swiper(
              itemWidth: _screenSize.width * 0.7,
              itemHeight: _screenSize.height * 0.5,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                movies[index].uniqueId = '${movies[index].id}-card';

                return Hero(
                  tag: movies[index].uniqueId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'details',
                            arguments: movies[index]);
                      },
                      child: FadeInImage(
                          placeholder:
                              AssetImage('assets/loadings/spinner.gif'),
                          image: NetworkImage(movies[index].getPosterImg()),
                          fit: BoxFit.cover),
                    ),
                  ),
                );
              },
              // Only to see tree points like there are more images
              pagination: SwiperPagination(),
              // This is only to see arrows left and right
              control: SwiperControl(),
              // The animation of how the images move
              layout: SwiperLayout.STACK,
            )));
  }
}
