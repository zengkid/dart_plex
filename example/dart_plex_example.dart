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

  var library = await connection.library();

  var artistLibraries =
      library.directories.where((e) => e.type == 'artist').toList();

  // var artistSection = await connection.sectionMetadatas(artistLibraries[0].key);
  //
  // var albumMetadata =
  //     await connection.sectionMetadata(artistSection.metadatas[0].key);
  // var trackMetadata =
  //     await connection.sectionMetadata(albumMetadata.metadatas[0].key);
  // print(trackMetadata);

  var allAlbums =
      await connection.sectionMetadatas(artistLibraries[0].key, type: '9');
  print(allAlbums);
  var allTracks =
      await connection.sectionMetadatas(artistLibraries[0].key, type: '10');
  print(allTracks);
}
