import 'package:smart_store/models/api_response.dart';

mixin ApiHelper {
  ApiResponse get errorRespnse => ApiResponse('Something went wrong', false);
}