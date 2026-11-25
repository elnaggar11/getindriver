/// Defines the expected phone number digit length range for a given country dial code.
///
/// [minLength] and [maxLength] represent the number of digits in the
/// **national** phone number (i.e. excluding the dial code itself).
class PhoneLengthRule {
  final int minLength;
  final int maxLength;

  const PhoneLengthRule({required this.minLength, required this.maxLength});
}

/// Maps country dial codes to their expected national phone number lengths.
///
/// Usage:
/// ```dart
/// final rule = phoneLengthRules['+90']; // Turkey → 10 digits
/// ```
const Map<String, PhoneLengthRule> phoneLengthRules = {
  // Middle East & North Africa
  '+90': PhoneLengthRule(minLength: 10, maxLength: 10), // Turkey
  '+966': PhoneLengthRule(minLength: 9, maxLength: 9), // Saudi Arabia
  '+971': PhoneLengthRule(minLength: 9, maxLength: 9), // UAE (Mobile)
  '+20': PhoneLengthRule(minLength: 10, maxLength: 10), // Egypt (Mobile)
  '+962': PhoneLengthRule(minLength: 9, maxLength: 9), // Jordan (Mobile)
  '+961': PhoneLengthRule(minLength: 7, maxLength: 8), // Lebanon (Mobile)
  '+964': PhoneLengthRule(minLength: 10, maxLength: 10), // Iraq (Mobile)
  '+965': PhoneLengthRule(minLength: 8, maxLength: 8), // Kuwait
  '+968': PhoneLengthRule(minLength: 8, maxLength: 8), // Oman
  '+974': PhoneLengthRule(minLength: 8, maxLength: 8), // Qatar
  '+973': PhoneLengthRule(minLength: 8, maxLength: 8), // Bahrain
  '+967': PhoneLengthRule(minLength: 9, maxLength: 9), // Yemen (Mobile)
  '+963': PhoneLengthRule(minLength: 9, maxLength: 9), // Syria (Mobile)
  '+970': PhoneLengthRule(minLength: 9, maxLength: 9), // Palestine (Mobile)
  '+218': PhoneLengthRule(minLength: 9, maxLength: 9), // Libya (Mobile)
  '+216': PhoneLengthRule(minLength: 8, maxLength: 8), // Tunisia
  '+213': PhoneLengthRule(minLength: 9, maxLength: 9), // Algeria
  '+212': PhoneLengthRule(minLength: 9, maxLength: 9), // Morocco
  '+249': PhoneLengthRule(minLength: 9, maxLength: 9), // Sudan
  // Europe
  '+44': PhoneLengthRule(minLength: 10, maxLength: 10), // UK
  '+49': PhoneLengthRule(minLength: 10, maxLength: 11), // Germany (Mobile)
  '+33': PhoneLengthRule(minLength: 9, maxLength: 9), // France (Mobile)
  '+39': PhoneLengthRule(minLength: 9, maxLength: 10), // Italy (Mobile)
  '+34': PhoneLengthRule(minLength: 9, maxLength: 9), // Spain
  '+31': PhoneLengthRule(minLength: 9, maxLength: 9), // Netherlands
  '+32': PhoneLengthRule(minLength: 9, maxLength: 9), // Belgium (Mobile)
  '+46': PhoneLengthRule(minLength: 9, maxLength: 9), // Sweden (Mobile)
  '+47': PhoneLengthRule(minLength: 8, maxLength: 8), // Norway
  '+45': PhoneLengthRule(minLength: 8, maxLength: 8), // Denmark
  '+358': PhoneLengthRule(minLength: 9, maxLength: 10), // Finland (Mobile)
  '+48': PhoneLengthRule(minLength: 9, maxLength: 9), // Poland (Mobile)
  '+43': PhoneLengthRule(minLength: 10, maxLength: 11), // Austria (Mobile)
  '+41': PhoneLengthRule(minLength: 9, maxLength: 9), // Switzerland
  '+351': PhoneLengthRule(minLength: 9, maxLength: 9), // Portugal
  '+30': PhoneLengthRule(minLength: 10, maxLength: 10), // Greece
  '+7': PhoneLengthRule(minLength: 10, maxLength: 10), // Russia
  '+380': PhoneLengthRule(minLength: 9, maxLength: 9), // Ukraine
  '+40': PhoneLengthRule(minLength: 9, maxLength: 9), // Romania
  '+36': PhoneLengthRule(minLength: 9, maxLength: 9), // Hungary (Mobile)
  '+420': PhoneLengthRule(minLength: 9, maxLength: 9), // Czech Republic
  '+421': PhoneLengthRule(minLength: 9, maxLength: 9), // Slovakia
  '+353': PhoneLengthRule(minLength: 9, maxLength: 9), // Ireland (Mobile)
  '+385': PhoneLengthRule(minLength: 8, maxLength: 9), // Croatia (Mobile)
  '+381': PhoneLengthRule(minLength: 8, maxLength: 9), // Serbia (Mobile)
  '+359': PhoneLengthRule(minLength: 8, maxLength: 9), // Bulgaria (Mobile)
  '+375': PhoneLengthRule(minLength: 9, maxLength: 9), // Belarus (Mobile)
  '+354': PhoneLengthRule(minLength: 7, maxLength: 7), // Iceland (Mobile)
  '+355': PhoneLengthRule(minLength: 9, maxLength: 9), // Albania (Mobile)
  '+387': PhoneLengthRule(minLength: 8, maxLength: 9), // Bosnia (Mobile)
  '+389': PhoneLengthRule(minLength: 8, maxLength: 8), // Macedonia (Mobile)
  '+382': PhoneLengthRule(minLength: 8, maxLength: 8), // Montenegro (Mobile)
  '+386': PhoneLengthRule(minLength: 8, maxLength: 8), // Slovenia (Mobile)
  '+372': PhoneLengthRule(minLength: 7, maxLength: 8), // Estonia (Mobile)
  '+371': PhoneLengthRule(minLength: 8, maxLength: 8), // Latvia (Mobile)
  '+370': PhoneLengthRule(minLength: 8, maxLength: 8), // Lithuania (Mobile)
  '+357': PhoneLengthRule(minLength: 8, maxLength: 8), // Cyprus (Mobile)
  '+356': PhoneLengthRule(minLength: 8, maxLength: 8), // Malta (Mobile)
  // Asia
  '+91': PhoneLengthRule(minLength: 10, maxLength: 10), // India
  '+86': PhoneLengthRule(minLength: 11, maxLength: 11), // China (Mobile)
  '+81': PhoneLengthRule(minLength: 10, maxLength: 10), // Japan (Mobile)
  '+82': PhoneLengthRule(minLength: 10, maxLength: 10), // South Korea (Mobile)
  '+92': PhoneLengthRule(minLength: 10, maxLength: 10), // Pakistan
  '+880': PhoneLengthRule(minLength: 10, maxLength: 10), // Bangladesh
  '+62': PhoneLengthRule(minLength: 10, maxLength: 12), // Indonesia
  '+60': PhoneLengthRule(minLength: 9, maxLength: 10), // Malaysia
  '+63': PhoneLengthRule(minLength: 10, maxLength: 10), // Philippines (Mobile)
  '+66': PhoneLengthRule(minLength: 9, maxLength: 9), // Thailand
  '+84': PhoneLengthRule(minLength: 9, maxLength: 9), // Vietnam
  '+65': PhoneLengthRule(minLength: 8, maxLength: 8), // Singapore
  '+886': PhoneLengthRule(minLength: 9, maxLength: 9), // Taiwan (Mobile)
  '+852': PhoneLengthRule(minLength: 8, maxLength: 8), // Hong Kong (Mobile)
  '+94': PhoneLengthRule(minLength: 9, maxLength: 9), // Sri Lanka (Mobile)
  '+95': PhoneLengthRule(minLength: 9, maxLength: 9), // Myanmar (Mobile)
  '+977': PhoneLengthRule(minLength: 10, maxLength: 10), // Nepal (Mobile)
  '+855': PhoneLengthRule(minLength: 8, maxLength: 9), // Cambodia (Mobile)
  '+98': PhoneLengthRule(minLength: 10, maxLength: 10), // Iran (Mobile)
  '+93': PhoneLengthRule(minLength: 9, maxLength: 9), // Afghanistan (Mobile)
  '+998': PhoneLengthRule(minLength: 9, maxLength: 9), // Uzbekistan (Mobile)
  '+972': PhoneLengthRule(minLength: 8, maxLength: 9), // Israel (Mobile)
  '+996': PhoneLengthRule(minLength: 9, maxLength: 9), // Kyrgyzstan (Mobile)
  '+992': PhoneLengthRule(minLength: 9, maxLength: 9), // Tajikistan (Mobile)
  '+993': PhoneLengthRule(minLength: 8, maxLength: 8), // Turkmenistan (Mobile)
  '+976': PhoneLengthRule(minLength: 8, maxLength: 8), // Mongolia (Mobile)
  '+856': PhoneLengthRule(minLength: 8, maxLength: 8), // Laos (Mobile)
  '+673': PhoneLengthRule(minLength: 7, maxLength: 7), // Brunei (Mobile)
  '+960': PhoneLengthRule(minLength: 7, maxLength: 7), // Maldives (Mobile)
  // Americas
  '+1': PhoneLengthRule(minLength: 10, maxLength: 10), // USA / Canada
  '+52': PhoneLengthRule(minLength: 10, maxLength: 10), // Mexico
  '+55': PhoneLengthRule(minLength: 11, maxLength: 11), // Brazil (Mobile)
  '+57': PhoneLengthRule(minLength: 10, maxLength: 10), // Colombia
  '+54': PhoneLengthRule(minLength: 10, maxLength: 10), // Argentina
  '+56': PhoneLengthRule(minLength: 9, maxLength: 9), // Chile
  '+51': PhoneLengthRule(minLength: 9, maxLength: 9), // Peru
  '+591': PhoneLengthRule(minLength: 8, maxLength: 8), // Bolivia (Mobile)
  '+506': PhoneLengthRule(minLength: 8, maxLength: 8), // Costa Rica (Mobile)
  '+53': PhoneLengthRule(minLength: 8, maxLength: 8), // Cuba (Mobile)
  '+593': PhoneLengthRule(minLength: 9, maxLength: 9), // Ecuador (Mobile)
  '+507': PhoneLengthRule(minLength: 8, maxLength: 8), // Panama (Mobile)
  '+595': PhoneLengthRule(minLength: 9, maxLength: 9), // Paraguay (Mobile)
  '+598': PhoneLengthRule(minLength: 8, maxLength: 8), // Uruguay (Mobile)
  '+58': PhoneLengthRule(minLength: 10, maxLength: 10), // Venezuela (Mobile)
  '+502': PhoneLengthRule(minLength: 8, maxLength: 8), // Guatemala (Mobile)
  '+504': PhoneLengthRule(minLength: 8, maxLength: 8), // Honduras (Mobile)
  '+503': PhoneLengthRule(minLength: 8, maxLength: 8), // El Salvador (Mobile)
  '+505': PhoneLengthRule(minLength: 8, maxLength: 8), // Nicaragua (Mobile)
  '+509': PhoneLengthRule(minLength: 8, maxLength: 8), // Haiti (Mobile)
  // Africa
  '+234': PhoneLengthRule(minLength: 10, maxLength: 10), // Nigeria
  '+27': PhoneLengthRule(minLength: 9, maxLength: 9), // South Africa
  '+254': PhoneLengthRule(minLength: 9, maxLength: 9), // Kenya
  '+233': PhoneLengthRule(minLength: 9, maxLength: 9), // Ghana
  '+255': PhoneLengthRule(minLength: 9, maxLength: 9), // Tanzania
  '+256': PhoneLengthRule(minLength: 9, maxLength: 9), // Uganda
  '+251': PhoneLengthRule(minLength: 9, maxLength: 9), // Ethiopia
  '+221': PhoneLengthRule(minLength: 9, maxLength: 9), // Senegal (Mobile)
  '+225': PhoneLengthRule(minLength: 10, maxLength: 10), // Ivory Coast (Mobile)
  '+237': PhoneLengthRule(minLength: 9, maxLength: 9), // Cameroon (Mobile)
  '+260': PhoneLengthRule(minLength: 9, maxLength: 9), // Zambia (Mobile)
  '+263': PhoneLengthRule(minLength: 9, maxLength: 9), // Zimbabwe (Mobile)
  '+244': PhoneLengthRule(minLength: 9, maxLength: 9), // Angola (Mobile)
  '+261': PhoneLengthRule(minLength: 9, maxLength: 9), // Madagascar (Mobile)
  '+223': PhoneLengthRule(minLength: 8, maxLength: 8), // Mali (Mobile)
  '+226': PhoneLengthRule(minLength: 8, maxLength: 8), // Burkina Faso (Mobile)
  '+224': PhoneLengthRule(minLength: 9, maxLength: 9), // Guinea (Mobile)
  '+250': PhoneLengthRule(minLength: 9, maxLength: 9), // Rwanda (Mobile)
  '+258': PhoneLengthRule(minLength: 9, maxLength: 9), // Mozambique (Mobile)
  '+265': PhoneLengthRule(minLength: 9, maxLength: 9), // Malawi (Mobile)
  '+267': PhoneLengthRule(minLength: 8, maxLength: 8), // Botswana (Mobile)
  '+264': PhoneLengthRule(minLength: 7, maxLength: 9), // Namibia (Mobile)
  '+230': PhoneLengthRule(minLength: 8, maxLength: 8), // Mauritius (Mobile)
  // Oceania
  '+61': PhoneLengthRule(minLength: 9, maxLength: 9), // Australia
  '+64': PhoneLengthRule(minLength: 9, maxLength: 10), // New Zealand (Mobile)
  '+679': PhoneLengthRule(minLength: 7, maxLength: 7), // Fiji (Mobile)
  '+675': PhoneLengthRule(minLength: 8, maxLength: 8), // Papua New Guinea (Mobile)
};

/// Default fallback rule when the dial code is not found in the map.
const PhoneLengthRule defaultPhoneLengthRule = PhoneLengthRule(
  minLength: 6,
  maxLength: 15,
);
