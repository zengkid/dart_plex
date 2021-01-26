import 'package:http/http.dart';

import '../dart_plex.dart';
import 'container/library_container.dart';
import 'container/my_plex_server.dart';
import 'container/plex_container.dart';
import 'container/plex_user.dart';
import 'plex_path.dart';
import 'request.dart';

class PlexConnection {
  List<MyPlexServer> servers;
  PlexHeaders headers;
  PlexUser user;

  PlexConnection(this.user, this.servers, this.headers);

  Uri getRequestUri(bool localServer, {Map<String, String> params}) {
    var server = servers.firstWhere((s) => s.local == localServer);
    return Uri(
        scheme: server.protocol,
        host: server.address,
        port: server.port,
        queryParameters: params);
  }

  Future<dynamic> requestJson(String route,
      {Map<String, String> params, bool localServer = true}) async {
    var requestUri = getRequestUri(localServer, params: params);
    var data = await requestPlexJson(
      requestUri.replace(path: route),
      headers: headers,
    );
    return data;
  }

  Future<Response> requestRaw(String route,
      {Map<String, String> params, bool localServer = true}) async {
    var requestUri = getRequestUri(localServer, params: params);
    return await requestPlexRaw(requestUri.replace(path: route),
        headers: headers.toMap());
  }

  Future<void> logout() async {
    await deleteRequest(signoutEndpoint, headers: headers);
  }

  Future<LibraryContainer> library(
      {Map<String, String> params, bool localServer = true}) async {
    var jsonData = await requestJson('/library/sections/',
        params: params, localServer: localServer);

    var container = LibraryContainer();
    return container.fromJson(jsonData['MediaContainer']);
  }

  Future<PlexContainer<M>> section<M extends PlexMetadata>(String sectionId,
      {String type,
      Map<String, String> params,
      bool localServer = true}) async {
    if (type?.isNotEmpty ?? false) {
      params = params ?? {};
      params['type'] = type;
    }

    var jsonData = await requestJson('/library/sections/$sectionId/all',
        params: params, localServer: localServer);

    var container = PlexContainer<M>();
    return container.fromJson(jsonData['MediaContainer']);
  }

  Future<PlexContainer<M>> metadata<M extends PlexMetadata>(String key,
      {Map<String, String> params, bool localServer = true}) async {
    var jsonData =
        await requestJson(key, params: params, localServer: localServer);

    var container = PlexContainer<M>();
    return container.fromJson(jsonData['MediaContainer']);
  }
}
