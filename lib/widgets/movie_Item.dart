import 'package:fit_movies_app/data/network/dio_api_client.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';
import 'package:fit_movies_app/navigations/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieItem extends StatelessWidget {
  final Result movie;

  const MovieItem({super.key, required this.movie});

  static final DateFormat formatter = DateFormat("dd MMMM yyyy");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context,
            NavigationRoutes.movieDetail.name,
            arguments: movie.id
        );
      },
      child: Card(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                    tag: movie.id,
                    child: Image.network(
                      '$imageUrl${movie.posterPath}',
                      fit: BoxFit.fill,
                      color: Colors.black.withValues(alpha: 100),
                      colorBlendMode: BlendMode.darken,
                    )
                )
            ),
            Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                        formatter.format(movie.releaseDate),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: Colors.white70)
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}