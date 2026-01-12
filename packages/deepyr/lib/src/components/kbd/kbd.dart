import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'kbd_style.dart';

/// A component used to display keyboard shortcuts or key presses.
///
/// It renders as an HTML `<kbd>` element with the 'kbd' base class.
/// The `style` list accepts instances of [KbdStyling], allowing for size adjustments.
class Kbd extends UiComponent {
  /// Creates a Kbd component.
  ///
  /// - [children] or [child]: The content to display within the key (e.g., text like "Ctrl", "A", or "⌘").
  /// - [tag]: The HTML tag for the root element, defaults to 'kbd'.
  /// - [style]: A list of [KbdStyling] instances, primarily for setting the size.
  /// - Other parameters are inherited from [UiComponent].
  const Kbd(
    super.children, {
    super.tag = 'kbd',
    List<KbdStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'kbd';

  @override
  Kbd copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Kbd(
      children,
      tag: tag,
      style: style as List<KbdStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Kbd Style Modifiers ---

  /// Extra-small size. `kbd-xs`
  static const KbdStyle xs = KbdStyle(
    'kbd-xs',
    type: StyleType.sizing,
  );

  /// Small size. `kbd-sm`
  static const KbdStyle sm = KbdStyle(
    'kbd-sm',
    type: StyleType.sizing,
  );

  /// Medium size (default). `kbd-md`
  static const KbdStyle md = KbdStyle(
    'kbd-md',
    type: StyleType.sizing,
  );

  /// Large size. `kbd-lg`
  static const KbdStyle lg = KbdStyle(
    'kbd-lg',
    type: StyleType.sizing,
  );

  /// Extra-large size. `kbd-xl`
  static const KbdStyle xl = KbdStyle(
    'kbd-xl',
    type: StyleType.sizing,
  );
}
