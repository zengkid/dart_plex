import 'plex_data.dart';

class PlexMetadata extends PlexData {
  String ratingKey;
  String key;
  String guid;
  String type;
  String title;
  String summary;

  @override
  PlexMetadata fromJson(json) {
    assert(json != null);
    ratingKey = json['ratingKey'];
    key = json['key'];
    guid = json['guid'];
    type = json['type'];
    title = json['title'];
    summary = json['summary'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        'ratingKey': ratingKey,
        'key': key,
        'guid': guid,
        'type': type,
        'title': title,
        'summary': summary,
      };
}

class PlexArtistMetaData extends PlexMetadata {}

class PlexAlbumMetaData extends PlexMetadata {
  String parentRatingKey;
  String parentGuid;
  String parentKey;
  String parentTitle;
  int index;
  int year;
  String originallyAvailableAt;
  int addedAt;
  int updateAt;
  String loudnessAnalysisVersion;

  @override
  PlexMetadata fromJson(json) {
    super.fromJson(json);
    parentRatingKey = json['parentRatingKey'];
    parentGuid = json['parentGuid'];
    parentKey = json['parentKey'];
    parentTitle = json['parentTitle'];
    index = json['index'];
    year = json['year'];
    originallyAvailableAt = json['originallyAvailableAt'];
    addedAt = json['addedAt'];
    updateAt = json['updateAt'];
    loudnessAnalysisVersion = json['loudnessAnalysisVersion'];

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map.addAll({
      'parentRatingKey': parentRatingKey,
      'parentGuid': parentGuid,
      'parentKey': parentKey,
      'parentTitle': parentTitle,
      'index': index,
      'year': year,
      'originallyAvailableAt': originallyAvailableAt,
      'addedAt': addedAt,
      'updateAt': updateAt,
      'loudnessAnalysisVersion': loudnessAnalysisVersion,
    });
    return map;
  }
}

class PlexTrackMetaData extends PlexMetadata {
  String parentRatingKey;
  String grandparentRatingKey;
  String parentGuid;
  String grandparentGuid;
  String grandparentKey;
  String parentKey;
  String grandparentTitle;
  String parentTitle;
  int parentIndex;
  int index;
  String thumb;
  String parentThumb;
  int addedAt;
  int duration;
  List<PlexMedia> medias;

  @override
  PlexMetadata fromJson(json) {
    super.fromJson(json);
    grandparentRatingKey = json['grandparentRatingKey'];
    parentRatingKey = json['parentRatingKey'];
    parentGuid = json['parentGuid'];
    grandparentKey = json['grandparentKey'];
    parentKey = json['parentKey'];
    grandparentTitle = json['grandparentTitle'];
    parentTitle = json['parentTitle'];
    parentIndex = json['parentIndex'];
    index = json['index'];
    thumb = json['thumb'];
    parentThumb = json['parentThumb'];
    addedAt = json['addedAt'];
    duration = json['duration'];

    if (json['Media'] != null) {
      medias = [];
      var jsonList = json['Media'] as List;
      medias = jsonList.map((e) => PlexMedia().fromJson(e)).toList();
    }

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map.addAll({
      'grandparentRatingKey': grandparentRatingKey,
      'parentRatingKey': parentRatingKey,
      'grandparentGuid': grandparentGuid,
      'parentGuid': parentGuid,
      'grandparentKey': grandparentKey,
      'parentKey': parentKey,
      'grandparentTitle': grandparentTitle,
      'parentTitle': parentTitle,
      'parentIndex': parentIndex,
      'index': index,
      'thumb': thumb,
      'parentThumb': parentThumb,
      'addedAt': addedAt,
      'duration': duration,
      'medias': medias,
    });
    return map;
  }
}

class PlexMedia extends PlexData {
  int id;
  int duration;
  int bitrate;
  String audioCodec;
  String container;
  int size;
  String key;

  @override
  PlexMedia fromJson(json) {
    assert(json != null);
    id = json['id'];
    duration = json['duration'];
    bitrate = json['bitrate'];
    audioCodec = json['audioCodec'];
    container = json['container'];
    if (json['Part'] != null && json['Part'].length > 0) {
      size = json['Part'][0]['size'];
      key = json['Part'][0]['key'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'duration': duration,
        'bitrate': bitrate,
        'audioCodec': audioCodec,
        'container': container,
        'size': size,
        'key': key
      };
}
