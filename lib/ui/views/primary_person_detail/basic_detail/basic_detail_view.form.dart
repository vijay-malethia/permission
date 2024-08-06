// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NameOfEntityValueKey = 'nameOfEntity';
const String AddressValueKey = 'address ';
const String CityValueKey = 'city';
const String StateValueKey = 'state';
const String PincodeValueKey = 'pincode';
const String WebsiteValueKey = 'website';

final Map<String, TextEditingController>
    _BasicDetailViewTextEditingControllers = {};

final Map<String, FocusNode> _BasicDetailViewFocusNodes = {};

final Map<String, String? Function(String?)?> _BasicDetailViewTextValidations =
    {
  NameOfEntityValueKey: null,
  AddressValueKey: null,
  CityValueKey: null,
  StateValueKey: null,
  PincodeValueKey: null,
  WebsiteValueKey: null,
};

mixin $BasicDetailView {
  TextEditingController get nameOfEntityController =>
      _getFormTextEditingController(NameOfEntityValueKey);
  TextEditingController get addressController =>
      _getFormTextEditingController(AddressValueKey);
  TextEditingController get cityController =>
      _getFormTextEditingController(CityValueKey);
  TextEditingController get stateController =>
      _getFormTextEditingController(StateValueKey);
  TextEditingController get pincodeController =>
      _getFormTextEditingController(PincodeValueKey);
  TextEditingController get websiteController =>
      _getFormTextEditingController(WebsiteValueKey);

  FocusNode get nameOfEntityFocusNode =>
      _getFormFocusNode(NameOfEntityValueKey);
  FocusNode get addressFocusNode => _getFormFocusNode(AddressValueKey);
  FocusNode get cityFocusNode => _getFormFocusNode(CityValueKey);
  FocusNode get stateFocusNode => _getFormFocusNode(StateValueKey);
  FocusNode get pincodeFocusNode => _getFormFocusNode(PincodeValueKey);
  FocusNode get websiteFocusNode => _getFormFocusNode(WebsiteValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_BasicDetailViewTextEditingControllers.containsKey(key)) {
      return _BasicDetailViewTextEditingControllers[key]!;
    }

    _BasicDetailViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _BasicDetailViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_BasicDetailViewFocusNodes.containsKey(key)) {
      return _BasicDetailViewFocusNodes[key]!;
    }
    _BasicDetailViewFocusNodes[key] = FocusNode();
    return _BasicDetailViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    nameOfEntityController.addListener(() => _updateFormData(model));
    addressController.addListener(() => _updateFormData(model));
    cityController.addListener(() => _updateFormData(model));
    stateController.addListener(() => _updateFormData(model));
    pincodeController.addListener(() => _updateFormData(model));
    websiteController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameOfEntityController.addListener(() => _updateFormData(model));
    addressController.addListener(() => _updateFormData(model));
    cityController.addListener(() => _updateFormData(model));
    stateController.addListener(() => _updateFormData(model));
    pincodeController.addListener(() => _updateFormData(model));
    websiteController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameOfEntityValueKey: nameOfEntityController.text,
          AddressValueKey: addressController.text,
          CityValueKey: cityController.text,
          StateValueKey: stateController.text,
          PincodeValueKey: pincodeController.text,
          WebsiteValueKey: websiteController.text,
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

    for (var controller in _BasicDetailViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _BasicDetailViewFocusNodes.values) {
      focusNode.dispose();
    }

    _BasicDetailViewTextEditingControllers.clear();
    _BasicDetailViewFocusNodes.clear();
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

  String? get nameOfEntityValue =>
      this.formValueMap[NameOfEntityValueKey] as String?;
  String? get addressValue => this.formValueMap[AddressValueKey] as String?;
  String? get cityValue => this.formValueMap[CityValueKey] as String?;
  String? get stateValue => this.formValueMap[StateValueKey] as String?;
  String? get pincodeValue => this.formValueMap[PincodeValueKey] as String?;
  String? get websiteValue => this.formValueMap[WebsiteValueKey] as String?;

  set nameOfEntityValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameOfEntityValueKey: value}),
    );

    if (_BasicDetailViewTextEditingControllers.containsKey(
        NameOfEntityValueKey)) {
      _BasicDetailViewTextEditingControllers[NameOfEntityValueKey]?.text =
          value ?? '';
    }
  }

  set addressValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AddressValueKey: value}),
    );

    if (_BasicDetailViewTextEditingControllers.containsKey(AddressValueKey)) {
      _BasicDetailViewTextEditingControllers[AddressValueKey]?.text =
          value ?? '';
    }
  }

  set cityValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CityValueKey: value}),
    );

    if (_BasicDetailViewTextEditingControllers.containsKey(CityValueKey)) {
      _BasicDetailViewTextEditingControllers[CityValueKey]?.text = value ?? '';
    }
  }

  set stateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({StateValueKey: value}),
    );

    if (_BasicDetailViewTextEditingControllers.containsKey(StateValueKey)) {
      _BasicDetailViewTextEditingControllers[StateValueKey]?.text = value ?? '';
    }
  }

  set pincodeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PincodeValueKey: value}),
    );

    if (_BasicDetailViewTextEditingControllers.containsKey(PincodeValueKey)) {
      _BasicDetailViewTextEditingControllers[PincodeValueKey]?.text =
          value ?? '';
    }
  }

  set websiteValue(String? value) {
    this.setData(
      this.formValueMap..addAll({WebsiteValueKey: value}),
    );

    if (_BasicDetailViewTextEditingControllers.containsKey(WebsiteValueKey)) {
      _BasicDetailViewTextEditingControllers[WebsiteValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasNameOfEntity =>
      this.formValueMap.containsKey(NameOfEntityValueKey) &&
      (nameOfEntityValue?.isNotEmpty ?? false);
  bool get hasAddress =>
      this.formValueMap.containsKey(AddressValueKey) &&
      (addressValue?.isNotEmpty ?? false);
  bool get hasCity =>
      this.formValueMap.containsKey(CityValueKey) &&
      (cityValue?.isNotEmpty ?? false);
  bool get hasState =>
      this.formValueMap.containsKey(StateValueKey) &&
      (stateValue?.isNotEmpty ?? false);
  bool get hasPincode =>
      this.formValueMap.containsKey(PincodeValueKey) &&
      (pincodeValue?.isNotEmpty ?? false);
  bool get hasWebsite =>
      this.formValueMap.containsKey(WebsiteValueKey) &&
      (websiteValue?.isNotEmpty ?? false);

  bool get hasNameOfEntityValidationMessage =>
      this.fieldsValidationMessages[NameOfEntityValueKey]?.isNotEmpty ?? false;
  bool get hasAddressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey]?.isNotEmpty ?? false;
  bool get hasCityValidationMessage =>
      this.fieldsValidationMessages[CityValueKey]?.isNotEmpty ?? false;
  bool get hasStateValidationMessage =>
      this.fieldsValidationMessages[StateValueKey]?.isNotEmpty ?? false;
  bool get hasPincodeValidationMessage =>
      this.fieldsValidationMessages[PincodeValueKey]?.isNotEmpty ?? false;
  bool get hasWebsiteValidationMessage =>
      this.fieldsValidationMessages[WebsiteValueKey]?.isNotEmpty ?? false;

  String? get nameOfEntityValidationMessage =>
      this.fieldsValidationMessages[NameOfEntityValueKey];
  String? get addressValidationMessage =>
      this.fieldsValidationMessages[AddressValueKey];
  String? get cityValidationMessage =>
      this.fieldsValidationMessages[CityValueKey];
  String? get stateValidationMessage =>
      this.fieldsValidationMessages[StateValueKey];
  String? get pincodeValidationMessage =>
      this.fieldsValidationMessages[PincodeValueKey];
  String? get websiteValidationMessage =>
      this.fieldsValidationMessages[WebsiteValueKey];
}

extension Methods on FormStateHelper {
  setNameOfEntityValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameOfEntityValueKey] = validationMessage;
  setAddressValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressValueKey] = validationMessage;
  setCityValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CityValueKey] = validationMessage;
  setStateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[StateValueKey] = validationMessage;
  setPincodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PincodeValueKey] = validationMessage;
  setWebsiteValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[WebsiteValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameOfEntityValue = '';
    addressValue = '';
    cityValue = '';
    stateValue = '';
    pincodeValue = '';
    websiteValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameOfEntityValueKey: getValidationMessage(NameOfEntityValueKey),
      AddressValueKey: getValidationMessage(AddressValueKey),
      CityValueKey: getValidationMessage(CityValueKey),
      StateValueKey: getValidationMessage(StateValueKey),
      PincodeValueKey: getValidationMessage(PincodeValueKey),
      WebsiteValueKey: getValidationMessage(WebsiteValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _BasicDetailViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _BasicDetailViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NameOfEntityValueKey: getValidationMessage(NameOfEntityValueKey),
      AddressValueKey: getValidationMessage(AddressValueKey),
      CityValueKey: getValidationMessage(CityValueKey),
      StateValueKey: getValidationMessage(StateValueKey),
      PincodeValueKey: getValidationMessage(PincodeValueKey),
      WebsiteValueKey: getValidationMessage(WebsiteValueKey),
    });
