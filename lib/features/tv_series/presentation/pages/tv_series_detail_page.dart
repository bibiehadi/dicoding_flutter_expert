// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';

class TvSeriesDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-series-detail-page';
  final TvSeries tvSeries;

  const TvSeriesDetailPage({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container()),
    );
  }
}
