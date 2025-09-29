import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import 'table_style.dart';

/// A component for displaying tabular data, rendering a `<table>` element.
///
/// `Table` acts as a container for standard Jaspr table elements like `thead`,
/// `tbody`, `tr`, `th`, and `td`.
///
/// **Important Usage Notes:**
///
/// 1.  **Responsiveness:** For tables to be responsive on small screens, you **must**
///     wrap the `Table` component in a container that provides horizontal scrolling.
///     The recommended approach is to use a `div` with the `overflow-x-auto` class
///     or a `deepyr` `Container` with the `[Layout.overflowXAuto]` style.
///
/// 2.  **Row Styling:** To style individual rows (e.g., for active or hover states),
///     apply general-purpose `deepyr` utilities directly to the `classes` property
///     of Jaspr's primitive `tr()` component using the `.toClasses()` extension.
///
/// Example:
/// ```dart
/// Container(
///   style: [Layout.overflowXAuto],
///   [
///     Table(
///       style: [Table.zebra, Table.sm],
///       [
///         thead([...]),
///         tbody([
///           tr(classes: [BgUtil.base200].toClasses(), [ // Active row
///             // ... cells
///           ]),
///           tr(classes: [BgUtil.base300.on(Is.hover)].toClasses(), [ // Hoverable row
///             // ... cells
///           ]),
///         ]),
///       ],
///     ),
///   ],
/// )
/// ```
class Table extends UiComponent {
  /// Creates a Table component.
  ///
  /// - [children]: The content of the table, which should be composed of
  ///   `thead`, `tbody`, and `tfoot` elements.
  /// - [tag]: The HTML tag for the root element, defaults to 'table'.
  /// - [style]: A list of [TableStyling] instances for modifiers like
  ///   `Table.zebra` or size variants.
  /// - Other parameters are inherited from [UiComponent].
  const Table(
    super.children, {
    super.tag = 'table',
    List<TableStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'table';

  @override
  Table copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Table(
      children,
      tag: tag,
      style: style as List<TableStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Adds zebra striping to table rows. `table-zebra`
  static const TableStyle zebra = TableStyle('table-zebra', type: StyleType.style);

  /// Makes `<thead>` and `<tfoot>` rows sticky. `table-pin-rows`
  static const TableStyle pinRows = TableStyle('table-pin-rows', type: StyleType.additional);

  /// Makes `<th>` columns sticky. `table-pin-cols`
  static const TableStyle pinCols = TableStyle('table-pin-cols', type: StyleType.additional);

  /// Extra small table size. `table-xs`
  static const TableStyle xs = TableStyle('table-xs', type: StyleType.sizing);

  /// Small table size. `table-sm`
  static const TableStyle sm = TableStyle('table-sm', type: StyleType.sizing);

  /// Medium table size (default). `table-md`
  static const TableStyle md = TableStyle('table-md', type: StyleType.sizing);

  /// Large table size. `table-lg`
  static const TableStyle lg = TableStyle('table-lg', type: StyleType.sizing);

  /// Extra large table size. `table-xl`
  static const TableStyle xl = TableStyle('table-xl', type: StyleType.sizing);
}
