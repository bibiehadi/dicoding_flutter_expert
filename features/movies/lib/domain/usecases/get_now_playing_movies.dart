import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:core/utils/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
