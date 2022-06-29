import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/presentation/bloc/tvseries/tvseries_watchlist_bloc.dart';

class TVSeriesDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/tv_series_detail';

  final int id;

  // ignore: use_key_in_widget_constructors
  const TVSeriesDetailPage({required this.id});

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesDetailBloc>().add(OnTVSeriesDetailCalled(widget.id));
      context
          .read<TVSeriesRecommendationBloc>()
          .add(OnTVSeriesRecommendationCalled(widget.id));
      context
          .read<TVSeriesWatchlistBloc>()
          .add(FetchTVSeriesWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedToWatchlist = context.select<TVSeriesWatchlistBloc, bool>(
        (bloc) => (bloc.state is TVSeriesIsAddedToWatchlist)
            ? (bloc.state as TVSeriesIsAddedToWatchlist).isAdded
            : false);
    return Scaffold(
      body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
        builder: (context, state) {
          if (state is TVSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVSeriesDetailHasData) {
            final tvSeries = state.result;
            return SafeArea(
              child: DetailContent(tvSeries, isAddedToWatchlist),
            );
          } else if (state is TVSeriesDetailEmpty) {
            return const Text(
              'empty',
              key: Key('empty_message'),
            );
          } else {
            return const Text(
              'error',
              key: Key('error_message'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TVSeriesDetail tv;
  bool isAddedWatchlist;

  // ignore: use_key_in_widget_constructors
  DetailContent(this.tv, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<TVSeriesWatchlistBloc>()
                                      .add(AddTVSeriesToWatchlist(widget.tv));
                                } else {
                                  context.read<TVSeriesWatchlistBloc>().add(
                                      RemoveTVSeriesFromWatchlist(widget.tv));
                                }

                                final message = context
                                    .select<TVSeriesWatchlistBloc, dynamic>(
                                  (value) => (value.state
                                          is TVSeriesIsAddedToWatchlist)
                                      ? (value.state as TVSeriesIsAddedToWatchlist)
                                                  .isAdded ==
                                              false
                                          ? const Text('Added to Watchlist')
                                          : const Text('Removed from watchlist')
                                      : !widget.isAddedWatchlist
                                          ? const Text('added to watchlist')
                                          : const Text(
                                              'removed from watchlist'),
                                );

                                if (message ==
                                        const Text('Added to Watchlist') ||
                                    message ==
                                        const Text('Removed from Watchlist')) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: message));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: message,
                                        );
                                      });
                                }
                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            IntrinsicHeight(
                              child: Row(children: [
                                Text(_showNumberOfSeasons(
                                    widget.tv.numberOfSeasons)),
                                const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  _showDuration(widget.tv.episodeRuntime[0]),
                                ),
                              ]),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                return SeasonCard(widget.tv.seasons[index]);
                              },
                              shrinkWrap: true,
                              itemCount: widget.tv.seasons.length,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVSeriesRecommendationBloc,
                                TVSeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is TVSeriesRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TVSeriesRecommendationError) {
                                  return const Text(
                                    'error',
                                    key: Key('error_message'),
                                  );
                                } else if (state
                                    is TVSeriesRecommendationHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    key: const Key('empty_message'),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _showNumberOfSeasons(int total) {
    return '$total ${total > 1 ? 'seasons' : 'season'}';
  }
}
