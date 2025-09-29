import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'table.dart';

/// A marker interface for any utility that can be passed to a [Table]'s `style` list.
///
/// This allows for type-safe application of styles for zebra-striping, pinning, and sizing.
abstract class TableStyling implements Styling {}

/// Defines specific styling options for a [Table] component.
///
/// This is the concrete implementation class for table-specific modifiers.
/// It implements the [TableStyling] interface, making it a valid type for the
/// `style` property of a [Table] component.
class TableStyle extends ComponentStyle<TableStyle>
    with Breakpoints<TableStyle>
    implements TableStyling {
  /// Constructs a [TableStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "table-zebra").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const TableStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  TableStyle create(List<PrefixModifier> modifiers) {
    return TableStyle(cssClass, type: type, modifiers: modifiers);
  }
}
