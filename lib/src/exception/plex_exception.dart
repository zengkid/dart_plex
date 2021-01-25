class PlexException implements Exception {
  final String msg;

  const PlexException(this.msg);

  @override
  String toString() => msg;
}
