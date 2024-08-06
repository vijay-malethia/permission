// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/form_validator.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String PhoneNumberValueKey = 'phoneNumber';
const String OtpValueKey = 'otp';

final Map<String, TextEditingController>
    _MobileNumberViewTextEditingControllers = {};

final Map<String, FocusNode> _MobileNumberViewFocusNodes = {};

final Map<String, String? Function(String?)?> _MobileNumberViewTextValidations =
    {
  PhoneNumberValueKey: FormValidator.mobileNumberValidator,
  OtpValueKey: null,
};

mixin $MobileNumberView {
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);
  TextEditingController get otpController =>
      _getFormTextEditingController(OtpValueKey);

  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);
  FocusNode get otpFocusNode => _getFormFocusNode(OtpValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_MobileNumberViewTextEditingControllers.containsKey(key)) {
      return _MobileNumberViewTextEditingControllers[key]!;
    }

    _MobileNumberViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _MobileNumberViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_MobileNumberViewFocusNodes.containsKey(key)) {
      return _MobileNumberViewFocusNodes[key]!;
    }
    _MobileNumberViewFocusNodes[key] = FocusNode();
    return _MobileNumberViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    phoneNumberController.addListener(() => _updateFormData(model));
    otpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    phoneNumberController.addListener(() => _updateFormData(model));
    otpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          PhoneNumberValueKey: phoneNumberController.text,
          OtpValueKey: otpController.text,
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

    for (var controller in _MobileNumberViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _MobileNumberViewFocusNodes.values) {
      focusNode.dispose();
    }

    _MobileNumberViewTextEditingControllers.clear();
    _MobileNumberViewFocusNodes.clear();
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

  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;
  String? get otpValue => this.formValueMap[OtpValueKey] as String?;

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_MobileNumberViewTextEditingControllers.containsKey(
        PhoneNumberValueKey)) {
      _MobileNumberViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  set otpValue(String? value) {
    this.setData(
      this.formValueMap..addAll({OtpValueKey: value}),
    );

    if (_MobileNumberViewTextEditingControllers.containsKey(OtpValueKey)) {
      _MobileNumberViewTextEditingControllers[OtpValueKey]?.text = value ?? '';
    }
  }

  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);
  bool get hasOtp =>
      this.formValueMap.containsKey(OtpValueKey) &&
      (otpValue?.isNotEmpty ?? false);

  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;
  bool get hasOtpValidationMessage =>
      this.fieldsValidationMessages[OtpValueKey]?.isNotEmpty ?? false;

  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
  String? get otpValidationMessage =>
      this.fieldsValidationMessages[OtpValueKey];
}

extension Methods on FormStateHelper {
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;
  setOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OtpValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    phoneNumberValue = '';
    otpValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      OtpValueKey: getValidationMessage(OtpValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _MobileNumberViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _MobileNumberViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      OtpValueKey: getValidationMessage(OtpValueKey),
    });
