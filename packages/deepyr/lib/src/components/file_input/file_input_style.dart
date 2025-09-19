import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'file_input.dart';

/// A marker interface for any utility that can be passed to a [FileInput]'s `style` list.
///
/// This allows for type-safe application of styles for colors, sizes, and variants.
abstract class FileInputStyling implements Styling {}

/// Defines specific styling options for a [FileInput] component.
///
/// This is the concrete implementation class for file input-specific modifiers.
/// It implements the [FileInputStyling] interface, making it a valid type for the
/// `style` property of a [FileInput] component.
class FileInputStyle extends ComponentStyle<FileInputStyle>
    with Breakpoints<FileInputStyle>
    implements FileInputStyling {
  /// Constructs a [FileInputStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "file-input-primary").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const FileInputStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [FileInputStyle] with the provided modifiers.
  @override
  FileInputStyle create(List<PrefixModifier> modifiers) {
    return FileInputStyle(cssClass, type: type, modifiers: modifiers);
  }
}
