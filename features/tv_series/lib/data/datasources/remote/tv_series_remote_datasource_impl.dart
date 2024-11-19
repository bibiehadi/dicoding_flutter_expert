import 'dart:convert';

import 'package:core/core.dart';

import 'tv_series_remote_datasource.dart';
import '../../models/tv_series_detail.dart';
import '../../models/tv_series_model.dart';
import '../../models/tv_series_response.dart';
import '../../models/tv_series_season_detail.dart';
import 'package:http/http.dart' as http;

class TvSeriesRemoteDatasourceImpl implements TvSeriesRemoteDatasource {
  final http.Client client;

  TvSeriesRemoteDatasourceImpl({required this.client});
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
    );
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendationTvSeries(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesSeasonDetailModel> getTvSeriesSeasonDetail(
      int id, int seasonNumber) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TvSeriesSeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
