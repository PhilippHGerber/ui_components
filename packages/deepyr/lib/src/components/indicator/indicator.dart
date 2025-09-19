import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../../deepyr.dart' show Badge;
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../badge/badge.dart' show Badge;
import 'indicator_style.dart';

/// A component to place a badge or item on the corner of another element.
///
/// The `Indicator` component wraps both the main content and the indicator item.
/// The indicator item itself should be wrapped in an [IndicatorItem] component.
class Indicator extends UiComponent {
  /// Creates an Indicator container.
  ///
  /// - [children]: The content, which should include the main element and one or
  ///   more [IndicatorItem]s.
  /// - [style]: A list of [IndicatorStyling] modifiers to control the
  ///   default position of all indicator items within it.
  /// - Other parameters are inherited from [UiComponent].
  const Indicator(
    super.children, {
    super.tag = 'div',
    List<IndicatorStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'indicator';

  @override
  Indicator copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Indicator(
      children,
      tag: tag,
      style: style as List<IndicatorStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
  // --- Static Style Modifiers ---
  // These can be applied to the Indicator container to set the default
  // position for all IndicatorItems within it.

  /// Positions items at the horizontal start. `indicator-start`
  static const IndicatorStyle start = IndicatorStyle('indicator-start', type: StyleType.layout);

  /// Positions items at the horizontal center. `indicator-center`
  static const IndicatorStyle center = IndicatorStyle('indicator-center', type: StyleType.layout);

  /// Positions items at the horizontal end. `indicator-end`
  static const IndicatorStyle end = IndicatorStyle('indicator-end', type: StyleType.layout);

  /// Positions items at the vertical top. `indicator-top`
  static const IndicatorStyle top = IndicatorStyle('indicator-top', type: StyleType.layout);

  /// Positions items at the vertical middle. `indicator-middle`
  static const IndicatorStyle middle = IndicatorStyle('indicator-middle', type: StyleType.layout);

  /// Positions items at the vertical bottom. `indicator-bottom`
  static const IndicatorStyle bottom = IndicatorStyle('indicator-bottom', type: StyleType.layout);
}

/// An item, such as a [Badge], to be placed on the corner of an element
/// within an [Indicator] container.
///
/// This component applies the `indicator-item` class and can be styled with
/// positional modifiers to override the parent [Indicator]'s settings.
class IndicatorItem extends UiComponent {
  /// Creates an IndicatorItem.
  ///
  /// - [children] or [child]: The component to display as the indicator (e.g., a `Badge`).
  /// - [style]: A list of [IndicatorItemStyling] modifiers to control its position.
  /// - Other parameters are inherited from [UiComponent].
  const IndicatorItem(
    super.children, {
    super.tag = 'div',
    List<IndicatorItemStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'indicator-item';

  /// Computes the combined string of CSS classes.
  ///
  /// This overridden method makes the component "smart". It automatically adds
  /// flexbox centering classes if the user provides `IndicatorItem.middle` or
  /// `IndicatorItem.center` styles, abstracting away the implementation detail.
  @override
  String get combinedClasses {
    final baseClasses = <String>[baseClass];
    final utilityClasses = <String>[];
    var hasMiddle = false;
    var hasCenter = false;

    // Process all style modifiers provided by the user.
    if (style != null) {
      for (final s in style!) {
        final sClass = s.toString();
        utilityClasses.add(sClass);
        // Check if any of the styles (including responsive ones) contain
        // the keywords for middle or center positioning.
        if (sClass.contains('indicator-middle')) hasMiddle = true;
        if (sClass.contains('indicator-center')) hasCenter = true;
      }
    }

    // If a middle or center alignment is requested, automatically add
    // the necessary flexbox classes for perfect centering.
    if (hasMiddle || hasCenter) {
      baseClasses.add('flex');
      if (hasMiddle) baseClasses.add('items-center');
      if (hasCenter) baseClasses.add('justify-center');
    }

    // Combine all class groups.
    return <String>[
      ...baseClasses,
      ...utilityClasses,
      if (classes != null) classes!,
    ].where((c) => c.isNotEmpty).join(' ');
  }

  @override
  IndicatorItem copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return IndicatorItem(
      children,
      tag: tag,
      style: style as List<IndicatorItemStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
  // --- Static Style Modifiers ---
  // These can be applied to an IndicatorItem to override the parent Indicator's position.

  /// Positions the item at the horizontal start. `indicator-start`
  static const IndicatorItemStyle start =
      IndicatorItemStyle('indicator-start', type: StyleType.layout);

  /// Positions the item at the horizontal center. `indicator-center`
  static const IndicatorItemStyle center =
      IndicatorItemStyle('indicator-center', type: StyleType.layout);

  /// Positions the item at the horizontal end. `indicator-end`
  static const IndicatorItemStyle end = IndicatorItemStyle('indicator-end', type: StyleType.layout);

  /// Positions the item at the vertical top. `indicator-top`
  static const IndicatorItemStyle top = IndicatorItemStyle('indicator-top', type: StyleType.layout);

  /// Positions the item at the vertical middle. `indicator-middle`
  static const IndicatorItemStyle middle =
      IndicatorItemStyle('indicator-middle', type: StyleType.layout);

  /// Positions the item at the vertical bottom. `indicator-bottom`
  static const IndicatorItemStyle bottom =
      IndicatorItemStyle('indicator-bottom', type: StyleType.layout);
}
