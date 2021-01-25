class PlexMediaType {
  final int id;
  final String typeString;
  final String title;
  final String element;
  final List<int> related;

  PlexMediaType(
      {this.id, this.typeString, this.title, this.element, this.related});

  static PlexMediaType get movie => PlexMediaType(
      id: 1,
      typeString: 'movie',
      title: 'Movie',
      element: 'Video',
      related: []);

  static PlexMediaType get show => PlexMediaType(
      id: 2,
      typeString: 'show',
      title: 'Show',
      element: 'directory',
      related: [3, 4]);

  static PlexMediaType get season => PlexMediaType(
      id: 3,
      typeString: 'season',
      title: 'Season',
      element: 'directory',
      related: [2, 4]);

  static PlexMediaType get episode => PlexMediaType(
      id: 4,
      typeString: 'episode',
      title: 'Episode',
      element: 'video',
      related: [2, 3]);

  static PlexMediaType get trailer => PlexMediaType(
      id: 5,
      typeString: 'trailer',
      title: 'Trailer',
      element: 'video',
      related: []);

  static PlexMediaType get comic => PlexMediaType(
      id: 6,
      typeString: 'comic',
      title: 'Comic',
      element: 'photo',
      related: []);

  static PlexMediaType get person => PlexMediaType(
      id: 7,
      typeString: 'person',
      title: 'Person',
      element: 'directory',
      related: []);

  static PlexMediaType get artist => PlexMediaType(
      id: 8,
      typeString: 'artist',
      title: 'Artist',
      element: 'directory',
      related: [9, 10]);

  static PlexMediaType get album => PlexMediaType(
      id: 9,
      typeString: 'album',
      title: 'Album',
      element: 'directory',
      related: [8, 10]);

  static PlexMediaType get track => PlexMediaType(
      id: 10,
      typeString: 'track',
      title: 'Track',
      element: 'audio',
      related: [8, 9]);

  static PlexMediaType get photoAlbum => PlexMediaType(
      id: 11,
      typeString: 'photoAlbum',
      title: 'Photo Album',
      element: 'directory',
      related: [12, 13]);

  static PlexMediaType get picture => PlexMediaType(
      id: 12,
      typeString: 'picture',
      title: 'Picture',
      element: 'photo',
      related: [11]);

  static PlexMediaType get photo => PlexMediaType(
      id: 13,
      typeString: 'photo',
      title: 'Photo',
      element: 'photo',
      related: [11]);

  static PlexMediaType get clip => PlexMediaType(
      id: 14, typeString: 'clip', title: 'Clip', element: 'video', related: []);

  static PlexMediaType get playlistItem => PlexMediaType(
      id: 15,
      typeString: 'playlistItem',
      title: 'Clip',
      element: 'video',
      related: []);

  static final _allTypes = [
    movie,
    show,
    season,
    episode,
    trailer,
    comic,
    person,
    artist,
    album,
    track,
    photoAlbum,
    picture,
    photo,
    clip,
    playlistItem
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlexMediaType &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  static PlexMediaType findByTypeId(int id) {
    return _allTypes.firstWhere((element) => element.id == id);
  }

  static PlexMediaType fromTypeString(String typeString) {
    return _allTypes.firstWhere((element) => element.typeString == typeString);
  }
}
