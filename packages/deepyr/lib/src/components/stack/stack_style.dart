import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'stack.dart';

/// A marker interface for any utility that can be passed to a [Stack]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like [StackStyle]) and applicable general utilities can implement this interface.
abstract class StackStyling implements Styling {}

/// Defines specific styling options for a [Stack] component, such as its alignment.
///
/// This is the concrete implementation class for stack-specific modifiers. It
/// implements the [StackStyling] interface, making it a valid type for the
/// `style` property of a [Stack] component.
class StackStyle extends ComponentStyle<StackStyle>
    with Breakpoints<StackStyle>
    implements StackStyling {
  /// Constructs a [StackStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "stack-top").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive or state-based styling.
  const StackStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [StackStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  StackStyle create(List<PrefixModifier> modifiers) {
    return StackStyle(cssClass, type: type, modifiers: modifiers);
  }
}
