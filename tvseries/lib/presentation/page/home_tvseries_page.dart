import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home_tv_series';

  @override
  State<HomeTVSeriesPage> createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesListBloc>().add(OnTVSeriesListCalled());
      context.read<TVSeriesPopularBloc>().add(OnTVSeriesPopularCalled());
      context.read<TVSeriesTopRatedBloc>().add(OnTVSeriesTopRatedCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerApp(pageRoute: HomeTVSeriesPage.ROUTE_NAME),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTVSeries.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On Air TV Series',
                onTap: () =>
                    Navigator.pushNamed(context, OnAirTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TVSeriesListBloc, TVSeriesListState>(
                  builder: (context, state) {
                if (state is TVSeriesDetailLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesListHasData) {
                  return TVSeriesList(state.result);
                } else {
                  return const Text('Failed to fetch data');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TVSeriesPopularBloc, TVSeriesPopularState>(
                  builder: (context, state) {
                if (state is TVSeriesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesPopularHasData) {
                  return TVSeriesList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TVSeriesTopRatedBloc, TVSeriesTopRatedState>(
                  builder: (context, state) {
                if (state is TVSeriesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVSeriesTopRatedHasData) {
                  return TVSeriesList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text('See More'),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    ],
  );
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvseries;

  TVSeriesList(this.tvseries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvseries.length,
      ),
    );
  }
}
