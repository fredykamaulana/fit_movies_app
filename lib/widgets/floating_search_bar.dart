import 'package:fit_movies_app/controllers/movie_list_controller/movie_filter.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingSearchBar extends StatefulWidget {
  const FloatingSearchBar({super.key});

  @override
  State<FloatingSearchBar> createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> {

  MovieListController movieListController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Input your desired movie title',
                ),
                onChanged: (text) {
                  movieListController.setSearchQuery(text);
                },
              )
          ),
          IconButton(
            icon: Icon(
                Icons.send,
                color: Colors.cyan
            ),
            onPressed: () {
              if(movieListController.searchQuery.isNotEmpty == true) {
                movieListController.searchMovie(
                    movieListController.searchQuery,
                    movieListController.currentPage
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
                Icons.close,
                color: Colors.cyan
            ),
            onPressed: () {
              movieListController.setIsSearching(false);
              movieListController.setFilter(MovieFilter.nowPlaying);
            },
          ),
        ],
      ),
    );
  }
}