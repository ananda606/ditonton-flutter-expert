import 'package:about/about.dart';
import 'package:watchlist/watchlist.dart';
import 'package:tvseries/tvseries.dart';
import 'package:movie/movie.dart';
import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  final String pageRoute;
  // ignore: use_key_in_widget_constructors
  const DrawerApp({required this.pageRoute});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TVSeries'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, HomeTVSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
