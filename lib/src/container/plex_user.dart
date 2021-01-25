class PlexUser {
  int id;
  String uuid;
  String email;
  String username;
  String title;
  String thumb;
  String authToken;
  String authenticationToken;

  PlexUser.fromJson(dynamic jsonData) {
    id = jsonData['id'];
    uuid = jsonData['uuid'];
    email = jsonData['email'];
    username = jsonData['username'];
    title = jsonData['title'];
    thumb = jsonData['thumb'];
    authToken = jsonData['authToken'];
    authenticationToken = jsonData['authenticationToken'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'email': email,
      'username': username,
      'title': title,
      'authToken': authToken,
      'authenticationToken': authenticationToken,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
