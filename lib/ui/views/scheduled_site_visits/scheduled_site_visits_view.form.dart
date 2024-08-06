// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ClientCodeValueKey = 'clientCode';
const String UserCodeValueKey = 'userCode';

final Map<String, TextEditingController>
    _ScheduledSiteVisitsViewTextEditingControllers = {};

final Map<String, FocusNode> _ScheduledSiteVisitsViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ScheduledSiteVisitsViewTextValidations = {
  ClientCodeValueKey: null,
  UserCodeValueKey: null,
};

mixin $ScheduledSiteVisitsView {
  TextEditingController get clientCodeController =>
      _getFormTextEditingController(ClientCodeValueKey);
  TextEditingController get userCodeController =>
      _getFormTextEditingController(UserCodeValueKey);

  FocusNode get clientCodeFocusNode => _getFormFocusNode(ClientCodeValueKey);
  FocusNode get userCodeFocusNode => _getFormFocusNode(UserCodeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ScheduledSiteVisitsViewTextEditingControllers.containsKey(key)) {
      return _ScheduledSiteVisitsViewTextEditingControllers[key]!;
    }

    _ScheduledSiteVisitsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ScheduledSiteVisitsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ScheduledSiteVisitsViewFocusNodes.containsKey(key)) {
      return _ScheduledSiteVisitsViewFocusNodes[key]!;
    }
    _ScheduledSiteVisitsViewFocusNodes[key] = FocusNode();
    return _ScheduledSiteVisitsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    clientCodeController.addListener(() => _updateFormData(model));
    userCodeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    clientCodeController.addListener(() => _updateFormData(model));
    userCodeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ClientCodeValueKey: clientCodeController.text,
          UserCodeValueKey: userCodeController.text,
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

    for (var controller
        in _ScheduledSiteVisitsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ScheduledSiteVisitsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ScheduledSiteVisitsViewTextEditingControllers.clear();
    _ScheduledSiteVisitsViewFocusNodes.clear();
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

  String? get clientCodeValue =>
      this.formValueMap[ClientCodeValueKey] as String?;
  String? get userCodeValue => this.formValueMap[UserCodeValueKey] as String?;

  set clientCodeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ClientCodeValueKey: value}),
    );

    if (_ScheduledSiteVisitsViewTextEditingControllers.containsKey(
        ClientCodeValueKey)) {
      _ScheduledSiteVisitsViewTextEditingControllers[ClientCodeValueKey]?.text =
          value ?? '';
    }
  }

  set userCodeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UserCodeValueKey: value}),
    );

    if (_ScheduledSiteVisitsViewTextEditingControllers.containsKey(
        UserCodeValueKey)) {
      _ScheduledSiteVisitsViewTextEditingControllers[UserCodeValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasClientCode =>
      this.formValueMap.containsKey(ClientCodeValueKey) &&
      (clientCodeValue?.isNotEmpty ?? false);
  bool get hasUserCode =>
      this.formValueMap.containsKey(UserCodeValueKey) &&
      (userCodeValue?.isNotEmpty ?? false);

  bool get hasClientCodeValidationMessage =>
      this.fieldsValidationMessages[ClientCodeValueKey]?.isNotEmpty ?? false;
  bool get hasUserCodeValidationMessage =>
      this.fieldsValidationMessages[UserCodeValueKey]?.isNotEmpty ?? false;

  String? get clientCodeValidationMessage =>
      this.fieldsValidationMessages[ClientCodeValueKey];
  String? get userCodeValidationMessage =>
      this.fieldsValidationMessages[UserCodeValueKey];
}

extension Methods on FormStateHelper {
  setClientCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ClientCodeValueKey] = validationMessage;
  setUserCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UserCodeValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    clientCodeValue = '';
    userCodeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ClientCodeValueKey: getValidationMessage(ClientCodeValueKey),
      UserCodeValueKey: getValidationMessage(UserCodeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ScheduledSiteVisitsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ScheduledSiteVisitsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ClientCodeValueKey: getValidationMessage(ClientCodeValueKey),
      UserCodeValueKey: getValidationMessage(UserCodeValueKey),
    });
