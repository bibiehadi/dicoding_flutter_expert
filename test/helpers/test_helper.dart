import 'package:core/utils/db/database_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:tv_series/data/datasources/local/tv_series_local_datasource.dart';
import 'package:tv_series/data/datasources/remote/tv_series_remote_datasource.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TvSeriesRepository,
  TvSeriesRemoteDatasource,
  TvSeriesLocalDatasource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
