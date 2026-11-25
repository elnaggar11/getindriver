// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String valid_numberBetween(int min, int max) {
    return 'يجب أن يكون بين $min و $max حرفاً';
  }

  @override
  String valid_exactLength(int length) {
    return 'يجب أن يكون $length حرفاً بالضبط';
  }

  @override
  String get newOrder => 'الطلب الجديد';

  @override
  String get onDelivery => 'التسليم';

  @override
  String get delivered => 'تم التسليم';

  @override
  String get cancelled => 'ملغاة';

  @override
  String get in_progress => 'قيد العمل عليه';

  @override
  String get completed => 'مكتمل';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع.';

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال. حاول مرة أخرى.';

  @override
  String get serverError => 'خطأ في الخادم.';

  @override
  String get badCertificate => 'شهادة الأمان غير صالحة.';

  @override
  String get unknownError =>
      'حدث خطأ غير معروف، يرجى التحقق من اتصالك بالإنترنت.';

  @override
  String get requestCanceled => 'تم إلغاء الطلب.';

  @override
  String get noNetwork => 'لا يوجد اتصال. يرجى التحقق من الشبكة.';

  @override
  String get pickLocation => 'اختر الموقع';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get requiredPhone => 'الهاتف مطلوب';

  @override
  String get phoneDoseNotMatch => 'الهاتف غير متطابق';

  @override
  String get requiredEmail => 'البريد الالكتروني مطلوب';

  @override
  String get wrongEmailValidation => 'البريد الالكتروني غير صحيح';

  @override
  String get requiredPassword => 'كلمة المرور مطلوبة';

  @override
  String get smallPassword => 'كلمة المرور قصيرة جدا';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordNotMatch => 'كلمة المرور غير متطابقة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get noImageSelected => 'لم يتم اختيار صورة.';

  @override
  String get mediaPickError => 'حدث خطأ أثناء اختيار الصورة.';

  @override
  String get permissionRequired => 'مطلوب إذن';

  @override
  String get enablePermissions =>
      'يرجى تمكين الأذونات المطلوبة من إعدادات التطبيق.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get settings => 'الإعدادات';

  @override
  String get error_occurred => 'حدث خطأ ما';

  @override
  String get path_not_found => 'مسار غير موجود';

  @override
  String get c__________Endcore => '';

  @override
  String get change_password => 'تغيير كلمة المرور';

  @override
  String get enter_new_password => 'أدخل كلمة المرور الجديدة';

  @override
  String get new_password => 'كلمة المرور الجديدة';

  @override
  String get confirm_new_password => 'تأكيد كلمة المرور الجديدة';

  @override
  String get change => 'تغيير';

  @override
  String get data_issue => 'هناك مشكلة في البيانات';

  @override
  String get select_your_location => 'حدد موقعك';

  @override
  String get select_location_first => 'يجب تحديد الموقع أولاً';

  @override
  String get select_another_location => 'يجب تحديد موقع آخر';

  @override
  String get tap_map_to_select_location => 'انقر على الخريطة لتحديد الموقع';

  @override
  String get best_orders => 'التقط أفضل الطلبات...';

  @override
  String get order_tracking => 'تتبع طلباتك...';

  @override
  String get no_orders => 'لا توجد طلبات';

  @override
  String get unspecified_phrase => '';

  @override
  String get delivery_time => 'وقت التسليم الخاص بك';

  @override
  String get delivery_distance_km => 'كيلومترات التوصيل';

  @override
  String branch_scope_work_km(String scopeWork) {
    return '$scopeWork كم';
  }

  @override
  String get see_more => 'شاهد المزيد';

  @override
  String get order_confirmed => 'تم تأكيد الطلب!';

  @override
  String get confirm_order => 'تأكيد الطلب';

  @override
  String get something_went_wrong => 'حدث خطأ ما';

  @override
  String get please_try_again => 'يرجى المحاولة مرة أخرى';

  @override
  String get refresh => 'تحديث';

  @override
  String get find_best_branches => 'ابحث عن أفضل الفروع لك!';

  @override
  String get find_best_branch => 'ابحث عن أفضل فرع لك...';

  @override
  String get today_special_menu => 'قائمة طعام اليوم الخاصة';

  @override
  String get branches => 'الفروع';

  @override
  String get view_all => 'عرض الكل';

  @override
  String get driver_details_label => 'السائق...';

  @override
  String get get_started_label => 'ابدأ';

  @override
  String get next_label => 'التالي';

  @override
  String get pickup_order_from_branch_message => 'التقط الطلب من الفرع';

  @override
  String get verify_mobile_number_text => 'تحقق من رقم الهاتف المحمول';

  @override
  String get verification_code_input_hint_text =>
      'أدخل الرمز المرسل إلى رقم هاتفك المحمول.';

  @override
  String get resend_code_question_text => 'ألم تستلم الرمز؟';

  @override
  String get resend_code_button_text => 'إعادة إرسال الرمز';

  @override
  String get verify_button_text => 'تحقق';

  @override
  String get forgot_password_link_text => 'هل نسيت كلمة المرور؟';

  @override
  String get registered_phone_number_input_hint_text =>
      'أدخل رقم الهاتف المرتبط بحسابك';

  @override
  String get input_number => 'أدخل رقمك هنا';

  @override
  String get get_code_action => 'احصل على الرمز الآن';

  @override
  String get welcome_back_message => 'مرحباً بعودتك!.';

  @override
  String get registered_information => 'يرجى إدخال المعلومات المسجلة لدينا.';

  @override
  String get next_action => 'التالي';

  @override
  String get start_action => 'ابدأ الآن';

  @override
  String get sign_up_action => 'التسجيل';

  @override
  String get login_action => 'تسجيل الدخول الآن';

  @override
  String get personal_information => 'المعلومات الشخصية';

  @override
  String get profile_picture => 'تحميل صورة الملف الشخصي';

  @override
  String get first_name => 'الاسم الأول';

  @override
  String get last_name => 'الاسم الأخير';

  @override
  String get email_address => 'البريد الإلكتروني * ';

  @override
  String get email => 'أدخل بريدك الإلكتروني هنا';

  @override
  String get id_or_residence_permit => 'رقم الهوية أو تصريح الإقامة * ';

  @override
  String get entered_id_or_residence_permit =>
      'أدخل رقم الهوية أو تصريح الإقامة الخاص بك هنا';

  @override
  String get date_of_birth => 'تاريخ الميلاد * ';

  @override
  String get entered_date_of_birth => 'أدخل تاريخ ميلادك هنا';

  @override
  String get nationality => 'الجنسية *';

  @override
  String get entered_nationality => 'أدخل جنسيتك هنا';

  @override
  String get password => 'كلمة المرور *';

  @override
  String get entered_password => 'أدخل كلمة المرور الخاصة بك هنا';

  @override
  String get confirm_password => 'تأكيد كلمة المرور *';

  @override
  String get reentered_password => 'أعد إدخال كلمة المرور الخاصة بك هنا';

  @override
  String get has_gps_or_maps_installed =>
      'هل لديك نظام تحديد المواقع (GPS) أو خرائط مثبتة على هاتفك؟ *';

  @override
  String get yes_no_option => '(نعم / لا )';

  @override
  String get is_yes => 'نعم';

  @override
  String get is_no => 'لا';

  @override
  String get vehicle_information => 'معلومات المركبة';

  @override
  String get vehicle_registration_document => 'تحميل وثيقة تسجيل المركبة';

  @override
  String get pdf_file => 'PDF';

  @override
  String get vehicle_insurance_document => 'تحميل تأمين المركبة';

  @override
  String get vehicle_type => 'نوع المركبة';

  @override
  String get vehicle_model => 'طراز المركبة';

  @override
  String get year_of_manufacture => 'سنة الصنع';

  @override
  String get license_plate_number => 'أدخل رقم لوحة الترخيص الخاص بك هنا';

  @override
  String get driving_license_information => 'معلومات رخصة القيادة';

  @override
  String get driving_license_photo => 'تحميل صورة رخصة القيادة';

  @override
  String get license_issue_date => 'أدخل تاريخ إصدار رخصتك هنا';

  @override
  String get license_expiry_date => 'أدخل تاريخ انتهاء صلاحية رخصتك هنا';

  @override
  String get has_previous_experience => 'هل لديك خبرة سابقة؟ *';

  @override
  String get past_experience_description => 'صف بإيجاز خبرتك السابقة *';

  @override
  String get input_text => 'اكتب هنا...';

  @override
  String get location_details => 'الموقع ومعلومات إضافية';

  @override
  String get city => 'المدينة *';

  @override
  String get entered_city => 'أدخل مدينتك هنا';

  @override
  String get district_area => 'المنطقة / الحي *';

  @override
  String get entered_district_area => 'أدخل منطقتك / حيك هنا';

  @override
  String get additional_notes => 'ملاحظات إضافية (اختياري)';

  @override
  String get extra_information => 'اكتب أي معلومات إضافية تود مشاركتها...';

  @override
  String get remember_me => 'تذكرني';

  @override
  String get no_account_prompt => 'ليس لديك حساب؟';

  @override
  String get lama_sans => 'Lama Sans';

  @override
  String get create_new_account => 'إنشاء حساب جديد';

  @override
  String get notification => 'الإشعارات';

  @override
  String get no_notifications => 'لا توجد إشعارات';

  @override
  String get no_current_notifications => 'لا توجد إشعارات حالية';

  @override
  String get home => 'الرئيسية';

  @override
  String get finance => 'المالية';

  @override
  String get reports => 'التقارير';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get order_status => 'حالة الطلب';

  @override
  String get order_details => 'تفاصيل الطلب';

  @override
  String get location => 'الموقع';

  @override
  String get order => 'الطلب';

  @override
  String get ordered_products => 'المنتجات التي طلبها العميل';

  @override
  String item_count(String itemsCount) {
    return '$itemsCount عناصر';
  }

  @override
  String get subtotal => 'المجموع الفرعي:';

  @override
  String get total_order_amount => 'إجمالي الطلب:';

  @override
  String get qr_reader => 'قارئ رمز الاستجابة السريعة';

  @override
  String get qr_data => 'بيانات رمز الاستجابة السريعة';

  @override
  String get is_order_confirmed => 'تم تأكيد الطلب';

  @override
  String get scan_qr_code => 'مسح رمز الاستجابة السريعة';

  @override
  String get scan_instruction_message => 'انقر على الزر أدناه لبدء المسح';

  @override
  String last_scanned_data(String scannedData) {
    return 'آخر مسح: $scannedData';
  }

  @override
  String get branch_receive_address => 'عنوان الفرع لاستلام الطلب';

  @override
  String get is_delivered => 'تم التوصيل';

  @override
  String get order_received => 'تم استلام الطلب';

  @override
  String get request_received => 'تم استلام الطلب.';

  @override
  String get account_info => 'معلومات الحساب';

  @override
  String get save_operation => 'حفظ';

  @override
  String get total_orders => 'إجمالي الطلبات';

  @override
  String get range => 'المدى';

  @override
  String get share => 'مشاركة';

  @override
  String get language => 'اللغة';

  @override
  String get terms_and_conditions => 'الشروط والأحكام';

  @override
  String get support => 'الدعم';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get turkish => 'التركية';

  @override
  String get privacy_policy => 'سياسة الخصوصية';

  @override
  String get confirm_logout_message => 'هل أنت متأكد أنك تريد تسجيل الخروج!؟';

  @override
  String get action_reversible_message => 'هذا الإجراء قابل للإلغاء!';

  @override
  String get log_out => 'تسجيل الخروج';

  @override
  String get your_evaluations => 'التقييمات الموجهة إليك';

  @override
  String get placeholder_text => '-';

  @override
  String get search_orders_hint => 'ابحث في طلباتك...';

  @override
  String get total_amounts_entered => 'إجمالي المبالغ التي تم إدخالها';

  @override
  String get order_history => 'سجل الطلبات';

  @override
  String get compared_to_last_month => 'مقارنة بالشهر الماضي';

  @override
  String get is_completed => 'مكتمل';

  @override
  String get is_complete => 'مكتمل';

  @override
  String get history => 'السجل';

  @override
  String get token => 'token';

  @override
  String get order_id_not_match => 'معرف الطلب غير متطابق';

  @override
  String get no_phone_number => 'لا يوجد رقم هاتف';

  @override
  String get delivery_address => 'عنوان التوصيل الخاص بك';

  @override
  String get destination_overview => 'نظرة عامة على الوجهة';

  @override
  String get current_location => 'الحصول على الموقع الحالي';

  @override
  String get your_location => 'موقعك';

  @override
  String get destination => 'الوجهة';

  @override
  String get customer_delivery => 'التوصيل إلى العميل';

  @override
  String get selected_location => 'تحديد الموقع';

  @override
  String get pick_location => 'اختيار الموقع';

  @override
  String get selected_date => 'تحديد التاريخ';

  @override
  String get selected_file => 'تحديد الملف';

  @override
  String get selected_image => 'تحديد الصورة';

  @override
  String image_selection_message(String imagePath) {
    return 'تم تحديد الصورة: $imagePath';
  }

  @override
  String current_step_label(String stepNumber) {
    return 'الخطوة $stepNumber';
  }

  @override
  String select_option(String label) {
    return 'يرجى اختيار $label';
  }

  @override
  String get is_ok => 'موافق';

  @override
  String get retry_action => 'إعادة المحاولة';

  @override
  String get go_back_action => 'العودة';

  @override
  String get no_items_found_message => 'لا توجد عناصر';

  @override
  String get select_location_first_message => 'يرجى تحديد موقع أولاً.';

  @override
  String selection_instruction_message(String label) {
    return 'يرجى تحديد $label';
  }

  @override
  String get search => 'بحث';

  @override
  String get contact_support => 'اتصل بدعم';

  @override
  String get ok => 'موافق';

  @override
  String get delete_account => 'حذف الحساب';

  @override
  String get are_you_sure_delete_account =>
      'هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get delete => 'حذف';

  @override
  String get phone_number_is_required => 'رقم الهاتف مطلوب';

  @override
  String get phone_number_should_be_between_7_and_15_characters =>
      'يجب أن يكون رقم الهاتف بين 7 و 15 رمزًا';

  @override
  String get password_is_required => 'كلمة المرور مطلوبة';

  @override
  String get password_should_be_at_least_8_characters =>
      'يجب أن تتكون كلمة المرور من 8 رموز على الأقل';

  @override
  String get required_field => 'حقل مطلوب';

  @override
  String get passwords_do_not_match => 'كلمتا المرور غير متطابقتين';

  @override
  String must_be_at_least_16_years_old(String age) {
    return 'يجب أن يكون عمرك $age عامًا على الأقل';
  }
}
