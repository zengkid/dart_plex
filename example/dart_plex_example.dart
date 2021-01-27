import 'package:dart_plex/dart_plex.dart';

Future<void> main() async {
  var credentials = PlexCredentials.withAccessToken('Ej6pGdUuRj72EmRdBXHx');

  var headers = PlexHeaders(
    accept: 'application/json',
    clientIdentifier: 'Plex Music Client',
  );

  var connection = await Plex(
    credentials,
    headers,
  ).authorize();

  // var library = await connection.library();
  //
  // var artistLibraries =
  //     library.directories.where((e) => e.type == 'artist').toList();
  //
  // var artist = await connection.section<PlexArtistMetaData>(artistLibraries[0].key);
  // var metadatas = artist.metadatas;
  // metadatas.forEach(print);
  // //
  // //
  // var albumMetadata =
  //     await connection.metadata<PlexAlbumMetaData>(artist.metadatas[0].key);
  // print(albumMetadata);
  //
  // var trackMetadata =
  //     await connection.metadata<PlexTrackMetaData>(albumMetadata.metadatas[0].key);
  // print(trackMetadata);
  //
  // var allAlbum =
  //     await connection.section<PlexAlbumMetaData>(artistLibraries[0].key, type: '9');
  // print(allAlbum.metadatas);
  // var allTracks =
  //     await connection.section(artistLibraries[0].key, type: '10');
  // print(allTracks);

  print('start checking...');

  var requestRaw = await connection.requestRaw('/poll');
  print(requestRaw.headers);
}
