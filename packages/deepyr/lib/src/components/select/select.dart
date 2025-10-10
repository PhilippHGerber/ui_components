import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'select_style.dart';

/// A dropdown select component, rendering an HTML `<select>` element.
///
/// Its children should be a list of Jaspr `option()` components.
class Select extends UiComponent {
  /// Creates a Select component.
  ///
  /// - [children]: A list of `option()` components to populate the dropdown.
  /// - [name]: The name of the select element, used for form submission.
  /// - [disabled]: If true, the select dropdown will be disabled.
  /// - [style]: A list of [SelectStyling] instances for styling.
  /// - [onChange]: Event handler for when the selected value changes.
  /// - Other parameters are inherited from [UiComponent].
  const Select(
    super.children, {
    this.name,
    this.disabled = false,
    super.tag = 'select',
    List<SelectStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onChange,
    super.key,
  }) : super(style: style);

  /// The name of the select element, used for form submission.
  final String? name;

  /// If true, the select dropdown will be disabled and non-interactive.
  final bool disabled;

  @override
  String get baseClass => 'select';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (name != null) {
      attributes.add('name', name!);
    }
    if (disabled) {
      attributes.add('disabled', '');
    }
  }

  @override
  Select copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Select(
      children,
      name: name,
      disabled: disabled,
      tag: tag,
      style: style as List<SelectStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      onChange: onChange,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Adds a border to the select. `select-bordered`
  static const SelectStyle bordered = SelectStyle('select-bordered', type: StyleType.border);

  /// Ghost style (transparent background). `select-ghost`
  static const SelectStyle ghost = SelectStyle('select-ghost', type: StyleType.style);

  // Colors
  /// Neutral color. `select-neutral`
  static const SelectStyle neutral = SelectStyle('select-neutral', type: StyleType.style);

  /// Primary color. `select-primary`
  static const SelectStyle primary = SelectStyle('select-primary', type: StyleType.style);

  /// Secondary color. `select-secondary`
  static const SelectStyle secondary = SelectStyle('select-secondary', type: StyleType.style);

  /// Accent color. `select-accent`
  static const SelectStyle accent = SelectStyle('select-accent', type: StyleType.style);

  /// Info color. `select-info`
  static const SelectStyle info = SelectStyle('select-info', type: StyleType.style);

  /// Success color. `select-success`
  static const SelectStyle success = SelectStyle('select-success', type: StyleType.style);

  /// Warning color. `select-warning`
  static const SelectStyle warning = SelectStyle('select-warning', type: StyleType.style);

  /// Error color. `select-error`
  static const SelectStyle error = SelectStyle('select-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `select-xs`
  static const SelectStyle xs = SelectStyle('select-xs', type: StyleType.sizing);

  /// Small size. `select-sm`
  static const SelectStyle sm = SelectStyle('select-sm', type: StyleType.sizing);

  /// Medium size (default). `select-md`
  static const SelectStyle md = SelectStyle('select-md', type: StyleType.sizing);

  /// Large size. `select-lg`
  static const SelectStyle lg = SelectStyle('select-lg', type: StyleType.sizing);

  /// Large size. `select-xl`
  static const SelectStyle xl = SelectStyle('select-xl', type: StyleType.sizing);
}
