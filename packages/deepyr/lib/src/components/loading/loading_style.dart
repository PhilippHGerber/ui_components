import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'loading.dart';

/// A marker interface for any utility that can be passed to a [Loading]'s `style` list.
///
/// This allows for type-safe application of styles for animation type and size.
/// Note that color is applied via general text utilities like `TextUtil.primary`.
abstract class LoadingStyling implements Styling {}

/// Defines specific styling options for a [Loading] component.
///
/// This is the concrete implementation class for loading-specific modifiers.
/// It implements the [LoadingStyling] interface, making it a valid type for the
/// `style` property of a [Loading] component.
class LoadingStyle extends ComponentStyle<LoadingStyle>
    with Breakpoints<LoadingStyle>
    implements LoadingStyling {
  /// Constructs a [LoadingStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "loading-spinner").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const LoadingStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [LoadingStyle] with the provided modifiers.
  @override
  LoadingStyle create(List<PrefixModifier> modifiers) {
    return LoadingStyle(cssClass, type: type, modifiers: modifiers);
  }
}
