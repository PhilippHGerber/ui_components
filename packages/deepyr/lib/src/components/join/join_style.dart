import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'join.dart';

/// A marker interface for any utility that can be passed to a [Join]'s `style` list.
///
/// This allows for type-safe application of styles, ensuring only relevant modifiers,
/// like direction (`Join.vertical`), can be applied to the container.
abstract class JoinStyling implements Styling {}

/// Defines specific styling options for a [Join] container component, such as its
/// orientation (horizontal or vertical).
///
/// This is the concrete implementation class for join-specific modifiers. It
/// implements the [JoinStyling] interface, making it a valid type for the
/// `style` property of a [Join] component.
class JoinStyle extends ComponentStyle<JoinStyle>
    with Breakpoints<JoinStyle>
    implements JoinStyling {
  /// Constructs a [JoinStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "join-vertical").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const JoinStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [JoinStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  JoinStyle create(List<PrefixModifier> modifiers) {
    return JoinStyle(cssClass, type: type, modifiers: modifiers);
  }
}
