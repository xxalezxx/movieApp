import 'package:flutter/material.dart';
import 'package:movie_app/src/widgets/card_swiper_widget.dart';

import 'package:movie_app/src/providers/movies_provider.dart';
import 'package:movie_app/src/search/search_delegate.dart';
import 'package:movie_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getMostPopulars();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Movies'),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        backgroundColor: Colors.white70,
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swiperTarjets(),
              _footer(context),
            ],
          ),
        )));
  }

  Widget _swiperTarjets() {
    return FutureBuilder(
      future: moviesProvider.getOnCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data,
          );
        } else {
          return Container(
              height: 100.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Populars!',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                    movies: snapshot.data,
                    nextPage: moviesProvider.getMostPopulars);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
