import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'label.dart';

/// A marker interface for any utility that can be passed to a [Label]'s
/// `style` list.
///
/// This allows for type-safe application of styles. Both component-specific
/// styles (like [LabelStyle]) and general utilities can implement this interface.
abstract class LabelStyling implements Styling {}

/// Defines specific styling options for a [Label] component, such as the
/// floating label effect.
///
/// This is the concrete implementation class for label-specific modifiers. It
/// implements the [LabelStyling] interface, making it a valid type for the
/// `style` property of a [Label] component.
class LabelStyle extends ComponentStyle<LabelStyle>
    with Breakpoints<LabelStyle>
    implements LabelStyling {
  /// Constructs a [LabelStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "floating-label").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const LabelStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [LabelStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  LabelStyle create(List<PrefixModifier> modifiers) {
    return LabelStyle(cssClass, type: type, modifiers: modifiers);
  }
}
