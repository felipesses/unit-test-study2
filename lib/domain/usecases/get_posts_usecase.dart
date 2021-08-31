import 'package:fpdart/fpdart.dart';
import 'package:unit_test_example_2/domain/errors/errors.dart';
import 'package:unit_test_example_2/domain/repositories/post_repository.dart';
import 'package:unit_test_example_2/dto/post_params_dto.dart';
import '../entities/post.dart';

abstract class GetPostsUsecase {
  Future<Either<PostException, List<Post>>> call(
      {required PostParamsDTO params});
}

class GetPostImpl implements GetPostsUsecase {
  final PostRepository repository;

  GetPostImpl(this.repository);

  @override
  Future<Either<PostException, List<Post>>> call(
      {required PostParamsDTO params}) async {
    if (params.page <= 0) {
      return Left(InvalidPostParams('Erro de paginação'));
    }
    if (params.offset <= 0) {
      return Left(InvalidPostParams('Erro de offset'));
    }
    return repository.fetchPosts(params: params);
  }
}
