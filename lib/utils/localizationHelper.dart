import 'dart:ui';

import 'package:equb/utils/localStorageHelper.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  LocalizationService._() {
    _currentLocale =
        Locale(LocalStorageService.instance.get('locale') ?? "am").obs;
  }
  static LocalizationService? _instance;
  static LocalizationService get instance =>
      _instance ?? LocalizationService._();

  late Rx<Locale> _currentLocale;

  final _supportedLocales = const [
    {'name': 'English', "languageCode": 'en', "locale": Locale('en')},
    {'name': 'አማረኛ', "languageCode": 'am', "locale": Locale('am')},
    // {'name': 'Afaan Oromoo', "languageCode": 'om', "locale": Locale('om')},
  ];

  List<Map<String, dynamic>> get supportedLocales => _supportedLocales;

  Locale? get currentLocale => _currentLocale.value;
  String get currentLocaleLangCode => _currentLocale.value.languageCode;

  Locale get fallbackLocale => const Locale('en');

  Future<void> changeLocale(String languageCode) async {
    _currentLocale.value = Locale(languageCode);
    await LocalStorageService.instance.addNew('locale', languageCode);
    await Get.updateLocale(Locale(languageCode));
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          "Register": "Register",
          "Login": "Login",
          "Yes": "Yes",
          "No": "No",
          "Email or UserName": "Email or UserName",
          "Password": "Password",
          "Are you sure?": "Are you sure?",
          "Do you want to exit an App": "Do you want to exit an App",
          "Total lot": "Total lot",
          "Total lot you have": "Total lot you have",
          "Saving amount you have": "Saving amount you have",
          "Saving amount": "Saving amount",
          "Wallet amount you have": "Wallet amount you have",
          "Wallet amount": "Wallet amount",
          "ETB": "ETB",
          "Drop tickets": "Drop tickets",
          "Total tickets you have": "Total tickets you have",
          "Todays Lot": "Todays Lot",
          "Reaming time": "Reaming time",
          "Todays Winner": "Todays Winner",
          "Language": "Language",
          "Home": "Home",
          "Wallet": "Wallet",
          "Drop": "Drop",
          "Theme": "Theme",
          "About us": "About us",
          "Contact us": "Contact us",
          "Withdrawal": "Withdrawal",
          "Logout": "Logout",
          //todo commen
          "FirstName": "FirstName",
          "LastName": "LastName",
          "Please insert your phone number": "Please enter your phone number",
          "Please insert valid phone number":
              "Please insert valid phone number",
          "Phone Number": "Phone Number",
          "PhoneNumber(Optional)": "PhoneNumber(Optional)",
          "Please insert required filed": "Please insert required filed",
          "Your Email is not correct": "Your Email is not correct",
          "Email": "Email",
          "Welcome": "Welcome",
          //todo admin
          "Register New Sales": "Register New Sales",
          "Total users account": "Total saving account",
          "Saving account": "Saving account",
          "Total Collector Account": "Total Collector Account",
          "Collectors": "Collectors",
          "Salesperson user account": "Salesperson user account",
          "Sales": "Sales"
        },
        'am': {
          "Register": "ይመዝገቡ",
          "Login": "ይግቡ",
          "Yes": "አዎ",
          "No": "አይ",
          "Email or UserName": "ስም ወይም ኢሜል",
          "Password": "የይለፍ ቃል",
          "Do you want to exit an App": "ከመተግበሪያ መውጣት ይፈልጋሉ",
          "Are you sure?": "እርግጠኛ ነህ?",
          "Total lot": "ጠቅላላ እጣዎች",
          "Total lot you have": "ጠቅላላ እጣዎች ያሎት",
          "Saving amount you have": "ያለዎት አጠቃላይ ቁጠባ ገንዘብ",
          "Saving amount": "የተጠራቀመ ገንዘብ",
          "Wallet amount you have": "ያለዎት ጠቅላላ ቀሪ ገንዘብ",
          "Wallet amount": "ጠቅላላ ቀሪ ገንዘብ",
          "ETB": "ብር",
          "Drop tickets": "የጣሉት እጣዎች",
          "Total tickets you have": "ጠቅላላ የጣሉት እጣዎች",
          "Todays Lot": "የዛሬ እጣ",
          "Reaming time": "የቀረው ጊዜ",
          "Todays Winner": "የዛሬ እጣ አሸናፊ",
          "Language": "ቋንቋ",
          "Theme": "የመጠቀሚያ አይነት",
          "Home": "መነሻ",
          "Wallet": "ቁጠባ",
          "Drop": "ጣል",
          "About us": "ስለ እኛ",
          "Contact us": "አግኙን",
          "Withdrawal": "ብር ማውጣት",
          "Logout": "ውጣ",
          //todo comman
          "FirstName": "የመጀመሪያ ስም",
          "LastName": "የአባት ስም",
          "Please insert your phone number": "እባክዎን ስልክ ቁጥርዎን ያስገቡ",
          "Please insert valid phone number": "እባክዎ የሚሰራ ስልክ ቁጥር ያስገቡ",
          "Phone Number": "ስልክ ቁጥር",
          "PhoneNumber(Optional)": "ስልክ ቁጥር(አማራጭ)",
          "Please insert required filed": "እባክዎ አስፈላጊ የሆነውን ያስገቡ",
          "Your Email is not correct": "እባክዎ የእርግጠኛዎን ኢሜል ያስገቡ",
          "Email": "ኢሜል",
          "Next": "ቀጣይ",
          "Welcome": "እንኳን ደህና መጡ",
          //todo admin
          "Register New Sales": "አዲስ ሻጭ ይመዝገቡ",
          "Total saving account": "አጠቃላይ እቁብ ጣይዮች ብዛት",
          "Saving account": "እቁብ ጣይዮች",
          "Total Collector Account": "የሰብሳቢዎች ጠቅላላ ቁጥር",
          "Collectors": "እቁብ ሰብሳቢዎች",
          "Salesperson user account ": "የሽያጭ ሠራተኞች ጠቅላላ ቁጥር",
          "Sales": "ሽያጭ ሠራተኞች",
        },
        'om': {},
      };
}
