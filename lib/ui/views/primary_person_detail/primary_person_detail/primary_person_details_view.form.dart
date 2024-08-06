// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/form_validator.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String PrimaryPersonNameValueKey = 'primaryPersonName';
const String PrimaryPersonEmailValueKey = 'primaryPersonEmail';
const String PrimaryPersonMobileValueKey = 'primaryPersonMobile';
const String EntityIdValueKey = 'entityId';

final Map<String, TextEditingController>
    _PrimaryPersonDetailsViewTextEditingControllers = {};

final Map<String, FocusNode> _PrimaryPersonDetailsViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _PrimaryPersonDetailsViewTextValidations = {
  PrimaryPersonNameValueKey: FormValidator.requriedValidator,
  PrimaryPersonEmailValueKey: FormValidator.emailValidatior,
  PrimaryPersonMobileValueKey: FormValidator.mobileNumberValidator,
  EntityIdValueKey: FormValidator.requriedValidator,
};

mixin $PrimaryPersonDetailsView {
  TextEditingController get primaryPersonNameController =>
      _getFormTextEditingController(PrimaryPersonNameValueKey);
  TextEditingController get primaryPersonEmailController =>
      _getFormTextEditingController(PrimaryPersonEmailValueKey);
  TextEditingController get primaryPersonMobileController =>
      _getFormTextEditingController(PrimaryPersonMobileValueKey);
  TextEditingController get entityIdController =>
      _getFormTextEditingController(EntityIdValueKey);

  FocusNode get primaryPersonNameFocusNode =>
      _getFormFocusNode(PrimaryPersonNameValueKey);
  FocusNode get primaryPersonEmailFocusNode =>
      _getFormFocusNode(PrimaryPersonEmailValueKey);
  FocusNode get primaryPersonMobileFocusNode =>
      _getFormFocusNode(PrimaryPersonMobileValueKey);
  FocusNode get entityIdFocusNode => _getFormFocusNode(EntityIdValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_PrimaryPersonDetailsViewTextEditingControllers.containsKey(key)) {
      return _PrimaryPersonDetailsViewTextEditingControllers[key]!;
    }

    _PrimaryPersonDetailsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _PrimaryPersonDetailsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_PrimaryPersonDetailsViewFocusNodes.containsKey(key)) {
      return _PrimaryPersonDetailsViewFocusNodes[key]!;
    }
    _PrimaryPersonDetailsViewFocusNodes[key] = FocusNode();
    return _PrimaryPersonDetailsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    primaryPersonNameController.addListener(() => _updateFormData(model));
    primaryPersonEmailController.addListener(() => _updateFormData(model));
    primaryPersonMobileController.addListener(() => _updateFormData(model));
    entityIdController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    primaryPersonNameController.addListener(() => _updateFormData(model));
    primaryPersonEmailController.addListener(() => _updateFormData(model));
    primaryPersonMobileController.addListener(() => _updateFormData(model));
    entityIdController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          PrimaryPersonNameValueKey: primaryPersonNameController.text,
          PrimaryPersonEmailValueKey: primaryPersonEmailController.text,
          PrimaryPersonMobileValueKey: primaryPersonMobileController.text,
          EntityIdValueKey: entityIdController.text,
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
        in _PrimaryPersonDetailsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _PrimaryPersonDetailsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _PrimaryPersonDetailsViewTextEditingControllers.clear();
    _PrimaryPersonDetailsViewFocusNodes.clear();
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

  String? get primaryPersonNameValue =>
      this.formValueMap[PrimaryPersonNameValueKey] as String?;
  String? get primaryPersonEmailValue =>
      this.formValueMap[PrimaryPersonEmailValueKey] as String?;
  String? get primaryPersonMobileValue =>
      this.formValueMap[PrimaryPersonMobileValueKey] as String?;
  String? get entityIdValue => this.formValueMap[EntityIdValueKey] as String?;

  set primaryPersonNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PrimaryPersonNameValueKey: value}),
    );

    if (_PrimaryPersonDetailsViewTextEditingControllers.containsKey(
        PrimaryPersonNameValueKey)) {
      _PrimaryPersonDetailsViewTextEditingControllers[PrimaryPersonNameValueKey]
          ?.text = value ?? '';
    }
  }

  set primaryPersonEmailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PrimaryPersonEmailValueKey: value}),
    );

    if (_PrimaryPersonDetailsViewTextEditingControllers.containsKey(
        PrimaryPersonEmailValueKey)) {
      _PrimaryPersonDetailsViewTextEditingControllers[
              PrimaryPersonEmailValueKey]
          ?.text = value ?? '';
    }
  }

  set primaryPersonMobileValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PrimaryPersonMobileValueKey: value}),
    );

    if (_PrimaryPersonDetailsViewTextEditingControllers.containsKey(
        PrimaryPersonMobileValueKey)) {
      _PrimaryPersonDetailsViewTextEditingControllers[
              PrimaryPersonMobileValueKey]
          ?.text = value ?? '';
    }
  }

  set entityIdValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EntityIdValueKey: value}),
    );

    if (_PrimaryPersonDetailsViewTextEditingControllers.containsKey(
        EntityIdValueKey)) {
      _PrimaryPersonDetailsViewTextEditingControllers[EntityIdValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasPrimaryPersonName =>
      this.formValueMap.containsKey(PrimaryPersonNameValueKey) &&
      (primaryPersonNameValue?.isNotEmpty ?? false);
  bool get hasPrimaryPersonEmail =>
      this.formValueMap.containsKey(PrimaryPersonEmailValueKey) &&
      (primaryPersonEmailValue?.isNotEmpty ?? false);
  bool get hasPrimaryPersonMobile =>
      this.formValueMap.containsKey(PrimaryPersonMobileValueKey) &&
      (primaryPersonMobileValue?.isNotEmpty ?? false);
  bool get hasEntityId =>
      this.formValueMap.containsKey(EntityIdValueKey) &&
      (entityIdValue?.isNotEmpty ?? false);

  bool get hasPrimaryPersonNameValidationMessage =>
      this.fieldsValidationMessages[PrimaryPersonNameValueKey]?.isNotEmpty ??
      false;
  bool get hasPrimaryPersonEmailValidationMessage =>
      this.fieldsValidationMessages[PrimaryPersonEmailValueKey]?.isNotEmpty ??
      false;
  bool get hasPrimaryPersonMobileValidationMessage =>
      this.fieldsValidationMessages[PrimaryPersonMobileValueKey]?.isNotEmpty ??
      false;
  bool get hasEntityIdValidationMessage =>
      this.fieldsValidationMessages[EntityIdValueKey]?.isNotEmpty ?? false;

  String? get primaryPersonNameValidationMessage =>
      this.fieldsValidationMessages[PrimaryPersonNameValueKey];
  String? get primaryPersonEmailValidationMessage =>
      this.fieldsValidationMessages[PrimaryPersonEmailValueKey];
  String? get primaryPersonMobileValidationMessage =>
      this.fieldsValidationMessages[PrimaryPersonMobileValueKey];
  String? get entityIdValidationMessage =>
      this.fieldsValidationMessages[EntityIdValueKey];
}

extension Methods on FormStateHelper {
  setPrimaryPersonNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PrimaryPersonNameValueKey] =
          validationMessage;
  setPrimaryPersonEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PrimaryPersonEmailValueKey] =
          validationMessage;
  setPrimaryPersonMobileValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PrimaryPersonMobileValueKey] =
          validationMessage;
  setEntityIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EntityIdValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    primaryPersonNameValue = '';
    primaryPersonEmailValue = '';
    primaryPersonMobileValue = '';
    entityIdValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      PrimaryPersonNameValueKey:
          getValidationMessage(PrimaryPersonNameValueKey),
      PrimaryPersonEmailValueKey:
          getValidationMessage(PrimaryPersonEmailValueKey),
      PrimaryPersonMobileValueKey:
          getValidationMessage(PrimaryPersonMobileValueKey),
      EntityIdValueKey: getValidationMessage(EntityIdValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _PrimaryPersonDetailsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _PrimaryPersonDetailsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      PrimaryPersonNameValueKey:
          getValidationMessage(PrimaryPersonNameValueKey),
      PrimaryPersonEmailValueKey:
          getValidationMessage(PrimaryPersonEmailValueKey),
      PrimaryPersonMobileValueKey:
          getValidationMessage(PrimaryPersonMobileValueKey),
      EntityIdValueKey: getValidationMessage(EntityIdValueKey),
    });
