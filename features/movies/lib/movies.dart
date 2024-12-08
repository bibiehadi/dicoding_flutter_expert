library movies;

// entities
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'domain/entities/genre.dart';

// repositories
export 'domain/repositories/movie_repository.dart';

// usecases
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/search_movies.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';
