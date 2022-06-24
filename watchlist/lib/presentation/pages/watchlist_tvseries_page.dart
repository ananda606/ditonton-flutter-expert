import 'package:core/core.dart';
import 'package:watchlist/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist_tv_series';

  const WatchlistTVSeriesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesWatchlistBloc>().add(OnFetchTVSeriesWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TVSeriesWatchlistBloc>().add(OnFetchTVSeriesWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      builder: (context, state) {
        if (state is TVSeriesWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TVSeriesWatchlistHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = state.result[index];
              return TVSeriesCard(tv);
            },
            itemCount: state.result.length,
          );
        } else {
          return const Center(
            key: Key('error_message'),
            child: Text('error'),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
