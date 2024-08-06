// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String AccountNumberValueKey = 'accountNumber';
const String IfscValueKey = 'IFSC';
const String AccountNameValueKey = 'accountName';
const String AccountTypeValueKey = 'accountType';
const String BankNameValueKey = 'bankName';
const String BranchValueKey = 'Branch';

final Map<String, TextEditingController>
    _AccountDetailViewTextEditingControllers = {};

final Map<String, FocusNode> _AccountDetailViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _AccountDetailViewTextValidations = {
  AccountNumberValueKey: null,
  IfscValueKey: null,
  AccountNameValueKey: null,
  AccountTypeValueKey: null,
  BankNameValueKey: null,
  BranchValueKey: null,
};

mixin $AccountDetailView {
  TextEditingController get accountNumberController =>
      _getFormTextEditingController(AccountNumberValueKey);
  TextEditingController get ifscController =>
      _getFormTextEditingController(IfscValueKey);
  TextEditingController get accountNameController =>
      _getFormTextEditingController(AccountNameValueKey);
  TextEditingController get accountTypeController =>
      _getFormTextEditingController(AccountTypeValueKey);
  TextEditingController get bankNameController =>
      _getFormTextEditingController(BankNameValueKey);
  TextEditingController get branchController =>
      _getFormTextEditingController(BranchValueKey);

  FocusNode get accountNumberFocusNode =>
      _getFormFocusNode(AccountNumberValueKey);
  FocusNode get ifscFocusNode => _getFormFocusNode(IfscValueKey);
  FocusNode get accountNameFocusNode => _getFormFocusNode(AccountNameValueKey);
  FocusNode get accountTypeFocusNode => _getFormFocusNode(AccountTypeValueKey);
  FocusNode get bankNameFocusNode => _getFormFocusNode(BankNameValueKey);
  FocusNode get branchFocusNode => _getFormFocusNode(BranchValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AccountDetailViewTextEditingControllers.containsKey(key)) {
      return _AccountDetailViewTextEditingControllers[key]!;
    }

    _AccountDetailViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AccountDetailViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AccountDetailViewFocusNodes.containsKey(key)) {
      return _AccountDetailViewFocusNodes[key]!;
    }
    _AccountDetailViewFocusNodes[key] = FocusNode();
    return _AccountDetailViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    accountNumberController.addListener(() => _updateFormData(model));
    ifscController.addListener(() => _updateFormData(model));
    accountNameController.addListener(() => _updateFormData(model));
    accountTypeController.addListener(() => _updateFormData(model));
    bankNameController.addListener(() => _updateFormData(model));
    branchController.addListener(() => _updateFormData(model));

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
    accountNameController.addListener(() => _updateFormData(model));
    accountTypeController.addListener(() => _updateFormData(model));
    bankNameController.addListener(() => _updateFormData(model));
    branchController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AccountNumberValueKey: accountNumberController.text,
          IfscValueKey: ifscController.text,
          AccountNameValueKey: accountNameController.text,
          AccountTypeValueKey: accountTypeController.text,
          BankNameValueKey: bankNameController.text,
          BranchValueKey: branchController.text,
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

    for (var controller in _AccountDetailViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AccountDetailViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AccountDetailViewTextEditingControllers.clear();
    _AccountDetailViewFocusNodes.clear();
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
  String? get accountNameValue =>
      this.formValueMap[AccountNameValueKey] as String?;
  String? get accountTypeValue =>
      this.formValueMap[AccountTypeValueKey] as String?;
  String? get bankNameValue => this.formValueMap[BankNameValueKey] as String?;
  String? get branchValue => this.formValueMap[BranchValueKey] as String?;

  set accountNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AccountNumberValueKey: value}),
    );

    if (_AccountDetailViewTextEditingControllers.containsKey(
        AccountNumberValueKey)) {
      _AccountDetailViewTextEditingControllers[AccountNumberValueKey]?.text =
          value ?? '';
    }
  }

  set ifscValue(String? value) {
    this.setData(
      this.formValueMap..addAll({IfscValueKey: value}),
    );

    if (_AccountDetailViewTextEditingControllers.containsKey(IfscValueKey)) {
      _AccountDetailViewTextEditingControllers[IfscValueKey]?.text =
          value ?? '';
    }
  }

  set accountNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AccountNameValueKey: value}),
    );

    if (_AccountDetailViewTextEditingControllers.containsKey(
        AccountNameValueKey)) {
      _AccountDetailViewTextEditingControllers[AccountNameValueKey]?.text =
          value ?? '';
    }
  }

  set accountTypeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AccountTypeValueKey: value}),
    );

    if (_AccountDetailViewTextEditingControllers.containsKey(
        AccountTypeValueKey)) {
      _AccountDetailViewTextEditingControllers[AccountTypeValueKey]?.text =
          value ?? '';
    }
  }

  set bankNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({BankNameValueKey: value}),
    );

    if (_AccountDetailViewTextEditingControllers.containsKey(
        BankNameValueKey)) {
      _AccountDetailViewTextEditingControllers[BankNameValueKey]?.text =
          value ?? '';
    }
  }

  set branchValue(String? value) {
    this.setData(
      this.formValueMap..addAll({BranchValueKey: value}),
    );

    if (_AccountDetailViewTextEditingControllers.containsKey(BranchValueKey)) {
      _AccountDetailViewTextEditingControllers[BranchValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasAccountNumber =>
      this.formValueMap.containsKey(AccountNumberValueKey) &&
      (accountNumberValue?.isNotEmpty ?? false);
  bool get hasIfsc =>
      this.formValueMap.containsKey(IfscValueKey) &&
      (ifscValue?.isNotEmpty ?? false);
  bool get hasAccountName =>
      this.formValueMap.containsKey(AccountNameValueKey) &&
      (accountNameValue?.isNotEmpty ?? false);
  bool get hasAccountType =>
      this.formValueMap.containsKey(AccountTypeValueKey) &&
      (accountTypeValue?.isNotEmpty ?? false);
  bool get hasBankName =>
      this.formValueMap.containsKey(BankNameValueKey) &&
      (bankNameValue?.isNotEmpty ?? false);
  bool get hasBranch =>
      this.formValueMap.containsKey(BranchValueKey) &&
      (branchValue?.isNotEmpty ?? false);

  bool get hasAccountNumberValidationMessage =>
      this.fieldsValidationMessages[AccountNumberValueKey]?.isNotEmpty ?? false;
  bool get hasIfscValidationMessage =>
      this.fieldsValidationMessages[IfscValueKey]?.isNotEmpty ?? false;
  bool get hasAccountNameValidationMessage =>
      this.fieldsValidationMessages[AccountNameValueKey]?.isNotEmpty ?? false;
  bool get hasAccountTypeValidationMessage =>
      this.fieldsValidationMessages[AccountTypeValueKey]?.isNotEmpty ?? false;
  bool get hasBankNameValidationMessage =>
      this.fieldsValidationMessages[BankNameValueKey]?.isNotEmpty ?? false;
  bool get hasBranchValidationMessage =>
      this.fieldsValidationMessages[BranchValueKey]?.isNotEmpty ?? false;

  String? get accountNumberValidationMessage =>
      this.fieldsValidationMessages[AccountNumberValueKey];
  String? get ifscValidationMessage =>
      this.fieldsValidationMessages[IfscValueKey];
  String? get accountNameValidationMessage =>
      this.fieldsValidationMessages[AccountNameValueKey];
  String? get accountTypeValidationMessage =>
      this.fieldsValidationMessages[AccountTypeValueKey];
  String? get bankNameValidationMessage =>
      this.fieldsValidationMessages[BankNameValueKey];
  String? get branchValidationMessage =>
      this.fieldsValidationMessages[BranchValueKey];
}

extension Methods on FormStateHelper {
  setAccountNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AccountNumberValueKey] = validationMessage;
  setIfscValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[IfscValueKey] = validationMessage;
  setAccountNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AccountNameValueKey] = validationMessage;
  setAccountTypeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AccountTypeValueKey] = validationMessage;
  setBankNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BankNameValueKey] = validationMessage;
  setBranchValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BranchValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    accountNumberValue = '';
    ifscValue = '';
    accountNameValue = '';
    accountTypeValue = '';
    bankNameValue = '';
    branchValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AccountNumberValueKey: getValidationMessage(AccountNumberValueKey),
      IfscValueKey: getValidationMessage(IfscValueKey),
      AccountNameValueKey: getValidationMessage(AccountNameValueKey),
      AccountTypeValueKey: getValidationMessage(AccountTypeValueKey),
      BankNameValueKey: getValidationMessage(BankNameValueKey),
      BranchValueKey: getValidationMessage(BranchValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AccountDetailViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AccountDetailViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AccountNumberValueKey: getValidationMessage(AccountNumberValueKey),
      IfscValueKey: getValidationMessage(IfscValueKey),
      AccountNameValueKey: getValidationMessage(AccountNameValueKey),
      AccountTypeValueKey: getValidationMessage(AccountTypeValueKey),
      BankNameValueKey: getValidationMessage(BankNameValueKey),
      BranchValueKey: getValidationMessage(BranchValueKey),
    });
