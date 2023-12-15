import 'package:demandium/core/helper/string_parser.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  final String? fromPage;
  const PaymentScreen({super.key, required this.url,this.fromPage});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  String? selectedUrl;
  double value = 0.0;
  final bool _isLoading = true;
  PullToRefreshController pullToRefreshController = PullToRefreshController();
  MyInAppBrowser? browser;

  @override
  void initState() {
    super.initState();
    selectedUrl = widget.url;
    _initData(widget.fromPage ?? "" );
  }

  void _initData(String fromPage) async {
    browser = MyInAppBrowser(fromPage: fromPage);
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable = await AndroidWebViewFeature
          .isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController = AndroidServiceWorkerController.instance();
        await serviceWorkerController.setServiceWorkerClient(
            AndroidServiceWorkerClient(
              shouldInterceptRequest: (request) async {
                if (kDebugMode) {
                  print(request);
                }
                return null;
              },
            ),
        );
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser?.webViewController.reload();
        } else if (Platform.isIOS) {
          browser?.webViewController.loadUrl(urlRequest: URLRequest(
              url: await browser?.webViewController.getUrl()));
        }
      },
    );
    browser?.pullToRefreshController = pullToRefreshController;

    await browser?.openUrlRequest(
      urlRequest: URLRequest(url: Uri.parse(selectedUrl!)),
      options: InAppBrowserClassOptions(
        crossPlatform: InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: CustomAppBar(title: 'payment'.tr,),
      body: Center(
        child: Stack(
          children: [
            _isLoading ? Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary)),
            ) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  final String fromPage;

  MyInAppBrowser({required  this.fromPage});

  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {
    if (kDebugMode) {
      print("\n\nBrowser Created!\n\n");
    }
  }

  @override
  Future onLoadStart(url) async {
    if (kDebugMode) {
      print("\n\nStarted: $url\n\n");
    }
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    if (kDebugMode) {
      print("\n\nStopped: $url\n\n");
    }
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    if (kDebugMode) {
      print("Can't load [$url] Error: $message");
    }
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
    if (kDebugMode) {
      print("Progress: $progress");
    }
  }

  @override
  void onExit() {
    if(_canRedirect) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const AlertDialog(
              contentPadding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              content: PaymentFailedDialog(),
            ),
          );
        },
      );

    }

    if (kDebugMode) {
      print("\n\nBrowser closed!\n\n");
    }
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(navigationAction) async {
    if (kDebugMode) {
      print("\n\nOverride ${navigationAction.request.url}\n\n");
    }
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(resource) {
   // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    if (kDebugMode) {
      print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
    }
  }

  void _pageRedirect(String url) async {
    if (kDebugMode) {
      print("inside_page_redirect");
    }
    printLog("url:$url");
    if(_canRedirect) {
      bool isSuccess = url.contains('success') && url.contains(AppConstants.baseUrl);
      bool isFailed = url.contains('fail') && url.contains(AppConstants.baseUrl);
      bool isCancel = url.contains('cancel') && url.contains(AppConstants.baseUrl);


      if (kDebugMode) {
        print('This_called_1::::$url');
      }
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
        close();
      }

      if (isSuccess) {
        if(fromPage == "checkout"){

          String token = StringParser.parseString(url, "token");

          Get.find<CartController>().getCartListFromServer();
          Get.back();
          Get.offNamed(RouteHelper.getCheckoutRoute(RouteHelper.checkout,'complete','null',token: token));
        }else if(fromPage=="custom-checkout"){
          Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
        } else if(fromPage == "add-fund"){
          Get.back();
          String uuid = const Uuid().v1();
          Get.offNamed(RouteHelper.getMyWalletScreen(flag : 'success', token: uuid));
        }
      } else if (isFailed || isCancel) {
        if(fromPage=="add-fund"){
          Get.offNamed(RouteHelper.getMyWalletScreen(flag : 'failed'));
        }else{
          Get.offNamed(RouteHelper.getOrderSuccessRoute('fail'));
        }
      }
    }
  }
}




