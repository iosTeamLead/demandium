import 'package:demandium/data/model/response/language_model.dart';
import 'package:demandium/utils/images.dart';

class AppConstants {
  static const String appName = 'Demandium';
  static const String appVersion = '2.1';

  static const String baseUrl = 'https://demandium.a1professionals.net';

  static const String categoryUrl = '/api/v1/customer/category?limit=20';
  static const String webLandingContents = '/api/v1/customer/landing/contents';
  static const String bannerUri = '/api/v1/customer/banner?limit=10&offset=1';
  static const String bonusUri = '/api/v1/customer/bonus-list?limit=100&offset=1';
  static const String allServiceUri = '/api/v1/customer/service';
  static const String popularServiceUri = '/api/v1/customer/service/popular';
  static const String trendingServiceUri = '/api/v1/customer/service/trending';
  static const String recentlyViewedServiceUri = '/api/v1/customer/service/recently-viewed';
  static const String recommendedServiceUri = '/api/v1/customer/service/recommended';
  static const String recommendedSearchUri = '/api/v1/customer/service/search/recommended';
  static const String offerListUri = '/api/v1/customer/service/offers';
  static const String serviceBasedOnSubcategory = '/api/v1/customer/service/sub-category/';
  static const String itemsBasedOnCampaignId = '/api/v1/customer/campaign/data/items?campaign_id=';
  static const String serviceDetailsUri = '/api/v1/customer/service/detail';
  static const String getServiceReviewList = '/api/v1/customer/service/review/';
  static const String subcategoryUri = '/api/v1/customer/category/childes?limit=20&offset=1&id=';
  static const String categoryServiceUri = '/api/v1/categories/service/';
  static const String configUri = '/api/v1/customer/config';
  static const String customerRemove = '/api/v1/customer/remove-account';
  static const String registerUri = '/api/v1/customer/auth/registration';
  static const String loginUri = '/api/v1/customer/auth/login';
  static const String loginOut = '/api/v1/customer/auth/logout';
  static const String addToCart = '/api/v1/customer/cart/add';
  static const String getCartList = '/api/v1/customer/cart/list?limit=100&offset=1';
  static const String removeCartItem = '/api/v1/customer/cart/remove/';
  static const String removeAllCartItem = '/api/v1/customer/cart/data/empty';
  static const String updateCartQuantity = '/api/v1/customer/cart/update-quantity/';
  static const String updateCartProvider = '/api/v1/customer/cart/update/provider';
  static const String tokenUri = '/api/v1/customer/update/fcm-token';
  static const String bookingList = '/api/v1/customer/booking';
  static const String bookingDetails = '/api/v1/customer/booking';
  static const String trackBooking = '/api/v1/customer/booking/track';
  static const String bookingCancel = '/api/v1/customer/booking/status-update';
  static const String serviceReview = '/api/v1/customer/review/submit';
  static const String bookingReviewList = '/api/v1/customer/review';
  static const String otherInfo = '/api/v1/customer/cart/other-info';
  static const String placeRequest = '/api/v1/customer/booking/request/send';
  static const String addressUri = '/api/v1/customer/address';
  static const String zoneUri = '/api/v1/customer/config/get-zone-id';
  static const String customerInfoUri = '/api/v1/customer/info';
  static const String couponUri = '/api/v1/customer/coupon?limit=100&offset=1';
  static const String applyCoupon = '/api/v1/customer/coupon/apply';
  static const String removeCoupon = '/api/v1/customer/coupon/remove';
  static const String orderCancelUri = '/api/v1/customer/order/cancel';
  static const String codSwitchUri = '/api/v1/customer/order/payment-method';
  static const String orderDetailsUri = '/api/v1/customer/order/details?order_id=';
  static const String notificationUri = '/api/v1/customer/notification';
  static const String updateProfileUri = '/api/v1/customer/update/profile';
  static const String searchUri = '/api/v1/customer/service/search';
  static const String suggestedSearchUri = '/api/v1/customer/recently-searched-keywords';
  static const String removeSuggestedServiceUri = '/api/v1/customer/remove-searched-keywords';
  static const String campaignUri = '/api/v1/customer/campaign?limit=10&offset=1';
  static const String searchLocationUri = '/api/v1/customer/config/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/customer/config/place-api-details';
  static const String geocodeUri = '/api/v1/customer/config/geocode-api';
  static const String socialLoginUri = '/api/v1/customer/auth/social-login';
  static const String socialRegisterUri = '/api/v1/auth/social-register';
  static const String updateZoneUri = '/api/v1/customer/update-zone';
  static const String createChannel = '/api/v1/customer/chat/create-channel';
  static const String getChannelList = '/api/v1/customer/chat/channel-list?limit=10&';
  static const String getConversation = '/api/v1/customer/chat/conversation';
  static const String sendMessage = '/api/v1/customer/chat/send-message';
  static const String pages = '/api/v1/customer/config/pages';
  static const String submitNewServiceRequest = '/api/v1/customer/service/request/make';
  static const String getSuggestedServiceList = '/api/v1/customer/service/request/list';
  static const String convertLoyaltyPointUri = '/api/v1/customer/loyalty-point/wallet-transfer';
  static const String loyaltyPointTransactionData = '/api/v1/customer/loyalty-point-transaction';
  static const String walletTransactionData = '/api/v1/customer/wallet-transaction';
  static const String getProviderList = '/api/v1/customer/provider/list?limit=10&offset=';
  static const String getProviderDetails = '/api/v1/customer/provider-details';
  static const String getProviderBasedOnSubcategory = '/api/v1/customer/provider/list-by-sub-category';
  static const String getFeaturedCategoryService = '/api/v1/customer/featured-categories?limit=100&offset=1';

  static const String createCustomizedPost = '/api/v1/customer/post';
  static const String getMyPostList = '/api/v1/customer/post';
  static const String getInterestedProviderList = '/api/v1/customer/post/bid';
  static const String updatePostStatus = '/api/v1/customer/post/bid/update-status';
  static const String getPostDetails = '/api/v1/customer/post/details';
  static const String updatePostInfo = '/api/v1/customer/post/update-info';
  static const String getProviderBidDetails = '/api/v1/customer/post/bid/details';

  static const String sendOtpForVerification = '/api/v1/user/verification/send-otp';
  static const String sendOtpForForgetPassword = '/api/v1/user/forget-password/send-otp';
  static const String verifyOtpForForgetPasswordScreen = '/api/v1/user/forget-password/verify-otp';
  static const String verifyOtpForVerificationScreen = '/api/v1/user/verification/verify-otp';
  static const String resetPasswordUri = '/api/v1/user/forget-password/reset';

  static const String offlinePaymentUri = '/api/v1/customer/offline-payment/methods?limit=100&offset=1';

  // Shared Key
  static const String theme = 'demand_theme';
  static const String token = 'demand_token';
  static const String guestId = 'guest_id';
  static const String countryCode = 'demand_country_code';
  static const String languageCode = 'demand_language_code';
  static const String cartList = 'demand_cart_list';
  static const String acceptCookies = 'demand_accept_cookies';
  static const String userPassword = 'demand_user_password';
  static const String userAddress = 'demand_user_address';
  static const String userNumber = 'demand_user_number';
  static const String userCountryCode = 'demand_user_country_code';
  static const String notification = 'demand_notification';
  static const String searchHistory = 'demand_search_history';
  static const String notificationCount = 'demand_notification_count';
  static const String isSplashScreen = 'demand_splash_seen';
  static const String cookiesManagement = 'cookies_management';
  static const String  topic = 'customer';
  static const String zoneId = 'zoneId';
  static const String localizationKey = 'X-localization';
  static const String walletAccessToken = 'wallet_access_token';
  static const int scheduleTime = 3;

  static Map<String, String> configHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    AppConstants.zoneId : 'configuration',
  };

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.us, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.ar, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
  ];
  static const double limitOfPickedImageSizeInMB = 2;

  static final List<Map<String, String>> walletTransactionSortingList = [
    {
      'title' : 'all_transactions',
      'value' : ''
    },
    {
      'title' : 'booking_transaction',
      'value' : 'wallet_payment'
    },
    {
      'title' : 'converted_from_loyalty_point',
      'value' : 'loyalty_point_earning'
    },
    {
      'title' : 'added_via_payment_method',
      'value' : 'add_fund'
    },
    {
      'title' : 'earned_by_referral',
      'value' : 'referral_earning'
    },
    {
      'title' : 'admin_fund',
      'value' : 'fund_by_admin'
    },
    {
      'title' : 'refund',
      'value' : 'booking_refund'
    },
  ];

}
