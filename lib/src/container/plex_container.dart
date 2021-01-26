import 'package:dart_plex/src/container/plex_metadata.dart';
import 'package:dart_plex/src/exception/plex_exception.dart';

import 'plex_data.dart';

/// path: /library/sections/<sectionId>/all
class PlexContainer<M extends PlexMetadata> extends PlexData {
  int size;
  bool allowSync;
  String art;
  String identifier;
  int librarySectionID;
  String librarySectionTitle;
  String librarySectionUUID;
  String mediaTagPrefix;
  int mediaTagVersion;
  bool nocache;
  String thumb;
  String title1;
  String title2;
  String viewGroup;
  int viewMode;
  List<M> metadatas;

  PlexContainer<M> fromJson(dynamic json) {
    assert(json != null);
    size = json['size'];
    allowSync = json['allowSync'];
    art = json['art'];
    identifier = json['identifier'];
    librarySectionID = json['librarySectionID'];
    librarySectionTitle = json['librarySectionTitle'];
    librarySectionUUID = json['librarySectionUUID'];
    mediaTagPrefix = json['mediaTagPrefix'];
    mediaTagVersion = json['mediaTagVersion'];
    nocache = json['nocache'];
    thumb = json['thumb'];
    title1 = json['title1'];
    title2 = json['title2'];
    viewGroup = json['viewGroup'];
    viewMode = json['viewMode'];
    if (json['Metadata'] != null) {
      var jsonList = json['Metadata'] as List;
      metadatas = jsonList.map((e) {
        // var
        return createMetadata(M, json['viewGroup'] as String).fromJson(e) as M;
      }).toList();
    }
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        'size': size,
        'allowSync': allowSync,
        'art': art,
        'identifier': identifier,
        'librarySectionID': librarySectionID,
        'librarySectionTitle': librarySectionTitle,
        'librarySectionUUID': librarySectionUUID,
        'mediaTagPrefix': mediaTagPrefix,
        'mediaTagVersion': mediaTagVersion,
        'nocache': nocache,
        'thumb': thumb,
        'title1': title1,
        'title2': title2,
        'viewGroup': viewGroup,
        'viewMode': viewMode,
        'metadatas': metadatas,
      };

  M createMetadataByViewGroup<M extends PlexMetadata>(String viewGroup) {
    if (viewGroup == null) {
      throw PlexException('can not find viewGroup');
    }
    var metadata = PlexMetadata();
    switch (viewGroup) {
      case 'artist':
        metadata = PlexArtistMetaData();
        break;
      case 'album':
        metadata = PlexAlbumMetaData();
        break;
      case 'track':
        metadata = PlexTrackMetaData();
        break;
    }
    return metadata;
  }

  M createMetadata(Type type, String viewGroup) {
    if (META_DATA_TYPES.containsKey(type)) {
      return META_DATA_TYPES[type]();
    }
    return createMetadataByViewGroup(viewGroup);
  }
}
