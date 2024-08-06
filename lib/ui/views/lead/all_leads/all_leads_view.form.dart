// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchValueKey = 'search';
const String RemarkValueKey = 'remark';
const String RemarkStageValueKey = 'remarkStage';
const String FollowUpRemarkValueKey = 'followUpRemark';
const String FollowUpClientFeedbackValueKey = 'followUpClientFeedback';
const String RemarkScheduleValueKey = 'remarkSchedule';

final Map<String, TextEditingController> _AllLeadsViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AllLeadsViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AllLeadsViewTextValidations = {
  SearchValueKey: null,
  RemarkValueKey: null,
  RemarkStageValueKey: null,
  FollowUpRemarkValueKey: null,
  FollowUpClientFeedbackValueKey: null,
  RemarkScheduleValueKey: null,
};

mixin $AllLeadsView {
  TextEditingController get searchController =>
      _getFormTextEditingController(SearchValueKey);
  TextEditingController get remarkController =>
      _getFormTextEditingController(RemarkValueKey);
  TextEditingController get remarkStageController =>
      _getFormTextEditingController(RemarkStageValueKey);
  TextEditingController get followUpRemarkController =>
      _getFormTextEditingController(FollowUpRemarkValueKey);
  TextEditingController get followUpClientFeedbackController =>
      _getFormTextEditingController(FollowUpClientFeedbackValueKey);
  TextEditingController get remarkScheduleController =>
      _getFormTextEditingController(RemarkScheduleValueKey);

  FocusNode get searchFocusNode => _getFormFocusNode(SearchValueKey);
  FocusNode get remarkFocusNode => _getFormFocusNode(RemarkValueKey);
  FocusNode get remarkStageFocusNode => _getFormFocusNode(RemarkStageValueKey);
  FocusNode get followUpRemarkFocusNode =>
      _getFormFocusNode(FollowUpRemarkValueKey);
  FocusNode get followUpClientFeedbackFocusNode =>
      _getFormFocusNode(FollowUpClientFeedbackValueKey);
  FocusNode get remarkScheduleFocusNode =>
      _getFormFocusNode(RemarkScheduleValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AllLeadsViewTextEditingControllers.containsKey(key)) {
      return _AllLeadsViewTextEditingControllers[key]!;
    }

    _AllLeadsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AllLeadsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AllLeadsViewFocusNodes.containsKey(key)) {
      return _AllLeadsViewFocusNodes[key]!;
    }
    _AllLeadsViewFocusNodes[key] = FocusNode();
    return _AllLeadsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchController.addListener(() => _updateFormData(model));
    remarkController.addListener(() => _updateFormData(model));
    remarkStageController.addListener(() => _updateFormData(model));
    followUpRemarkController.addListener(() => _updateFormData(model));
    followUpClientFeedbackController.addListener(() => _updateFormData(model));
    remarkScheduleController.addListener(() => _updateFormData(model));

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
    remarkController.addListener(() => _updateFormData(model));
    remarkStageController.addListener(() => _updateFormData(model));
    followUpRemarkController.addListener(() => _updateFormData(model));
    followUpClientFeedbackController.addListener(() => _updateFormData(model));
    remarkScheduleController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchValueKey: searchController.text,
          RemarkValueKey: remarkController.text,
          RemarkStageValueKey: remarkStageController.text,
          FollowUpRemarkValueKey: followUpRemarkController.text,
          FollowUpClientFeedbackValueKey: followUpClientFeedbackController.text,
          RemarkScheduleValueKey: remarkScheduleController.text,
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

    for (var controller in _AllLeadsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AllLeadsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AllLeadsViewTextEditingControllers.clear();
    _AllLeadsViewFocusNodes.clear();
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
  String? get remarkValue => this.formValueMap[RemarkValueKey] as String?;
  String? get remarkStageValue =>
      this.formValueMap[RemarkStageValueKey] as String?;
  String? get followUpRemarkValue =>
      this.formValueMap[FollowUpRemarkValueKey] as String?;
  String? get followUpClientFeedbackValue =>
      this.formValueMap[FollowUpClientFeedbackValueKey] as String?;
  String? get remarkScheduleValue =>
      this.formValueMap[RemarkScheduleValueKey] as String?;

  set searchValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchValueKey: value}),
    );

    if (_AllLeadsViewTextEditingControllers.containsKey(SearchValueKey)) {
      _AllLeadsViewTextEditingControllers[SearchValueKey]?.text = value ?? '';
    }
  }

  set remarkValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RemarkValueKey: value}),
    );

    if (_AllLeadsViewTextEditingControllers.containsKey(RemarkValueKey)) {
      _AllLeadsViewTextEditingControllers[RemarkValueKey]?.text = value ?? '';
    }
  }

  set remarkStageValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RemarkStageValueKey: value}),
    );

    if (_AllLeadsViewTextEditingControllers.containsKey(RemarkStageValueKey)) {
      _AllLeadsViewTextEditingControllers[RemarkStageValueKey]?.text =
          value ?? '';
    }
  }

  set followUpRemarkValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FollowUpRemarkValueKey: value}),
    );

    if (_AllLeadsViewTextEditingControllers.containsKey(
        FollowUpRemarkValueKey)) {
      _AllLeadsViewTextEditingControllers[FollowUpRemarkValueKey]?.text =
          value ?? '';
    }
  }

  set followUpClientFeedbackValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FollowUpClientFeedbackValueKey: value}),
    );

    if (_AllLeadsViewTextEditingControllers.containsKey(
        FollowUpClientFeedbackValueKey)) {
      _AllLeadsViewTextEditingControllers[FollowUpClientFeedbackValueKey]
          ?.text = value ?? '';
    }
  }

  set remarkScheduleValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RemarkScheduleValueKey: value}),
    );

    if (_AllLeadsViewTextEditingControllers.containsKey(
        RemarkScheduleValueKey)) {
      _AllLeadsViewTextEditingControllers[RemarkScheduleValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasSearch =>
      this.formValueMap.containsKey(SearchValueKey) &&
      (searchValue?.isNotEmpty ?? false);
  bool get hasRemark =>
      this.formValueMap.containsKey(RemarkValueKey) &&
      (remarkValue?.isNotEmpty ?? false);
  bool get hasRemarkStage =>
      this.formValueMap.containsKey(RemarkStageValueKey) &&
      (remarkStageValue?.isNotEmpty ?? false);
  bool get hasFollowUpRemark =>
      this.formValueMap.containsKey(FollowUpRemarkValueKey) &&
      (followUpRemarkValue?.isNotEmpty ?? false);
  bool get hasFollowUpClientFeedback =>
      this.formValueMap.containsKey(FollowUpClientFeedbackValueKey) &&
      (followUpClientFeedbackValue?.isNotEmpty ?? false);
  bool get hasRemarkSchedule =>
      this.formValueMap.containsKey(RemarkScheduleValueKey) &&
      (remarkScheduleValue?.isNotEmpty ?? false);

  bool get hasSearchValidationMessage =>
      this.fieldsValidationMessages[SearchValueKey]?.isNotEmpty ?? false;
  bool get hasRemarkValidationMessage =>
      this.fieldsValidationMessages[RemarkValueKey]?.isNotEmpty ?? false;
  bool get hasRemarkStageValidationMessage =>
      this.fieldsValidationMessages[RemarkStageValueKey]?.isNotEmpty ?? false;
  bool get hasFollowUpRemarkValidationMessage =>
      this.fieldsValidationMessages[FollowUpRemarkValueKey]?.isNotEmpty ??
      false;
  bool get hasFollowUpClientFeedbackValidationMessage =>
      this
          .fieldsValidationMessages[FollowUpClientFeedbackValueKey]
          ?.isNotEmpty ??
      false;
  bool get hasRemarkScheduleValidationMessage =>
      this.fieldsValidationMessages[RemarkScheduleValueKey]?.isNotEmpty ??
      false;

  String? get searchValidationMessage =>
      this.fieldsValidationMessages[SearchValueKey];
  String? get remarkValidationMessage =>
      this.fieldsValidationMessages[RemarkValueKey];
  String? get remarkStageValidationMessage =>
      this.fieldsValidationMessages[RemarkStageValueKey];
  String? get followUpRemarkValidationMessage =>
      this.fieldsValidationMessages[FollowUpRemarkValueKey];
  String? get followUpClientFeedbackValidationMessage =>
      this.fieldsValidationMessages[FollowUpClientFeedbackValueKey];
  String? get remarkScheduleValidationMessage =>
      this.fieldsValidationMessages[RemarkScheduleValueKey];
}

extension Methods on FormStateHelper {
  setSearchValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchValueKey] = validationMessage;
  setRemarkValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RemarkValueKey] = validationMessage;
  setRemarkStageValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RemarkStageValueKey] = validationMessage;
  setFollowUpRemarkValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FollowUpRemarkValueKey] = validationMessage;
  setFollowUpClientFeedbackValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FollowUpClientFeedbackValueKey] =
          validationMessage;
  setRemarkScheduleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RemarkScheduleValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchValue = '';
    remarkValue = '';
    remarkStageValue = '';
    followUpRemarkValue = '';
    followUpClientFeedbackValue = '';
    remarkScheduleValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchValueKey: getValidationMessage(SearchValueKey),
      RemarkValueKey: getValidationMessage(RemarkValueKey),
      RemarkStageValueKey: getValidationMessage(RemarkStageValueKey),
      FollowUpRemarkValueKey: getValidationMessage(FollowUpRemarkValueKey),
      FollowUpClientFeedbackValueKey:
          getValidationMessage(FollowUpClientFeedbackValueKey),
      RemarkScheduleValueKey: getValidationMessage(RemarkScheduleValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AllLeadsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AllLeadsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchValueKey: getValidationMessage(SearchValueKey),
      RemarkValueKey: getValidationMessage(RemarkValueKey),
      RemarkStageValueKey: getValidationMessage(RemarkStageValueKey),
      FollowUpRemarkValueKey: getValidationMessage(FollowUpRemarkValueKey),
      FollowUpClientFeedbackValueKey:
          getValidationMessage(FollowUpClientFeedbackValueKey),
      RemarkScheduleValueKey: getValidationMessage(RemarkScheduleValueKey),
    });
