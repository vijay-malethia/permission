// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/form_validator.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String AccountNumberValueKey = 'accountNumber';
const String IfscValueKey = 'ifsc';

final Map<String, TextEditingController>
    _BankDetailsSheetTextEditingControllers = {};

final Map<String, FocusNode> _BankDetailsSheetFocusNodes = {};

final Map<String, String? Function(String?)?> _BankDetailsSheetTextValidations =
    {
  AccountNumberValueKey: FormValidator.validateAccountNumber,
  IfscValueKey: FormValidator.validateIfscCode,
};

mixin $BankDetailsSheet {
  TextEditingController get accountNumberController =>
      _getFormTextEditingController(AccountNumberValueKey);
  TextEditingController get ifscController =>
      _getFormTextEditingController(IfscValueKey);

  FocusNode get accountNumberFocusNode =>
      _getFormFocusNode(AccountNumberValueKey);
  FocusNode get ifscFocusNode => _getFormFocusNode(IfscValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_BankDetailsSheetTextEditingControllers.containsKey(key)) {
      return _BankDetailsSheetTextEditingControllers[key]!;
    }

    _BankDetailsSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _BankDetailsSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_BankDetailsSheetFocusNodes.containsKey(key)) {
      return _BankDetailsSheetFocusNodes[key]!;
    }
    _BankDetailsSheetFocusNodes[key] = FocusNode();
    return _BankDetailsSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    accountNumberController.addListener(() => _updateFormData(model));
    ifscController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    accountNumberController.addListener(() => _updateFormData(model));
    ifscController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AccountNumberValueKey: accountNumberController.text,
          IfscValueKey: ifscController.text,
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

    for (var controller in _BankDetailsSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _BankDetailsSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _BankDetailsSheetTextEditingControllers.clear();
    _BankDetailsSheetFocusNodes.clear();
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

  String? get accountNumberValue =>
      this.formValueMap[AccountNumberValueKey] as String?;
  String? get ifscValue => this.formValueMap[IfscValueKey] as String?;

  set accountNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AccountNumberValueKey: value}),
    );

    if (_BankDetailsSheetTextEditingControllers.containsKey(
        AccountNumberValueKey)) {
      _BankDetailsSheetTextEditingControllers[AccountNumberValueKey]?.text =
          value ?? '';
    }
  }

  set ifscValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IfscValueKey: value}),
    );

    if (_BankDetailsSheetTextEditingControllers.containsKey(IfscValueKey)) {
      _BankDetailsSheetTextEditingControllers[IfscValueKey]?.text = value ?? '';
    }
  }

  bool get hasAccountNumber =>
      this.formValueMap.containsKey(AccountNumberValueKey) &&
      (accountNumberValue?.isNotEmpty ?? false);
  bool get hasIfsc =>
      this.formValueMap.containsKey(IfscValueKey) &&
      (ifscValue?.isNotEmpty ?? false);

  bool get hasAccountNumberValidationMessage =>
      this.fieldsValidationMessages[AccountNumberValueKey]?.isNotEmpty ?? false;
  bool get hasIfscValidationMessage =>
      this.fieldsValidationMessages[IfscValueKey]?.isNotEmpty ?? false;

  String? get accountNumberValidationMessage =>
      this.fieldsValidationMessages[AccountNumberValueKey];
  String? get ifscValidationMessage =>
      this.fieldsValidationMessages[IfscValueKey];
}

extension Methods on FormStateHelper {
  setAccountNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AccountNumberValueKey] = validationMessage;
  setIfscValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IfscValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    accountNumberValue = '';
    ifscValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AccountNumberValueKey: getValidationMessage(AccountNumberValueKey),
      IfscValueKey: getValidationMessage(IfscValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _BankDetailsSheetTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _BankDetailsSheetTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AccountNumberValueKey: getValidationMessage(AccountNumberValueKey),
      IfscValueKey: getValidationMessage(IfscValueKey),
    });
