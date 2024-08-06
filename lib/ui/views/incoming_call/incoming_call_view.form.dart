// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchValueKey = 'search';
const String FromDateValueKey = 'fromDate';
const String ToDateValueKey = 'toDate';

final Map<String, TextEditingController>
    _IncomingCallViewTextEditingControllers = {};

final Map<String, FocusNode> _IncomingCallViewFocusNodes = {};

final Map<String, String? Function(String?)?> _IncomingCallViewTextValidations =
    {
  SearchValueKey: null,
  FromDateValueKey: null,
  ToDateValueKey: null,
};

mixin $IncomingCallView {
  TextEditingController get searchController =>
      _getFormTextEditingController(SearchValueKey);
  TextEditingController get fromDateController =>
      _getFormTextEditingController(FromDateValueKey);
  TextEditingController get toDateController =>
      _getFormTextEditingController(ToDateValueKey);

  FocusNode get searchFocusNode => _getFormFocusNode(SearchValueKey);
  FocusNode get fromDateFocusNode => _getFormFocusNode(FromDateValueKey);
  FocusNode get toDateFocusNode => _getFormFocusNode(ToDateValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_IncomingCallViewTextEditingControllers.containsKey(key)) {
      return _IncomingCallViewTextEditingControllers[key]!;
    }

    _IncomingCallViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _IncomingCallViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_IncomingCallViewFocusNodes.containsKey(key)) {
      return _IncomingCallViewFocusNodes[key]!;
    }
    _IncomingCallViewFocusNodes[key] = FocusNode();
    return _IncomingCallViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchController.addListener(() => _updateFormData(model));
    fromDateController.addListener(() => _updateFormData(model));
    toDateController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchController.addListener(() => _updateFormData(model));
    fromDateController.addListener(() => _updateFormData(model));
    toDateController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchValueKey: searchController.text,
          FromDateValueKey: fromDateController.text,
          ToDateValueKey: toDateController.text,
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

    for (var controller in _IncomingCallViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _IncomingCallViewFocusNodes.values) {
      focusNode.dispose();
    }

    _IncomingCallViewTextEditingControllers.clear();
    _IncomingCallViewFocusNodes.clear();
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

  String? get searchValue => this.formValueMap[SearchValueKey] as String?;
  String? get fromDateValue => this.formValueMap[FromDateValueKey] as String?;
  String? get toDateValue => this.formValueMap[ToDateValueKey] as String?;

  set searchValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchValueKey: value}),
    );

    if (_IncomingCallViewTextEditingControllers.containsKey(SearchValueKey)) {
      _IncomingCallViewTextEditingControllers[SearchValueKey]?.text =
          value ?? '';
    }
  }

  set fromDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FromDateValueKey: value}),
    );

    if (_IncomingCallViewTextEditingControllers.containsKey(FromDateValueKey)) {
      _IncomingCallViewTextEditingControllers[FromDateValueKey]?.text =
          value ?? '';
    }
  }

  set toDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ToDateValueKey: value}),
    );

    if (_IncomingCallViewTextEditingControllers.containsKey(ToDateValueKey)) {
      _IncomingCallViewTextEditingControllers[ToDateValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasSearch =>
      this.formValueMap.containsKey(SearchValueKey) &&
      (searchValue?.isNotEmpty ?? false);
  bool get hasFromDate =>
      this.formValueMap.containsKey(FromDateValueKey) &&
      (fromDateValue?.isNotEmpty ?? false);
  bool get hasToDate =>
      this.formValueMap.containsKey(ToDateValueKey) &&
      (toDateValue?.isNotEmpty ?? false);

  bool get hasSearchValidationMessage =>
      this.fieldsValidationMessages[SearchValueKey]?.isNotEmpty ?? false;
  bool get hasFromDateValidationMessage =>
      this.fieldsValidationMessages[FromDateValueKey]?.isNotEmpty ?? false;
  bool get hasToDateValidationMessage =>
      this.fieldsValidationMessages[ToDateValueKey]?.isNotEmpty ?? false;

  String? get searchValidationMessage =>
      this.fieldsValidationMessages[SearchValueKey];
  String? get fromDateValidationMessage =>
      this.fieldsValidationMessages[FromDateValueKey];
  String? get toDateValidationMessage =>
      this.fieldsValidationMessages[ToDateValueKey];
}

extension Methods on FormStateHelper {
  setSearchValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchValueKey] = validationMessage;
  setFromDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FromDateValueKey] = validationMessage;
  setToDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ToDateValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchValue = '';
    fromDateValue = '';
    toDateValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchValueKey: getValidationMessage(SearchValueKey),
      FromDateValueKey: getValidationMessage(FromDateValueKey),
      ToDateValueKey: getValidationMessage(ToDateValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _IncomingCallViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _IncomingCallViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchValueKey: getValidationMessage(SearchValueKey),
      FromDateValueKey: getValidationMessage(FromDateValueKey),
      ToDateValueKey: getValidationMessage(ToDateValueKey),
    });
