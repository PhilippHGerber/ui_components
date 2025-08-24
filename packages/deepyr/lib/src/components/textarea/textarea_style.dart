import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'textarea.dart';

/// A marker interface for any utility that can be passed to a [Textarea]'s `style` list.
///
/// This allows for type-safe application of styles for colors, sizes, and variants.
abstract class TextareaStyling implements Styling {}

/// Defines specific styling options for a [Textarea] component.
///
/// This is the concrete implementation class for textarea-specific modifiers.
/// It implements the [TextareaStyling] interface, making it a valid type for the
/// `style` property of a [Textarea] component.
class TextareaStyle extends ComponentStyle<TextareaStyle>
    with Breakpoints<TextareaStyle>
    implements TextareaStyling {
  /// Constructs a [TextareaStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "textarea-bordered").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const TextareaStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [TextareaStyle] with the provided modifiers.
  @override
  TextareaStyle create(List<PrefixModifier> modifiers) {
    return TextareaStyle(cssClass, type: type, modifiers: modifiers);
  }
}
