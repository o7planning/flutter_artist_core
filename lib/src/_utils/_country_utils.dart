class CountryUtils {
  static const Map<String, String> map = {
    // Major world languages
    'en': 'GB',
    'vi': 'VN',
    'fr': 'FR',
    'de': 'DE',
    'es': 'ES',
    'pt': 'PT',
    'it': 'IT',
    'ru': 'RU',
    'zh': 'CN',
    'ja': 'JP',
    'ko': 'KR',
    'ar': 'SA',
    'hi': 'IN',
    'bn': 'BD',
    'ur': 'PK',
    'fa': 'IR',
    'tr': 'TR',
    'id': 'ID',
    'ms': 'MY',
    'th': 'TH',
    'tl': 'PH',

    // Europe
    'nl': 'NL',
    'sv': 'SE',
    'no': 'NO',
    'da': 'DK',
    'fi': 'FI',
    'pl': 'PL',
    'cs': 'CZ',
    'sk': 'SK',
    'hu': 'HU',
    'ro': 'RO',
    'bg': 'BG',
    'el': 'GR',
    'uk': 'UA',
    'sr': 'RS',
    'hr': 'HR',
    'sl': 'SI',
    'et': 'EE',
    'lv': 'LV',
    'lt': 'LT',
    'ga': 'IE',
    'is': 'IS',
    'mt': 'MT',
    'sq': 'AL',
    'mk': 'MK',
    'bs': 'BA',

    // Middle East & Central Asia
    'he': 'IL',
    'az': 'AZ',
    'ka': 'GE',
    'hy': 'AM',
    'kk': 'KZ',
    'uz': 'UZ',
    'tk': 'TM',
    'ky': 'KG',
    'ps': 'AF',

    // South & Southeast Asia
    'ta': 'IN',
    'te': 'IN',
    'ml': 'IN',
    'kn': 'IN',
    'mr': 'IN',
    'ne': 'NP',
    'si': 'LK',
    'km': 'KH',
    'lo': 'LA',
    'my': 'MM',

    // East Asia variants
    'zh-hans': 'CN',
    'zh-hant': 'TW',

    // Africa
    'sw': 'TZ',
    'am': 'ET',
    'ha': 'NG',
    'yo': 'NG',
    'ig': 'NG',
    'zu': 'ZA',
    'xh': 'ZA',
    'af': 'ZA',
    'st': 'LS',
    'tn': 'BW',
    'sn': 'ZW',
    'rw': 'RW',
    'so': 'SO',

    // Others
    'eo': 'EO', // Esperanto (no country → custom)
    'la': 'VA', // Latin → Vatican
    'cy': 'GB', // Welsh
    'gd': 'GB', // Scottish Gaelic
    'br': 'FR', // Breton
    'co': 'FR', // Corsican
    'eu': 'ES', // Basque
    'gl': 'ES', // Galician
    // Extra (less common but valid ISO 639-1)
    'ab': 'GE',
    'aa': 'ET',
    'an': 'ES',
    'as': 'IN',
    'ay': 'BO',
    'ba': 'RU',
    'be': 'BY',
    'bi': 'VU',
    'bm': 'ML',
    'bo': 'CN',
    'ch': 'GU',
    'cr': 'CA',
    'cv': 'RU',
    'dz': 'BT',
    'ee': 'GH',
    'fj': 'FJ',
    'fo': 'FO',
    'fy': 'NL',
    'gn': 'PY',
    'gv': 'IM',
    'ht': 'HT',
    'iu': 'CA',
    'jv': 'ID',
    'kl': 'GL',
    'ks': 'IN',
    'ku': 'TR',
    'kw': 'GB',
    'lg': 'UG',
    'ln': 'CD',
    'mg': 'MG',
    'na': 'NR',
    'oc': 'FR',
    'om': 'ET',
    'or': 'IN',
    'pa': 'IN',
    'qu': 'PE',
    'rm': 'CH',
    'rn': 'BI',
    'sa': 'IN',
    'sc': 'IT',
    'sd': 'PK',
    'se': 'NO',
    'sg': 'CF',
    'ti': 'ER',
    'to': 'TO',
    'ts': 'ZA',
    'tt': 'RU',
    'tw': 'GH',
    'ug': 'CN',
    've': 'ZA',
    'vo': 'EO',
    'wa': 'BE',
    'wo': 'SN',
    'yi': 'IL',
    'za': 'CN',
  };

  static String? getCountryByLangCode(String lang) {
    return map[lang.toLowerCase()];
  }

  static String? getFlag(String lang) {
    final code = getCountryByLangCode(lang);
    if (code == null || code.length != 2) return null;

    return code.codeUnits.map((c) => String.fromCharCode(c + 127397)).join();
  }
}
