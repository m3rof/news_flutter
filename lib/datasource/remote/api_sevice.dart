import 'package:dio/dio.dart';
import 'package:newsapi2/datasource/remote/dio_config.dart';
import 'package:newsapi2/model/ErrorResponse.dart';
import 'package:newsapi2/model/SuccessResponse.dart';

import '../../model/NewsRespnse.dart';

class ApiSevice{
  ApiSevice._();
  static ApiSevice sevice=ApiSevice._();
  Future<NewsResponse>FetchNews()async{
    String url='https://newsapi.org/v2/everything?q=Apple&from=2022-09-27&sortBy=popularity&apiKey=8c046ee1011c4440ba3685153a9af5ca';
    Dio dio=DioConfig.getPrettyDio();
    Response response=await dio.get(url);
    if(response.statusCode==200){
      try{
      var successResponse= SuccessResponse.fromJson(response.data);
      return successResponse;}
      catch (error){
        return ErrorResponse(error.toString());
      }
    }else{
      throw Exception('unable to fetch Weather');
    }
}
}