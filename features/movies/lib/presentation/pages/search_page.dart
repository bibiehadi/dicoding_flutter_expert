import 'package:core/core.dart';
import 'package:movies/presentation/bloc/search_movies/search_movies_cubit.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchMoviesCubit>().fetchSearchMovies(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
              builder: (context, state) {
                if (state is SearchMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchMoviesSuccess) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.moviesData[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.moviesData.length,
                    ),
                  );
                } else if (state is SearchMoviesFailed) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
