import 'dart:convert';
import 'package:demandium/components/push_notification_dialog.dart';
import 'package:demandium/data/model/notification_body.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:demandium/components/core_export.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (payload) async {
      if (kDebugMode) {
        print("Payload: $payload");
      }

      try{
        if(payload.payload!=null && payload.payload!=''){
          NotificationBody notificationBody = NotificationBody.fromJson(jsonDecode(payload.payload!));
          if (kDebugMode) {
            print("Type: ${notificationBody.type}");
          }
          if(notificationBody.type == "chatting"){
            Get.toNamed(RouteHelper.getChatScreenRoute(
                notificationBody.channelId ?? "",
                notificationBody.userName ?? "",
                notificationBody.userProfileImage ?? "",
                notificationBody.userPhone ?? "",
                "",
              notificationBody.userType ?? "",
            ));
          }
          else if(notificationBody.type == 'bidding'){
            Get.toNamed(RouteHelper.getMyPostScreen());
          }
          else if(notificationBody.type == 'wallet'){
            if(!Get.currentRoute.contains(RouteHelper.myWallet)){
              Get.toNamed(RouteHelper.getMyWalletScreen());
            }
          }
          else if(notificationBody.type == 'booking' && notificationBody.bookingId !=null && notificationBody.bookingId!=''){
            Get.toNamed(RouteHelper.getBookingDetailsScreen(notificationBody.bookingId.toString(),"",'fromNotification'));
          } else if(notificationBody.type=='privacy_policy' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
          }else if(notificationBody.type=='terms_and_conditions' && notificationBody.title!=null && notificationBody.title!=''){
              Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
          }else{
              Get.toNamed(RouteHelper.getNotificationRoute());
          }
        }
      }catch (e) {
        if (kDebugMode) {
          print("");
        }
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printLog("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey} || ${message.data}");

      if(!ResponsiveHelper.isWeb()){
        if(message.data['type']=='bidding'){

          if((message.data['post_id']!="" && message.data['post_id']!=null) && (message.data['provider_id']!="" && message.data['provider_id']!=null)){
            Get.find<CreatePostController>().providerBidDetailsForNotification(message.data['post_id'],message.data['provider_id']);
          }else{
            NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
          }

          if(Get.currentRoute==RouteHelper.myPost){
            Get.find<CreatePostController>().getMyPostList(1);
          }
        }
        else if(message.data['type'] == 'chatting'){

          if(Get.currentRoute.contains(RouteHelper.chatScreen) && (message.data['channel_id']!="" && message.data['channel_id']!=null)){
            Get.find<ConversationController>().cleanOldData();
            Get.find<ConversationController>().setChannelId(message.data['channel_id']);
            Get.find<ConversationController>().getConversation(message.data['channel_id'], 1,isInitial:true);
          } else{
            NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
          }
        }
        else{
          NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
        }
      }
      else{
        if(Get.find<AuthController>().isLoggedIn()) {
          NotificationBody notificationBody = NotificationBody.fromJson(message.data);

          if(message.data["type"]=="chatting" && (message.data['channel_id']!="" && message.data['channel_id']!=null) && Get.currentRoute.contains(RouteHelper.chatScreen)){
            Get.find<ConversationController>().cleanOldData();
            Get.find<ConversationController>().setChannelId(message.data['channel_id']);
            Get.find<ConversationController>().getConversation(message.data['channel_id'], 1,isInitial:true);
          } else if(message.data["type"]=="bidding" && message.data["provider_id"]==""){

          }
          else{

            Future.delayed(const Duration(milliseconds: 1700),(){
              Get.dialog(PushNotificationDialog(
                  title: message.notification!.title,
                  notificationBody: notificationBody
              ));
            });

          }

          if(message.data["type"]=="bidding" &&Get.currentRoute==RouteHelper.myPost && (message.data['post_id']!="" && message.data['post_id']!=null)){
            Get.find<CreatePostController>().getMyPostList(1,reload: true);
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      printLog("onMessageOpenApp: ${message?.notification!.title}/${message?.notification!.body}/${message?.notification!.titleLocKey} || ${message?.data}");

     try{
       if(message !=null && message.data.isNotEmpty) {
         NotificationBody notificationBody = convertNotification(message.data);
         if(notificationBody.type == "chatting"){
           Get.toNamed(RouteHelper.getChatScreenRoute(
             notificationBody.channelId ?? "",
             notificationBody.userName ?? "",
             notificationBody.userProfileImage ?? "",
             notificationBody.userPhone ?? "",
             "",
             notificationBody.userType ?? "",
           ));
         }
         else if(notificationBody.type == 'bidding'){
          if(!Get.currentRoute.contains(RouteHelper.myWallet)){
            Get.toNamed(RouteHelper.getMyPostScreen());
          }
         }
         else if(notificationBody.type == 'booking' && notificationBody.bookingId != null && notificationBody.bookingId !=''){
           Get.toNamed(RouteHelper.getBookingDetailsScreen(notificationBody.bookingId.toString(),"",'fromNotification'));
         }
         else if(notificationBody.type == 'privacy_policy' && notificationBody.title != null && notificationBody.title !=''){
           Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
         }
         else if(notificationBody.type == 'terms_and_conditions' && notificationBody.title != null && notificationBody.title !=''){
           Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
         }
         else if(notificationBody.type == "wallet"){
          Get.toNamed(RouteHelper.getMyWalletScreen());
         }
         else{
           Get.toNamed(RouteHelper.getNotificationRoute());
         }
       }
     }catch (e) {
       if (kDebugMode) {
         print("");
       }
     }
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    if(!GetPlatform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? image;
      String playLoad = jsonEncode(message.data);



      if(data) {

        title = message.data['title']?.replaceAll('_', ' ').toString().capitalize;
        body = message.data['body'].replaceAll('_', ' ').toString();
        orderID = message.data['booking_id'].toString();
        image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
      }else {
        title = message.notification!.title?.replaceAll('_', ' ').toString().capitalize;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        if(GetPlatform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
        }else if(GetPlatform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
        }
      }

      if(image != null && image.isNotEmpty) {
        try{
          await showBigPictureNotificationHiddenLargeIcon(title!, body!, playLoad, image, fln);
        }catch(e) {
          await showBigTextNotification(title!, '',playLoad, orderID!,fln);
        }

      }else {
        await showBigTextNotification(title!, '',playLoad, orderID!, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'demandium', 'demandium', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigTextNotification(String title, String body, String payload, String image, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    if(!Get.find<AuthController>().isNotificationActive()){
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithoutsound","demandium without sound", channelDescription:"description",
        playSound: false,
        importance: Importance.max,
        styleInformation: bigTextStyleInformation, priority: Priority.max,

      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
    }
    else {
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithsound", 'demandium with sound', channelDescription:"description",
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('notification'),
        importance: Importance.max,
        styleInformation: bigTextStyleInformation, priority: Priority.max,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(1, title, body, platformChannelSpecifics, payload: payload);
    }
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String payload, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    if(!Get.find<AuthController>().isNotificationActive()){
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithoutsound","demandium without sound", channelDescription:"description",
        playSound: false,
        largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max,
        styleInformation: bigPictureStyleInformation, importance: Importance.max,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(0, title, body, platformChannelSpecifics, payload: payload);

    }else{
      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "demandiumWithsound", 'demandium with sound', channelDescription:"description",
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('notification'),
        largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max,
        styleInformation: bigPictureStyleInformation, importance: Importance.max,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await fln.show(1, title, body, platformChannelSpecifics, payload: payload);
    }
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data){
   return NotificationBody.fromJson(data);
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  printLog("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}