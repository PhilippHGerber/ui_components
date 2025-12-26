import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart';

import '../base/base_style.dart';
import '../base/styling.dart';
import '../base/ui_component.dart';
import '../base/ui_events.dart';
import '../base/ui_prefix_modifier.dart';

/// A generic container component, typically rendering as an HTML `<div>`.
///
/// It serves as a versatile building block for layout and grouping content.
/// Styling and layout are primarily controlled by applying general utility classes
/// (instances of [Styling]) through its `styles` property.
///
/// Use the [Container.responsive] factory for a convenient way to apply
/// different modifiers at various breakpoints.
class Container extends UiComponent {
  /// Creates a generic Container component.
  ///
  /// - [children] or [child]: The content to be placed within the container.
  /// - [tag]: The HTML tag for the container element, defaults to 'div'.
  /// - [styles]: A list of general [Styling] instances for styling
  ///   and layout (e.g., Spacing, Sizing, Flex, Background).
  /// - Other parameters are inherited from [UiComponent].
  const Container(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.onClick, // If the container itself needs to be clickable
    super.key,
  });

  @override
  String get baseClass => ''; // Container itself has no specific DaisyUI base class


  @override
  Container copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Container(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      onClick: onClick,
      key: key ?? this.key,
    );
  }

  /// Factory method to create a [Container] with responsive modifiers.
  ///
  /// This allows defining different sets of utility classes for mobile, tablet,
  /// and desktop breakpoints.
  ///
  /// Example:
  /// ```dart
  /// Container.responsive(
  ///   children: [Text("Responsive Content")],
  ///   mobile: [Sizing.wFull, Flex.flexCol],
  ///   tablet: [Sizing.w3_4, Flex.flexRow, Alignment.justifyBetween],
  ///   desktop: [Sizing.w1_2, Spacing.mxAuto()],
  /// )
  /// ```
  ///
  /// - [children] or [child]: The content of the container.
  /// - [tag]: The HTML tag for the container.
  /// - [mobile]: List of [Styling] for mobile and smaller screens (default).
  /// - [tablet]: List of [Styling] applied from the 'md' breakpoint upwards.
  ///   Only instances of [BaseStyle] within this list will have the breakpoint applied.
  /// - [desktop]: List of [Styling] applied from the 'lg' breakpoint upwards.
  ///   Only instances of [BaseStyle] within this list will have the breakpoint applied.
  /// - [id], [classes], [css], [attributes], [key]: Standard [UiComponent] parameters.
  static Container responsive({
    List<Component>? children,
    Component? child,
    String tag = 'div',
    List<Styling>? mobile,
    List<Styling>? tablet,
    List<Styling>? desktop,
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    final responsiveStyles = <Styling>[];

    if (mobile != null) {
      responsiveStyles.addAll(mobile);
    }

    // Helper function to safely apply breakpoints
    Styling applyBreakpoint(Styling utility, PrefixModifier breakpoint) {
      // Check if the utility is an instance of BaseStyle.
      // We use BaseStyle<dynamic> because we don't know the concrete T here,
      // but we only need to access the 'at' method which BaseStyle provides.
      if (utility is BaseStyle) {
        // The 'at' method returns 'T', which is a subtype of BaseStyle<dynamic>,
        // and BaseStyle<dynamic> implements Styling. So the result is a Styling.
        return utility.at(breakpoint);
      }
      // If it's not a BaseStyle, it cannot have breakpoints applied via .at().
      // Log a warning in development mode if a non-BaseStyle utility is passed
      // to tablet/desktop where a breakpoint would be expected.
      // assert(false,
      //    'Warning: Utility of type ${utility.runtimeType} was passed to responsive tablet/desktop modifiers '
      //    'but does not support breakpoints via .at(). Utility: "$utility"');
      return utility; // Return the utility as is.
    }

    if (tablet != null) {
      responsiveStyles.addAll(
        tablet.map((u) => applyBreakpoint(u, Breakpoint.md)),
      );
    }

    if (desktop != null) {
      responsiveStyles.addAll(
        desktop.map((u) => applyBreakpoint(u, Breakpoint.lg)),
      );
    }

    return Container(
      children ?? (child != null ? [child] : null),
      tag: tag,
      style: responsiveStyles.isNotEmpty ? responsiveStyles : null,
      id: id,
      classes: classes,
      css: css,
      attributes: attributes,
      key: key,
    );
  }
}
