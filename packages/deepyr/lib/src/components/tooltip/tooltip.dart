import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'tooltip_style.dart';

/// A component that shows a message when hovering over an element.
///
/// It acts as a wrapper around the trigger element. The tooltip's content can
/// be provided either as a simple string via the `tip` property (which uses the
/// `data-tip` attribute) or as rich HTML content via the `content` property,
/// which should be a [TooltipContent] component.
class Tooltip extends UiComponent {
  /// Creates a Tooltip component.
  ///
  /// - [children]: The trigger element(s) for the tooltip (e.g., a `Button`).
  /// - [tip]: A simple string to be displayed as the tooltip's content.
  /// - [content]: A [TooltipContent] component for rich HTML content.
  ///   You must provide either `tip` or `content`, but not both.
  /// - [style]: A list of [TooltipStyling] modifiers for color, placement, and behavior.
  /// - Other parameters are inherited from [UiComponent].
  const Tooltip(
    super.children, {
    this.tip,
    this.content,
    super.tag = 'div',
    List<TooltipStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : assert(
         tip == null || content == null,
         'Cannot provide both a text `tip` and rich `content` for a Tooltip.',
       ),
       super(style: style);

  /// The text content to display in the tooltip. This will be rendered
  /// to the `data-tip` attribute.
  final String? tip;

  /// A component, typically [TooltipContent], that holds rich HTML for the tooltip.
  final Component? content;

  @override
  String get baseClass => 'tooltip';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (tip != null) {
      attributes.add('data-tip', tip!);
    }
  }

  @override
  Component build(BuildContext context) {
    final effectiveChildren = <Component>[];
    if (content != null) {
      effectiveChildren.add(content!);
    }
    if (children != null) {
      effectiveChildren.addAll(children!);
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
      children: effectiveChildren,
    );
  }

  @override
  Tooltip copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Tooltip(
      children,
      tip: tip,
      content: content,
      tag: tag,
      style: style as List<TooltipStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Forces the tooltip to be always visible. `tooltip-open`
  static const TooltipStyle open = TooltipStyle('tooltip-open', type: StyleType.state);

  // Placement
  /// Positions the tooltip on the top. `tooltip-top` (Default)
  static const TooltipStyle top = TooltipStyle('tooltip-top', type: StyleType.layout);

  /// Positions the tooltip on the bottom. `tooltip-bottom`
  static const TooltipStyle bottom = TooltipStyle('tooltip-bottom', type: StyleType.layout);

  /// Positions the tooltip on the left. `tooltip-left`
  static const TooltipStyle left = TooltipStyle('tooltip-left', type: StyleType.layout);

  /// Positions the tooltip on the right. `tooltip-right`
  static const TooltipStyle right = TooltipStyle('tooltip-right', type: StyleType.layout);

  // Colors
  /// Neutral color. `tooltip-neutral`
  static const TooltipStyle neutral = TooltipStyle('tooltip-neutral', type: StyleType.style);

  /// Primary color. `tooltip-primary`
  static const TooltipStyle primary = TooltipStyle('tooltip-primary', type: StyleType.style);

  /// Secondary color. `tooltip-secondary`
  static const TooltipStyle secondary = TooltipStyle('tooltip-secondary', type: StyleType.style);

  /// Accent color. `tooltip-accent`
  static const TooltipStyle accent = TooltipStyle('tooltip-accent', type: StyleType.style);

  /// Info color. `tooltip-info`
  static const TooltipStyle info = TooltipStyle('tooltip-info', type: StyleType.style);

  /// Success color. `tooltip-success`
  static const TooltipStyle success = TooltipStyle('tooltip-success', type: StyleType.style);

  /// Warning color. `tooltip-warning`
  static const TooltipStyle warning = TooltipStyle('tooltip-warning', type: StyleType.style);

  /// Error color. `tooltip-error`
  static const TooltipStyle error = TooltipStyle('tooltip-error', type: StyleType.style);
}

/// A container for rich HTML content to be used within a [Tooltip].
///
/// This component should be passed to the `content` property of a [Tooltip].
/// It renders a `<div>` with the `tooltip-content` class.
class TooltipContent extends UiComponent {
  /// Creates a TooltipContent container.
  ///
  /// - [children]: The rich HTML content for the tooltip.
  /// - Other parameters are inherited from [UiComponent].
  const TooltipContent(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'tooltip-content';

  @override
  TooltipContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return TooltipContent(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}
