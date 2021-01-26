import 'plex_metadata.dart';

abstract class PlexData {
  PlexData fromJson(dynamic json);

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}

final META_DATA_TYPES = {
  PlexArtistMetaData: () => PlexArtistMetaData(),
  PlexAlbumMetaData: () => PlexAlbumMetaData(),
  PlexTrackMetaData: () => PlexTrackMetaData(),
};
