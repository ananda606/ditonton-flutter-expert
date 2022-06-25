library core;

export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/utils.dart';
export 'utils/ssl_pinning.dart';

//data
//datasource
export 'data/datasources/db/database_helper.dart';
export 'data/datasources/db/database_helper_tvseries.dart';
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/datasources/tvseries_local_data_source.dart';
export 'data/datasources/tvseries_remote_data_source.dart';
//models

export 'data/models/tvseries_model/tvseries_detail_model.dart';
export 'data/models/tvseries_model/tvseries_model.dart';
export 'data/models/tvseries_model/tvseries_response.dart';
export 'data/models/tvseries_model/tvseries_table.dart';
export 'data/models/movie_model/genre_model.dart';
export 'data/models/movie_model/movie_detail_model.dart';
export 'data/models/movie_model/movie_model.dart';
export 'data/models/movie_model/movie_response.dart';
export 'data/models/movie_model/movie_table.dart';
//repositories
export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tvseries_repository_impl.dart';

//domain
//entities
export 'domain/entities/movie/genre.dart';
export 'domain/entities/movie/movie.dart';
export 'domain/entities/movie/movie_detail.dart';
export 'domain/entities/tvseries/tvseries.dart';
export 'domain/entities/tvseries/tvseries_detail.dart';
//repossitories
export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tvseries_repository.dart';

//presentation
//widgets
export 'presentation/widgets/movie_card_list.dart';
export 'presentation/widgets/custom_drawer.dart';
export 'presentation/widgets/season_card_list.dart';
export 'presentation/widgets/tvseries_card_list.dart';
