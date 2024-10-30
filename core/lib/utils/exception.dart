class ServerException implements Exception {}

class DBException implements Exception {
  final String message;

  DBException(this.message);
}
