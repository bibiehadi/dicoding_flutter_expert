import 'package:ditonton/features/movies/data/datasources/db/movie_database_helper.dart';
import 'package:ditonton/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/tv_series/data/datasources/local/tv_series_local_datasource.dart';
import 'package:ditonton/features/tv_series/data/datasources/remote/tv_series_remote_datasource.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
  TvSeriesRepository,
  TvSeriesRemoteDatasource,
  TvSeriesLocalDatasource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
