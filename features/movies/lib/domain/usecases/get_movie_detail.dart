import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
