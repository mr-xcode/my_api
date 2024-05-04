import 'package:dio/dio.dart';
import 'package:my_api/network/model/task_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://jsonplaceholder.typicode.com/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    return ApiService(dio);
  }

  @GET('photos')
  Future<List<TaskModel>> getTask();
}
