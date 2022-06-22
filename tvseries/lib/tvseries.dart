library tvseries;

//domain - usecase
export 'domain/tvseries/get_popular_tvseries.dart';
export 'domain/tvseries/get_top_rated_tvseries.dart';
export 'domain/tvseries/get_onair_tvseries.dart';
export 'domain/tvseries/get_tvseries_recommendations.dart';
export 'domain/tvseries/get_tvseries_detail.dart';

//presentation
//page
export 'presentation/page/home_tvseries_page.dart';
export 'presentation/page/onair_tvseries_page.dart';
export 'presentation/page/popular_tvseries_page.dart';
export 'presentation/page/top_rated_tvseries_page.dart';
export 'presentation/page/tvseries_detail_page.dart';
//provioder
// export 'presentation/provider/Tv_list_notifier.dart';
// export 'presentation/provider/popular_tv_notifier.dart';
// export 'presentation/provider/top_rated_tv_notifier.dart';
// export 'presentation/provider/tv_detail_notifier.dart';

//bloc
export 'presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
export 'presentation/bloc/tvseries_onair/tvseries_list_bloc.dart';
export 'presentation/bloc/tvseries_popular/tvseries_popular_bloc.dart';
export 'presentation/bloc/tvseries_recommendation/tvseries_recommendation_bloc.dart';
export 'presentation/bloc/tvseries_top_rated/tvseries_top_rated_bloc.dart';
