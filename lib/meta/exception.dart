class DocumentedException implements Exception {
  final String message;
  final Object cause;

  DocumentedException(this.message, this.cause);
}
