class Validation {

  static String? validateEmail(String? value) {
    // Regex pattern for validating the basic structure of email addresses
    const pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$";
    final regex = RegExp(pattern);

    // List of allowed main domains (extend as needed)
    const List<String> validDomains = [
      "com", "net", "org", "edu", "gov", "io", "co", "us", "uk", "ca", "de", "fr", "au", "in", "pk", "ae"
    ];

    // Null or empty email check
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email';
    }

    // Trim the input value
    final trimmedValue = value.trim();

    // Basic regex validation
    if (!regex.hasMatch(trimmedValue)) {
      return 'Please enter valid email';
    }

    // Extract the domain part
    final domainPart = trimmedValue.split('@').last;
    final domainSegments = domainPart.split('.');

    // Ensure there are at least two parts (domain + TLD)
    if (domainSegments.length < 2) {
      return 'Please enter valid email';
    }

    // Check for consecutive duplicate domain segments
    for (int i = 1; i < domainSegments.length; i++) {
      if (domainSegments[i] == domainSegments[i - 1]) {
        return 'Please enter valid email';
      }
    }

    // Validate TLD against allowed domains
    final tld = domainSegments.last.toLowerCase();
    if (!validDomains.contains(tld)) {
      return 'Please enter valid email';
    }

    return null; // Validation successful
  }

  /// Password matching expression. Password must be at least 4 characters,
  /// no more than 8 characters, and must include at least one upper case letter,
  /// one lower case letter, and one numeric digit.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Please enter your password";
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$').hasMatch(value)) {
      return 'Password should be alphanumeric';
    }
    if (value.length <= 7) {
      return "Password should be more than 8 character";
    }
    if (value.length > 25) {
      return "Password should be less than 25 character";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateLoginPass(String value) {
    if (value.isEmpty) return "Please enter your password";
    return null;
  }

  static String? validateuser(String value) {
    if (value.isEmpty) return "Please enter your username";
    if (value.length <= 6) {
      return "Username must be more than 8 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  static String? validatePersons(String value) {
    if (value.isEmpty) return "Enter persons";
    if (value.isEmpty) {
      return "Must be 1 person";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Please enter your name";
    return null;
  }
   static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) return "Please enter your firstName";
    if (value.length < 3) {
      return "Atleast 3 characters!";
    }
    if (value.length >= 50) {
      return "The name must not be greater than 50 characters";
    }
    return null;
  }
   static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) return "Please enter your last name";
    if (value.length < 3) {
      return "Atleast 3 characters!";
    }
    if (value.length >= 50) {
      return "The name must not be greater than 50 characters";
    }
    return null;
  }

  static String? validateValue(String? value) {
    if (value == null || value.isEmpty) return "Please enter";
    if (value.length < 3) {
      return "Atleast 3 characters!";
    }
    if (value.length >= 250) {
      return "Must not be greater than 250 characters";
    }
    return null;
  }

  static String? validatequestion(String? value) {
    if (value == null || value.isEmpty) return "Please enter question";
    if (value.length < 3) {
      return "Atleast 3 characters!";
    }
    if (value.length >= 250) {
      return "Must not be greater than 250 characters";
    }
    return null;
  }

  static String? validateChoices(String? value) {
    if (value == null || value.isEmpty) return "Please enter choice";
    if (value.length < 2) {
      return "Atleast 2 characters!";
    }
    if (value.length >= 250) {
      return "Must not be greater than 250 characters";
    }
    return null;
  }

  static String? validateCountry(String? value) {
    if (value == null || value.isEmpty) return "Please select country";
    return null;
  }

  String? validatetext(String? value) {
    if (value == null || value.isEmpty) return "Please enter your answer";
    if (value.length < 4) {
      return "Atleast 4 characters!";
    }
    if (value.length >= 150) {
      return "Below 150 characters!";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    // Regular expression to validate phone numbers with country code
    final RegExp phoneRegExp = RegExp(r'^\+\d{1,3}\d{7,12}$');

    if (value == null || value.isEmpty) {
      return "Please enter mobile number";
    }
    if (!phoneRegExp.hasMatch(value)) {
      return "Enter number with country code (e.g., +1234567890)";
    }
    return null;
  }

  String? validatMonthDayYear(String value) {
//day/month/year
    //([0-2][0-9]|(3)[0-1])[-|\/](((0)[0-9])|((1)[0-2]))[-|\/]\d{4}
    if (value.isEmpty) return "Please enter month and year";
    Pattern pattern = r'^(((0)[0-9])|((1)[0-2]))[/]\d{2}';
    RegExp regex = RegExp("$pattern");
    if (!regex.hasMatch(value.trim())) {
      return "eg. mm/yy";
    }
    return null;
  }

  String? validateText(String value) {
    if (value.isEmpty) return "Please enter your name";
    if (value.length <= 10) {
      return "Atleast 2 characters!";
    }
    if (value.length >= 500) {
      return "Must be below 50 characters!";
    }
    return null;
  }

  String? validateVechileNo(String? value) {
    Pattern pattern = 'r(^[A-Z]{3}-d{3}-d{2})';
    RegExp regex = RegExp("$pattern");
    if (!regex.hasMatch(value!.trim())) {
      return "Invalid Vechile Number";
    }
    return null;
  }

  String? validateCompanyName(String value) {
    if (value.isEmpty) return "Please enter company name";
    if (value.length <= 2) {
      return "Atleast 2 characters!";
    }
    if (value.length >= 50) {
      return "Must be below 50 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatCompanyename(String value) {
    if (value.isEmpty) return " Please enter company name";
    if (value.length <= 2) {
      return "Atleast 2 characters!";
    }
    if (value.length > 50) {
      return "Must be below 50 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatCountryename(String value) {
    if (value.isEmpty) return " Please enter country name";
    if (value.length <= 3) {
      return "Atleast 2 characters!";
    }
    if (value.length > 50) {
      return "Must be below 50 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatZipCode(String value) {
    if (value.isEmpty) return "Enter zip code";
    if (value.length < 0) {
      return "Zip Code";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatCityename(String value) {
    if (value.isEmpty) return "Please enter city name";
    if (value.length <= 2) {
      return "Atleast 2 characters!";
    }
    if (value.length >= 50) {
      return "Must be below 50 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatStateename(String value) {
    if (value.isEmpty) return "Please enter state name";
    if (value.length <= 2) {
      return "Atleast 2 characters!";
    }
    if (value.length >= 50) {
      return "Below 50 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatStreetname(String value) {
    if (value.isEmpty) return "Please enter street name";
    if (value.length <= 2) {
      return "Atleast 2 characters!";
    }
    if (value.length >= 50) {
      return "Must be below 50 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateaddress(String? value) {
    if (value!.isEmpty) return "Please enter your address";
    if (value.length <= 5) {
      return "Atleast 5 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateCompanyAddress(String? value) {
    if (value == null) return "Please enter company address";
    if (value.length <= 5) {
      return "Atleast 5 characters!";
    }
    if (value.length > 500) {
      return "Must be below 500 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateAccountNumber(String? value) {
    if (value == null) return "Please enter your CNIC number";
    if (value.length < 13) {
      return "Please enter valid CNIC";
    }
    return null;
  }

  String? validateAccountName(String value) {
    if (value.isEmpty) return "Please enter your account name";
    return null;
  }

  String? validateabout(String value) {
    if (value.isEmpty) return "Please enter your about!";
    if (value.length <= 5) {
      return "Atleast 5 characters!";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatecard(String value) {
    if (value.isEmpty) return "Enter your card number";
    if (value.length < 12) {
      return "Card Number must be 12 Digits";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatemonth(String value) {
    if (value.isEmpty) return "Enter your month";
    if (value.length < 2) {
      return "Month must be 2 Digit";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateyear(String value) {
    if (value.isEmpty) return "Enter your year";
    if (value.length < 2) {
      return "Year must be 2 Digit";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validatecvv(String value) {
    if (value.isEmpty) return "Enter your CVV";
    if (value.length < 4 && value.length < 3) {
      return "CVV must be 3 or 4 Digit";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateholder(String value) {
    if (value.isEmpty) return "Enter card holder name";
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateMobile(String value) {
    // only for single country
    // String pattern = r'(^(?:[+0]9)?[0-9]{10,15}$)';
    String pattern = r'(^(?:[+0-9])?[0-9]{10,15}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? validateOldPassword(String value) {
    print("validatepassword : $value ");

    if (value.isEmpty) return "Enter your old password";
    if (!RegExp(r"^(?=.[A-Za-z])(?=.\d).{6,}$").hasMatch(value)) {
      return 'Password Should be Alphanumeric';
    }
    if (value.length <= 6) {
      return "Password Should be more than 6 character";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateNewPassword(String value) {
    print("validatepassword : $value ");

    if (value.isEmpty) return "Enter your new password";
    if (!RegExp(r"^(?=.[A-Za-z])(?=.\d).{6,}$").hasMatch(value)) {
      return 'Password Should be Alphanumeric';
    }
    if (value.length <= 6) {
      return "Password Should be more than 6 character";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    print("validatepassword : $value ");

    if (value == null || value.isEmpty) return "Confirm your password";
    if (!RegExp(r"^(?=.[A-Za-z])(?=.\d).{6,}$").hasMatch(value)) {
      return 'Password Should be Alphanumeric';
    }
    if (value.length <= 6) {
      return "Password Should be more than 6 character";
    }
    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }

  static String? simple(String? value) {
    print("validatepassword : $value ");

    if (value == null || value.isEmpty) return "Field must not be null";

    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }
  static String? validateZip(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return "Please enter zip code.";
    }

    // Check if the length is less than 5 digits
    else if (value.length != 5) {
      return 'Please enter a valid 5-digit zip code';
    }

    // Check if the value only contains digits
    else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return 'Please enter a valid 5-digit zip code';
    }

    return null;
  }
  static String? validateDescription(String? value) {
   
    if (value == null || value.isEmpty) return "Please enter description";

    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }
    static String? validateTaskName(String? value) {
   
    if (value == null || value.isEmpty) return "Please enter task name";

    // Pattern pattern =
    //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{6,}$';
    // RegExp regex = new RegExp(pattern);
    // if (!regex.hasMatch(value.trim())) {
    //   return "include one capital letter, number and symbol";
    // }
    return null;
  }
}
