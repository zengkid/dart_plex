import 'package:meta/meta.dart';

import 'plex_data.dart';

class PlexServer extends PlexData {
  static final String path = 'servers';

  final String name;
  final String host;
  final String address;
  final int port;
  final String machineIdentifier;
  final String version;

  PlexServer({
    this.name,
    this.host,
    this.address,
    this.port,
    this.machineIdentifier,
    this.version,
  });

  @override
  PlexServer.fromJson({
    @required dynamic json,
  })  : assert(json != null),
        name = json['name'],
        host = json['host'],
        address = json['address'],
        port = json['port'],
        machineIdentifier = json['machineIdentifier'],
        version = json['version'];

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'host': host,
        'address': address,
        'port': port,
        'machineIdentifier': machineIdentifier,
        'version': version,
      };

  @override
  PlexData fromJson(json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
