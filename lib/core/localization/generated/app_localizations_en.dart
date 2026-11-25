// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String valid_numberBetween(int min, int max) {
    return 'Must be between $min and $max characters';
  }

  @override
  String valid_exactLength(int length) {
    return 'Phone number must be $length digits exactly';
  }

  @override
  String get newOrder => 'New Order';

  @override
  String get onDelivery => 'On Delivery';

  @override
  String get delivered => 'Delivered';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get in_progress => 'in progress';

  @override
  String get completed => 'completed';

  @override
  String get unexpectedError => 'An unexpected error occurred.';

  @override
  String get connectionTimeout => 'Connection timeout. Please try again.';

  @override
  String get serverError => 'Server error.';

  @override
  String get badCertificate => 'Bad Certificate.';

  @override
  String get unknownError =>
      'An unknown error occurred, please check your internet connection.';

  @override
  String get requestCanceled => 'Request canceled.';

  @override
  String get noNetwork => 'No network. Please check your connection.';

  @override
  String get pickLocation => 'Pick Location';

  @override
  String get requiredField => 'required Field';

  @override
  String get requiredPhone => 'required phone';

  @override
  String get phoneDoseNotMatch => 'phone dose not match';

  @override
  String get requiredEmail => 'required Email';

  @override
  String get wrongEmailValidation => 'wrong Email Validation';

  @override
  String get requiredPassword => 'required Password';

  @override
  String get smallPassword => 'small Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordNotMatch => 'password not match';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get noImageSelected => 'No image was selected.';

  @override
  String get mediaPickError => 'An error occurred while selecting the image.';

  @override
  String get permissionRequired => 'Permission Required';

  @override
  String get enablePermissions =>
      'Please enable the required permissions from app settings.';

  @override
  String get cancel => 'Cancel';

  @override
  String get settings => 'Settings';

  @override
  String get error_occurred => 'error occurred';

  @override
  String get path_not_found => 'path not found';

  @override
  String get c__________Endcore => '';

  @override
  String get change_password => 'Change password';

  @override
  String get enter_new_password => 'Enter the new password';

  @override
  String get new_password => 'New password';

  @override
  String get confirm_new_password => 'Confirm new password';

  @override
  String get change => 'Change';

  @override
  String get data_issue => 'There is a data issue';

  @override
  String get select_your_location => 'Select your location';

  @override
  String get select_location_first => 'Location must be selected first';

  @override
  String get select_another_location => 'Another location must be selected';

  @override
  String get tap_map_to_select_location => 'Tap on the map to select location';

  @override
  String get best_orders => 'Pick up the best orders...';

  @override
  String get order_tracking => 'Track your Orders...';

  @override
  String get no_orders => 'No Orders';

  @override
  String get unspecified_phrase => '';

  @override
  String get delivery_time => 'Your Delivery time';

  @override
  String get delivery_distance_km => 'Delivery kilometer';

  @override
  String branch_scope_work_km(String scopeWork) {
    return '$scopeWork km';
  }

  @override
  String get see_more => 'See more';

  @override
  String get order_confirmed => 'Order Confirmed!';

  @override
  String get confirm_order => 'Confirm Order';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get please_try_again => 'Please try again';

  @override
  String get refresh => 'Refresh';

  @override
  String get find_best_branches => 'Find best branches for you!';

  @override
  String get find_best_branch => 'Find Your best Branch...';

  @override
  String get today_special_menu => 'Today\'s SPECIAL MENU';

  @override
  String get branches => 'Branches';

  @override
  String get view_all => 'View all';

  @override
  String get driver_details_label => 'Driver...';

  @override
  String get get_started_label => 'Get Started';

  @override
  String get next_label => 'Next';

  @override
  String get pickup_order_from_branch_message =>
      'Pick up the order from branch';

  @override
  String get verify_mobile_number_text => 'Verify Mobile Number';

  @override
  String get verification_code_input_hint_text =>
      'Enter the code sent to your mobile number.';

  @override
  String get resend_code_question_text => 'Didn\'t receive the code?';

  @override
  String get resend_code_button_text => 'Resend code';

  @override
  String get verify_button_text => 'Verify';

  @override
  String get forgot_password_link_text => 'Forgot your password?';

  @override
  String get registered_phone_number_input_hint_text =>
      'Enter the phone number linked to your account';

  @override
  String get input_number => 'Enter your number here';

  @override
  String get get_code_action => 'Get the code now';

  @override
  String get welcome_back_message => 'Welcome back !.';

  @override
  String get registered_information =>
      'Please enter the information registered with us.';

  @override
  String get next_action => 'next';

  @override
  String get start_action => 'Get Started now';

  @override
  String get sign_up_action => 'Sign Up';

  @override
  String get login_action => 'Log In now';

  @override
  String get personal_information => 'Personal Information';

  @override
  String get profile_picture => 'Upload profile picture';

  @override
  String get first_name => 'First Name';

  @override
  String get last_name => 'Last Name';

  @override
  String get email_address => 'Email Address * ';

  @override
  String get email => 'Enter your email here';

  @override
  String get id_or_residence_permit => 'ID Number or Residence Permit * ';

  @override
  String get entered_id_or_residence_permit =>
      'Enter your ID Number or Residence Permit here';

  @override
  String get date_of_birth => 'Date of Birth * ';

  @override
  String get entered_date_of_birth => 'Enter your Date of Birth here';

  @override
  String get nationality => 'Nationality *';

  @override
  String get entered_nationality => 'Enter your Nationality here';

  @override
  String get password => 'Password *';

  @override
  String get entered_password => 'Enter your password here';

  @override
  String get confirm_password => 'confirm password *';

  @override
  String get reentered_password => 'Renter your password here';

  @override
  String get has_gps_or_maps_installed =>
      'Do you have GPS or maps installed on your phone? *';

  @override
  String get yes_no_option => '(Yes / No )';

  @override
  String get is_yes => 'Yes';

  @override
  String get is_no => 'No';

  @override
  String get vehicle_information => 'Vehicle Information';

  @override
  String get vehicle_registration_document =>
      'Upload Vehicle Registration Document';

  @override
  String get pdf_file => 'PDF';

  @override
  String get vehicle_insurance_document => 'Upload Vehicle Insurance ';

  @override
  String get vehicle_type => 'Type of Vehicle';

  @override
  String get vehicle_model => 'Vehicle model';

  @override
  String get year_of_manufacture => 'Year of Manufacture';

  @override
  String get license_plate_number => 'Enter your License Plate Number here';

  @override
  String get driving_license_information => 'Driving License Information';

  @override
  String get driving_license_photo => 'Upload Driving License Photo';

  @override
  String get license_issue_date => 'Enter your License Issue Date here';

  @override
  String get license_expiry_date => 'Enter your License Expiry Date here';

  @override
  String get has_previous_experience => 'Do you have previous experience? *';

  @override
  String get past_experience_description =>
      'Briefly describe your past experience *';

  @override
  String get input_text => 'Write here...';

  @override
  String get location_details => 'Location & Additional Information';

  @override
  String get city => 'City *';

  @override
  String get entered_city => 'Enter your city here';

  @override
  String get district_area => 'District / Area *';

  @override
  String get entered_district_area => 'Enter your district / area here';

  @override
  String get additional_notes => 'Additional Notes (Optional)';

  @override
  String get extra_information =>
      'Write any extra information you\'d like to share...';

  @override
  String get remember_me => 'Remember me';

  @override
  String get no_account_prompt => 'Don\'t have an account?';

  @override
  String get lama_sans => 'Lama Sans';

  @override
  String get create_new_account => 'Create a new account';

  @override
  String get notification => 'Notification';

  @override
  String get no_notifications => 'No Notifications';

  @override
  String get no_current_notifications => 'No Current Notifications';

  @override
  String get home => 'Home';

  @override
  String get finance => 'Finance';

  @override
  String get reports => 'Reports';

  @override
  String get profile => 'Profile';

  @override
  String get order_status => 'orderStatus';

  @override
  String get order_details => 'Order Details';

  @override
  String get location => 'location';

  @override
  String get order => 'order';

  @override
  String get ordered_products => 'Products ordered by the customer';

  @override
  String item_count(String itemsCount) {
    return '$itemsCount items';
  }

  @override
  String get subtotal => 'Subtotal:';

  @override
  String get total_order_amount => 'Total Order:';

  @override
  String get qr_reader => 'Qr reader';

  @override
  String get qr_data => 'qr data';

  @override
  String get is_order_confirmed => 'Order Confirmed';

  @override
  String get scan_qr_code => 'Scan QR Code';

  @override
  String get scan_instruction_message =>
      'Tap the button below to start scanning';

  @override
  String last_scanned_data(String scannedData) {
    return 'Last scanned: $scannedData';
  }

  @override
  String get branch_receive_address => 'Branch address to receive order';

  @override
  String get is_delivered => 'Delivered';

  @override
  String get order_received => 'Order received';

  @override
  String get request_received => 'request has been received.';

  @override
  String get account_info => 'Account information';

  @override
  String get save_operation => 'save';

  @override
  String get total_orders => 'Total Orders';

  @override
  String get range => 'range';

  @override
  String get share => 'Share';

  @override
  String get language => 'Language';

  @override
  String get terms_and_conditions => 'Terms and Conditions';

  @override
  String get support => 'Support';

  @override
  String get logout => 'Logout';

  @override
  String get change_language => 'Change Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get turkish => 'Turkish';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get confirm_logout_message => 'Are you sure you want to log out!?';

  @override
  String get action_reversible_message => 'This Action is Reversible!';

  @override
  String get log_out => 'Log Out';

  @override
  String get your_evaluations => 'Evaluations directed to you';

  @override
  String get placeholder_text => '-';

  @override
  String get search_orders_hint => 'Search your Orders...';

  @override
  String get total_amounts_entered => 'Total amounts entered';

  @override
  String get order_history => 'Order history';

  @override
  String get compared_to_last_month => 'Compared to last month';

  @override
  String get is_completed => 'Completed';

  @override
  String get is_complete => 'Complete';

  @override
  String get history => 'History';

  @override
  String get token => 'token';

  @override
  String get order_id_not_match => 'Order Id Not Match';

  @override
  String get no_phone_number => 'No phone number';

  @override
  String get delivery_address => 'Your Delivery Address';

  @override
  String get destination_overview => 'Destination Overview';

  @override
  String get current_location => 'get current Location';

  @override
  String get your_location => 'Your Location';

  @override
  String get destination => 'Destination';

  @override
  String get customer_delivery => 'Delivery to the customer';

  @override
  String get selected_location => 'Select Location';

  @override
  String get pick_location => 'Pick Location';

  @override
  String get selected_date => 'Select Date';

  @override
  String get selected_file => 'Select File';

  @override
  String get selected_image => 'Select Image';

  @override
  String image_selection_message(String imagePath) {
    return 'Image Selected: $imagePath';
  }

  @override
  String current_step_label(String stepNumber) {
    return 'Step $stepNumber';
  }

  @override
  String select_option(String label) {
    return 'please Choose $label';
  }

  @override
  String get is_ok => 'OK';

  @override
  String get retry_action => 'Retry';

  @override
  String get go_back_action => 'Go back';

  @override
  String get no_items_found_message => 'No Items';

  @override
  String get select_location_first_message => 'Please select a location first.';

  @override
  String selection_instruction_message(String label) {
    return 'Please select $label';
  }

  @override
  String get search => 'search';

  @override
  String get contact_support => 'Contact Support';

  @override
  String get ok => 'Ok';

  @override
  String get delete_account => 'Delete Account';

  @override
  String get are_you_sure_delete_account =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get delete => 'Delete';

  @override
  String get phone_number_is_required => 'Phone number is required';

  @override
  String get phone_number_should_be_between_7_and_15_characters =>
      'Phone number should be between 7 and 15 characters';

  @override
  String get password_is_required => 'Password is required';

  @override
  String get password_should_be_at_least_8_characters =>
      'Password should be at least 8 characters';

  @override
  String get required_field => 'Required field';

  @override
  String get passwords_do_not_match => 'Passwords do not match';

  @override
  String must_be_at_least_16_years_old(String age) {
    return 'You must be at least $age years old';
  }
}
