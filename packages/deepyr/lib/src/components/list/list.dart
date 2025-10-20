import 'package:jaspr/jaspr.dart' show Component, Key, Styles;
import 'package:jaspr/ui.dart' show BuildContext;

import '../../../deepyr.dart' show Flex;
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'list_style.dart';

/// The main container for a list, typically rendering as a `<ul>` or `<div>`.
/// It should contain one or more [ListRow] components.
class Listing extends UiComponent {
  /// Creates a Listing container.
  ///
  /// - [children]: The content, which should be a list of [ListRow] components.
  /// - [style]: A list of [ListingStyling] modifiers, like `Listing.itemBorder`.
  const Listing(
    super.children, {
    super.tag = 'ul',
    List<ListingStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'list';

  @override
  Listing copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Listing(
      children,
      tag: tag,
      style: style as List<ListingStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Adds a border between each [ListRow]. `list-item-border`
  static const ListingStyle itemBorder = ListingStyle('list-item-border', type: StyleType.border);
}

/// A wrapper for content within a [ListRow] to define a column.
/// This component supports layout modifiers to control its behavior within the row.
class ListCol extends UiComponent {
  /// Creates a column within a ListRow.
  ///
  /// - [children]: The content of the column (e.g., an `Avatar`, `text`, `Button`).
  /// - [style]: A list of [ListColStyling] modifiers like `ListCol.grow` or
  ///   general utilities like `Size.w16`.
  const ListCol(
    super.children, {
    super.tag = 'div',
    List<ListColStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  // A ListCol itself has no base class. Its modifiers add classes.
  @override
  String get baseClass => '';

  @override
  ListCol copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    // Allow style to be injected by the parent (ListRow).
    List<ListColStyling>? style,
  }) {
    return ListCol(
      children,
      tag: tag,
      style: style ?? this.style as List<ListColStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Allows the column to grow and fill available space. `list-col-grow`
  static const ListColStyle grow = ListColStyle('list-col-grow', type: StyleType.layout);

  /// Allows columns within the row to wrap to the next line. `list-col-wrap`
  static const ListColStyle wrap = ListColStyle('list-col-wrap', type: StyleType.layout);

  /// Prevents the column from shrinking.
  static const ListColStyling shrink0 = Flex.shrink0;

  /// Creates a column that spans a specific number of grid tracks. `list-col-span-`
  static ListColStyle span(int count) =>
      ListColStyle('list-col-span-$count', type: StyleType.layout);
}

/// Represents a single row within a [Listing], typically rendering as an `<li>`.
/// It acts as a "smart container" for [ListCol] components, automatically
/// applying DaisyUI's default layout behavior.
class ListRow extends UiComponent {
  /// Creates a single ListRow.
  ///
  /// - [children]: The content, which should be a list of [ListCol] components
  ///   to define the columnar layout.
  /// - [style]: A list of general utilities for styling, like hover effects.
  const ListRow(
    super.children, {
    super.tag = 'li',
    List<ListRowStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'list-row';

  @override
  ListRow copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ListRow(
      children,
      tag: tag,
      style: style as List<ListRowStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  /// The `build` method is overridden to make this a "smart container".
  ///
  /// It automatically applies the `list-col-grow` style to the second `ListCol` child
  /// if no other child has been explicitly given a `.grow` modifier. This perfectly
  /// mimics DaisyUI's default behavior, providing an intuitive API.
  @override
  Component build(BuildContext context) {
    var effectiveChildren = children ?? [?child];

    // Check if any child already has the `grow` modifier.
    final hasExplicitGrow = effectiveChildren.any(
      (c) => c is ListCol && (c.style?.any((s) => s.toString() == ListCol.grow.cssClass) ?? false),
    );

    // If no explicit grow is found, apply it to the second ListCol.
    if (!hasExplicitGrow) {
      var listColIndex = -1;
      var childIndexToModify = -1;

      for (var i = 0; i < effectiveChildren.length; i++) {
        if (effectiveChildren[i] is ListCol) {
          listColIndex++;
          if (listColIndex == 1) {
            // This is the second ListCol
            childIndexToModify = i;
            break;
          }
        }
      }

      if (childIndexToModify != -1) {
        final targetChild = effectiveChildren[childIndexToModify] as ListCol;
        final newStyles = [...?(targetChild.style as List<ListColStyling>?), ListCol.grow];

        final newChildren = List<Component>.from(effectiveChildren);
        newChildren[childIndexToModify] = targetChild.copyWith(style: newStyles);
        effectiveChildren = newChildren;
      }
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: events,
      children: effectiveChildren,
    );
  }
}
