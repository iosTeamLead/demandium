import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:get/get.dart';

class WebLandingController extends GetxController implements GetxService {
  final WebLandingRepo webLandingRepo;

  WebLandingController(this.webLandingRepo);

  WebLandingContent? _webLandingContent;
  List<SocialMedia>? _socialMedia;
  Map<String, dynamic>? _textContent ;

  int? _currentPage = 0;
  int? get currentPage => _currentPage;

  WebLandingContent? get webLandingContent=> _webLandingContent;
  List<SocialMedia>? get socialMedia=> _socialMedia;
  Map<String, dynamic>? get textContent=> _textContent;

  Future<void> getWebLandingContent({bool reload = true}) async {
    if(_webLandingContent == null || reload ){
      Response response = await webLandingRepo.getWebLandingContents();
      if(response.statusCode == 200){
        _webLandingContent = WebLandingContent.fromJson(response.body['content']);

        if(_webLandingContent?.socialMedia!=null){
          _socialMedia = _webLandingContent?.socialMedia;
        }
      }else{
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void setPageIndex(int index){
    _currentPage = index;
    update();
  }

}