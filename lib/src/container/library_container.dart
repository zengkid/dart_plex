import 'package:dart_plex/src/container/plex_media_type.dart';

import 'plex_data.dart';

/// path:/library/sections
class LibraryContainer extends PlexData {
  int size;
  bool allowSync;
  String identifier;
  String mediaTagPrefix;
  int mediaTagVersion;
  String title1;
  List<Directory> directories;

  @override
  LibraryContainer fromJson(dynamic json) {
    assert(json != null);
    size = json['size'];
    allowSync = json['allowSync'];
    identifier = json['identifier'];
    mediaTagPrefix = json['mediaTagPrefix'];
    mediaTagVersion = json['mediaTagVersion'];
    title1 = json['title1'];
    if (json['Directory'] != null) {
      var jsonList = json['Directory'] as List;
      directories = jsonList.map((e) => Directory().fromJson(e)).toList();
      // var directory = Directory();
      // directories.add(directory.fromJson(json['Directory']));
    }
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        'size': size,
        'allowSync': allowSync,
        'identifier': identifier,
        'mediaTagPrefix': mediaTagPrefix,
        'mediaTagVersion': mediaTagVersion,
        'title1': title1,
        'directories': directories,
      };

  List<Directory> _getDirectoriesByType(PlexMediaType type) {
    return directories.where((element) => element.type == type.id.toString());
  }

  List<Directory> movieLibrary() {
    return _getDirectoriesByType(PlexMediaType.movie);
  }

  List<Directory> artistLibrary() {
    return _getDirectoriesByType(PlexMediaType.artist);
  }

  List<Directory> showLibrary() {
    return _getDirectoriesByType(PlexMediaType.show);
  }
}

class Directory extends PlexData {
  bool allowSync;
  String art;
  String composite;
  bool filters;
  bool refreshing;
  String thumb;
  String key;
  String type;
  String title;
  String agent;
  String scanner;
  String language;
  String uuid;
  int updatedAt;
  int createdAt;
  int scannedAt;
  List<Location> locations;

  @override
  Directory fromJson(
    dynamic json,
  ) {
    assert(json != null);
    allowSync = json['allowSync'];
    art = json['art'];
    composite = json['composite'];
    filters = json['filters'];
    refreshing = json['refreshing'];
    thumb = json['thumb'];
    key = json['key'];
    type = json['type'];
    title = json['title'];
    agent = json['agent'];
    scanner = json['scanner'];
    language = json['language'];
    uuid = json['uuid'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    scannedAt = json['scannedAt'];
    if (json['Location'] != null) {
      var jsonList = json['Location'] as List;
      locations = jsonList.map((e) => Location().fromJson(e)).toList();
      // var location = Location();
      // locations.add(location.fromJson(jsonList));
    }

    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        'allowSync': allowSync,
        'art': art,
        'composite': composite,
        'filters': filters,
        'refreshing': refreshing,
        'thumb': thumb,
        'key': key,
        'type': type,
        'title': title,
        'agent': agent,
        'scanner': scanner,
        'language': language,
        'uuid': uuid,
        'updatedAt': updatedAt,
        'createdAt': createdAt,
        'scannedAt': scannedAt,
        'location': locations,
      };
}

class Location extends PlexData {
  int id;
  String path;

  Location({
    this.id,
    this.path,
  });

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'path': path,
      };

  @override
  Location fromJson(json) {
    id = json['id'];
    path = json['path'];
    return this;
  }
}
