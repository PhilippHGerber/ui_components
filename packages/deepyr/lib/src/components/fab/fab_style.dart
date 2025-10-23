import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'fab.dart';

/// A marker interface for any utility that can be passed to a [Fab]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like [FabStyle]) and applicable general utilities can implement this interface.
abstract class FabStyling implements Styling {}

/// Defines specific styling options for a [Fab] component, such as its layout.
///
/// This is the concrete implementation class for fab-specific modifiers. It
/// implements the [FabStyling] interface, making it a valid type for the
/// `style` property of a [Fab] component.
class FabStyle extends ComponentStyle<FabStyle> with Breakpoints<FabStyle> implements FabStyling {
  /// Constructs a [FabStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "fab-flower").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const FabStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [FabStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  FabStyle create(List<PrefixModifier> modifiers) {
    return FabStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// A marker interface for any utility that can be passed to a [FabAction]'s `style` list.
///
/// `FabAction` and its variants have no unique modifiers of their own, but this
/// interface allows general utilities to be applied to their container in a type-safe manner.
abstract class FabActionStyling implements Styling {}

/// Defines specific styling options for a [FabAction] component.
///
/// This class exists for architectural consistency and future extensibility.
class FabActionStyle extends ComponentStyle<FabActionStyle>
    with Breakpoints<FabActionStyle>
    implements FabActionStyling {
  /// Constructs a [FabActionStyle].
  const FabActionStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  FabActionStyle create(List<PrefixModifier> modifiers) {
    return FabActionStyle(cssClass, type: type, modifiers: modifiers);
  }
}
