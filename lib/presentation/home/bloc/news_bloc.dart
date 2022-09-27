import 'package:bloc/bloc.dart';
import 'package:newsapi2/model/ErrorResponse.dart';
import 'package:newsapi2/model/NewsRespnse.dart';
import 'package:newsapi2/model/SuccessResponse.dart';
import 'package:newsapi2/presentation/home/bloc/news_event.dart';
import 'package:newsapi2/presentation/home/bloc/news_state.dart';

import '../../../repository/NewsRepository.dart';

class NewsBloc extends Bloc<NewsEvent,NewsState>{
  NewsRepository repository=NewsRepository();
  NewsBloc(initialState):super(initialState){
    on<FetchNews>((event, emit)async{
      NewsResponse response=await repository.FetchRemoteNews();
      if(response is SuccessResponse){
        emit(SuccessState(response));
      }else{
        emit(FailureState(response as ErrorResponse));
      }
    });
  }
}