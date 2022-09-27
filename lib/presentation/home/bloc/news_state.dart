import 'package:newsapi2/model/ErrorResponse.dart';
import 'package:newsapi2/model/SuccessResponse.dart';

abstract class NewsState{}
class LoadingState extends NewsState{}
class SuccessState extends NewsState{
  SuccessResponse? successResponse;
  SuccessState(this.successResponse);
}
class FailureState extends NewsState{
  ErrorResponse? errorResponse;
  FailureState(this.errorResponse);
}