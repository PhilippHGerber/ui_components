import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import 'label_style.dart';

/// An enum defining the contextual container roles a [Label] can adopt
/// based on DaisyUI patterns.
enum LabelContainerType {
  /// Styles the label as a container for an `<input>` element (`class="input"`).
  input('input'),

  /// Styles the label as a container for a `<select>` element (`class="select"`).
  select('select');

  const LabelContainerType(this.cssClass);
  final String cssClass;
}

/// A component that renders an HTML `<label>` element, specifically designed to
/// act as a styled container for form elements as per DaisyUI patterns.
///
/// This component encapsulates patterns like `<label class="input input-bordered">`.
/// Its role is determined by the required [type] parameter.
///
/// **Note:** For a simple, semantic `<label for="...">` used for accessibility,
/// please use Jaspr's built-in `label()` function. This component is for
/// creating styled DaisyUI fields.
class Label extends UiComponent {
  /// Creates a styled `<label>` container for form elements.
  ///
  /// - [children] or [child]: The content of the container, typically an `Input`
  ///   or `Select` component along with its descriptive text.
  /// - [type]: **Required.** The contextual role of the container, which
  ///   determines its base class (e.g., `input` or `select`).
  /// - [isBordered]: If true, applies the corresponding bordered class
  ///   (e.g., `input-bordered`, `select-bordered`). Defaults to `true`.
  /// - [style]: A list of [LabelStyling] modifiers, such as [Label.floating],
  ///   and general layout utilities.
  const Label(
    super.children, {
    required this.type,
    this.isBordered = true,
    List<LabelStyling>? style,
    super.tag = 'label',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// The contextual role of the container, which defines its base class.
  final LabelContainerType type;

  /// If true, applies the bordered variation class (e.g., 'input-bordered').
  final bool isBordered;

  /// CSS rules associated with the Label component.
  /// This is automatically collected by the Jaspr build system.
  @css
  static final List<StyleRule> styles = [
    // This rule prevents the default browser focus outline on an <input>
    // or <select> when it is a direct child of a deepyr Label container
    // (which has the .input or .select class). This allows the parent
    // label's :focus-within style from DaisyUI to be the only visible
    // focus indicator, preventing a "double outline" glitch.
    css('.input > input:focus, .select > select:focus').styles(
      raw: {
        'outline': 'none',
      },
    ),
  ];

  @override
  String get baseClass => type.cssClass;

  @override
  String get combinedClasses {
    final effectiveClasses = <String>[
      baseClass,
      if (isBordered) '$baseClass-bordered',
    ];

    final utilityClasses = style?.map((s) => s.toString()).join(' ');
    if (utilityClasses != null && utilityClasses.isNotEmpty) {
      effectiveClasses.add(utilityClasses);
    }

    if (classes != null && classes!.isNotEmpty) {
      effectiveClasses.add(classes!);
    }

    return effectiveClasses.where((c) => c.isNotEmpty).join(' ');
  }

  @override
  Label copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Label(
      children,
      type: type,
      isBordered: isBordered,
      style: style as List<LabelStyling>?,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Label Style Modifiers ---

  /// Styles the label as a container for a floating label effect.
  /// The `<span>` text inside will float above the input on focus.
  static const LabelStyle floating = LabelStyle(
    'floating-label',
    type: StyleType.layout,
  );
}
