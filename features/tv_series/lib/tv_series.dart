library tv_series;

// entities
export 'domain/entities/tv_series.dart';
export 'domain/entities/tv_series_detail.dart';
export 'domain/entities/tv_series_episode.dart';
export 'domain/entities/tv_series_genre.dart';
export 'domain/entities/tv_series_season.dart';
export 'domain/entities/tv_series_season_detail.dart';

// repositories
export 'domain/repositories/tv_series_repository.dart';

// usecases
export 'domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
export 'domain/usecases/get_tv_series_list/get_tv_series_list.dart';
export 'domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
export 'domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
export 'domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
export 'domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';
export 'domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
export 'domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
export 'domain/usecases/search_tv_series/search_tv_series.dart';
