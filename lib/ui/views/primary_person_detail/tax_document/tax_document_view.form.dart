// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String GstinValueKey = 'gstin';
const String PancardValueKey = 'pancard';
const String ReraCertificateValueKey = 'reraCertificate';

final Map<String, TextEditingController>
    _TaxDocumentViewTextEditingControllers = {};

final Map<String, FocusNode> _TaxDocumentViewFocusNodes = {};

final Map<String, String? Function(String?)?> _TaxDocumentViewTextValidations =
    {
  GstinValueKey: null,
  PancardValueKey: null,
  ReraCertificateValueKey: null,
};

mixin $TaxDocumentView {
  TextEditingController get gstinController =>
      _getFormTextEditingController(GstinValueKey);
  TextEditingController get pancardController =>
      _getFormTextEditingController(PancardValueKey);
  TextEditingController get reraCertificateController =>
      _getFormTextEditingController(ReraCertificateValueKey);

  FocusNode get gstinFocusNode => _getFormFocusNode(GstinValueKey);
  FocusNode get pancardFocusNode => _getFormFocusNode(PancardValueKey);
  FocusNode get reraCertificateFocusNode =>
      _getFormFocusNode(ReraCertificateValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_TaxDocumentViewTextEditingControllers.containsKey(key)) {
      return _TaxDocumentViewTextEditingControllers[key]!;
    }

    _TaxDocumentViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _TaxDocumentViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_TaxDocumentViewFocusNodes.containsKey(key)) {
      return _TaxDocumentViewFocusNodes[key]!;
    }
    _TaxDocumentViewFocusNodes[key] = FocusNode();
    return _TaxDocumentViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    gstinController.addListener(() => _updateFormData(model));
    pancardController.addListener(() => _updateFormData(model));
    reraCertificateController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    gstinController.addListener(() => _updateFormData(model));
    pancardController.addListener(() => _updateFormData(model));
    reraCertificateController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          GstinValueKey: gstinController.text,
          PancardValueKey: pancardController.text,
          ReraCertificateValueKey: reraCertificateController.text,
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

    for (var controller in _TaxDocumentViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _TaxDocumentViewFocusNodes.values) {
      focusNode.dispose();
    }

    _TaxDocumentViewTextEditingControllers.clear();
    _TaxDocumentViewFocusNodes.clear();
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

  String? get gstinValue => this.formValueMap[GstinValueKey] as String?;
  String? get pancardValue => this.formValueMap[PancardValueKey] as String?;
  String? get reraCertificateValue =>
      this.formValueMap[ReraCertificateValueKey] as String?;

  set gstinValue(String? value) {
    this.setData(
      this.formValueMap..addAll({GstinValueKey: value}),
    );

    if (_TaxDocumentViewTextEditingControllers.containsKey(GstinValueKey)) {
      _TaxDocumentViewTextEditingControllers[GstinValueKey]?.text = value ?? '';
    }
  }

  set pancardValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PancardValueKey: value}),
    );

    if (_TaxDocumentViewTextEditingControllers.containsKey(PancardValueKey)) {
      _TaxDocumentViewTextEditingControllers[PancardValueKey]?.text =
          value ?? '';
    }
  }

  set reraCertificateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ReraCertificateValueKey: value}),
    );

    if (_TaxDocumentViewTextEditingControllers.containsKey(
        ReraCertificateValueKey)) {
      _TaxDocumentViewTextEditingControllers[ReraCertificateValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasGstin =>
      this.formValueMap.containsKey(GstinValueKey) &&
      (gstinValue?.isNotEmpty ?? false);
  bool get hasPancard =>
      this.formValueMap.containsKey(PancardValueKey) &&
      (pancardValue?.isNotEmpty ?? false);
  bool get hasReraCertificate =>
      this.formValueMap.containsKey(ReraCertificateValueKey) &&
      (reraCertificateValue?.isNotEmpty ?? false);

  bool get hasGstinValidationMessage =>
      this.fieldsValidationMessages[GstinValueKey]?.isNotEmpty ?? false;
  bool get hasPancardValidationMessage =>
      this.fieldsValidationMessages[PancardValueKey]?.isNotEmpty ?? false;
  bool get hasReraCertificateValidationMessage =>
      this.fieldsValidationMessages[ReraCertificateValueKey]?.isNotEmpty ??
      false;

  String? get gstinValidationMessage =>
      this.fieldsValidationMessages[GstinValueKey];
  String? get pancardValidationMessage =>
      this.fieldsValidationMessages[PancardValueKey];
  String? get reraCertificateValidationMessage =>
      this.fieldsValidationMessages[ReraCertificateValueKey];
}

extension Methods on FormStateHelper {
  setGstinValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[GstinValueKey] = validationMessage;
  setPancardValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PancardValueKey] = validationMessage;
  setReraCertificateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ReraCertificateValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    gstinValue = '';
    pancardValue = '';
    reraCertificateValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      GstinValueKey: getValidationMessage(GstinValueKey),
      PancardValueKey: getValidationMessage(PancardValueKey),
      ReraCertificateValueKey: getValidationMessage(ReraCertificateValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _TaxDocumentViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _TaxDocumentViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      GstinValueKey: getValidationMessage(GstinValueKey),
      PancardValueKey: getValidationMessage(PancardValueKey),
      ReraCertificateValueKey: getValidationMessage(ReraCertificateValueKey),
    });
