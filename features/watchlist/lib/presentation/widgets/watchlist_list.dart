import 'package:core/core.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';

class WatchlistList extends StatelessWidget {
  final List<WatchlistTable> watchlistList;

  const WatchlistList(this.watchlistList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final watchlist = watchlistList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                if (watchlist.isMovies == '1') {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.ROUTE_NAME,
                    arguments: watchlist.id,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    tvSeriesDetailRoute,
                    arguments: watchlist.id,
                  );
                }
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${watchlist.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: watchlistList.length,
      ),
    );
  }
}
