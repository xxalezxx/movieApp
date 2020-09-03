import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movies_model.dart';
import 'package:movie_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final movieProvider = new MovieProvider();

  final movies = [
    'Spider-man',
    'Aqua-man',
    'Batman',
    'Capitan America',
  ];

  final recentsMovies = [
    'Spider-man',
    'Iron-man',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions of the appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon on the left of the search
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //  Create the results shown
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//  Suggestions happend when someone write
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
              children: snapshot.data.map((e) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(e.getPosterImg()),
                placeholder: AssetImage('assets/loadings/spinner.gif'),
                width: 50.0,
                fit: BoxFit.cover,
              ),
              title: Text(e.title),
              subtitle: Text(e.originalTitle),
              onTap: () {
                close(context, null);
                e.uniqueId = "";
                Navigator.pushNamed(context, 'details', arguments: e);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
