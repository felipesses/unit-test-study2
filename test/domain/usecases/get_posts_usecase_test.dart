import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_example_2/domain/errors/errors.dart';
import 'package:unit_test_example_2/domain/entities/post.dart';
import 'package:unit_test_example_2/domain/repositories/post_repository.dart';
import 'package:unit_test_example_2/domain/usecases/get_posts_usecase.dart';
import 'package:unit_test_example_2/dto/post_params_dto.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  // arrange (configuração)
  final repository = PostRepositoryMock();
  final usecase = GetPostImpl(repository);

  test('Deve retornar uma lista de posts', () async {
    // arrange (configuração)
    final params = PostParamsDTO(page: 1);
    when(() => repository.fetchPosts(params: params))
        .thenAnswer((_) async => Right(<Post>[]));
    // act (ação, chamada)
    final result = await usecase.call(params: params);
    // asset (esperado)
    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<Post>>());
  });

  test('Deve retornar um post exception quando falhar no repository', () async {
    // arrange (configuração)
    final params = PostParamsDTO(page: 1);
    when(() => repository.fetchPosts(params: params)).thenAnswer(
        (_) async => Left(PostRepositoryException('Repository error')));
    // act (ação, chamada)
    final result = await usecase.call(params: params);
    // asset (esperado)
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<PostRepositoryException>());
  });

  test('Deve retornar erro caso página seja menor ou igual a 0', () async {
    // arrange (configuração)
    final params = PostParamsDTO(page: 0);
    // act (ação, chamada)
    final result = await usecase.call(params: params);
    // asset (esperado)
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidPostParams>());
  });

  test('Deve retornar erro caso offset seja menor ou igual a 0', () async {
    // arrange (configuração)
    final params = PostParamsDTO(page: 1, offset: 0);
    // act (ação, chamada)
    final result = await usecase.call(params: params);
    // asset (esperado)
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidPostParams>());
  });
}
