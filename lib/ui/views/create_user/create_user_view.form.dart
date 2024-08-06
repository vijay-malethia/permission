// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NameValueKey = 'name';
const String EmailValueKey = 'email';
const String MobileValueKey = 'mobile';
const String PhoneOtpValueKey = 'phoneOtp';
const String EmailOtpValueKey = 'emailOtp';

final Map<String, TextEditingController> _CreateUserViewTextEditingControllers =
    {};

final Map<String, FocusNode> _CreateUserViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CreateUserViewTextValidations = {
  NameValueKey: null,
  EmailValueKey: null,
  MobileValueKey: null,
  PhoneOtpValueKey: null,
  EmailOtpValueKey: null,
};

mixin $CreateUserView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get mobileController =>
      _getFormTextEditingController(MobileValueKey);
  TextEditingController get phoneOtpController =>
      _getFormTextEditingController(PhoneOtpValueKey);
  TextEditingController get emailOtpController =>
      _getFormTextEditingController(EmailOtpValueKey);

  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get mobileFocusNode => _getFormFocusNode(MobileValueKey);
  FocusNode get phoneOtpFocusNode => _getFormFocusNode(PhoneOtpValueKey);
  FocusNode get emailOtpFocusNode => _getFormFocusNode(EmailOtpValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateUserViewTextEditingControllers.containsKey(key)) {
      return _CreateUserViewTextEditingControllers[key]!;
    }

    _CreateUserViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateUserViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateUserViewFocusNodes.containsKey(key)) {
      return _CreateUserViewFocusNodes[key]!;
    }
    _CreateUserViewFocusNodes[key] = FocusNode();
    return _CreateUserViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    nameController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    mobileController.addListener(() => _updateFormData(model));
    phoneOtpController.addListener(() => _updateFormData(model));
    emailOtpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    mobileController.addListener(() => _updateFormData(model));
    phoneOtpController.addListener(() => _updateFormData(model));
    emailOtpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          EmailValueKey: emailController.text,
          MobileValueKey: mobileController.text,
          PhoneOtpValueKey: phoneOtpController.text,
          EmailOtpValueKey: emailOtpController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CreateUserViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateUserViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateUserViewTextEditingControllers.clear();
    _CreateUserViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get mobileValue => this.formValueMap[MobileValueKey] as String?;
  String? get phoneOtpValue => this.formValueMap[PhoneOtpValueKey] as String?;
  String? get emailOtpValue => this.formValueMap[EmailOtpValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_CreateUserViewTextEditingControllers.containsKey(NameValueKey)) {
      _CreateUserViewTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_CreateUserViewTextEditingControllers.containsKey(EmailValueKey)) {
      _CreateUserViewTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set mobileValue(String? value) {
    this.setData(
      this.formValueMap..addAll({MobileValueKey: value}),
    );

    if (_CreateUserViewTextEditingControllers.containsKey(MobileValueKey)) {
      _CreateUserViewTextEditingControllers[MobileValueKey]?.text = value ?? '';
    }
  }

  set phoneOtpValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneOtpValueKey: value}),
    );

    if (_CreateUserViewTextEditingControllers.containsKey(PhoneOtpValueKey)) {
      _CreateUserViewTextEditingControllers[PhoneOtpValueKey]?.text =
          value ?? '';
    }
  }

  set emailOtpValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailOtpValueKey: value}),
    );

    if (_CreateUserViewTextEditingControllers.containsKey(EmailOtpValueKey)) {
      _CreateUserViewTextEditingControllers[EmailOtpValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasMobile =>
      this.formValueMap.containsKey(MobileValueKey) &&
      (mobileValue?.isNotEmpty ?? false);
  bool get hasPhoneOtp =>
      this.formValueMap.containsKey(PhoneOtpValueKey) &&
      (phoneOtpValue?.isNotEmpty ?? false);
  bool get hasEmailOtp =>
      this.formValueMap.containsKey(EmailOtpValueKey) &&
      (emailOtpValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasMobileValidationMessage =>
      this.fieldsValidationMessages[MobileValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneOtpValidationMessage =>
      this.fieldsValidationMessages[PhoneOtpValueKey]?.isNotEmpty ?? false;
  bool get hasEmailOtpValidationMessage =>
      this.fieldsValidationMessages[EmailOtpValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get mobileValidationMessage =>
      this.fieldsValidationMessages[MobileValueKey];
  String? get phoneOtpValidationMessage =>
      this.fieldsValidationMessages[PhoneOtpValueKey];
  String? get emailOtpValidationMessage =>
      this.fieldsValidationMessages[EmailOtpValueKey];
}

extension Methods on FormStateHelper {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setMobileValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MobileValueKey] = validationMessage;
  setPhoneOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneOtpValueKey] = validationMessage;
  setEmailOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailOtpValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    emailValue = '';
    mobileValue = '';
    phoneOtpValue = '';
    emailOtpValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
      MobileValueKey: getValidationMessage(MobileValueKey),
      PhoneOtpValueKey: getValidationMessage(PhoneOtpValueKey),
      EmailOtpValueKey: getValidationMessage(EmailOtpValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateUserViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateUserViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
      MobileValueKey: getValidationMessage(MobileValueKey),
      PhoneOtpValueKey: getValidationMessage(PhoneOtpValueKey),
      EmailOtpValueKey: getValidationMessage(EmailOtpValueKey),
    });
