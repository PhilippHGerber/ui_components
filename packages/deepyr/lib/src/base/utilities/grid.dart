import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying CSS Grid layout styles.
///
/// This class provides a comprehensive, type-safe API for controlling grid
/// layout properties, including template columns/rows, column/row spanning,
/// auto flow, and auto columns/rows.
///
/// To create a grid container, first apply the `Layout.grid` utility to a
/// component. Then, use the utilities from this `Grid` class to define its
/// structure.
///
/// Note: Spacing between grid items is controlled by the `Layout.gap()`,
/// `Layout.gapX()`, and `Layout.gapY()` utilities, as `gap` is a property
/// shared by both Grid and Flexbox layouts.
class Grid extends CommonStyle<Grid> {
  /// Creates a Grid utility class.
  /// This constructor is used internally by the static factories.
  const Grid(super.cssClass, {super.modifiers}) : super(type: StyleType.layout);

  // --- Grid Template Columns ---

  /// Sets `grid-template-columns: none`, resetting any explicit column definitions.
  ///
  /// See: https://tailwindcss.com/docs/grid-template-columns
  static const Grid colsNone = Grid('grid-cols-none');

  /// Sets `grid-template-columns: subgrid`, allowing the grid to adopt the
  /// column tracks of its parent grid.
  ///
  /// See: https://tailwindcss.com/docs/grid-template-columns#subgrid
  static const Grid colsSubgrid = Grid('grid-cols-subgrid');

  /// Creates a `grid-cols-{count}` utility for a grid with a specified
  /// number of equal-width columns.
  ///
  /// [count]: The number of columns, from 1 to 12.
  ///
  /// See: https://tailwindcss.com/docs/grid-template-columns
  static Grid cols(int count) {
    assert(count >= 1 && count <= 12, 'Column count must be between 1 and 12.');
    return Grid('grid-cols-$count');
  }

  /// Creates a grid with a custom column template using arbitrary values.
  ///
  /// This is useful for complex layouts not covered by the standard 1-12 columns.
  /// The [value] should be a valid CSS `grid-template-columns` value, without spaces.
  ///
  /// Example: `Grid.colsCustom('repeat(auto-fit,minmax(10rem,1fr))')`
  ///
  /// See: https://tailwindcss.com/docs/grid-template-columns#arbitrary-values
  static Grid colsCustom(String value) => Grid('grid-cols-[$value]');

  // --- Grid Column Start / End ---

  /// Sets `grid-column: auto`.
  ///
  /// See: https://tailwindcss.com/docs/grid-column
  static const Grid colAuto = Grid('col-auto');

  /// Creates a `col-span-{count}` utility, making an item span a specific
  /// number of columns.
  ///
  /// [count]: The number of columns to span, from 1 to 12.
  ///
  /// See: https://tailwindcss.com/docs/grid-column#spanning-columns
  static Grid colSpan(int count) {
    assert(count >= 1 && count <= 12, 'Column span must be between 1 and 12.');
    return Grid('col-span-$count');
  }

  /// Sets `col-span-full`, making an item span all columns of the grid.
  ///
  /// See: https://tailwindcss.com/docs/grid-column#spanning-columns
  static const Grid colSpanFull = Grid('col-span-full');

  /// Creates a `col-start-{line}` utility, making an item start at a specific
  /// grid column line.
  ///
  /// [line]: The starting grid line, from 1 to 13.
  ///
  /// See: https://tailwindcss.com/docs/grid-column#starting-and-ending-lines
  static Grid colStart(int line) {
    assert(line >= 1 && line <= 13, 'Column start line must be between 1 and 13.');
    return Grid('col-start-$line');
  }

  /// Sets `grid-column-start: auto`.
  static const Grid colStartAuto = Grid('col-start-auto');

  /// Creates a `col-end-{line}` utility, making an item end at a specific
  /// grid column line.
  ///
  /// [line]: The ending grid line, from 1 to 13.
  ///
  /// See: https://tailwindcss.com/docs/grid-column#starting-and-ending-lines
  static Grid colEnd(int line) {
    assert(line >= 1 && line <= 13, 'Column end line must be between 1 and 13.');
    return Grid('col-end-$line');
  }

  /// Sets `grid-column-end: auto`.
  static const Grid colEndAuto = Grid('col-end-auto');

  // --- Grid Template Rows ---

  /// Sets `grid-template-rows: none`, resetting any explicit row definitions.
  ///
  /// See: https://tailwindcss.com/docs/grid-template-rows
  static const Grid rowsNone = Grid('grid-rows-none');

  /// Sets `grid-template-rows: subgrid`, allowing the grid to adopt the
  /// row tracks of its parent grid.
  ///
  /// See: https://tailwindcss.com/docs/grid-template-rows#subgrid
  static const Grid rowsSubgrid = Grid('grid-rows-subgrid');

  /// Creates a `grid-rows-{count}` utility for a grid with a specified
  /// number of equal-height rows.
  ///
  /// [count]: The number of rows, from 1 to 12.
  ///
  /// See: https://tailwindcss.com/docs/grid-template-rows
  static Grid rows(int count) {
    assert(count >= 1 && count <= 12, 'Row count must be between 1 and 12.');
    return Grid('grid-rows-$count');
  }

  /// Creates a grid with a custom row template using arbitrary values.
  ///
  /// The [value] should be a valid CSS `grid-template-rows` value, without spaces.
  ///
  /// Example: `Grid.rowsCustom('[200px,minmax(900px,1fr),100px]')`
  ///
  /// See: https://tailwindcss.com/docs/grid-template-rows#arbitrary-values
  static Grid rowsCustom(String value) => Grid('grid-rows-[$value]');

  // --- Grid Row Start / End ---

  /// Sets `grid-row: auto`.
  ///
  /// See: https://tailwindcss.com/docs/grid-row
  static const Grid rowAuto = Grid('row-auto');

  /// Creates a `row-span-{count}` utility, making an item span a specific
  /// number of rows.
  ///
  /// [count]: The number of rows to span, from 1 to 12.
  ///
  /// See: https://tailwindcss.com/docs/grid-row#spanning-rows
  static Grid rowSpan(int count) {
    assert(count >= 1 && count <= 12, 'Row span must be between 1 and 12.');
    return Grid('row-span-$count');
  }

  /// Sets `row-span-full`, making an item span all rows of the grid.
  ///
  /// See: https://tailwindcss.com/docs/grid-row#spanning-rows
  static const Grid rowSpanFull = Grid('row-span-full');

  /// Creates a `row-start-{line}` utility, making an item start at a specific
  /// grid row line.
  ///
  /// [line]: The starting grid line, from 1 to 13.
  ///
  /// See: https://tailwindcss.com/docs/grid-row#starting-and-ending-lines
  static Grid rowStart(int line) {
    assert(line >= 1 && line <= 13, 'Row start line must be between 1 and 13.');
    return Grid('row-start-$line');
  }

  /// Sets `grid-row-start: auto`.
  static const Grid rowStartAuto = Grid('row-start-auto');

  /// Creates a `row-end-{line}` utility, making an item end at a specific
  /// grid row line.
  ///
  /// [line]: The ending grid line, from 1 to 13.
  ///
  /// See: https://tailwindcss.com/docs/grid-row#starting-and-ending-lines
  static Grid rowEnd(int line) {
    assert(line >= 1 && line <= 13, 'Row end line must be between 1 and 13.');
    return Grid('row-end-$line');
  }

  /// Sets `grid-row-end: auto`.
  static const Grid rowEndAuto = Grid('row-end-auto');

  // --- Grid Auto Flow ---

  /// Sets `grid-auto-flow: row`. Items are placed by filling each row.
  ///
  /// See: https://tailwindcss.com/docs/grid-auto-flow
  static const Grid flowRow = Grid('grid-flow-row');

  /// Sets `grid-auto-flow: column`. Items are placed by filling each column.
  static const Grid flowCol = Grid('grid-flow-col');

  /// Sets `grid-auto-flow: dense`. Uses a "dense" packing algorithm.
  static const Grid flowDense = Grid('grid-flow-dense');

  /// Sets `grid-auto-flow: row dense`.
  static const Grid flowRowDense = Grid('grid-flow-row-dense');

  /// Sets `grid-auto-flow: column dense`.
  static const Grid flowColDense = Grid('grid-flow-col-dense');

  // --- Grid Auto Columns ---

  /// Sets `grid-auto-columns: auto`. Columns are sized based on their content.
  ///
  /// See: https://tailwindcss.com/docs/grid-auto-columns
  static const Grid autoColsAuto = Grid('auto-cols-auto');

  /// Sets `grid-auto-columns: min-content`. Columns are sized to their minimum content size.
  static const Grid autoColsMin = Grid('auto-cols-min');

  /// Sets `grid-auto-columns: max-content`. Columns are sized to their maximum content size.
  static const Grid autoColsMax = Grid('auto-cols-max');

  /// Sets `grid-auto-columns: 1fr`. Columns share available space equally.
  static const Grid autoColsFr = Grid('auto-cols-fr');

  // --- Grid Auto Rows ---

  /// Sets `grid-auto-rows: auto`. Rows are sized based on their content.
  ///
  /// See: https://tailwindcss.com/docs/grid-auto-rows
  static const Grid autoRowsAuto = Grid('auto-rows-auto');

  /// Sets `grid-auto-rows: min-content`. Rows are sized to their minimum content size.
  static const Grid autoRowsMin = Grid('auto-rows-min');

  /// Sets `grid-auto-rows: max-content`. Rows are sized to their maximum content size.
  static const Grid autoRowsMax = Grid('auto-rows-max');

  /// Sets `grid-auto-rows: 1fr`. Rows share available space equally.
  static const Grid autoRowsFr = Grid('auto-rows-fr');

  @override
  Grid create(List<PrefixModifier> modifiers) {
    return Grid(cssClass, modifiers: modifiers);
  }
}
