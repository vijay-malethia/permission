class FormValidator {
  static String? mobileNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    if (value.length < 10) {
      return 'Invalid mobile number';
    }
    return null;
  }

  static String? validateIfscCode(String? value) {
    RegExp ifscCodeRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    var isValid = ifscCodeRegex.hasMatch(value!);
    if (value.trim().isEmpty) {
      return 'Required';
    }
    if (!isValid && value.isNotEmpty) {
      return 'Please enter valid IFSC code';
    } else {
      return null;
    }
  }

  static String? validateAccountNumber(String? value) {
    RegExp accountNumberRegex = RegExp(r'^[0-9]{9,18}$');

    var isValid = accountNumberRegex.hasMatch(value!);
    if (value.trim().isEmpty) {
      return 'Required';
    }
    if (!isValid && value.isNotEmpty) {
      return 'Please enter valid account number';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    RegExp validate = RegExp(r'^([6-9]{1})([0-9]{9})$');
    var isValid = validate.hasMatch(value!);
    if (value.trim().isEmpty) {
      return 'Required';
    }
    if (!isValid && value.isNotEmpty) {
      return 'Please enter valid phone number';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Required';
    }
    if (value.length < 4 && value.isNotEmpty) {
      return 'Please enter valid name';
    } else {
      return null;
    }
  }

  static String? requriedValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  //email validator

  static String? emailValidatior(String? value) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (value!.trim().isEmpty) {
      return 'Required';
    } else if (value.isNotEmpty && !emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }
}
