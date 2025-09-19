import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'kbd.dart';

/// A marker interface for any utility that can be passed to a [Kbd]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like [KbdStyle]) and applicable general utilities can implement this interface.
abstract class KbdStyling implements Styling {}

/// Defines specific styling options for a [Kbd] component, such as its size.
///
/// This is the concrete implementation class for kbd-specific modifiers.
/// It implements the [KbdStyling] interface, making it a valid type for the
/// `style` property of a [Kbd] component.
class KbdStyle extends ComponentStyle<KbdStyle> with Breakpoints<KbdStyle> implements KbdStyling {
  /// Constructs a [KbdStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "kbd-lg").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive or state-based styling.
  const KbdStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [KbdStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  KbdStyle create(List<PrefixModifier> modifiers) {
    return KbdStyle(cssClass, type: type, modifiers: modifiers);
  }
}
