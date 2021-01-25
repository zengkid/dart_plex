import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dart_plex.dart';
import 'exception/plex_exception.dart';

enum Method { get, head, post, put, delete, patch }

Future<dynamic> postRequest(uri,
    {Map<String, dynamic> params, PlexHeaders headers}) async {
  var data = await requestPlexJson(uri,
      method: Method.post, params: params, headers: headers);
  return data;
}

Future<dynamic> getRequest(uri,
    {Map<String, dynamic> params, PlexHeaders headers}) async {
  var data = await requestPlexJson(uri,
      method: Method.get, params: params, headers: headers);
  return data;
}

Future<dynamic> deleteRequest(uri,
    {Map<String, dynamic> params, PlexHeaders headers}) async {
  var data = await requestPlexJson(uri,
      method: Method.delete, params: params, headers: headers);
  return data;
}

Future<dynamic> patchRequest(uri,
    {Map<String, dynamic> params, PlexHeaders headers}) async {
  var data = await requestPlexJson(uri,
      method: Method.patch, params: params, headers: headers);
  return data;
}

Future<http.Response> requestPlexRaw(uri,
    {Method method = Method.get,
    Map<String, String> params,
    Map<String, String> headers}) async {
  try {
    var response;
    switch (method) {
      case Method.head:
        response = await http.head(uri, headers: headers);
        break;
      case Method.post:
        response = await http.post(uri, headers: headers, body: params);
        break;
      case Method.put:
        response = await http.put(uri, headers: headers, encoding: utf8);
        break;
      case Method.delete:
        response = await http.delete(uri, headers: headers);
        break;
      case Method.patch:
        response = await http.patch(uri, headers: headers, encoding: utf8);
        break;
      case Method.get:
      default:
        response = await http.get(uri, headers: headers);
    }
    return response;
  } catch (e) {
    throw PlexException(e.toString());
  }
}

Future<dynamic> requestPlexJson(uri,
    {Method method = Method.get,
    Map<String, dynamic> params,
    PlexHeaders headers}) async {
  var header = headers.toMap();
  header['Accept'] = 'application/json';

  var response = await requestPlexRaw(uri,
      method: method, params: params, headers: header);

  var body = utf8.decode(response.bodyBytes);

  var data = json.decode(body.isEmpty ? '{}' : body);

  if (response.statusCode ~/ 100 != 2) {
    throw PlexException(data.toString());
  }

  return data;
}
