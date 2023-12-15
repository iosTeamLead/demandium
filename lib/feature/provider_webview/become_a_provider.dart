import 'package:demandium/components/core_export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class ProviderWebView extends StatefulWidget {
  const ProviderWebView({Key? key}) : super(key: key);

  @override
  State<ProviderWebView> createState() => _ProviderWebViewState();
}

class _ProviderWebViewState extends State<ProviderWebView> {

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: url),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).primaryColorLight,
      //   leading: IconButton(
      //     hoverColor:Colors.transparent,
      //     icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).colorScheme.primary),
      //     color: Theme.of(context).textTheme.bodyLarge!.color,
      //     onPressed: () =>  Navigator.pop(context),
      //   ),
      //   leadingWidth: 70,
      //   title: Tex,
      // ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InAppWebView(
              key: webViewKey,
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              androidOnPermissionRequest: (_, __, resources) async {
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT,
                );
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },

              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = url;
                });
              },

              initialUrlRequest: URLRequest(url: Uri.parse('${AppConstants.baseUrl}/provider/auth/sign-up')),
            ),

            progress < 1.0
                ? LinearProgressIndicator(
              value: progress,color: Theme.of(context).primaryColor,
              minHeight: 10,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
