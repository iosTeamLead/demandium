import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:demandium/core/common_model/errrors_model.dart';
import 'package:demandium/components/core_export.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as foundation;

class ApiClient extends GetxService {
  final String? appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    printLog('Token: $token');
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
      printLog( addressModel.toJson());
    }catch(e) {
      if (kDebugMode) {
        print('');
      }
    }

    ///pick zone id to update header
    updateHeader(
      token, addressModel?.zoneId,
      sharedPreferences.getString(AppConstants.languageCode),
    );
  }
  void updateHeader(String? token, String? zoneIDs, String? languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.zoneId: zoneIDs ?? '',
      AppConstants.localizationKey: languageCode ?? AppConstants.languages[0].languageCode!,
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');
    try {
      printLog('====> API Call: $uri\nHeader: $_mainHeaders');
      http.Response response = await http.get(
        Uri.parse(appBaseUrl!+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');
    printLog('====> body : ${body.toString()}');

    http.Response response = await http.post(
      Uri.parse(appBaseUrl!+uri!),
      body: jsonEncode(body),
      headers: headers ?? _mainHeaders,
    ).timeout(Duration(seconds: timeoutInSeconds));
    try {
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartDataConversation(
      String? uri,
      Map<String, String> body,
      List<MultipartBody>? multipartBody,
      {Map<String, String>? headers,PlatformFile? otherFile}) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
    request.headers.addAll(headers ?? _mainHeaders);

    if(otherFile != null) {
      request.files.add(http.MultipartFile('files[${multipartBody!.length}]', otherFile.readStream!, otherFile.size, filename: basename(otherFile.name)));
    }
    if(multipartBody!=null){
      for(MultipartBody multipart in multipartBody) {
        Uint8List list = await multipart.file.readAsBytes();
        request.files.add(http.MultipartFile(
          multipart.key!, multipart.file.readAsBytes().asStream(), list.length, filename:'${DateTime.now().toString()}.png',
        ));
      }
    }
    request.fields.addAll(body);
    http.Response response = await http.Response.fromStream(await request.send());
    return handleResponse(response, uri);
  }

  Future<Response> postMultipartData(String? uri, Map<String, String> body, List<MultipartBody>? multipartBody, {Map<String, String>? headers}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
      request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody!) {
        if(kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          http.MultipartFile part = http.MultipartFile(
            multipart.key!, multipart.file.readAsBytes().asStream(), list.length,
            filename: basename(multipart.file.path), contentType: MediaType('images', 'jpg'),
          );
          request.files.add(part);
        }else {
          File file = File(multipart.file.path);
          request.files.add(http.MultipartFile(
            multipart.key!, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    printLog('====> body : ${body.toString()}');
    try {
      http.Response response = await http.put(
        Uri.parse(appBaseUrl!+uri!),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String? uri, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(appBaseUrl!+uri!),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String? uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    }catch(e) {
      if (kDebugMode) {
        print("");
      }
    }
    Response response0 = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(response0.statusCode != 200 && response0.body != null && response0.body is !String) {
      if(response0.body.toString().startsWith('{response_code:')) {
        ErrorsModel errorResponse = ErrorsModel.fromJson(response0.body);
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: errorResponse.responseCode);
      }else if(response0.body.toString().startsWith('{message')) {
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: response0.body['message']);
      }
    }else if(response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(foundation.kDebugMode) {
       debugPrint('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }
    return response0;
  }
}

class MultipartBody {
  String? key;
  XFile file;

  MultipartBody(this.key, this.file);
}