class SignInResponse {
  String? responseCode;
  String? message;
  Content? content;

  SignInResponse({this.responseCode, this.message, this.content});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class Content {
  String? token;
  int? isActive;

  Content({this.token, this.isActive});

  Content.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['is_active'] = isActive;
    return data;
  }
}