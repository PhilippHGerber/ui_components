import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import 'stats_style.dart';

/// A container for showing numbers and data in a block. It groups multiple [Stat] components.
///
/// It can be styled to lay out its children vertically or horizontally, including
/// responsive variations.
class Stats extends UiComponent {
  /// Creates a container for `Stat` components.
  ///
  /// - [children]: The content, which should be a list of [Stat] components.
  /// - [style]: A list of [StatsStyling] instances, including directional modifiers
  ///   like `Stats.vertical` and general utilities like `Effects.shadow`.
  /// - Other parameters are inherited from [UiComponent].
  const Stats(
    super.children, {
    super.tag = 'div',
    List<StatsStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'stats';

  @override
  Stats copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Stats(
      children,
      tag: tag,
      style: style as List<StatsStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Arranges stat items vertically. `stats-vertical`
  static const StatsStyle vertical = StatsStyle('stats-vertical', type: StyleType.layout);

  /// Arranges stat items horizontally (default). `stats-horizontal`
  static const StatsStyle horizontal = StatsStyle('stats-horizontal', type: StyleType.layout);
}

/// A single block to display statistical data about a topic.
///
/// This component is a container for the individual parts of a statistic, such as
/// [StatTitle], [StatValue], and [StatFigure]. It has no unique modifiers of its
/// own; styling (like background color or alignment) is applied using general
/// utilities in the `style` property.
class Stat extends UiComponent {
  /// Creates a single Stat component.
  ///
  /// - [children]: The content, composed of `StatTitle`, `StatValue`, etc.
  /// - [style]: A list of general utilities like `Alignment.placeItemsCenter`
  ///   or `BgUtil.base200`.
  /// - Other parameters are inherited from [UiComponent].
  const Stat(
    super.children, {
    super.tag = 'div',
    List<StatStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'stat';

  @override
  Stat copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Stat(
      children,
      tag: tag,
      style: style as List<StatStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}

/// The title part of a [Stat] component (e.g., "Total Likes").
class StatTitle extends UiComponent {
  /// Creates the title part of a [Stat] component.
  ///
  /// - [children]: The text or other content for the title.
  /// - [tag]: The HTML tag to use for the component, defaults to 'div'.
  /// - [style]: A list of [StatTitleStyling] to apply.
  /// - [key]: A [Key] to uniquely identify this widget.
  const StatTitle(super.children, {super.tag = 'div', List<StatTitleStyling>? style, super.key})
    : super(style: style);

  @override
  String get baseClass => 'stat-title';

  @override
  StatTitle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return StatTitle(
      children,
      tag: tag,
      style: style as List<StatTitleStyling>?,
      key: key ?? this.key,
    );
  }
}

/// The main value part of a [Stat] component (e.g., "25.6K").
class StatValue extends UiComponent {
  /// Creates the value part of a [Stat] component.
  ///
  /// - [children]: The text or other content for the value.
  /// - [tag]: The HTML tag to use for the component, defaults to 'div'.
  /// - [style]: A list of [StatValueStyling] to apply.
  /// - [key]: A [Key] to uniquely identify this widget.
  const StatValue(super.children, {super.tag = 'div', List<StatValueStyling>? style, super.key})
    : super(style: style);

  @override
  String get baseClass => 'stat-value';

  @override
  StatValue copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return StatValue(
      children,
      tag: tag,
      style: style as List<StatValueStyling>?,
      key: key ?? this.key,
    );
  }
}

/// The description part of a [Stat] component (e.g., "21% more than last month").
class StatDesc extends UiComponent {
  /// Creates the description part of a [Stat] component.
  ///
  /// - [children]: The text or other content for the description.
  /// - [tag]: The HTML tag to use for the component, defaults to 'div'.
  /// - [style]: A list of [StatDescStyling] to apply.
  /// - [key]: A [Key] to uniquely identify this widget.
  const StatDesc(super.children, {super.tag = 'div', List<StatDescStyling>? style, super.key})
    : super(style: style);

  @override
  String get baseClass => 'stat-desc';

  @override
  StatDesc copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return StatDesc(
      children,
      tag: tag,
      style: style as List<StatDescStyling>?,
      key: key ?? this.key,
    );
  }
}

/// The figure/icon part of a [Stat] component.
class StatFigure extends UiComponent {
  /// Creates the figure/icon part of a [Stat] component.
  ///
  /// - [children]: The icon or other visual content.
  /// - [tag]: The HTML tag to use for the component, defaults to 'div'.
  /// - [style]: A list of [StatFigureStyling] to apply.
  /// - [key]: A [Key] to uniquely identify this widget.
  const StatFigure(super.children, {super.tag = 'div', List<StatFigureStyling>? style, super.key})
    : super(style: style);

  @override
  String get baseClass => 'stat-figure';

  @override
  StatFigure copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return StatFigure(
      children,
      tag: tag,
      style: style as List<StatFigureStyling>?,
      key: key ?? this.key,
    );
  }
}

/// The actions part of a [Stat] component, for buttons or other interactive elements.
class StatActions extends UiComponent {
  /// Creates the actions part of a [Stat] component.
  ///
  /// - [children]: The buttons or other interactive elements.
  /// - [tag]: The HTML tag to use for the component, defaults to 'div'.
  /// - [style]: A list of [StatActionsStyling] to apply.
  /// - [key]: A [Key] to uniquely identify this widget.
  const StatActions(super.children, {super.tag = 'div', List<StatActionsStyling>? style, super.key})
    : super(style: style);

  @override
  String get baseClass => 'stat-actions';

  @override
  StatActions copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return StatActions(
      children,
      tag: tag,
      style: style as List<StatActionsStyling>?,
      key: key ?? this.key,
    );
  }
}
