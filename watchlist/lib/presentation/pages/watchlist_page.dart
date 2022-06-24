import 'package:core/core.dart';
import 'package:watchlist/watchlist.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist_page';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBox) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Watchlist'),
              bottom: TabBar(
                indicatorColor: kPrussianBlue,
                tabs: [
                  _tabBarWatchlist('TV Series', Icons.live_tv),
                  _tabBarWatchlist('Movies', Icons.movie_creation_outlined),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            WatchlistTVSeriesPage(),
            WatchlistMoviesPage(),
          ],
        ),
      )),
    );
  }

  Widget _tabBarWatchlist(String title, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Icon(iconData),
      ),
    );
  }
}
