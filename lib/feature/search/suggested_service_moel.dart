class SuggestedServiceModel {
  String? responseCode;
  String? message;
  SuggestedServiceContent? content;

  SuggestedServiceModel({this.responseCode, this.message, this.content});

  SuggestedServiceModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? SuggestedServiceContent.fromJson(json['content']) : null;
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

class SuggestedServiceContent {
  int? currentPage;
  List<SuggestedService>? data;

  SuggestedServiceContent({this.currentPage, this.data});

  SuggestedServiceContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SuggestedService>[];
      json['data'].forEach((v) {
        data!.add(SuggestedService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuggestedService {
  String? id;
  String? keyword;

  SuggestedService({this.id, this.keyword});

  SuggestedService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['keyword'] = keyword;
    return data;
  }
}