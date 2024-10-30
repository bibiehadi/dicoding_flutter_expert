import '../../features/movies/lib/data/datasources/db/movie_database_helper.dart';
import '../../features/movies/lib/data/datasources/movie_local_data_source.dart';
import '../../features/movies/lib/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/lib/domain/repositories/movie_repository.dart';
import '../../features/tv_series/lib/data/datasources/local/tv_series_local_datasource.dart';
import '../../features/tv_series/lib/data/datasources/remote/tv_series_remote_datasource.dart';
import '../../features/tv_series/lib/domain/repositories/tv_series_repository.dart';
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
