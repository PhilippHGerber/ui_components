import 'package:jaspr/jaspr.dart' show Key, Styles, text;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'textarea_style.dart';

/// A component for multi-line text input, rendering an HTML `<textarea>` element.
///
/// It supports various styles, sizes, and colors through its `style` property,
/// and common textarea attributes can be passed directly to the constructor.
class Textarea extends UiComponent {
  /// Creates a Textarea component.
  ///
  /// - [value]: The text content to display within the textarea.
  /// - [placeholder]: The placeholder text to display when the textarea is empty.
  /// - [name]: The name of the textarea, used for form submission.
  /// - [disabled]: If true, the textarea will be disabled.
  /// - [rows]: The visible number of lines in a text area.
  /// - [style]: A list of [TextareaStyling] instances for styling.
  /// - Event handlers like [onInput] and [onChange] from [UiComponent] are available.
  /// - Other parameters are inherited from [UiComponent].
  Textarea({
    String? value,
    this.placeholder,
    this.name,
    this.disabled = false,
    this.rows,
    super.tag = 'textarea',
    List<TextareaStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onInput,
    super.onChange,
    super.key,
  })  : _value = value,
        super(value != null ? [text(value)] : null, style: style);

  /// The text content of the textarea.
  final String? _value;

  /// The placeholder text displayed when the textarea is empty.
  final String? placeholder;

  /// The name of the textarea, used in form submissions.
  final String? name;

  /// If true, the textarea is not interactive.
  final bool disabled;

  /// The number of visible text lines for the control.
  final int? rows;

  @override
  String get baseClass => 'textarea';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (placeholder != null) attributes.add('placeholder', placeholder!);
    if (name != null) attributes.add('name', name!);
    if (disabled) attributes.add('disabled', '');
    if (rows != null) attributes.add('rows', rows!.toString());
  }

  @override
  Textarea copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Textarea(
      value: _value,
      placeholder: placeholder,
      name: name,
      disabled: disabled,
      rows: rows,
      tag: tag,
      style: style as List<TextareaStyling>?,
      onInput: onInput,
      onChange: onChange,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Adds a border to the textarea. `textarea-bordered`
  static const TextareaStyle bordered = TextareaStyle('textarea-bordered', type: StyleType.border);

  /// Ghost style (transparent background). `textarea-ghost`
  static const TextareaStyle ghost = TextareaStyle('textarea-ghost', type: StyleType.style);

  // Colors
  /// Neutral color. `textarea-neutral`
  static const TextareaStyle neutral = TextareaStyle('textarea-neutral', type: StyleType.style);

  /// Primary color. `textarea-primary`
  static const TextareaStyle primary = TextareaStyle('textarea-primary', type: StyleType.style);

  /// Secondary color. `textarea-secondary`
  static const TextareaStyle secondary = TextareaStyle('textarea-secondary', type: StyleType.style);

  /// Accent color. `textarea-accent`
  static const TextareaStyle accent = TextareaStyle('textarea-accent', type: StyleType.style);

  /// Info color. `textarea-info`
  static const TextareaStyle info = TextareaStyle('textarea-info', type: StyleType.style);

  /// Success color. `textarea-success`
  static const TextareaStyle success = TextareaStyle('textarea-success', type: StyleType.style);

  /// Warning color. `textarea-warning`
  static const TextareaStyle warning = TextareaStyle('textarea-warning', type: StyleType.style);

  /// Error color. `textarea-error`
  static const TextareaStyle error = TextareaStyle('textarea-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `textarea-xs`
  static const TextareaStyle xs = TextareaStyle('textarea-xs', type: StyleType.sizing);

  /// Small size. `textarea-sm`
  static const TextareaStyle sm = TextareaStyle('textarea-sm', type: StyleType.sizing);

  /// Medium size (default). `textarea-md`
  static const TextareaStyle md = TextareaStyle('textarea-md', type: StyleType.sizing);

  /// Large size. `textarea-lg`
  static const TextareaStyle lg = TextareaStyle('textarea-lg', type: StyleType.sizing);

  /// Extra-large size. `textarea-xl`
  static const TextareaStyle xl = TextareaStyle('textarea-xl', type: StyleType.sizing);
}
