import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
