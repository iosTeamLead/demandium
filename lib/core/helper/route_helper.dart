import 'dart:convert';
import 'package:demandium/data/model/notification_body.dart';
import 'package:demandium/feature/booking/view/booking_track_screen.dart';
import 'package:demandium/feature/checkout/view/custom_post_checkout_screen.dart';
import 'package:demandium/feature/create_post/model/my_post_model.dart';
import 'package:demandium/feature/create_post/model/provider_offer_model.dart';
import 'package:demandium/feature/create_post/view/create_post_screen.dart';
import 'package:demandium/feature/create_post/view/post_create_successfully_screen.dart';
import 'package:demandium/feature/my_post/view/provider_offer_details_screen.dart';
import 'package:demandium/feature/my_post/view/provider_offers_list_screen.dart';
import 'package:demandium/feature/loyalty_point/binding/loyalty_point_binding.dart';
import 'package:demandium/feature/loyalty_point/loyality_point_screen.dart';
import 'package:demandium/feature/my_post/view/all_post_screen.dart';
import 'package:demandium/feature/provider/view/all_provider_view.dart';
import 'package:demandium/feature/provider/view/provider_details_screen.dart';
import 'package:demandium/feature/provider/view/provider_review_screen.dart';
import 'package:demandium/feature/provider_webview/become_a_provider.dart';
import 'package:demandium/feature/refer_and_earn/refer_and_earn_screen.dart';
import 'package:demandium/feature/service/model/feathered_service_model.dart';
import 'package:demandium/feature/service/view/all_feathered_category_services.dart';
import 'package:demandium/feature/booking/view/booking_list_screen.dart';
import 'package:demandium/feature/suggest_new_service/binding/suggest_service_binding.dart';
import 'package:demandium/feature/suggest_new_service/view/suggest_service_screen.dart';
import 'package:demandium/feature/suggest_new_service/view/suggested_service_list_screen.dart';
import 'package:demandium/feature/wallet/binding/wallet_binding.dart';
import 'package:demandium/feature/wallet/wallet_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/core/initial_binding/initial_binding.dart';
import 'package:demandium/feature/category/bindings/category_bindings.dart';
import 'package:demandium/feature/category/view/sub_category_screen.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:demandium/feature/service/view/all_service_view.dart';
import 'package:demandium/feature/html/html_viewer_screen.dart';
import 'package:demandium/feature/settings/bindings/settings_bindings.dart';
import 'package:demandium/utils/html_type.dart';
import 'package:demandium/components/core_export.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String offers = '/offers';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String accessLocation = '/access-location';
  static const String pickMap = '/pick-map';
  static const String main = '/main';
  static const String verification = '/verification';
  static const String sendOtpScreen = '/send-otp';
  static const String changePassword = '/change-password';
  static const String searchScreen = '/search';
  static const String service = '/service';
  static const String profile = '/profile';
  static const String profileEdit = '/profile-edit';
  static const String notification = '/notification';
  static const String map = '/map';
  static const String address = '/address';
  static const String orderSuccess = '/order-completed';
  static const String checkout = '/checkout';
  static const String customPostCheckout = '/custom-post-checkout';
  static const String html = '/html';
  static const String categories = '/categories';
  static const String categoryProduct = '/category-product';
  static const String popularFoods = '/popular-foods';
  static const String itemCampaign = '/item-campaign';
  static const String support = '/help-and-support';
  static const String rateReview = '/rate-and-review';
  static const String update = '/update';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';
  static const String editAddress = '/edit-address';
  static const String restaurantReview = '/restaurant-review';
  static const String serviceImages = '/service-images';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String onBoardScreen = '/onBoardScreen';
  static const String settingScreen = '/settingScreen';
  static const String languageScreen = '/language-screen';
  static const String voucherScreen = '/voucherScreen';
  static const String bookingListScreen = '/booking-list-Screen';
  static const String bookingDetailsScreen = '/bookingDetailsScreen';
  static const String trackBooking = '/track-booking';
  static const String rateReviewScreen = '/rateReviewScreen';
  static const String allServiceScreen = '/allServiceScreen';
  static const String featheredServiceScreen = '/featheredServiceScreen';
  static const String subCategoryScreen = '/subCategoryScreen';
  static const String paymentPage = '/paymentPage';
  static const String invoice = '/invoice';
  static const String completeBooking = '/completeBooking';
  static const String notLoggedScreen = '/notLoggedScreen';
  static const String suggestService = '/suggest-service';
  static const String suggestServiceList = '/suggest-service-list';
  static const String myWallet = '/my-wallet';
  static const String loyaltyPoint = '/my-point';
  static const String referAndEarn = '/refer-and-earn';
  static const String allProviderList = '/all-provider';
  static const String providerDetailsScreen = '/provider-details';
  static const String providerReviewScreen = '/provider-review-screen';
  static const String createPost = '/create-post';
  static const String createPostSuccessfully = '/create-post-successfully';
  static const String myPost = '/my-post';
  static const String providerOfferList = '/provider-offer-list';
  static const String providerOfferDetails = '/provider-offer-details';
  static const String providerWebView = '/provider-web-view';


  static String getInitialRoute({String fromPage = "home"}) => '$initial?page=$fromPage';
  static String getSplashRoute(NotificationBody? body) {
    String data = 'null';
    if(body != null) {
      List<int> encoded = utf8.encode(jsonEncode(body));
      data = base64Encode(encoded);
    }
    return '$splash?data=$data';
  }
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getOffersRoute(String page) => '$offers?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getSignUpRoute() => signUp;

  static String getSendOtpScreen(String fromScreen){
    return '$sendOtpScreen?fromPage=$fromScreen';
  }

  static String getVerificationRoute(String identity,String identityType, String fromPage) {
    String data = Uri.encodeComponent(jsonEncode(identity));
    return '$verification?identity=$data&identity_type=$identityType&fromPage=$fromPage';
  }
  static String getChangePasswordRoute(String identity,String identityType ,String otp) {
    String identity0 = Uri.encodeComponent(jsonEncode(identity));
    String otp0 = Uri.encodeComponent(jsonEncode(otp));
    return '$changePassword?identity=$identity0&identity_type=$identityType&otp=$otp0';
  }

  static String getAccessLocationRoute(String page) =>
      '$accessLocation?page=$page';
  static String getPickMapRoute(String page, bool canRoute, String isFromCheckout) {
   return '$pickMap?page=$page&route=${canRoute.toString()}&checkout=$isFromCheckout';
  }
  static String getMainRoute(String page) => '$main?page=$page';


  static String getSearchResultRoute({String? queryText}) => '$searchScreen?query=${queryText ?? ''}';
  static String getServiceRoute(String id, {String fromPage="others"}) => '$service?id=$id&fromPage=$fromPage';
  static String getProfileRoute() => profile;
  static String getEditProfileRoute() => profileEdit;
  static String getNotificationRoute() => notification;
  static String getMapRoute(AddressModel addressModel, String page) {
    List<int> encoded = utf8.encode(jsonEncode(addressModel.toJson()));
    String data = base64Encode(encoded);
    return '$map?address=$data&page=$page';
  }

  static String getAddressRoute(String fromPage) => '$address?fromProfileScreen=$fromPage';
  static String getOrderSuccessRoute( String status) => '$orderSuccess?flag=$status';
  static String getCheckoutRoute(String page,String currentPage,String addressId, {bool? reload, String? token} ) {
    return '$checkout?currentPage=$currentPage&addressID=$addressId&reload=$reload&token=$token';
  }

  static String getCustomPostCheckoutRoute(String postId,String providerId,String amount) {
    List<int> encoded = utf8.encode(amount);
    String data = base64Encode(encoded);
    return "$customPostCheckout?postId=$postId&providerId=$providerId&amount=$data";
  }
  static String getTrackBookingRoute() => trackBooking;
  static String getHtmlRoute(String page) => '$html?page=$page';
  static String getCategoryRoute(String fromPage,String campaignID) => '$categories?fromPage=$fromPage&campaignID=$campaignID';
  static String getCategoryProductRoute(String id, String name, String subCategoryIndex) {
    List<int> encoded = utf8.encode(name);
    String data = base64Encode(encoded);
    return '$categoryProduct?id=$id&name=$data&subCategoryIndex=$subCategoryIndex';
  }

  static String getPopularFoodRoute() => '$popularFoods?page=popular';
  static String getItemCampaignRoute() => itemCampaign;
  static String getSupportRoute() => support;
  static String getReviewRoute() => rateReview;
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getCartRoute() => cart;
  static String getAddAddressRoute(bool fromCheckout) => '$addAddress?page=${fromCheckout ? 'checkout' : 'address'}';
  static String getEditAddressRoute(AddressModel address) {
    String data = base64Url.encode(utf8.encode(jsonEncode(address.toJson())));
    return '$editAddress?data=$data';
  }
  static String getRestaurantReviewRoute(int restaurantID) =>
      '$restaurantReview?id=$restaurantID';


  static String getItemImagesRoute(Service product) {
    String data = base64Url.encode(utf8.encode(jsonEncode(product.toJson())));
    return '$serviceImages?item=$data';
  }

  static String getChatScreenRoute(
      String channelId,
      String name,
      String image,
      String phone,
      String bookingID,
      String userType
      ){
    return '$chatScreen?channelID=$channelId&name=$name&image=$image&phone=$phone&bookingID=$bookingID&userType=$userType';
  }


  static String getSettingRoute() => settingScreen;
  static String getBookingScreenRoute(bool isFromMenu) => '$bookingListScreen?isFromMenu=$isFromMenu';

  static String getInboxScreenRoute() => chatInbox;
  static String getVoucherRoute() => voucherScreen;

  static String getBookingDetailsScreen(String bookingID, String phone , String fromPage ) {
    return '$bookingDetailsScreen?bookingID=$bookingID&phone=$phone&fromPage=$fromPage';
  }

  static String getRateReviewScreen(
      String id,
      ) {
    return '$rateReviewScreen?id=$id';
  }

  static String allServiceScreenRoute(String fromPage, {String campaignID = ''}) => '$allServiceScreen?fromPage=$fromPage&campaignID=$campaignID';
  static String getFeatheredCategoryService(String fromPage, CategoryData categoryData) {
    String data = base64Url.encode(utf8.encode(jsonEncode(categoryData.toJson())));
    return '$featheredServiceScreen?fromPage=$fromPage&categoryData=$data';
  }
  static String subCategoryScreenRoute(String categoryName,String categoryID,int subCategoryIndex) {
    return '$subCategoryScreen?categoryName=$categoryName&categoryId=$categoryID&subCategoryIndex=$subCategoryIndex';
  }
  static String getPaymentScreen(String url) => '$paymentPage?url=$url';
  static String getInvoiceRoute(String bookingID) => '$invoice?bookingID=$bookingID';
  static String getCompletedBooking() => completeBooking;
  static String getLanguageScreen(String fromPage) => '$languageScreen?fromPage=$fromPage';
  static String getNotLoggedScreen(String fromPage,String appbarTitle) => '$notLoggedScreen?fromPage=$fromPage&appbarTitle=$appbarTitle';
  static String getMyWalletScreen({String? flag , String? token}) => '$myWallet?flag=$flag&&token=$token';
  static String getLoyaltyPointScreen() => loyaltyPoint;
  static String getReferAndEarnScreen() => referAndEarn;
  static String getNewSuggestedServiceScreen() => suggestService;
  static String getNewSuggestedServiceList() => suggestServiceList;
  static String getAllProviderRoute() => allProviderList;
  static String getProviderDetails(String providerId,String subCategories) => '$providerDetailsScreen?provider_id=$providerId&sub_categories=$subCategories';
  static String getProviderReviewScreen(String subcategories,String providerId) => '$providerReviewScreen?sub_categories=$subcategories&provider_id=$providerId';
  static String getCreatePostScreen({String? schedule}){
    List<int> encoded = utf8.encode(jsonEncode(schedule));
    String data = base64Encode(encoded);
    return "$createPost?schedule=$data";
  }
  static String getCreatePostSuccessfullyScreen() => createPostSuccessfully;
  static String getMyPostScreen() => myPost;
  static String getProviderOfferListScreen(String postId ,String status, MyPostData myPostData) {
    List<int> encoded = utf8.encode(jsonEncode(myPostData.toJson()));
    String data = base64Encode(encoded);
     return "$providerOfferList?postId=$postId&myPostData=$data&status=$status";
  }
  static String getProviderOfferDetailsScreen(String postId , ProviderOfferData providerOfferData) {
    List<int> encoded = utf8.encode(jsonEncode(providerOfferData.toJson()));
    String data = base64Encode(encoded);
    return "$providerOfferDetails?postId=$postId&providerOfferData=$data";
  }

  static String getProviderWebView() => providerWebView;

  static List<GetPage> routes = [
    GetPage(
      name: initial, binding: BottomNavBinding(),
      page: () => getRoute(ResponsiveHelper.isDesktop(Get.context)
          ? AccessLocationScreen(fromSignUp: false, fromHome: Get.parameters['page']=='home', route: RouteHelper.getMainRoute('home'))
          : const BottomNavScreen(pageIndex: 0)),
    ),
    GetPage(name: splash, page: () {
      NotificationBody? data;
      if(Get.parameters['data'] != 'null') {
        List<int> decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
        data = NotificationBody.fromJson(jsonDecode(utf8.decode(decode)));
      }
      return SplashScreen(body: data);
    }),
    GetPage(name: language, page: () => const ChooseLanguageBottomSheet()),
    GetPage(name: languageScreen, page: () => LanguageScreen(fromPage: Get.parameters['fromPage']!,)),
    GetPage(name: offers, page: () => getRoute(const OfferScreen())),
    GetPage(name: signIn, page: () =>
        SignInScreen(
          exitFromApp: Get.parameters['page'] == signUp || Get.parameters['page'] == splash,
          fromPage: Get.parameters['page']! ,
        )),
    GetPage(name: signUp, page: () => const SignUpScreen()),


    GetPage(name: accessLocation, page: () => AccessLocationScreen(
      fromSignUp: Get.parameters['page'] == signUp,
      fromHome: Get.parameters['page'] == 'home', route: null,
    )),
    GetPage(
        name: pickMap,
        page: () {
          PickMapScreen? pickMapScreen = Get.arguments;
          bool fromAddress = Get.parameters['page'] == 'add-address';
          return (fromAddress && pickMapScreen == null) ? const NotFoundScreen() :
          pickMapScreen ?? PickMapScreen(
              fromSignUp: Get.parameters['page'] == signUp,
              fromAddAddress: fromAddress, route: Get.parameters['page']!,
              canRoute: Get.parameters['route'] == 'true',
              formCheckout: Get.parameters['checkout'] == 'true'
      );
    }),
    GetPage(
        binding: BottomNavBinding(),
        name: main,
        page: () => getRoute(BottomNavScreen(
          pageIndex: Get.parameters['page'] == 'home' ? 0 :
          Get.parameters['page'] == 'booking' ? 1 :
          Get.parameters['page'] == 'cart' ? 2 :
          Get.parameters['page'] == 'order' ? 3 :
          Get.parameters['page'] == 'menu' ? 4 : 0,
    ))),

    GetPage(name: sendOtpScreen, page:() {
      return  ForgetPassScreen(
        fromVerification: Get.parameters['fromPage']=="verification",
      );
    }),

    GetPage(name: verification, page:() {
      String data = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));

      return VerificationScreen(
        identity: data,
        identityType: Get.parameters['identity_type']!,
        fromVerification: Get.parameters['fromPage']=="verification",
      );
    }),

    GetPage(name: changePassword, page:() {
      String identity0 = Uri.decodeComponent(jsonDecode(Get.parameters['identity']!));
      String otp0 = Uri.decodeComponent(jsonDecode(Get.parameters['otp']!));

      return NewPassScreen(
          identity: identity0,
          identityType:  Get.parameters['identity_type']!,
          otp: otp0
      );
    }),

    GetPage(name: featheredServiceScreen, page: () {
      List<int> decode = base64Decode(Get.parameters['categoryData']!);
      CategoryData categoryData = CategoryData.fromJson(jsonDecode(utf8.decode(decode)));

      return AllFeatheredCategoryServiceView(
        fromPage: Get.parameters['fromPage']!,
        categoryData: categoryData,
      );
    }),

    GetPage(
        name: searchScreen,
        page: () => getRoute(SearchResultScreen(queryText: Get.parameters['query']))),
    GetPage(
        name: service,
        binding: ServiceDetailsBinding(),
        page: () {
          return getRoute(Get.arguments ?? ServiceDetailsScreen(serviceID: Get.parameters['id']!,fromPage: Get.parameters['fromPage']!,));}),

    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(
        binding: EditProfileBinding(),
        name: profileEdit, page: () => getRoute(const EditProfileScreen())),
    GetPage(name: notification, page: () => getRoute(const NotificationScreen())),
    GetPage(
        name: map,
        page: () {
          List<int> decode = base64Decode(Get.parameters['address']!.replaceAll(' ', '+'));
          AddressModel data = AddressModel.fromJson(jsonDecode(utf8.decode(decode)));
          return getRoute(MapScreen( address: data));
      }),
      GetPage(
          name: orderSuccess,
          page: () => getRoute(OrderSuccessfulScreen(status: Get.parameters['flag'].toString().contains('success') ? 1 : 0,))
      ),
      GetPage( binding: CheckoutBinding(),
        name: checkout, page: () {

          if(Get.parameters['flag'] == 'failed' || Get.parameters['flag'] == 'fail' || Get.parameters['flag'] == 'cancelled' || Get.parameters['flag'] == 'canceled' || Get.parameters['flag'] == 'cancel')  {
            return getRoute(const OrderSuccessfulScreen(status: 0,));
          }
          return getRoute(CheckoutScreen(
            Get.parameters.containsKey('flag') && Get.parameters['flag']! == 'success' ? 'complete' : Get.parameters['currentPage'].toString(),
            Get.parameters['addressID'] != null ? Get.parameters['addressID']! :'null' ,
            reload : Get.parameters['reload'].toString() == "true" || Get.parameters['reload'].toString() == "null" ? true : false,
            token: Get.parameters["token"],
          ));
      }),

      GetPage(name: customPostCheckout, page: (){
        List<int> decode = base64Decode(Get.parameters['amount']!);
        String data = utf8.decode(decode);
        return CustomPostCheckoutScreen(
          postId: Get.parameters['postId']!,
          providerId: Get.parameters['providerId']!,
          amount: data,
        );
      }),

      GetPage(
          binding: InitialBinding(),
          name: html,
          page: () => HtmlViewerScreen(
              htmlType:
              Get.parameters['page'] == 'terms-and-condition' ? HtmlType.termsAndCondition :
              Get.parameters['page'] == 'privacy-policy' ? HtmlType.privacyPolicy :
              Get.parameters['page'] == 'cancellation_policy' ? HtmlType.cancellationPolicy :
              Get.parameters['page'] == 'refund_policy' ? HtmlType.refundPolicy :
              HtmlType.aboutUs
      )),

      GetPage(
          name: categories,
          page: () => getRoute(CategoryScreen(fromPage: Get.parameters['fromPage']!,campaignID:Get.parameters['campaignID']!))),
      GetPage(
          binding: CategoryBindings(),
          name: categoryProduct,
          page: () {
            List<int> decode = base64Decode(Get.parameters['name']!.replaceAll(' ', '+'));
            String data = utf8.decode(decode);
            return getRoute(CategorySubCategoryScreen(
              categoryID: Get.parameters['id']!,
              categoryName: data,
              subCategoryIndex: Get.parameters['subCategoryIndex']!,
            ));
      }),
      GetPage(name: support, page: () => ContactUsPage()),
      GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
      GetPage(name: cart, page: () => getRoute(const CartScreen(fromNav: false))),
      GetPage(name: addAddress, page: () => getRoute(AddAddressScreen(fromCheckout: Get.parameters['page'] == 'checkout'))),
      GetPage(
          name: editAddress,
          page: () => getRoute(AddAddressScreen(
            fromCheckout: false,
            address: AddressModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['data']!.replaceAll(' ', '+'))))),
      ))),
      GetPage(
          name: rateReview,
          page: () => getRoute(Get.arguments ?? const NotFoundScreen())),
     GetPage(name: chatScreen, page: () =>
        ConversationScreen(
          channelID: Get.parameters['channelID']!,
          image: Get.parameters['image']!,
          name: Get.parameters['name']!,
          phone: Get.parameters['phone']!,
          bookingID: Get.parameters['bookingID']!,
          userType: Get.parameters['userType']!,
        ),
        binding: ConversationBinding()),

      GetPage(name: chatInbox,binding: ConversationBinding(), page: () => const ChannelList()),
      GetPage(name: address, page: ()=>getRoute(
          AddressScreen(fromPage:Get.parameters['fromProfileScreen']!)
      ) ),
      GetPage(binding: OnBoardBinding(),name: onBoardScreen, page: ()=>const OnBoardingScreen(),),
      GetPage(name: settingScreen,binding: SettingsBinding(), page: ()=>const SettingScreen(),),
      GetPage(name: voucherScreen, page: ()=> const CouponScreen(),),
      GetPage(binding: BookingBinding(),name: bookingDetailsScreen, page: ()=> BookingDetailsScreen(
        bookingID: Get.parameters['bookingID']!,
        phone: Get.parameters['phone']!,
        fromPage: Get.parameters['fromPage']!,
      ),),

      GetPage(binding: BookingBinding(),name: trackBooking, page: ()=> const BookingTrackScreen(),),
      GetPage(binding: ServiceBinding(),name: allServiceScreen, page:  ()=> getRoute(AllServiceView(fromPage: Get.parameters['fromPage']!,campaignID: Get.parameters['campaignID']!,)),),
      GetPage(binding: ServiceBinding(),name: subCategoryScreen, page: ()=> SubCategoryScreen(
        categoryTitle: Get.parameters['categoryName']!,
        categoryID: Get.parameters['categoryId']!,
        subCategoryIndex: int.parse(Get.parameters['subCategoryIndex']!),
      ),),
      GetPage(
        binding: SubmitReviewBinding(),
        name: rateReviewScreen, page: () {
        // List<int> _decode = base64Decode(Get.parameters['bookingDetailsContent']!.replaceAll(' ', '+'));
        // BookingDetailsContent _data = BookingDetailsContent.fromJson(jsonDecode(utf8.decode(_decode)));
          return RateReviewScreen(
            id : Get.parameters['id'].toString(),
          );
          },),
    GetPage(binding: CheckoutBinding(),name: paymentPage, page: ()=> PaymentScreen(url: Get.parameters['url']!,)),
    GetPage(name: bookingListScreen, page: ()=> BookingListScreen( isFromMenu: Get.parameters['isFromMenu'] == "true"? true: false)),
    GetPage(name: notLoggedScreen, page: ()=> NotLoggedInScreen(
        fromPage: Get.parameters['fromPage']!,
      appbarTitle: Get.parameters['appbarTitle']!,
    )
    ),
    GetPage(binding: SuggestServiceBinding(),name:suggestService, page:() => getRoute(const SuggestServiceScreen(),)),
    GetPage(binding: SuggestServiceBinding(),name:suggestServiceList, page:() => getRoute(const SuggestedServiceListScreen(),)),
    GetPage(binding: WalletBinding(), name: myWallet, page:() =>  WalletScreen(status: Get.parameters['flag'], token: Get.parameters['token'],)),
    GetPage(binding: LoyaltyPointBinding(),name:loyaltyPoint, page:() => const LoyaltyPointScreen()),
    GetPage(name:referAndEarn, page:() => getRoute(const ReferAndEarnScreen(),)),
    GetPage(name:allProviderList, page:() => getRoute(const AllProviderView(),)),
    GetPage(name:providerDetailsScreen, page:() => getRoute(ProviderDetailsScreen(providerId: Get.parameters['provider_id']!,subCategories: Get.parameters['sub_categories']!,))),
    GetPage(name:providerReviewScreen, page:() =>
        getRoute(ProviderReviewScreen(
          subCategories: Get.parameters['sub_categories']!,
          providerId: Get.parameters['provider_id']!,
        ))),
    GetPage( name:createPost, page:() {
      List<int> decode = base64Decode(Get.parameters['schedule']!);
      String data = jsonDecode(utf8.decode(decode));
      return CreatePostScreen(
        schedule: data,
      );
    }),
    GetPage(name:createPostSuccessfully, page:() => getRoute(const PostCreateSuccessfullyScreen(),)),
    GetPage(name:myPost, page:() => getRoute(const AllPostScreen(),)),
    GetPage( name:providerOfferList, page:() {

     List<int> decode = base64Decode(Get.parameters['myPostData']!.replaceAll(' ', '+'));
     MyPostData data = MyPostData.fromJson(jsonDecode(utf8.decode(decode)));
     return ProviderOfferListScreen(
        postId: Get.parameters['postId'],
        myPostData: data,
        status: Get.parameters['status']!,
      );
    }),

    GetPage( name:providerOfferDetails, page:() {

      List<int> decode = base64Decode(Get.parameters['providerOfferData']!.replaceAll(' ', '+'));
      ProviderOfferData data = ProviderOfferData.fromJson(jsonDecode(utf8.decode(decode)));
       return ProviderOfferDetailsScreen(
         postId: Get.parameters['postId'],
         providerOfferData: data,
       );
    }),

    GetPage(name: providerWebView, page: () => const ProviderWebView()),
  ];

  static getRoute(Widget navigateTo) {
    double minimumVersion = 1;
    if(Get.find<SplashController>().configModel.content!.minimumVersion!=null){
      if(GetPlatform.isAndroid) {
        minimumVersion = double.parse(Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString());
      }else if(GetPlatform.isIOS) {
        minimumVersion = double.parse(Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!.toString());
      }
    }
    return 5 < minimumVersion ? const UpdateScreen(isUpdate: true)
        : Get.find<LocationController>().getUserAddress() != null ? navigateTo
        : AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute);
  }
  }
