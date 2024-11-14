import 'package:core/utils/db/database_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:watchlist/data/datasources/local/local_datasource.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

@GenerateMocks([
  DatabaseHelper,
  WatchlistRepository,
  LocalDatasource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
