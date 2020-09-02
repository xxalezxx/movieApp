import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 300.0,
        child: Swiper(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Image.network('http://via.placeholder.com/350x150',
                fit: BoxFit.fill);
          },
          // Only to see tree points like there are more images
          pagination: SwiperPagination(),
          // This is only to see arrows left and right
          control: SwiperControl(),
          // The animation of how the images move
          layout: SwiperLayout.STACK,
          itemWidth: 200.0,
        ));
  }
}
