import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'collapse.dart' show Collapse;

/// A marker interface for any utility that can be passed to a [Collapse]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like [CollapseStyle]) and applicable general utilities can implement this interface.
abstract class CollapseStyling implements Styling {}

/// Defines specific styling options for a [Collapse] component, such as adding
/// an icon or forcing its state.
///
/// This is the concrete implementation class for collapse-specific modifiers.
/// It implements the [CollapseStyling] interface, making it a valid type for the
/// `style` property of a [Collapse] component.
class CollapseStyle extends ComponentStyle<CollapseStyle>
    with Breakpoints<CollapseStyle>
    implements CollapseStyling {
  /// Constructs a [CollapseStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "collapse-arrow").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive or state-based styling.
  const CollapseStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [CollapseStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  CollapseStyle create(List<PrefixModifier> modifiers) {
    return CollapseStyle(cssClass, type: type, modifiers: modifiers);
  }
}
