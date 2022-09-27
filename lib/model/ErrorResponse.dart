import 'package:newsapi2/model/NewsRespnse.dart';
class ErrorResponse extends NewsResponse{
   String error;
  ErrorResponse(this.error);
}