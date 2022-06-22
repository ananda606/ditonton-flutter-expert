library movie;

export 'movie/domain/movie/get_movie_detail.dart';
export 'movie/domain/movie/get_movie_recommendations.dart';
export 'movie/domain/movie/get_now_playing_movies.dart';
export 'movie/domain/movie/get_popular_movies.dart';
export 'movie/domain/movie/get_top_rated_movies.dart';

//presentation
//pages
export 'movie/presentation/pages/home_movie_page.dart';
export 'movie/presentation/pages/movie_detail_page.dart';
export 'movie/presentation/pages/popular_movies_page.dart';
export 'movie/presentation/pages/top_rated_movies_page.dart';

//bloc
export 'movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
export 'movie/presentation/bloc/movie_list/movie_list_bloc.dart';
export 'movie/presentation/bloc/movie_popular/movie_popular_bloc.dart';
export 'movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
export 'movie/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
