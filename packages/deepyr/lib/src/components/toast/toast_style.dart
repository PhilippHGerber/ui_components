import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'toast.dart';

/// A marker interface for any utility that can be passed to a [Toast]'s `style` list.
///
/// This allows for type-safe application of styles for positioning. Both
/// component-specific styles (like [ToastStyle]) and applicable general utilities
/// can implement this interface.
abstract class ToastStyling implements Styling {}

/// Defines specific styling options for a [Toast] component, such as its
/// horizontal and vertical alignment on the screen.
///
/// This is the concrete implementation class for toast-specific modifiers. It
/// implements the [ToastStyling] interface, making it a valid type for the
/// `style` property of a [Toast] component.
class ToastStyle extends ComponentStyle<ToastStyle>
    with Breakpoints<ToastStyle>
    implements ToastStyling {
  /// Constructs a [ToastStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "toast-top").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const ToastStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [ToastStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  ToastStyle create(List<PrefixModifier> modifiers) {
    return ToastStyle(cssClass, type: type, modifiers: modifiers);
  }
}
