import 'package:newsapi2/datasource/remote/api_sevice.dart';

import '../model/NewsRespnse.dart';

class NewsRepository{
  Future<NewsResponse>FetchRemoteNews(){
    return ApiSevice.sevice.FetchNews();
  }
}