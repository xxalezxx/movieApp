import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> movies;

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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network('http://via.placeholder.com/350x150',
                      fit: BoxFit.fill),
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
