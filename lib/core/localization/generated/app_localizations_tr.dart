// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String valid_numberBetween(int min, int max) {
    return '$min ile $max karakter arasında olmalıdır';
  }

  @override
  String valid_exactLength(int length) {
    return 'Telefon numarası $length haneli olmalıdır';
  }

  @override
  String get newOrder => 'Yeni Sipariş';

  @override
  String get onDelivery => 'Teslim Ediliyor';

  @override
  String get delivered => 'Teslim Edildi';

  @override
  String get cancelled => 'İptal Edildi';

  @override
  String get in_progress => 'devam ediyor';

  @override
  String get completed => 'tamamlandı';

  @override
  String get unexpectedError => 'Beklenmedik bir hata oluştu.';

  @override
  String get connectionTimeout =>
      'Bağlantı zaman aşımına uğradı. Lütfen tekrar deneyin.';

  @override
  String get serverError => 'Sunucu hatası.';

  @override
  String get badCertificate => 'Geçersiz Sertifika.';

  @override
  String get unknownError =>
      'Bilinmeyen bir hata oluştu, lütfen internet bağlantınızı kontrol edin.';

  @override
  String get requestCanceled => 'İstek iptal edildi.';

  @override
  String get noNetwork =>
      'Ağ bağlantısı yok. Lütfen bağlantınızı kontrol edin.';

  @override
  String get pickLocation => 'Konum Seç';

  @override
  String get requiredField => 'Gerekli alan';

  @override
  String get requiredPhone => 'Telefon gerekli';

  @override
  String get phoneDoseNotMatch => 'Telefon eşleşmiyor';

  @override
  String get requiredEmail => 'E-posta gerekli';

  @override
  String get wrongEmailValidation => 'Hatalı E-posta Doğrulaması';

  @override
  String get requiredPassword => 'Şifre gerekli';

  @override
  String get smallPassword => 'Kısa Şifre';

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get passwordNotMatch => 'Şifre eşleşmiyor';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get noImageSelected => 'Hiçbir resim seçilmedi.';

  @override
  String get mediaPickError => 'Resim seçilirken bir hata oluştu.';

  @override
  String get permissionRequired => 'İzin Gerekli';

  @override
  String get enablePermissions =>
      'Lütfen uygulama ayarlarından gerekli izinleri etkinleştirin.';

  @override
  String get cancel => 'İptal';

  @override
  String get settings => 'Ayarlar';

  @override
  String get error_occurred => 'hata oluştu';

  @override
  String get path_not_found => 'yol bulunamadı';

  @override
  String get c__________Endcore => '';

  @override
  String get change_password => 'Şifre değiştir';

  @override
  String get enter_new_password => 'Yeni şifreyi girin';

  @override
  String get new_password => 'Yeni şifre';

  @override
  String get confirm_new_password => 'Yeni şifreyi onayla';

  @override
  String get change => 'Değiştir';

  @override
  String get data_issue => 'Bir veri sorunu var';

  @override
  String get select_your_location => 'Konumunuzu seçin';

  @override
  String get select_location_first => 'Önce konum seçilmelidir';

  @override
  String get select_another_location => 'Başka bir konum seçilmelidir';

  @override
  String get tap_map_to_select_location => 'Konum seçmek için haritaya dokunun';

  @override
  String get best_orders => 'En iyi siparişleri alın...';

  @override
  String get order_tracking => 'Siparişlerinizi Takip Edin...';

  @override
  String get no_orders => 'Sipariş Yok';

  @override
  String get unspecified_phrase => '';

  @override
  String get delivery_time => 'Teslimat Süreniz';

  @override
  String get delivery_distance_km => 'Teslimat kilometresi';

  @override
  String branch_scope_work_km(String scopeWork) {
    return '$scopeWork km';
  }

  @override
  String get see_more => 'Daha fazlasını gör';

  @override
  String get order_confirmed => 'Sipariş Onaylandı!';

  @override
  String get confirm_order => 'Siparişi Onayla';

  @override
  String get something_went_wrong => 'Bir şeyler ters gitti';

  @override
  String get please_try_again => 'Lütfen tekrar deneyin';

  @override
  String get refresh => 'Yenile';

  @override
  String get find_best_branches => 'Sizin için en iyi şubeleri bulun!';

  @override
  String get find_best_branch => 'En iyi Şubenizi Bulun...';

  @override
  String get today_special_menu => 'Bugünün ÖZEL MENÜSÜ';

  @override
  String get branches => 'Şubeler';

  @override
  String get view_all => 'Tümünü gör';

  @override
  String get driver_details_label => 'Sürücü...';

  @override
  String get get_started_label => 'Başlayın';

  @override
  String get next_label => 'İleri';

  @override
  String get pickup_order_from_branch_message => 'Siparişi şubeden alın';

  @override
  String get verify_mobile_number_text => 'Cep Numarasını Doğrula';

  @override
  String get verification_code_input_hint_text =>
      'Cep numaranıza gönderilen kodu girin.';

  @override
  String get resend_code_question_text => 'Kodu almadınız mı?';

  @override
  String get resend_code_button_text => 'Kodu tekrar gönder';

  @override
  String get verify_button_text => 'Doğrula';

  @override
  String get forgot_password_link_text => 'Şifrenizi mi unuttunuz?';

  @override
  String get registered_phone_number_input_hint_text =>
      'Hesabınıza bağlı telefon numarasını girin';

  @override
  String get input_number => 'Numaranızı buraya girin';

  @override
  String get get_code_action => 'Kodu şimdi alın';

  @override
  String get welcome_back_message => 'Tekrar hoş geldiniz!.';

  @override
  String get registered_information => 'Lütfen bize kayıtlı bilgileri girin.';

  @override
  String get next_action => 'ileri';

  @override
  String get start_action => 'Şimdi Başlayın';

  @override
  String get sign_up_action => 'Kaydol';

  @override
  String get login_action => 'Şimdi Giriş Yap';

  @override
  String get personal_information => 'Kişisel Bilgiler';

  @override
  String get profile_picture => 'Profil resmi yükle';

  @override
  String get first_name => 'Ad';

  @override
  String get last_name => 'Soyad';

  @override
  String get email_address => 'E-posta Adresi * ';

  @override
  String get email => 'E-postanızı buraya girin';

  @override
  String get id_or_residence_permit => 'Kimlik Numarası veya İkamet İzni * ';

  @override
  String get entered_id_or_residence_permit =>
      'Kimlik Numaranızı veya İkamet İzninizi buraya girin';

  @override
  String get date_of_birth => 'Doğum Tarihi * ';

  @override
  String get entered_date_of_birth => 'Doğum Tarihinizi buraya girin';

  @override
  String get nationality => 'Uyruk *';

  @override
  String get entered_nationality => 'Uyruğunuzu buraya girin';

  @override
  String get password => 'Şifre *';

  @override
  String get entered_password => 'Şifrenizi buraya girin';

  @override
  String get confirm_password => 'şifreyi onayla *';

  @override
  String get reentered_password => 'Şifrenizi tekrar girin';

  @override
  String get has_gps_or_maps_installed =>
      'Telefonunuzda GPS veya haritalar yüklü mü? *';

  @override
  String get yes_no_option => '(Evet / Hayır )';

  @override
  String get is_yes => 'Evet';

  @override
  String get is_no => 'Hayır';

  @override
  String get vehicle_information => 'Araç Bilgileri';

  @override
  String get vehicle_registration_document => 'Araç Kayıt Belgesini Yükle';

  @override
  String get pdf_file => 'PDF';

  @override
  String get vehicle_insurance_document => 'Araç Sigortasını Yükle ';

  @override
  String get vehicle_type => 'Araç Tipi';

  @override
  String get vehicle_model => 'Araç modeli';

  @override
  String get year_of_manufacture => 'Üretim Yılı';

  @override
  String get license_plate_number => 'Plaka Numaranızı buraya girin';

  @override
  String get driving_license_information => 'Sürücü Belgesi Bilgileri';

  @override
  String get driving_license_photo => 'Sürücü Belgesi Fotoğrafını Yükle';

  @override
  String get license_issue_date => 'Ehliyet Veriliş Tarihinizi buraya girin';

  @override
  String get license_expiry_date =>
      'Ehliyet Son Kullanma Tarihinizi buraya girin';

  @override
  String get has_previous_experience => 'Daha önce deneyiminiz var mı? *';

  @override
  String get past_experience_description =>
      'Geçmiş deneyiminizi kısaca açıklayın *';

  @override
  String get input_text => 'Buraya yazın...';

  @override
  String get location_details => 'Konum ve Ek Bilgiler';

  @override
  String get city => 'Şehir *';

  @override
  String get entered_city => 'Şehrinizi buraya girin';

  @override
  String get district_area => 'İlçe / Bölge *';

  @override
  String get entered_district_area => 'İlçenizi / bölgenizi buraya girin';

  @override
  String get additional_notes => 'Ek Notlar (İsteğe Bağlı)';

  @override
  String get extra_information =>
      'Paylaşmak istediğiniz herhangi bir ek bilgiyi buraya yazın...';

  @override
  String get remember_me => 'Beni hatırla';

  @override
  String get no_account_prompt => 'Hesabınız yok mu?';

  @override
  String get lama_sans => 'Lama Sans';

  @override
  String get create_new_account => 'Yeni hesap oluştur';

  @override
  String get notification => 'Bildirim';

  @override
  String get no_notifications => 'Bildirim Yok';

  @override
  String get no_current_notifications => 'Güncel Bildirim Yok';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get finance => 'Finans';

  @override
  String get reports => 'Raporlar';

  @override
  String get profile => 'Profil';

  @override
  String get order_status => 'siparişDurumu';

  @override
  String get order_details => 'Sipariş Detayları';

  @override
  String get location => 'konum';

  @override
  String get order => 'sipariş';

  @override
  String get ordered_products => 'Müşteri tarafından sipariş edilen ürünler';

  @override
  String item_count(String itemsCount) {
    return '$itemsCount ürün';
  }

  @override
  String get subtotal => 'Ara Toplam:';

  @override
  String get total_order_amount => 'Toplam Sipariş:';

  @override
  String get qr_reader => 'Qr okuyucu';

  @override
  String get qr_data => 'qr veri';

  @override
  String get is_order_confirmed => 'Sipariş Onaylandı';

  @override
  String get scan_qr_code => 'QR Kodu Tara';

  @override
  String get scan_instruction_message =>
      'Taramayı başlatmak için aşağıdaki düğmeye dokunun';

  @override
  String last_scanned_data(String scannedData) {
    return 'Son taranan: $scannedData';
  }

  @override
  String get branch_receive_address => 'Siparişi alacak şube adresi';

  @override
  String get is_delivered => 'Teslim edildi';

  @override
  String get order_received => 'Sipariş alındı';

  @override
  String get request_received => 'istek alındı.';

  @override
  String get account_info => 'Hesap bilgileri';

  @override
  String get save_operation => 'kaydet';

  @override
  String get total_orders => 'Toplam Siparişler';

  @override
  String get range => 'aralık';

  @override
  String get share => 'Paylaş';

  @override
  String get language => 'Dil';

  @override
  String get terms_and_conditions => 'Şartlar ve Koşullar';

  @override
  String get support => 'Destek';

  @override
  String get logout => 'Çıkış yap';

  @override
  String get change_language => 'Dili Değiştir';

  @override
  String get english => 'İngilizce';

  @override
  String get arabic => 'Arapça';

  @override
  String get turkish => 'Türkçe';

  @override
  String get privacy_policy => 'Gizlilik Politikası';

  @override
  String get confirm_logout_message =>
      'Çıkış yapmak istediğinizden emin misiniz!?';

  @override
  String get action_reversible_message => 'Bu Eylem Geri Alınabilir!';

  @override
  String get log_out => 'Çıkış Yap';

  @override
  String get your_evaluations => 'Size Yönlendirilen Değerlendirmeler';

  @override
  String get placeholder_text => '-';

  @override
  String get search_orders_hint => 'Siparişlerinizi arayın...';

  @override
  String get total_amounts_entered => 'Girilen toplam tutarlar';

  @override
  String get order_history => 'Sipariş geçmişi';

  @override
  String get compared_to_last_month => 'Geçen aya göre';

  @override
  String get is_completed => 'Tamamlandı';

  @override
  String get is_complete => 'Tamamla';

  @override
  String get history => 'Geçmiş';

  @override
  String get token => 'token';

  @override
  String get order_id_not_match => 'Sipariş Kimliği Eşleşmiyor';

  @override
  String get no_phone_number => 'Telefon numarası yok';

  @override
  String get delivery_address => 'Teslimat Adresiniz';

  @override
  String get destination_overview => 'Hedefe Genel Bakış';

  @override
  String get current_location => 'Mevcut Konumu al';

  @override
  String get your_location => 'Konumunuz';

  @override
  String get destination => 'Hedef';

  @override
  String get customer_delivery => 'Müşteriye teslimat';

  @override
  String get selected_location => 'Konum Seç';

  @override
  String get pick_location => 'Konum Seç';

  @override
  String get selected_date => 'Tarih Seç';

  @override
  String get selected_file => 'Dosya Seç';

  @override
  String get selected_image => 'Resim Seç';

  @override
  String image_selection_message(String imagePath) {
    return 'Seçilen Resim: $imagePath';
  }

  @override
  String current_step_label(String stepNumber) {
    return 'Adım $stepNumber';
  }

  @override
  String select_option(String label) {
    return 'lütfen $label seçin';
  }

  @override
  String get is_ok => 'Tamam';

  @override
  String get retry_action => 'Tekrar Dene';

  @override
  String get go_back_action => 'Geri dön';

  @override
  String get no_items_found_message => 'Öğe Yok';

  @override
  String get select_location_first_message => 'Lütfen önce bir konum seçin.';

  @override
  String selection_instruction_message(String label) {
    return 'Lütfen $label seçin';
  }

  @override
  String get search => 'ara';

  @override
  String get contact_support => 'Destekle İletişime Geç';

  @override
  String get ok => 'Tamam';

  @override
  String get delete_account => 'Hesabı Sil';

  @override
  String get are_you_sure_delete_account =>
      'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get delete => 'Sil';

  @override
  String get phone_number_is_required => 'Telefon numarası zorunludur';

  @override
  String get phone_number_should_be_between_7_and_15_characters =>
      'Telefon numarası 7 ile 15 karakter arasında olmalıdır';

  @override
  String get password_is_required => 'Şifre zorunludur';

  @override
  String get password_should_be_at_least_8_characters =>
      'Şifre en az 8 karakter olmalıdır';

  @override
  String get required_field => 'Zorunlu alan';

  @override
  String get passwords_do_not_match => 'Şifreler eşleşmiyor';

  @override
  String must_be_at_least_16_years_old(String age) {
    return 'En az $age yaşında olmalısınız';
  }
}
