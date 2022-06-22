library watchlist;

export 'presentation/pages/watchlist_movies_page.dart';
export 'presentation/pages/watchlist_tvseries_page.dart';
export 'presentation/pages/watchlist_page.dart';
//bloc
export 'presentation/bloc/movie/movie_watchlist_bloc.dart';
export 'presentation/bloc/tvseries/tvseries_watchlist_bloc.dart';

//usecase
export 'domain/movie_usecase/get_watchlist_movies.dart';
export 'domain/movie_usecase/get_watchlist_status.dart';
export 'domain/movie_usecase/remove_watchlist.dart';
export 'domain/movie_usecase/save_watchlist.dart';

export 'domain/tvseries_usecase/get_watchlist_tvseries.dart';
export 'domain/tvseries_usecase/get_watchlist_tvseries_status.dart';
export 'domain/tvseries_usecase/remove_watchlist_tvseries.dart';
export 'domain/tvseries_usecase/save_watchlist_tvseries.dart';
