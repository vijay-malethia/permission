// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String PhoneOtpValueKey = 'phoneOtp';
const String EmailOtpValueKey = 'emailOtp';

final Map<String, TextEditingController> _VerifyOtpViewTextEditingControllers =
    {};

final Map<String, FocusNode> _VerifyOtpViewFocusNodes = {};

final Map<String, String? Function(String?)?> _VerifyOtpViewTextValidations = {
  PhoneOtpValueKey: null,
  EmailOtpValueKey: null,
};

mixin $VerifyOtpView {
  TextEditingController get phoneOtpController =>
      _getFormTextEditingController(PhoneOtpValueKey);
  TextEditingController get emailOtpController =>
      _getFormTextEditingController(EmailOtpValueKey);

  FocusNode get phoneOtpFocusNode => _getFormFocusNode(PhoneOtpValueKey);
  FocusNode get emailOtpFocusNode => _getFormFocusNode(EmailOtpValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_VerifyOtpViewTextEditingControllers.containsKey(key)) {
      return _VerifyOtpViewTextEditingControllers[key]!;
    }

    _VerifyOtpViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _VerifyOtpViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_VerifyOtpViewFocusNodes.containsKey(key)) {
      return _VerifyOtpViewFocusNodes[key]!;
    }
    _VerifyOtpViewFocusNodes[key] = FocusNode();
    return _VerifyOtpViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
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
    phoneOtpController.addListener(() => _updateFormData(model));
    emailOtpController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
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

    for (var controller in _VerifyOtpViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _VerifyOtpViewFocusNodes.values) {
      focusNode.dispose();
    }

    _VerifyOtpViewTextEditingControllers.clear();
    _VerifyOtpViewFocusNodes.clear();
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

  String? get phoneOtpValue => this.formValueMap[PhoneOtpValueKey] as String?;
  String? get emailOtpValue => this.formValueMap[EmailOtpValueKey] as String?;

  set phoneOtpValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneOtpValueKey: value}),
    );

    if (_VerifyOtpViewTextEditingControllers.containsKey(PhoneOtpValueKey)) {
      _VerifyOtpViewTextEditingControllers[PhoneOtpValueKey]?.text =
          value ?? '';
    }
  }

  set emailOtpValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailOtpValueKey: value}),
    );

    if (_VerifyOtpViewTextEditingControllers.containsKey(EmailOtpValueKey)) {
      _VerifyOtpViewTextEditingControllers[EmailOtpValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasPhoneOtp =>
      this.formValueMap.containsKey(PhoneOtpValueKey) &&
      (phoneOtpValue?.isNotEmpty ?? false);
  bool get hasEmailOtp =>
      this.formValueMap.containsKey(EmailOtpValueKey) &&
      (emailOtpValue?.isNotEmpty ?? false);

  bool get hasPhoneOtpValidationMessage =>
      this.fieldsValidationMessages[PhoneOtpValueKey]?.isNotEmpty ?? false;
  bool get hasEmailOtpValidationMessage =>
      this.fieldsValidationMessages[EmailOtpValueKey]?.isNotEmpty ?? false;

  String? get phoneOtpValidationMessage =>
      this.fieldsValidationMessages[PhoneOtpValueKey];
  String? get emailOtpValidationMessage =>
      this.fieldsValidationMessages[EmailOtpValueKey];
}

extension Methods on FormStateHelper {
  setPhoneOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneOtpValueKey] = validationMessage;
  setEmailOtpValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailOtpValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    phoneOtpValue = '';
    emailOtpValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      PhoneOtpValueKey: getValidationMessage(PhoneOtpValueKey),
      EmailOtpValueKey: getValidationMessage(EmailOtpValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _VerifyOtpViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _VerifyOtpViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      PhoneOtpValueKey: getValidationMessage(PhoneOtpValueKey),
      EmailOtpValueKey: getValidationMessage(EmailOtpValueKey),
    });
