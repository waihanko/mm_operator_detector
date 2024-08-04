library mm_operator_detector;


enum TelecomOperator {
  ooredoo,
  telenor,
  mpt,
  mec,
  mytel,
  unknown,
}

enum NetworkType {
  gsm,
  wcdma,
  cdma450,
  cdma800,
  unknown,
}

class MMOperatorDetector {
  static const Map<String, int> _myanmarNumbers = {
    "၀": 0,
    "၁": 1,
    "၂": 2,
    "၃": 3,
    "၄": 4,
    "၅": 5,
    "၆": 6,
    "၇": 7,
    "၈": 8,
    "၉": 9,
  };

  static final RegExp _ooredooRegex = RegExp(r'^(09|\+?959)9([4-9])\d{7}$');
  static final RegExp _telenorRegex = RegExp(r'^(09|\+?959)7([4-9])\d{7}$');
  static final RegExp _mytelRegex = RegExp(r'^(09|\+?959)6([5-9])\d{7}$');
  static final RegExp _mptRegex = RegExp(r'^(09|\+?959)(5\d{6}|4\d{7,8}|2\d{6,8}|6\d{6}|8\d{6}|7\d{7}|9(0|1|9)\d{5,6}|2[0-4]\d{5}|5[0-6]\d{5}|8[13-7]\d{5}|4[1379]\d{6}|73\d{6}|91\d{6}|25\d{7}|26[0-5]\d{6}|40[0-4]\d{6}|42\d{7}|45\d{7}|89[6789]\d{6}|)$');
  static final RegExp _mecRegex = RegExp(r'^(09|\+?959)(3\d{7,8}|3[0-369]\d{6}|34\d{7})$');

  static bool isValidMMPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) {
      throw ArgumentError('Please include phoneNumber parameter.');
    }
    phoneNumber = normalizeInput(phoneNumber);
    final RegExp myanmarPhoneRe = RegExp(r'^(09|\+?950?9|\+?95950?9)\d{7,9}$');
    return myanmarPhoneRe.hasMatch(phoneNumber);
  }

  static String _sanitizeInput(String? phoneNumber) {
    if (phoneNumber == null) {
      throw ArgumentError('Please include phoneNumber parameter.');
    }

    phoneNumber = phoneNumber.trim().replaceAll(RegExp(r'[- )(]+'), '');

    final RegExp countryCodeRe = RegExp(r'^\+?950?9\d+$');
    if (countryCodeRe.hasMatch(phoneNumber)) {
      final RegExp doubleCountryCodeRe = RegExp(r'^\+?95950?9\d{7,9}$');
      if (doubleCountryCodeRe.hasMatch(phoneNumber)) {
        phoneNumber = phoneNumber.replaceAll(RegExp(r'9595'), '95');
      }
      final RegExp zeroBeforeAreaCodeRe = RegExp(r'^\+?9509\d{7,9}$');
      if (zeroBeforeAreaCodeRe.hasMatch(phoneNumber)) {
        phoneNumber = phoneNumber.replaceAll(RegExp(r'9509'), '959');
      }
    }
    return phoneNumber;
  }

  static String normalizeInput(String? phoneNumber) {
    if (phoneNumber == null) {
      throw ArgumentError('Please include phoneNumber parameter.');
    }
    String sanitizedNumber = _sanitizeInput(phoneNumber);
    final RegExp possibleCases = RegExp(r'^((09-)|(\+959)|(09\s)|(959)|(09\.))');

    if (possibleCases.hasMatch(sanitizedNumber)) {
      sanitizedNumber = sanitizedNumber.replaceFirst(possibleCases, '09');
    }

    if (RegExp(r'[၀-၉]').hasMatch(sanitizedNumber)) {
      sanitizedNumber = sanitizedNumber.split('').map((num) {
        return _myanmarNumbers[num]?.toString() ?? '';
      }).join().replaceFirst(possibleCases, '09');
    }

    return sanitizedNumber;
  }

  static TelecomOperator getTelecomName(String phoneNumber) {
    if (!isValidMMPhoneNumber(phoneNumber)) {
      return TelecomOperator.unknown;
    }

    phoneNumber = normalizeInput(phoneNumber);

    if (_ooredooRegex.hasMatch(phoneNumber)) {
      return TelecomOperator.ooredoo;
    } else if (_telenorRegex.hasMatch(phoneNumber)) {
      return TelecomOperator.telenor;
    } else if (_mptRegex.hasMatch(phoneNumber)) {
      return TelecomOperator.mpt;
    } else if (_mecRegex.hasMatch(phoneNumber)) {
      return TelecomOperator.mec;
    } else if (_mytelRegex.hasMatch(phoneNumber)) {
      return TelecomOperator.mytel;
    } else {
      return TelecomOperator.unknown;
    }
  }

  static NetworkType getPhoneNetworkType(String phoneNumber) {
    if (!isValidMMPhoneNumber(phoneNumber)) {
      return NetworkType.unknown;
    }

    phoneNumber = normalizeInput(phoneNumber);

    if (_ooredooRegex.hasMatch(phoneNumber) || _telenorRegex.hasMatch(phoneNumber) || _mytelRegex.hasMatch(phoneNumber)) {
      return NetworkType.gsm;
    } else if (_mptRegex.hasMatch(phoneNumber) || _mecRegex.hasMatch(phoneNumber)) {
      final RegExp wcdmaRe = RegExp(r'^(09|\+?959)(55\d{5}|25[2-4]\d{6}|26\d{7}|4(4|5|6)\d{7})$');
      final RegExp cdma450Re = RegExp(r'^(09|\+?959)(8\d{6}|6\d{6}|49\d{6})$');
      final RegExp cdma800Re = RegExp(r'^(09|\+?959)(3\d{7}|73\d{6}|91\d{6})$');

      if (wcdmaRe.hasMatch(phoneNumber)) {
        return NetworkType.wcdma;
      } else if (cdma450Re.hasMatch(phoneNumber)) {
        return NetworkType.cdma450;
      } else if (cdma800Re.hasMatch(phoneNumber)) {
        return NetworkType.cdma800;
      } else {
        return NetworkType.gsm;
      }
    }
    return NetworkType.unknown;
  }
}