import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
