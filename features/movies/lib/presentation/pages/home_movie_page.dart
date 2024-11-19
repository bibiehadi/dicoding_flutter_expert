import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';

import '../../domain/entities/movie.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies();
      context.read<PopularMoviesCubit>().fetchPopularMovies();
      context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, tvSeriesRoute);
              },
              leading: const Icon(Icons.tv_rounded),
              title: const Text('TV Series'),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchMoviesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is NowPlayingMoviesSuccess) {
                    return MovieList(state.movieData);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularMovieRoute),
              ),
              BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                  builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PopularMoviesSuccess) {
                  return MovieList(state.moviesData);
                } else {
                  return const Text('Failed');
                }
              }),
              // Consumer<MovieListNotifier>(builder: (context, data, child) {
              //   final state = data.popularMoviesState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.popularMovies);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedMovieRoute),
              ),
              BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TopRatedMoviesSuccess) {
                    return MovieList(state.moviesData);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailMovieRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
