import 'package:demandium/data/model/notification_body.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:uuid/uuid.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, @required this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    if( Get.find<SplashController>().getGuestId().isEmpty){
      var uuid = const Uuid().v1();
      Get.find<SplashController>().setGuestId(uuid);
    }

    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    _route();

  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(const Duration(seconds: 1), () async {
          bool isAvailableUpdate =false;

          String minimumVersion = "1.1.0";
          double? minimumBaseVersion =1.0;
          double? minimumLastVersion =0;

          String appVersion = AppConstants.appVersion;
          double? baseVersion = double.tryParse(appVersion.substring(0,3));
          double lastVersion=0;
          if(appVersion.length>3){
             lastVersion = double.tryParse(appVersion.substring(4,5))!;
          }


          if(GetPlatform.isAndroid && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString();
            if(minimumVersion.length==1){
              minimumVersion = "$minimumVersion.0";
            }
            if(minimumVersion.length==3){
              minimumVersion = "$minimumVersion.0";
            }
            minimumBaseVersion = double.tryParse(minimumVersion.substring(0,3));
            minimumLastVersion = double.tryParse(minimumVersion.substring(4,5));

            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          else if(GetPlatform.isIOS && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!;
            if(minimumVersion.length==1){
              minimumVersion = "$minimumVersion.0";
            }
            if(minimumVersion.length==3){
              minimumVersion = "$minimumVersion.0";
            }
            minimumBaseVersion = double.tryParse(minimumVersion.substring(0,3));
            if(minimumVersion.length>3){
              minimumLastVersion = double.tryParse(minimumVersion.substring(4,5));
            }
            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          if(isAvailableUpdate) {
            Get.offNamed(RouteHelper.getUpdateRoute(isAvailableUpdate));
          }
          else {
            if(widget.body != null) {

              String notificationType = widget.body?.type??"";

              switch(notificationType) {

                case "chatting": {
                  Get.toNamed(RouteHelper.getChatScreenRoute(
                    widget.body?.channelId??"",
                    widget.body?.userName??"",
                    widget.body?.userProfileImage??"",
                    widget.body?.userPhone??"",
                    "",
                    widget.body?.userType??"",
                  ));
                } break;

                case "booking": {
                  if( widget.body!.bookingId!=null&& widget.body!.bookingId!=""){
                    Get.toNamed(RouteHelper.getBookingDetailsScreen(widget.body!.bookingId!,"",'fromNotification'));
                  }else{
                    Get.toNamed(RouteHelper.getMainRoute(""));
                  }
                } break;

                case "privacy_policy": {
                  Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
                } break;

                case "terms_and_conditions": {
                  Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
                } break;

                default: {
                  Get.toNamed(RouteHelper.getNotificationRoute());
                } break;
              }
            }
            else {
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                if (Get.find<LocationController>().getUserAddress() != null) {

                  Get.offNamed(RouteHelper.getInitialRoute());
                } else {
                  Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
                }
              } else {
                if(!Get.find<SplashController>().isSplashSeen()){
                  Get.offNamed(RouteHelper.getLanguageScreen('fromOthers'));
                }else{
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }
              }
            }
          }
        });
      }else{

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        PriceConverter.getCurrency();
        return Center(
          child: splashController.hasConnection ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Image.asset(
                Images.logo,
                width: Dimensions.logoSize,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
            ],
          ) : NoInternetScreen(child: SplashScreen(body: widget.body)),
        );
      }),
    );
  }
}
