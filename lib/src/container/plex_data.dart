abstract class PlexData<T> {
  T fromJson(dynamic json);

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}
