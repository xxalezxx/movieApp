import 'package:flutter/material.dart';

import 'package:movie_app/src/models/movies_model.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _titlePost(context, movie),
              _descriptionMovie(movie),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/loadings/spinner.gif '),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titlePost(BuildContext context, Movie movie) {
    return Container(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descriptionMovie(Movie movie) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
        ));
  }
}
