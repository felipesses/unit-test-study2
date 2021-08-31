abstract class PostException implements Exception {
  final String errorMessage;
  final StackTrace? stackTrace;

  PostException(this.errorMessage, [this.stackTrace]);
}

class InvalidPostParams extends PostException {
  InvalidPostParams(String errorMessage) : super(errorMessage);
}

class PostRepositoryException extends PostException {
  PostRepositoryException(String errorMessage, [StackTrace? stackTrace])
      : super(errorMessage, stackTrace);
}
