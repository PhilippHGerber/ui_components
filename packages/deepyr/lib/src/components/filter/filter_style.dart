import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'filter.dart';

/// A marker interface for any utility that can be passed to a [Filter]'s `style` list.
///
/// `Filter` has no component-specific modifiers of its own; this interface is used
/// to allow general utilities (like `Size`, `Effects`, etc.) to be applied to the
/// main container in a type-safe manner.
abstract class FilterStyling implements Styling {}

/// Defines specific styling options for a [Filter] component.
///
/// This is the concrete implementation class for filter-specific modifiers. It
/// implements the [FilterStyling] interface, making it a valid type for the
/// `style` property of a [Filter] component.
///
/// Currently, there are no predefined static modifiers for `Filter`, but this
/// class provides a consistent and extensible structure for the library.
class FilterStyle extends ComponentStyle<FilterStyle>
    with Breakpoints<FilterStyle>
    implements FilterStyling {
  /// Constructs a [FilterStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const FilterStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [FilterStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  FilterStyle create(List<PrefixModifier> modifiers) {
    return FilterStyle(cssClass, type: type, modifiers: modifiers);
  }
}
