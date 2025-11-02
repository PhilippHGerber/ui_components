import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'accordion.dart';

/// A marker interface for any utility that can be passed to an [AccordionItem]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like `AccordionStyle`) and applicable general utilities can implement this interface.
abstract class AccordionStyling implements Styling {}

/// Defines specific styling options for an [AccordionItem] component, such as adding
/// an arrow or a plus/minus icon.
///
/// Implements the [AccordionStyling] interface, making it a valid type for the
/// `style` property of an [AccordionItem].
class AccordionStyle extends ComponentStyle<AccordionStyle>
    with Breakpoints<AccordionStyle>
    implements AccordionStyling {
  /// Constructs an [AccordionStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "collapse-arrow").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive or state-based styling.
  const AccordionStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [AccordionStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  AccordionStyle create(List<PrefixModifier> modifiers) {
    return AccordionStyle(cssClass, type: type, modifiers: modifiers);
  }
}
