import 'package:flutter/material.dart';
import 'package:movie_world/providers/movie_provider.dart';
import 'package:movie_world/widgets/card_swiper.dart';
import 'package:movie_world/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie World'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Main cards
            CardSwiper(movies: movieProvider.onDisplayMovies),

            // horizontal card slider
            MovieSlider(
                popularMovies: movieProvider.popularMovies, title: 'Populares'),
          ],
        ),
      ),
    );
  }
}
