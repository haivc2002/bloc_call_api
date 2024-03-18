import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../model/model.dart';

part 'ability_event.dart';
part 'ability_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  int page = 1;
  int limit = 15;
  bool hasMoreData = true;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();
  List<loadapi> allDatas = [];
  bool isRefreshing = false;

  DataBloc() : super(DataInitial()) {
    scrollController.addListener(_onScroll);
    on<DataEvent>((event, emit) async {
      Dio dio = Dio();
      if (event is FetchData) {
        isRefreshing = true;
        try {
          dio.interceptors.add(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
          ));
          if (isLoading || !hasMoreData) {
            return;
          }
          isLoading = true;
          Options options = Options(
            headers: {
              'X-Rapidapi-Key': '1f05642c1dmshe7b3b9f44bf8faep1229cdjsn614784777930',
            },
          );

          Response response = await dio.get(
            'https://bando-radio-api.p.rapidapi.com/stations?page=$page&limit=$limit',
            options: options,
          );
          if (response.statusCode == 200) {
            // final List<dynamic> jsonDatas = response.ui;
            allDatas.addAll((response.data as List).map((item) => loadapi.fromJson(item)).toList());
            page++;
            hasMoreData = (response.data as List).isNotEmpty;

            emit(DataLoaded(
              datas: allDatas,
              hasMoreData: hasMoreData,
              isLoading: isLoading,
            ));
          } else {
            emit(const DataError(errorMessage: 'Failed to load banners'));
          }
        } catch (error) {
          emit(DataError(errorMessage: 'Error: $error'));
        } finally {
          isLoading = false;
          isRefreshing = false;
        }

      } else if (event is LoadMoreData) {
        try {
          if (isLoading || !hasMoreData) {
            return;
          }
          isLoading = true;
          Options options = Options(
            headers: {
              'X-Rapidapi-Key': '1f05642c1dmshe7b3b9f44bf8faep1229cdjsn614784777930',
            },
          );

          Response response = await dio.get(
            'https://bando-radio-api.p.rapidapi.com/stations?page=$page&limit=$limit',
            options: options
          );
          if (response.statusCode == 200) {
            final List<dynamic> jsonDatas = response.data;
            final List<loadapi> newDatas = jsonDatas.map((json) => loadapi.fromJson(json)).toList();
            page++;
            hasMoreData = newDatas.isNotEmpty;

            List<loadapi> temporaryDatas = List.from(allDatas);
            temporaryDatas.addAll(newDatas);

            emit(DataLoaded(
              datas: temporaryDatas,
              hasMoreData: hasMoreData,
              isLoading: isLoading,
            ));


            allDatas = temporaryDatas;
          } else {
            emit(const DataError(errorMessage: 'Failed to load more banners'));
          }
        } catch (error) {
          emit(DataError(errorMessage: 'Error: $error'));
        } finally {
          isLoading = false;
        }
      }
    });
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(!isRefreshing) {
        add(LoadMoreData());
      }
    }
  }
}



