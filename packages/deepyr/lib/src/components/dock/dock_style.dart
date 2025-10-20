import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'dock.dart';

// --- Marker Interfaces for Type Safety ---

/// A marker interface for any utility that can be passed to a [Dock]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like [DockStyle]) and general utilities can implement this interface.
abstract class DockStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [DockItem]'s `style` list.
///
/// `DockItem` has no unique modifiers of its own, but this interface allows
/// general utilities to be applied in a type-safe manner.
abstract class DockItemStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [DockLabel]'s `style` list.
///
/// `DockLabel` has no unique modifiers of its own, but this interface allows
/// general utilities to be applied in a type-safe manner.
abstract class DockLabelStyling implements Styling {}

// --- Concrete Style Classes ---

/// Defines specific styling options for a [Dock] container component, such as its size.
///
/// This is the concrete implementation class for dock-specific modifiers. It
/// implements the [DockStyling] interface, making it a valid type for the
/// `style` property of a [Dock] component.
class DockStyle extends ComponentStyle<DockStyle>
    with Breakpoints<DockStyle>
    implements DockStyling {
  /// Constructs a [DockStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "dock-lg").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const DockStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [DockStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  DockStyle create(List<PrefixModifier> modifiers) {
    return DockStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// Defines specific styling options for a [DockItem] component.
///
/// Currently, `DockItem` has no unique modifiers (the `active` state is a prop),
/// but this class provides architectural consistency and future extensibility.
class DockItemStyle extends ComponentStyle<DockItemStyle>
    with Breakpoints<DockItemStyle>
    implements DockItemStyling {
  /// Constructs a [DockItemStyle].
  const DockItemStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  DockItemStyle create(List<PrefixModifier> modifiers) {
    return DockItemStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// Defines specific styling options for a [DockLabel] component.
///
/// Currently, `DockLabel` has no unique modifiers, but this class provides
/// architectural consistency and future extensibility.
class DockLabelStyle extends ComponentStyle<DockLabelStyle>
    with Breakpoints<DockLabelStyle>
    implements DockLabelStyling {
  /// Constructs a [DockLabelStyle].
  const DockLabelStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  DockLabelStyle create(List<PrefixModifier> modifiers) {
    return DockLabelStyle(cssClass, type: type, modifiers: modifiers);
  }
}
