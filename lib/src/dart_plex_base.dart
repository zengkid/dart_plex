import 'package:meta/meta.dart';

import 'container/my_plex_server.dart';
import 'container/plex_user.dart';
import 'plex_connection.dart';
import 'plex_path.dart';
import 'request.dart';

class PlexCredentials {
  String username;
  String password;

  //auth token
  String accessToken;

  PlexCredentials(this.username, this.password)
      : assert(username != null && username != null),
        assert(password != null && password != null);

  PlexCredentials.withAccessToken(this.accessToken)
      : assert(accessToken != null);

  bool hasToken() {
    return accessToken?.isNotEmpty ?? false;
  }
}

class PlexHeaders {
  /// X-Plex-Platform	(Platform name, eg iOS, MacOSX, Android, LG, etc)
  String platform;

  /// X-Plex-Platform-Version	(Operating system version, eg 4.3.1, 10.6.7, 3.2)
  String platformVersion;

  /// X-Plex-Provides	(one or more of [player, controller, server])
  String provides;

  /// X-Plex-Client-Identifier	(UUID, serial number, or other number unique per device)
  String clientIdentifier;

  /// X-Plex-Product	(Plex application name, eg Laika, Plex Media Server, Media Link)
  String product;

  /// X-Plex-Version	(Plex application version number)
  String version;

  /// X-Plex-Device	(Device name and model number, eg iPhone3,2, Motorola XOOM™, LG5200TV)
  String device;

  /// X-Plex-Container-Size	(Paging Size, eg Plex-Container-Size=1)
  String containerSize;

  /// X-Plex-Token	(Authentication token)
  String token;

  /// Accept
  String accept;

  PlexHeaders({
    @required this.clientIdentifier,
    this.platform,
    this.platformVersion,
    this.provides,
    this.product,
    this.version,
    this.device,
    this.containerSize,
    this.token,
    this.accept,
  });

  Map<String, String> toMap() {
    var map = {
      'X-Plex-Platform': platform,
      'X-Plex-Platform-Version': platformVersion,
      'X-Plex-Provides': provides,
      'X-Plex-Client-Identifier': clientIdentifier,
      'X-Plex-Product': product,
      'X-Plex-Version': version,
      'X-Plex-Device': device,
      'X-Plex-Container-Size': containerSize,
      'X-Plex-Token': token,
      'Accept': accept,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}

class Plex {
  PlexCredentials _credentials;
  PlexHeaders _headers;

  Plex(
    this._credentials,
    this._headers,
  ) : assert(_credentials != null);

  Future<PlexConnection> authorize() async {
    PlexUser user;
    if (_credentials != null && !_credentials.hasToken()) {
      var params = {
        'user[login]': _credentials.username,
        'user[password]': _credentials.password
      };
      var data =
          await postRequest(authEndpoint, params: params, headers: _headers);
      user = PlexUser.fromJson(data['user']);
      _credentials.accessToken = user.authToken ?? user.authenticationToken;
      _headers.token = user.authToken ?? user.authenticationToken;
    } else {
      _headers.token = _credentials.accessToken;
      var data = await getRequest(userEndpoint, headers: _headers);
      user = PlexUser.fromJson(data);
    }

    var servers = <MyPlexServer>[];
    var data = await getRequest(resourcesEndpoint, headers: _headers) as List;
    var server =
        data.firstWhere((e) => e['provides'] == 'server' || e['owned']);
    var connections = server['connections'] as List;
    for (var connection in connections) {
      var server = MyPlexServer.fromJson(connection);
      servers.add(server);
    }

    return PlexConnection(user, servers, _headers);
  }
}
