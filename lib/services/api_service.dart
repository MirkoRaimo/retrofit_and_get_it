import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

import '../models/comment_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('posts')
  Future<List<PostModel>> getPosts();

  @GET('posts/{id}')
  Future<PostModel> getSpecificPost(@Path('id') int id);

  @GET('comments?postId={id}')
  Future<List<CommentModel>> getPostComments(@Path('id') int id);
}
