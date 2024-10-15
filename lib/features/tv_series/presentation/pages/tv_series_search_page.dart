import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv-series';
  const TvSeriesSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<TvSeriesSearchNotifier>(context, listen: false)
                    .fetchsearchTvSeries(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<TvSeriesSearchNotifier>(
              builder: (context, value, child) {
                if (value.searchState == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (value.searchState == RequestState.Loaded) {
                  final result = value.searchTvSeriesList;
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = value.searchTvSeriesList[index];
                        return TvSeriesCard(tvSeries);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
