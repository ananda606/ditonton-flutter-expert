import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnAirTVSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/onair_tv_series';

  const OnAirTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<OnAirTVSeriesPage> createState() => _OnAirTVSeriesPageState();
}

class _OnAirTVSeriesPageState extends State<OnAirTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesListBloc>().add(OnTVSeriesListCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVSeriesListBloc, TVSeriesListState>(
          builder: (context, state) {
            if (state is TVSeriesListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVSeriesListHasData) {
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
        ),
      ),
    );
  }
}
