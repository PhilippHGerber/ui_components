import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'input_style.dart';

/// A component for user text input, rendering an HTML `<input>` element.
///
/// It supports various styles, sizes, and colors through its `style` property,
/// and common input attributes can be passed directly to the constructor.
class Input extends UiComponent {
  /// Creates an Input component.
  ///
  /// - [type]: The HTML input type (e.g., 'text', 'password', 'email'). Defaults to 'text'.
  /// - [placeholder]: The placeholder text to display in the input.
  /// - [value]: The initial value of the input field.
  /// - [name]: The name of the input, used for form submission.
  /// - [disabled]: If true, the input will be disabled.
  /// - [style]: A list of [InputStyling] instances for styling.
  /// - Event handlers like [onInput] and [onChange] from [UiComponent] are available.
  /// - Other parameters are inherited from [UiComponent].
  const Input({
    this.type = 'text',
    this.placeholder,
    this.value,
    this.name,
    this.disabled = false,
    super.tag = 'input',
    List<InputStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onInput,
    super.onChange,
    super.key,
    this.required = false,
    this.pattern,
    this.minLength,
    this.maxLength,
    this.min,
    this.max,
    this.title,
  }) : super(null, style: style); // Input elements have no children.

  /// The HTML `type` attribute for the input element (e.g., 'text', 'password', 'email').
  final String type;

  /// The placeholder text displayed when the input is empty.
  final String? placeholder;

  /// The initial value of the input field.
  final String? value;

  /// The name of the input, used for form submission.
  final String? name;

  /// If true, the input will be disabled and non-interactive.
  final bool disabled;

  /// If true, the input is required for form submission.
  final bool required;

  /// A regular expression that the input's value must match.
  final String? pattern;

  /// The minimum number of characters required in the input.
  final int? minLength;

  /// The maximum number of characters allowed in the input.
  final int? maxLength;

  /// The minimum numeric value for number-based inputs.
  final num? min;

  /// The maximum numeric value for number-based inputs.
  final num? max;

  /// The title attribute, often shown as a tooltip on hover.
  final String? title;

  @override
  String get baseClass => 'input';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.add('type', type);
    if (placeholder != null) attributes.add('placeholder', placeholder!);
    if (value != null) attributes.add('value', value!);
    if (name != null) attributes.add('name', name!);
    if (disabled) attributes.add('disabled', '');
    if (required) attributes.add('required', '');
    if (pattern != null) attributes.add('pattern', pattern!);
    if (minLength != null) attributes.add('minlength', minLength!.toString());
    if (maxLength != null) attributes.add('maxlength', maxLength!.toString());
    if (min != null) attributes.add('min', min!.toString());
    if (max != null) attributes.add('max', max!.toString());
    if (title != null) attributes.add('title', title!);
  }

  @override
  String get combinedClasses {
    final classes = super.combinedClasses;
    final needsValidator = required ||
        pattern != null ||
        minLength != null ||
        maxLength != null ||
        min != null ||
        max != null;
    if (needsValidator) {
      return '$classes validator';
    }
    return classes;
  }

  @override
  Input copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Input(
      type: type,
      placeholder: placeholder,
      value: value,
      name: name,
      disabled: disabled,
      tag: tag,
      style: style as List<InputStyling>?,
      onInput: onInput,
      onChange: onChange,
      required: required,
      pattern: pattern,
      minLength: minLength,
      maxLength: maxLength,
      min: min,
      max: max,
      title: title,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Adds a border to the input. `input-bordered`
  static const InputStyle bordered = InputStyle('input-bordered', type: StyleType.border);

  /// Ghost style (transparent background). `input-ghost`
  static const InputStyle ghost = InputStyle('input-ghost', type: StyleType.style);

  // Colors
  /// Neutral color. `input-neutral`
  static const InputStyle neutral = InputStyle('input-neutral', type: StyleType.style);

  /// Primary color. `input-primary`
  static const InputStyle primary = InputStyle('input-primary', type: StyleType.style);

  /// Secondary color. `input-secondary`
  static const InputStyle secondary = InputStyle('input-secondary', type: StyleType.style);

  /// Accent color. `input-accent`
  static const InputStyle accent = InputStyle('input-accent', type: StyleType.style);

  /// Info color. `input-info`
  static const InputStyle info = InputStyle('input-info', type: StyleType.style);

  /// Success color. `input-success`
  static const InputStyle success = InputStyle('input-success', type: StyleType.style);

  /// Warning color. `input-warning`
  static const InputStyle warning = InputStyle('input-warning', type: StyleType.style);

  /// Error color. `input-error`
  static const InputStyle error = InputStyle('input-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `input-xs`
  static const InputStyle xs = InputStyle('input-xs', type: StyleType.sizing);

  /// Small size. `input-sm`
  static const InputStyle sm = InputStyle('input-sm', type: StyleType.sizing);

  /// Medium size (default). `input-md`
  static const InputStyle md = InputStyle('input-md', type: StyleType.sizing);

  /// Large size. `input-lg`
  static const InputStyle lg = InputStyle('input-lg', type: StyleType.sizing);

  /// Extra-large size. `input-xl`
  static const InputStyle xl = InputStyle('input-xl', type: StyleType.sizing);
}
