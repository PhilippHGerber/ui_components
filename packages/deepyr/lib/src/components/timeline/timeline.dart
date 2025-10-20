import 'package:jaspr/jaspr.dart' hide Flex;

import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/styling_extensions.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'timeline_style.dart';

/// The content on the "start" side of a [TimelineItem] (left in vertical, top in horizontal).
class TimelineStart extends UiComponent {
  /// Creates the start content area for a timeline item.
  ///
  /// - [children]: The content to display.
  /// - [tag]: The HTML tag to render, defaults to 'div'.
  /// - [style]: A list of [TimelineContentStyling] instances, such as `TimelineStart.box`.
  const TimelineStart(
    super.children, {
    super.tag = 'div',
    List<TimelineContentStyling>? style,
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'timeline-start';

  /// Applies a box style to the content.
  static const TimelineContentStyle box = TimelineContentStyle(
    'timeline-box',
    type: StyleType.style,
  );

  @override
  TimelineStart copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return TimelineStart(
      children,
      tag: tag,
      style: style as List<TimelineContentStyling>?,
      classes: mergeClasses(this.classes, classes),
      attributes: attributes ?? componentAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// The content on the "end" side of a [TimelineItem] (right in vertical, bottom in horizontal).
class TimelineEnd extends UiComponent {
  /// Creates the end content area for a timeline item.
  ///
  /// - [children]: The content to display.
  /// - [tag]: The HTML tag to render, defaults to 'div'.
  /// - [style]: A list of [TimelineContentStyling] instances, such as `TimelineEnd.box`.
  const TimelineEnd(
    super.children, {
    super.tag = 'div',
    List<TimelineContentStyling>? style,
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'timeline-end';

  /// Applies a box style to the content.
  static const TimelineContentStyle box = TimelineContentStyle(
    'timeline-box',
    type: StyleType.style,
  );

  @override
  TimelineEnd copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return TimelineEnd(
      children,
      tag: tag,
      style: style as List<TimelineContentStyling>?,
      classes: mergeClasses(this.classes, classes),
      attributes: attributes ?? componentAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// The central icon or marker in a [TimelineItem].
class TimelineMiddle extends UiComponent {
  /// Creates the middle icon area for a timeline item.
  ///
  /// - [children]: The icon or element to display in the middle.
  /// - [tag]: The HTML tag to render, defaults to 'div'.
  const TimelineMiddle(
    super.children, {
    super.tag = 'div',
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super();

  @override
  String get baseClass => 'timeline-middle';

  @override
  TimelineMiddle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return TimelineMiddle(
      children,
      tag: tag,
      classes: mergeClasses(this.classes, classes),
      attributes: attributes ?? componentAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// A structural component representing a single event or item within a [Timeline].
///
/// This component renders an `<li>` and uses a "slot-based" API via its named
/// constructor parameters (`start`, `middle`, `end`) to ensure a correct and
/// readable structure. The connecting `<hr>` lines are managed automatically by the
/// parent [Timeline] component.
class TimelineItem extends UiComponent {
  /// Creates a single item for a [Timeline].
  ///
  /// - [start]: Optional content for the start side.
  /// - [middle]: Optional content for the middle (icon).
  /// - [end]: Optional content for the end side.
  /// - [startConnectorStyle]: A list of `Styling` utilities to apply to the starting `<hr>` connector.
  /// - [endConnectorStyle]: A list of `Styling` utilities to apply to the ending `<hr>` connector.
  /// - [showStartConnector]: Internal flag to control the visibility of the start connector.
  /// - [showEndConnector]: Internal flag to control the visibility of the end connector.
  /// - [classes]: Additional CSS classes to apply to the component.
  /// - [key]: A [Key] to uniquely identify this widget.
  TimelineItem({
    this.start,
    this.middle,
    this.end,
    this.startConnectorStyle,
    this.endConnectorStyle,
    bool showStartConnector = false,
    bool showEndConnector = false,
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : _showStartConnector = showStartConnector,
       _showEndConnector = showEndConnector,
       super([], tag: 'li');

  /// The content for the start side of the timeline item.
  final TimelineStart? start;

  /// The content for the middle icon/marker of the timeline item.
  final TimelineMiddle? middle;

  /// The content for the end side of the timeline item.
  final TimelineEnd? end;

  /// A list of `Styling` utilities to apply to the starting `<hr>` connector.
  final List<Styling>? startConnectorStyle;

  /// A list of `Styling` utilities to apply to the ending `<hr>` connector.
  final List<Styling>? endConnectorStyle;

  // Internal flags controlled by the parent `Timeline` component.
  final bool _showStartConnector;
  final bool _showEndConnector;

  @override
  String get baseClass => '';

  @override
  Component build(BuildContext context) {
    final kids = <Component>[];
    if (_showStartConnector) kids.add(hr(classes: startConnectorStyle.toClasses()));
    if (start != null) kids.add(start!);
    if (middle != null) kids.add(middle!);
    if (end != null) kids.add(end!);
    if (_showEndConnector) kids.add(hr(classes: endConnectorStyle.toClasses()));

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: kids,
    );
  }

  @override
  TimelineItem copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    TimelineStart? start,
    TimelineMiddle? middle,
    TimelineEnd? end,
    List<Styling>? startConnectorStyle,
    List<Styling>? endConnectorStyle,
    bool? showStartConnector,
    bool? showEndConnector,
  }) {
    return TimelineItem(
      start: start ?? this.start,
      middle: middle ?? this.middle,
      end: end ?? this.end,
      startConnectorStyle: startConnectorStyle ?? this.startConnectorStyle,
      endConnectorStyle: endConnectorStyle ?? this.endConnectorStyle,
      showStartConnector: showStartConnector ?? _showStartConnector,
      showEndConnector: showEndConnector ?? _showEndConnector,
      classes: mergeClasses(this.classes, classes),
      attributes: attributes ?? componentAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// A "smart container" that displays a list of events in chronological order.
///
/// It renders a `<ul>` and automatically manages the connecting lines between
/// its `TimelineItem` children, providing a clean and declarative API.
class Timeline extends UiComponent {
  /// Creates a Timeline container.
  ///
  /// - [children]: A list of [TimelineItem] components.
  /// - [style]: A list of [TimelineStyling] modifiers for layout and behavior.
  const Timeline(
    super.children, {
    List<TimelineStyling>? style,
    super.id,
    super.css,
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(tag: 'ul', style: style);

  @override
  String get baseClass => 'timeline';

  // --- Static Modifiers ---

  /// Arranges items in a vertical layout.
  static const TimelineStyle vertical = TimelineStyle('timeline-vertical', type: StyleType.layout);

  /// Arranges items in a horizontal layout (default).
  static const TimelineStyle horizontal = TimelineStyle(
    'timeline-horizontal',
    type: StyleType.layout,
  );

  /// Snaps the middle icon to the start of the content area.
  static const TimelineStyle snapIcon = TimelineStyle('timeline-snap-icon', type: StyleType.layout);

  /// Forces all content to one side in vertical mode. Can be made responsive.
  /// Example: `Timeline.compact.below(Breakpoint.md)`
  static const TimelineStyle compact = TimelineStyle('timeline-compact', type: StyleType.layout);

  /// Overrides the default build method to become a "smart container".
  /// This method iterates through its `TimelineItem` children and intelligently
  /// injects the properties needed to render the connecting `<hr>` lines.
  @override
  Component build(BuildContext context) {
    // Filter for only TimelineItem children to ensure correct processing.
    final items = children?.whereType<TimelineItem>().toList() ?? [];
    final finalChildren = <Component>[];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      // Create a new instance of TimelineItem, passing the original content
      // but injecting the calculated connector visibility.
      finalChildren.add(
        item.copyWith(
          showStartConnector: i > 0,
          showEndConnector: i < items.length - 1,
        ),
      );
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: finalChildren,
    );
  }

  @override
  Timeline copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Timeline(
      children,
      style: style as List<TimelineStyling>?,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? componentAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
