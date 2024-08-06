// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/form_validator.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NameValueKey = 'name';
const String EmailIdValueKey = 'emailId';
const String MobileValueKey = 'mobile';
const String RemarkValueKey = 'remark';

final Map<String, TextEditingController>
    _CaptureLeadViewTextEditingControllers = {};

final Map<String, FocusNode> _CaptureLeadViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CaptureLeadViewTextValidations =
    {
  NameValueKey: FormValidator.validateName,
  EmailIdValueKey: null,
  MobileValueKey: FormValidator.validatePhoneNumber,
  RemarkValueKey: null,
};

mixin $CaptureLeadView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get emailIdController =>
      _getFormTextEditingController(EmailIdValueKey);
  TextEditingController get mobileController =>
      _getFormTextEditingController(MobileValueKey);
  TextEditingController get remarkController =>
      _getFormTextEditingController(RemarkValueKey);

  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get emailIdFocusNode => _getFormFocusNode(EmailIdValueKey);
  FocusNode get mobileFocusNode => _getFormFocusNode(MobileValueKey);
  FocusNode get remarkFocusNode => _getFormFocusNode(RemarkValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CaptureLeadViewTextEditingControllers.containsKey(key)) {
      return _CaptureLeadViewTextEditingControllers[key]!;
    }

    _CaptureLeadViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CaptureLeadViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CaptureLeadViewFocusNodes.containsKey(key)) {
      return _CaptureLeadViewFocusNodes[key]!;
    }
    _CaptureLeadViewFocusNodes[key] = FocusNode();
    return _CaptureLeadViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    nameController.addListener(() => _updateFormData(model));
    emailIdController.addListener(() => _updateFormData(model));
    mobileController.addListener(() => _updateFormData(model));
    remarkController.addListener(() => _updateFormData(model));

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
    emailIdController.addListener(() => _updateFormData(model));
    mobileController.addListener(() => _updateFormData(model));
    remarkController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          EmailIdValueKey: emailIdController.text,
          MobileValueKey: mobileController.text,
          RemarkValueKey: remarkController.text,
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

    for (var controller in _CaptureLeadViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CaptureLeadViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CaptureLeadViewTextEditingControllers.clear();
    _CaptureLeadViewFocusNodes.clear();
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
  String? get emailIdValue => this.formValueMap[EmailIdValueKey] as String?;
  String? get mobileValue => this.formValueMap[MobileValueKey] as String?;
  String? get remarkValue => this.formValueMap[RemarkValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_CaptureLeadViewTextEditingControllers.containsKey(NameValueKey)) {
      _CaptureLeadViewTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  set emailIdValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailIdValueKey: value}),
    );

    if (_CaptureLeadViewTextEditingControllers.containsKey(EmailIdValueKey)) {
      _CaptureLeadViewTextEditingControllers[EmailIdValueKey]?.text =
          value ?? '';
    }
  }

  set mobileValue(String? value) {
    this.setData(
      this.formValueMap..addAll({MobileValueKey: value}),
    );

    if (_CaptureLeadViewTextEditingControllers.containsKey(MobileValueKey)) {
      _CaptureLeadViewTextEditingControllers[MobileValueKey]?.text =
          value ?? '';
    }
  }

  set remarkValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RemarkValueKey: value}),
    );

    if (_CaptureLeadViewTextEditingControllers.containsKey(RemarkValueKey)) {
      _CaptureLeadViewTextEditingControllers[RemarkValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasEmailId =>
      this.formValueMap.containsKey(EmailIdValueKey) &&
      (emailIdValue?.isNotEmpty ?? false);
  bool get hasMobile =>
      this.formValueMap.containsKey(MobileValueKey) &&
      (mobileValue?.isNotEmpty ?? false);
  bool get hasRemark =>
      this.formValueMap.containsKey(RemarkValueKey) &&
      (remarkValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasEmailIdValidationMessage =>
      this.fieldsValidationMessages[EmailIdValueKey]?.isNotEmpty ?? false;
  bool get hasMobileValidationMessage =>
      this.fieldsValidationMessages[MobileValueKey]?.isNotEmpty ?? false;
  bool get hasRemarkValidationMessage =>
      this.fieldsValidationMessages[RemarkValueKey]?.isNotEmpty ?? false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get emailIdValidationMessage =>
      this.fieldsValidationMessages[EmailIdValueKey];
  String? get mobileValidationMessage =>
      this.fieldsValidationMessages[MobileValueKey];
  String? get remarkValidationMessage =>
      this.fieldsValidationMessages[RemarkValueKey];
}

extension Methods on FormStateHelper {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setEmailIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailIdValueKey] = validationMessage;
  setMobileValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MobileValueKey] = validationMessage;
  setRemarkValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RemarkValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    emailIdValue = '';
    mobileValue = '';
    remarkValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      EmailIdValueKey: getValidationMessage(EmailIdValueKey),
      MobileValueKey: getValidationMessage(MobileValueKey),
      RemarkValueKey: getValidationMessage(RemarkValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CaptureLeadViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CaptureLeadViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      EmailIdValueKey: getValidationMessage(EmailIdValueKey),
      MobileValueKey: getValidationMessage(MobileValueKey),
      RemarkValueKey: getValidationMessage(RemarkValueKey),
    });
