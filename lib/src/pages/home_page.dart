import 'package:flutter/material.dart';

import 'package:movie_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Movies in the cinema'),
          backgroundColor: Colors.indigoAccent,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        // The SafeArea is to avoid the NOTCH in the newest cell-phones!
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              _swiperTarjets(),
            ],
          ),
        )));
  }

// SWIPER for tarjets.
// Need instalation => pubspec.yaml => dependencies: flutter_swiper
  Widget _swiperTarjets() {
    return CardSwiper(
      movies: [1, 2, 3, 4, 5, 6],
    );
  }
}
