import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'skeleton.dart';

/// A marker interface for any utility that can be passed to a [Skeleton]'s
/// `style` list.
///
/// This allows for type-safe application of styles. `Skeleton` has no specific
/// modifiers of its own, so this interface is primarily used to allow general
/// utilities (like `Size`, `Effects`, etc.) to be applied to it.
abstract class SkeletonStyling implements Styling {}

/// Defines specific styling options for a [Skeleton] component.
///
/// This is the concrete implementation class for skeleton-specific modifiers.
/// It implements the [SkeletonStyling] interface. Currently, there are no
/// predefined static modifiers for `Skeleton`, but this class provides a
/// consistent and extensible structure.
class SkeletonStyle extends ComponentStyle<SkeletonStyle>
    with Breakpoints<SkeletonStyle>
    implements SkeletonStyling {
  /// Constructs a [SkeletonStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const SkeletonStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [SkeletonStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  SkeletonStyle create(List<PrefixModifier> modifiers) {
    return SkeletonStyle(cssClass, type: type, modifiers: modifiers);
  }
}
