import 'package:core/utils/db/database_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/data/datasources/local/tv_series_local_datasource.dart';
import 'package:tv_series/data/datasources/remote/tv_series_remote_datasource.dart';
import 'package:tv_series/tv_series.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  DatabaseHelper,
  TvSeriesRepository,
  TvSeriesRemoteDatasource,
  TvSeriesLocalDatasource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
