import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_world/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 170,
            child: const CupertinoActivityIndicator(),
          );
        }
        final cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 170,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, int index) => _CastCard()),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/150x300'),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Actors name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
