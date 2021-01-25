class MyPlexServer {
  String protocol;
  String address;
  int port;
  String uri;
  bool local;

  MyPlexServer.fromJson(dynamic jsonData) {
    protocol = jsonData['protocol'];
    address = jsonData['address'];
    port = jsonData['port'];
    uri = jsonData['uri'];
    local = jsonData['local'];
  }

  Map<String, dynamic> toJson() {
    return {
      'protocol': protocol,
      'address': address,
      'port': port,
      'uri': uri,
      'local': local
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
