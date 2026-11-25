import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @valid_numberBetween.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يكون بين {min} و {max} حرفاً'**
  String valid_numberBetween(int min, int max);

  /// No description provided for @valid_exactLength.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يكون {length} حرفاً بالضبط'**
  String valid_exactLength(int length);

  /// No description provided for @newOrder.
  ///
  /// In ar, this message translates to:
  /// **'الطلب الجديد'**
  String get newOrder;

  /// No description provided for @onDelivery.
  ///
  /// In ar, this message translates to:
  /// **'التسليم'**
  String get onDelivery;

  /// No description provided for @delivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التسليم'**
  String get delivered;

  /// No description provided for @cancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغاة'**
  String get cancelled;

  /// No description provided for @in_progress.
  ///
  /// In ar, this message translates to:
  /// **'قيد العمل عليه'**
  String get in_progress;

  /// No description provided for @completed.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get completed;

  /// No description provided for @unexpectedError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع.'**
  String get unexpectedError;

  /// No description provided for @connectionTimeout.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة الاتصال. حاول مرة أخرى.'**
  String get connectionTimeout;

  /// No description provided for @serverError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم.'**
  String get serverError;

  /// No description provided for @badCertificate.
  ///
  /// In ar, this message translates to:
  /// **'شهادة الأمان غير صالحة.'**
  String get badCertificate;

  /// No description provided for @unknownError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير معروف، يرجى التحقق من اتصالك بالإنترنت.'**
  String get unknownError;

  /// No description provided for @requestCanceled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الطلب.'**
  String get requestCanceled;

  /// No description provided for @noNetwork.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال. يرجى التحقق من الشبكة.'**
  String get noNetwork;

  /// No description provided for @pickLocation.
  ///
  /// In ar, this message translates to:
  /// **'اختر الموقع'**
  String get pickLocation;

  /// No description provided for @requiredField.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get requiredField;

  /// No description provided for @requiredPhone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف مطلوب'**
  String get requiredPhone;

  /// No description provided for @phoneDoseNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف غير متطابق'**
  String get phoneDoseNotMatch;

  /// No description provided for @requiredEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني مطلوب'**
  String get requiredEmail;

  /// No description provided for @wrongEmailValidation.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني غير صحيح'**
  String get wrongEmailValidation;

  /// No description provided for @requiredPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة'**
  String get requiredPassword;

  /// No description provided for @smallPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور قصيرة جدا'**
  String get smallPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @passwordNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير متطابقة'**
  String get passwordNotMatch;

  /// No description provided for @camera.
  ///
  /// In ar, this message translates to:
  /// **'الكاميرا'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In ar, this message translates to:
  /// **'المعرض'**
  String get gallery;

  /// No description provided for @noImageSelected.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم اختيار صورة.'**
  String get noImageSelected;

  /// No description provided for @mediaPickError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء اختيار الصورة.'**
  String get mediaPickError;

  /// No description provided for @permissionRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب إذن'**
  String get permissionRequired;

  /// No description provided for @enablePermissions.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تمكين الأذونات المطلوبة من إعدادات التطبيق.'**
  String get enablePermissions;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @error_occurred.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما'**
  String get error_occurred;

  /// No description provided for @path_not_found.
  ///
  /// In ar, this message translates to:
  /// **'مسار غير موجود'**
  String get path_not_found;

  /// No description provided for @c__________Endcore.
  ///
  /// In ar, this message translates to:
  /// **''**
  String get c__________Endcore;

  /// No description provided for @change_password.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get change_password;

  /// No description provided for @enter_new_password.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الجديدة'**
  String get enter_new_password;

  /// No description provided for @new_password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور الجديدة'**
  String get confirm_new_password;

  /// No description provided for @change.
  ///
  /// In ar, this message translates to:
  /// **'تغيير'**
  String get change;

  /// No description provided for @data_issue.
  ///
  /// In ar, this message translates to:
  /// **'هناك مشكلة في البيانات'**
  String get data_issue;

  /// No description provided for @select_your_location.
  ///
  /// In ar, this message translates to:
  /// **'حدد موقعك'**
  String get select_your_location;

  /// No description provided for @select_location_first.
  ///
  /// In ar, this message translates to:
  /// **'يجب تحديد الموقع أولاً'**
  String get select_location_first;

  /// No description provided for @select_another_location.
  ///
  /// In ar, this message translates to:
  /// **'يجب تحديد موقع آخر'**
  String get select_another_location;

  /// No description provided for @tap_map_to_select_location.
  ///
  /// In ar, this message translates to:
  /// **'انقر على الخريطة لتحديد الموقع'**
  String get tap_map_to_select_location;

  /// No description provided for @best_orders.
  ///
  /// In ar, this message translates to:
  /// **'التقط أفضل الطلبات...'**
  String get best_orders;

  /// No description provided for @order_tracking.
  ///
  /// In ar, this message translates to:
  /// **'تتبع طلباتك...'**
  String get order_tracking;

  /// No description provided for @no_orders.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات'**
  String get no_orders;

  /// No description provided for @unspecified_phrase.
  ///
  /// In ar, this message translates to:
  /// **''**
  String get unspecified_phrase;

  /// No description provided for @delivery_time.
  ///
  /// In ar, this message translates to:
  /// **'وقت التسليم الخاص بك'**
  String get delivery_time;

  /// No description provided for @delivery_distance_km.
  ///
  /// In ar, this message translates to:
  /// **'كيلومترات التوصيل'**
  String get delivery_distance_km;

  /// No description provided for @branch_scope_work_km.
  ///
  /// In ar, this message translates to:
  /// **'{scopeWork} كم'**
  String branch_scope_work_km(String scopeWork);

  /// No description provided for @see_more.
  ///
  /// In ar, this message translates to:
  /// **'شاهد المزيد'**
  String get see_more;

  /// No description provided for @order_confirmed.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد الطلب!'**
  String get order_confirmed;

  /// No description provided for @confirm_order.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الطلب'**
  String get confirm_order;

  /// No description provided for @something_went_wrong.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما'**
  String get something_went_wrong;

  /// No description provided for @please_try_again.
  ///
  /// In ar, this message translates to:
  /// **'يرجى المحاولة مرة أخرى'**
  String get please_try_again;

  /// No description provided for @refresh.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get refresh;

  /// No description provided for @find_best_branches.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن أفضل الفروع لك!'**
  String get find_best_branches;

  /// No description provided for @find_best_branch.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن أفضل فرع لك...'**
  String get find_best_branch;

  /// No description provided for @today_special_menu.
  ///
  /// In ar, this message translates to:
  /// **'قائمة طعام اليوم الخاصة'**
  String get today_special_menu;

  /// No description provided for @branches.
  ///
  /// In ar, this message translates to:
  /// **'الفروع'**
  String get branches;

  /// No description provided for @view_all.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get view_all;

  /// No description provided for @driver_details_label.
  ///
  /// In ar, this message translates to:
  /// **'السائق...'**
  String get driver_details_label;

  /// No description provided for @get_started_label.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get get_started_label;

  /// No description provided for @next_label.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next_label;

  /// No description provided for @pickup_order_from_branch_message.
  ///
  /// In ar, this message translates to:
  /// **'التقط الطلب من الفرع'**
  String get pickup_order_from_branch_message;

  /// No description provided for @verify_mobile_number_text.
  ///
  /// In ar, this message translates to:
  /// **'تحقق من رقم الهاتف المحمول'**
  String get verify_mobile_number_text;

  /// No description provided for @verification_code_input_hint_text.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز المرسل إلى رقم هاتفك المحمول.'**
  String get verification_code_input_hint_text;

  /// No description provided for @resend_code_question_text.
  ///
  /// In ar, this message translates to:
  /// **'ألم تستلم الرمز؟'**
  String get resend_code_question_text;

  /// No description provided for @resend_code_button_text.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الرمز'**
  String get resend_code_button_text;

  /// No description provided for @verify_button_text.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get verify_button_text;

  /// No description provided for @forgot_password_link_text.
  ///
  /// In ar, this message translates to:
  /// **'هل نسيت كلمة المرور؟'**
  String get forgot_password_link_text;

  /// No description provided for @registered_phone_number_input_hint_text.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم الهاتف المرتبط بحسابك'**
  String get registered_phone_number_input_hint_text;

  /// No description provided for @input_number.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقمك هنا'**
  String get input_number;

  /// No description provided for @get_code_action.
  ///
  /// In ar, this message translates to:
  /// **'احصل على الرمز الآن'**
  String get get_code_action;

  /// No description provided for @welcome_back_message.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بعودتك!.'**
  String get welcome_back_message;

  /// No description provided for @registered_information.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال المعلومات المسجلة لدينا.'**
  String get registered_information;

  /// No description provided for @next_action.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next_action;

  /// No description provided for @start_action.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get start_action;

  /// No description provided for @sign_up_action.
  ///
  /// In ar, this message translates to:
  /// **'التسجيل'**
  String get sign_up_action;

  /// No description provided for @login_action.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول الآن'**
  String get login_action;

  /// No description provided for @personal_information.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الشخصية'**
  String get personal_information;

  /// No description provided for @profile_picture.
  ///
  /// In ar, this message translates to:
  /// **'تحميل صورة الملف الشخصي'**
  String get profile_picture;

  /// No description provided for @first_name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأخير'**
  String get last_name;

  /// No description provided for @email_address.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني * '**
  String get email_address;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني هنا'**
  String get email;

  /// No description provided for @id_or_residence_permit.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهوية أو تصريح الإقامة * '**
  String get id_or_residence_permit;

  /// No description provided for @entered_id_or_residence_permit.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم الهوية أو تصريح الإقامة الخاص بك هنا'**
  String get entered_id_or_residence_permit;

  /// No description provided for @date_of_birth.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد * '**
  String get date_of_birth;

  /// No description provided for @entered_date_of_birth.
  ///
  /// In ar, this message translates to:
  /// **'أدخل تاريخ ميلادك هنا'**
  String get entered_date_of_birth;

  /// No description provided for @nationality.
  ///
  /// In ar, this message translates to:
  /// **'الجنسية *'**
  String get nationality;

  /// No description provided for @entered_nationality.
  ///
  /// In ar, this message translates to:
  /// **'أدخل جنسيتك هنا'**
  String get entered_nationality;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور *'**
  String get password;

  /// No description provided for @entered_password.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الخاصة بك هنا'**
  String get entered_password;

  /// No description provided for @confirm_password.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور *'**
  String get confirm_password;

  /// No description provided for @reentered_password.
  ///
  /// In ar, this message translates to:
  /// **'أعد إدخال كلمة المرور الخاصة بك هنا'**
  String get reentered_password;

  /// No description provided for @has_gps_or_maps_installed.
  ///
  /// In ar, this message translates to:
  /// **'هل لديك نظام تحديد المواقع (GPS) أو خرائط مثبتة على هاتفك؟ *'**
  String get has_gps_or_maps_installed;

  /// No description provided for @yes_no_option.
  ///
  /// In ar, this message translates to:
  /// **'(نعم / لا )'**
  String get yes_no_option;

  /// No description provided for @is_yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get is_yes;

  /// No description provided for @is_no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get is_no;

  /// No description provided for @vehicle_information.
  ///
  /// In ar, this message translates to:
  /// **'معلومات المركبة'**
  String get vehicle_information;

  /// No description provided for @vehicle_registration_document.
  ///
  /// In ar, this message translates to:
  /// **'تحميل وثيقة تسجيل المركبة'**
  String get vehicle_registration_document;

  /// No description provided for @pdf_file.
  ///
  /// In ar, this message translates to:
  /// **'PDF'**
  String get pdf_file;

  /// No description provided for @vehicle_insurance_document.
  ///
  /// In ar, this message translates to:
  /// **'تحميل تأمين المركبة'**
  String get vehicle_insurance_document;

  /// No description provided for @vehicle_type.
  ///
  /// In ar, this message translates to:
  /// **'نوع المركبة'**
  String get vehicle_type;

  /// No description provided for @vehicle_model.
  ///
  /// In ar, this message translates to:
  /// **'طراز المركبة'**
  String get vehicle_model;

  /// No description provided for @year_of_manufacture.
  ///
  /// In ar, this message translates to:
  /// **'سنة الصنع'**
  String get year_of_manufacture;

  /// No description provided for @license_plate_number.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم لوحة الترخيص الخاص بك هنا'**
  String get license_plate_number;

  /// No description provided for @driving_license_information.
  ///
  /// In ar, this message translates to:
  /// **'معلومات رخصة القيادة'**
  String get driving_license_information;

  /// No description provided for @driving_license_photo.
  ///
  /// In ar, this message translates to:
  /// **'تحميل صورة رخصة القيادة'**
  String get driving_license_photo;

  /// No description provided for @license_issue_date.
  ///
  /// In ar, this message translates to:
  /// **'أدخل تاريخ إصدار رخصتك هنا'**
  String get license_issue_date;

  /// No description provided for @license_expiry_date.
  ///
  /// In ar, this message translates to:
  /// **'أدخل تاريخ انتهاء صلاحية رخصتك هنا'**
  String get license_expiry_date;

  /// No description provided for @has_previous_experience.
  ///
  /// In ar, this message translates to:
  /// **'هل لديك خبرة سابقة؟ *'**
  String get has_previous_experience;

  /// No description provided for @past_experience_description.
  ///
  /// In ar, this message translates to:
  /// **'صف بإيجاز خبرتك السابقة *'**
  String get past_experience_description;

  /// No description provided for @input_text.
  ///
  /// In ar, this message translates to:
  /// **'اكتب هنا...'**
  String get input_text;

  /// No description provided for @location_details.
  ///
  /// In ar, this message translates to:
  /// **'الموقع ومعلومات إضافية'**
  String get location_details;

  /// No description provided for @city.
  ///
  /// In ar, this message translates to:
  /// **'المدينة *'**
  String get city;

  /// No description provided for @entered_city.
  ///
  /// In ar, this message translates to:
  /// **'أدخل مدينتك هنا'**
  String get entered_city;

  /// No description provided for @district_area.
  ///
  /// In ar, this message translates to:
  /// **'المنطقة / الحي *'**
  String get district_area;

  /// No description provided for @entered_district_area.
  ///
  /// In ar, this message translates to:
  /// **'أدخل منطقتك / حيك هنا'**
  String get entered_district_area;

  /// No description provided for @additional_notes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات إضافية (اختياري)'**
  String get additional_notes;

  /// No description provided for @extra_information.
  ///
  /// In ar, this message translates to:
  /// **'اكتب أي معلومات إضافية تود مشاركتها...'**
  String get extra_information;

  /// No description provided for @remember_me.
  ///
  /// In ar, this message translates to:
  /// **'تذكرني'**
  String get remember_me;

  /// No description provided for @no_account_prompt.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get no_account_prompt;

  /// No description provided for @lama_sans.
  ///
  /// In ar, this message translates to:
  /// **'Lama Sans'**
  String get lama_sans;

  /// No description provided for @create_new_account.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get create_new_account;

  /// No description provided for @notification.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notification;

  /// No description provided for @no_notifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات'**
  String get no_notifications;

  /// No description provided for @no_current_notifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات حالية'**
  String get no_current_notifications;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @finance.
  ///
  /// In ar, this message translates to:
  /// **'المالية'**
  String get finance;

  /// No description provided for @reports.
  ///
  /// In ar, this message translates to:
  /// **'التقارير'**
  String get reports;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @order_status.
  ///
  /// In ar, this message translates to:
  /// **'حالة الطلب'**
  String get order_status;

  /// No description provided for @order_details.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الطلب'**
  String get order_details;

  /// No description provided for @location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get location;

  /// No description provided for @order.
  ///
  /// In ar, this message translates to:
  /// **'الطلب'**
  String get order;

  /// No description provided for @ordered_products.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات التي طلبها العميل'**
  String get ordered_products;

  /// No description provided for @item_count.
  ///
  /// In ar, this message translates to:
  /// **'{itemsCount} عناصر'**
  String item_count(String itemsCount);

  /// No description provided for @subtotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الفرعي:'**
  String get subtotal;

  /// No description provided for @total_order_amount.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الطلب:'**
  String get total_order_amount;

  /// No description provided for @qr_reader.
  ///
  /// In ar, this message translates to:
  /// **'قارئ رمز الاستجابة السريعة'**
  String get qr_reader;

  /// No description provided for @qr_data.
  ///
  /// In ar, this message translates to:
  /// **'بيانات رمز الاستجابة السريعة'**
  String get qr_data;

  /// No description provided for @is_order_confirmed.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد الطلب'**
  String get is_order_confirmed;

  /// No description provided for @scan_qr_code.
  ///
  /// In ar, this message translates to:
  /// **'مسح رمز الاستجابة السريعة'**
  String get scan_qr_code;

  /// No description provided for @scan_instruction_message.
  ///
  /// In ar, this message translates to:
  /// **'انقر على الزر أدناه لبدء المسح'**
  String get scan_instruction_message;

  /// No description provided for @last_scanned_data.
  ///
  /// In ar, this message translates to:
  /// **'آخر مسح: {scannedData}'**
  String last_scanned_data(String scannedData);

  /// No description provided for @branch_receive_address.
  ///
  /// In ar, this message translates to:
  /// **'عنوان الفرع لاستلام الطلب'**
  String get branch_receive_address;

  /// No description provided for @is_delivered.
  ///
  /// In ar, this message translates to:
  /// **'تم التوصيل'**
  String get is_delivered;

  /// No description provided for @order_received.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام الطلب'**
  String get order_received;

  /// No description provided for @request_received.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام الطلب.'**
  String get request_received;

  /// No description provided for @account_info.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الحساب'**
  String get account_info;

  /// No description provided for @save_operation.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save_operation;

  /// No description provided for @total_orders.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الطلبات'**
  String get total_orders;

  /// No description provided for @range.
  ///
  /// In ar, this message translates to:
  /// **'المدى'**
  String get range;

  /// No description provided for @share.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get share;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @terms_and_conditions.
  ///
  /// In ar, this message translates to:
  /// **'الشروط والأحكام'**
  String get terms_and_conditions;

  /// No description provided for @support.
  ///
  /// In ar, this message translates to:
  /// **'الدعم'**
  String get support;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @change_language.
  ///
  /// In ar, this message translates to:
  /// **'تغيير اللغة'**
  String get change_language;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @turkish.
  ///
  /// In ar, this message translates to:
  /// **'التركية'**
  String get turkish;

  /// No description provided for @privacy_policy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get privacy_policy;

  /// No description provided for @confirm_logout_message.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج!؟'**
  String get confirm_logout_message;

  /// No description provided for @action_reversible_message.
  ///
  /// In ar, this message translates to:
  /// **'هذا الإجراء قابل للإلغاء!'**
  String get action_reversible_message;

  /// No description provided for @log_out.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get log_out;

  /// No description provided for @your_evaluations.
  ///
  /// In ar, this message translates to:
  /// **'التقييمات الموجهة إليك'**
  String get your_evaluations;

  /// No description provided for @placeholder_text.
  ///
  /// In ar, this message translates to:
  /// **'-'**
  String get placeholder_text;

  /// No description provided for @search_orders_hint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في طلباتك...'**
  String get search_orders_hint;

  /// No description provided for @total_amounts_entered.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المبالغ التي تم إدخالها'**
  String get total_amounts_entered;

  /// No description provided for @order_history.
  ///
  /// In ar, this message translates to:
  /// **'سجل الطلبات'**
  String get order_history;

  /// No description provided for @compared_to_last_month.
  ///
  /// In ar, this message translates to:
  /// **'مقارنة بالشهر الماضي'**
  String get compared_to_last_month;

  /// No description provided for @is_completed.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get is_completed;

  /// No description provided for @is_complete.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get is_complete;

  /// No description provided for @history.
  ///
  /// In ar, this message translates to:
  /// **'السجل'**
  String get history;

  /// No description provided for @token.
  ///
  /// In ar, this message translates to:
  /// **'token'**
  String get token;

  /// No description provided for @order_id_not_match.
  ///
  /// In ar, this message translates to:
  /// **'معرف الطلب غير متطابق'**
  String get order_id_not_match;

  /// No description provided for @no_phone_number.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد رقم هاتف'**
  String get no_phone_number;

  /// No description provided for @delivery_address.
  ///
  /// In ar, this message translates to:
  /// **'عنوان التوصيل الخاص بك'**
  String get delivery_address;

  /// No description provided for @destination_overview.
  ///
  /// In ar, this message translates to:
  /// **'نظرة عامة على الوجهة'**
  String get destination_overview;

  /// No description provided for @current_location.
  ///
  /// In ar, this message translates to:
  /// **'الحصول على الموقع الحالي'**
  String get current_location;

  /// No description provided for @your_location.
  ///
  /// In ar, this message translates to:
  /// **'موقعك'**
  String get your_location;

  /// No description provided for @destination.
  ///
  /// In ar, this message translates to:
  /// **'الوجهة'**
  String get destination;

  /// No description provided for @customer_delivery.
  ///
  /// In ar, this message translates to:
  /// **'التوصيل إلى العميل'**
  String get customer_delivery;

  /// No description provided for @selected_location.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الموقع'**
  String get selected_location;

  /// No description provided for @pick_location.
  ///
  /// In ar, this message translates to:
  /// **'اختيار الموقع'**
  String get pick_location;

  /// No description provided for @selected_date.
  ///
  /// In ar, this message translates to:
  /// **'تحديد التاريخ'**
  String get selected_date;

  /// No description provided for @selected_file.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الملف'**
  String get selected_file;

  /// No description provided for @selected_image.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الصورة'**
  String get selected_image;

  /// No description provided for @image_selection_message.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديد الصورة: {imagePath}'**
  String image_selection_message(String imagePath);

  /// No description provided for @current_step_label.
  ///
  /// In ar, this message translates to:
  /// **'الخطوة {stepNumber}'**
  String current_step_label(String stepNumber);

  /// No description provided for @select_option.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار {label}'**
  String select_option(String label);

  /// No description provided for @is_ok.
  ///
  /// In ar, this message translates to:
  /// **'موافق'**
  String get is_ok;

  /// No description provided for @retry_action.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry_action;

  /// No description provided for @go_back_action.
  ///
  /// In ar, this message translates to:
  /// **'العودة'**
  String get go_back_action;

  /// No description provided for @no_items_found_message.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناصر'**
  String get no_items_found_message;

  /// No description provided for @select_location_first_message.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تحديد موقع أولاً.'**
  String get select_location_first_message;

  /// No description provided for @selection_instruction_message.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تحديد {label}'**
  String selection_instruction_message(String label);

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @contact_support.
  ///
  /// In ar, this message translates to:
  /// **'اتصل بدعم'**
  String get contact_support;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'موافق'**
  String get ok;

  /// No description provided for @delete_account.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحساب'**
  String get delete_account;

  /// No description provided for @are_you_sure_delete_account.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.'**
  String get are_you_sure_delete_account;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @phone_number_is_required.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف مطلوب'**
  String get phone_number_is_required;

  /// No description provided for @phone_number_should_be_between_7_and_15_characters.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يكون رقم الهاتف بين 7 و 15 رمزًا'**
  String get phone_number_should_be_between_7_and_15_characters;

  /// No description provided for @password_is_required.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة'**
  String get password_is_required;

  /// No description provided for @password_should_be_at_least_8_characters.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تتكون كلمة المرور من 8 رموز على الأقل'**
  String get password_should_be_at_least_8_characters;

  /// No description provided for @required_field.
  ///
  /// In ar, this message translates to:
  /// **'حقل مطلوب'**
  String get required_field;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get passwords_do_not_match;

  /// No description provided for @must_be_at_least_16_years_old.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يكون عمرك {age} عامًا على الأقل'**
  String must_be_at_least_16_years_old(String age);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
