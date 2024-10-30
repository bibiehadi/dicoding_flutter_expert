import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:core/utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
