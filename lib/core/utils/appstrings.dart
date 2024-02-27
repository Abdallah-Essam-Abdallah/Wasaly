import 'package:firebase_auth/firebase_auth.dart';

class AppStrings {
/////onBoarding_screen//////
  static const String onBoardingTitle1 = 'Easy to use';
  static const String onBoardingTitle2 = 'Fast Delivery';
  static const String onBoardingTitle3 = 'Enjoy the experience';

  static const String onBoardingDescription1 =
      'Getting all the home needs wasnt that easy before';
  static const String onBoardingDescription2 =
      'Fast delivery to your home or office. We will deliver it, wherever you are!';
  static const String onBoardingDescription3 =
      'Dont feel like going out? No proplem, We will deliver your order to your place';

  static const String next = 'Next';
  static const String getStarted = 'Get Started';

  static const String firstOnboardingImage = 'assets/lotties/onBoarding1.json';
  static const String secondOnboardingImage = 'assets/lotties/onBoarding2.json';
  static const String thirdOnboardingImage = 'assets/lotties/onBoarding3.json';
  /////internet faliure//////
  static const String internetFaliureMessage =
      'No internet. Please check your connection';

  /////firestore collections////////
  static const String users = 'users';
  static String userId = FirebaseAuth.instance.currentUser!.uid;

  ////login screen/////
  static const String login = 'Login';
  static const String loginImg = 'assets/images/login_img.png';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String orLogInWith = 'or Login with';
  static const String dontHaveAnAccount = 'Dont have an account?';
  static const String signUp = 'Sign Up';
  static const String invalidEmail = 'please enter a valid email';
  static const String emptyPassword = 'please enter a password';
  static const String shortPassword =
      'password should be at least 8 characters';
  static const String forgotPassword = 'forgot password?';
  ////reset password screen////
  static const String resetPasswordText =
      'Receive an email to reset your password';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordSnackBar =
      'We have sent you an email to reset your password';
  ////Signup Screen////
  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String emptyName = 'please enter a valid name';
  static const String confirmPassword = 'confirm password';
  static const String passwordDoNotMatch = 'password do not match';
  static const String emptyPhone = 'please enter a valid phone number';
  static const String alreadyHaveAnAccount = 'Already have an account?';
  static const String emailVerfication = 'Please check your email.';
  ////offer screen////
  static const String offerDetails = 'Offer Details';
  static const String offers = 'offers';
  static const String addToCart = 'Add To Cart';

  ////Home screen////
  static const String categories = 'Categories';
  static const String hello = 'Hello, ';
  static const String seeMore = 'See More';

  ////Bottom Nav Bar////
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String search = 'Search';
  ////Categories////
  static const String groceriesImage = 'assets/images/groceries.jpg';
  static const String pharmacyImage = 'assets/images/pharmacy.jpg';
  static const String resturantsImage = 'assets/images/resturants.jpg';
  static const String specialorderImage = 'assets/images/specialorder.jpg';
  static const String groceries = 'Groceries';
  static const String pharmacy = 'Pharmacy';
  static const String resturants = 'Resturants';
  static const String specialorder = 'Special Order';
  ////Pharmacy Screen////
  static const String uploadPrescription = 'Upload Your Prescription!';
  static const String pharmacyScreenNote =
      'Note that the cost of this prescribtion will be added to the final cost once its calculated';
  static const String pharmacyPrescription = 'Pharmacy Prescription';
  ////Menu Screen////
  static const String menu = 'Menu';
  static const String deliveryFee = 'Delivery Fee';
  static const String deliveryTime = 'Delivery Time';
  ////Cart Screen////e
  static const String cart = 'Cart';
  static const String cartSuccsesMessage =
      'Item has been added to cart succefuly';
  static const String checkout = 'Checkout';
  static const String totalPrice = 'Total Price:';
  static const String price = 'Price:';
  static const String deliveryFess = 'Delivery Fees:';
  static const String remove = 'Remove';
  static const String removeDialogContent =
      'Are you sure that you want to remove this item from cart?';
  static const String emptyCart = 'Your cart is empty. start shopping now';
  static const String invalidCoupon = 'Invalid Coupon!';
  static const String expiredCoupon = 'Expired Coupon!';
  static const String addCoupon = 'Add Coupon';
  static const String apply = 'Apply';
  static const String couponSuccess = 'Coupon applied succesfully!';
  ////Location Feature////
  static const String location = 'Location';
  static const String confirmlocation = 'Confirm Location';
  static const String getLocation = 'Get Location';
  static const String permissionDenidMsg = 'Location permission is denied.';
  static const String permissionDenidForeverMsg =
      'Location permissions are permanently denied, cannot request permissions.';
  static const String getPossitionErrorMsg =
      'Error retrieving current position.Please try again later';
  static const String error = 'Error';
  static const String markerId = 'userLocation';
  ////Orders screen////
  static const String emptyOrders = 'You have no orders yet';
  static const String orderId = 'Order ID ';
  static const String deleteFromFavorites = 'Delete from favorite';
  static const String submitted = 'Submitted';
  static const String received = 'Received';
  static const String onTheWay = 'On the way';
  static const String delivered = 'Delivered';
  static const String canceled = 'Canceled';
  static const String cancelOrder = 'Cancel order';
  static const String cancelOrderDialogContent =
      'Are you sure you want to cancel this order?';
  ////Profile screen////
  static const String orders = 'Orders';
  static const String signOut = 'Sign Out';
  static const String profileImage = 'assets/images/Avatar.png';
  ////Payment screens////
  static const String paymentMethods = 'Payment Methods';
  static const String selectPaymentMethods = 'Select Payment Method:';
  static const String cashIcon = 'assets/images/money.png';
  static const String visaIcon = 'assets/images/visa.png';
  static const String cash = 'Cash';
  static const String card = 'Card';
  static const String total = 'Total';
  static const String placeOrder = 'Place Order';
  static const String addNote = 'Add Note';
  static const String unpaid = 'Unpaid';
  static const String paid = 'Paid';
  static const String success = 'Success';
  static const String close = 'Close';
  static const String paymentConfirmation = 'Order has been Placed succesfuly!';
  static const String screenShot =
      'You are not allowed to take schreenshot in this screen';
  static const String paymentFailed = 'Payment failed. try again late';
  ////Exception messages////
  static const String invalidEmailException = 'The email is invalid';
  static const String wrongPasswordException =
      'The password is incorrect. try again';
  static const String userNotFoundException = 'User not found';
  static const String emailAlreadyInUseException = 'Email already in use';
  static const String weakPasswordException =
      'WeakPassword. password should be at least 8 characters';
  static const String unexpectedException =
      'Unexpected error. please try again later';
  static const String accountExistsWithDifferentCredential =
      'Account Exists With Different Credential';
  static const String invalidCredential =
      'User Name or Password might be wrong';

  static const String tooManyRequests = 'Too many requests. try again later';
  static const String noImageUploded =
      'No image to upload,Please choose an image';
  static const String imageUploadError =
      'Error has happened while uploading the image,please try again';
  static const String noImageChoosedError =
      'No Image has been choosen,please try again';
}
