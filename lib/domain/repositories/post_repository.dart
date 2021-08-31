import 'package:fpdart/fpdart.dart';
import 'package:unit_test_example_2/domain/entities/post.dart';
import 'package:unit_test_example_2/domain/errors/errors.dart';
import 'package:unit_test_example_2/dto/post_params_dto.dart';

abstract class PostRepository {
  Future<Either<PostException, List<Post>>> fetchPosts(
      {required PostParamsDTO params});
}
