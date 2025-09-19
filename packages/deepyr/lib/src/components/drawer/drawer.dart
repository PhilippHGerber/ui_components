import 'package:jaspr/jaspr.dart' hide css;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'drawer_style.dart';

/// A container component that provides a slide-out panel (sidebar) for navigation or content.
///
/// The drawer's visibility is controlled by an internal checkbox. Interaction is handled by
/// linking <label> elements (like [DrawerSide]'s overlay or a custom button) to this checkbox
/// using the [drawerId]. The component's state is synchronized via the [onToggle] callback,
/// which correctly handles the browser's `onChange` event.
class Drawer extends UiComponent {
  /// Creates a Drawer container component.
  ///
  /// - [content]: The main content area of the page ([DrawerContent]).
  /// - [side]: The slide-out panel content ([DrawerSide]).
  /// - [drawerId]: A unique ID for the internal checkbox. Essential for linking toggle labels.
  /// - [isOpen]: The current state of the drawer (true for open, false for closed).
  /// - [onToggle]: A callback that fires when the drawer's state changes. It receives the new boolean state.
  /// - [styles]: A list of [DrawerStyling] instances for styling and behavior (e.g., [Drawer.end]).
  /// - Other parameters are inherited from [UiComponent].
  const Drawer({
    required this.content,
    required this.side,
    required this.drawerId,
    this.isOpen = false,
    this.onToggle,
    super.tag = 'div',
    List<DrawerStyling>? styles,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null, style: styles);

  /// The main content area of the page.
  final DrawerContent content;

  /// The slide-out panel content.
  final DrawerSide side;

  /// Whether the drawer is currently open. This directly controls the 'checked' state of the internal checkbox.
  final bool isOpen;

  /// This callback is crucial for state management. It is triggered when the internal
  /// checkbox's state changes, providing the new state (`true` for open, `false` for closed).
  final ValueChanged<bool>? onToggle;

  /// A unique ID used for the internal checkbox and for linking labels (like the overlay) to it.
  final String drawerId;

  @override
  String get baseClass => 'drawer';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // No additional attributes needed by default.
  }

  @override
  Drawer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Drawer(
      content: content,
      side: side,
      drawerId: drawerId,
      isOpen: isOpen,
      onToggle: onToggle,
      tag: tag,
      styles: style as List<DrawerStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: this.events,
      children: [
        // The hidden checkbox that controls the drawer's visibility via CSS.
        input(
          type: InputType.checkbox,
          id: drawerId,
          classes: 'drawer-toggle',
          attributes: {
            if (isOpen) 'checked': '',
          },
          events: onToggle != null
              ? {
                  'change': (dynamic rawEvent) {
                    if (kIsWeb) {
                      final target = (rawEvent as Event).target! as HTMLInputElement;
                      onToggle!(target.checked);
                    }
                  },
                }
              : null,
        ),
        content,
        DrawerSide(
          menuContent: side.menuContent,
          drawerId: drawerId,
          // Pass through other properties from the user-provided 'side' component.
          tag: side.tag,
          id: side.id,
          style: side.style,
          classes: side.classes,
          css: side.css,
          attributes: side.componentAttributes,
          key: side.key,
        ),
      ],
    );
  }

  // --- Static Drawer Modifiers ---

  /// Changes drawer to open from the right side. `drawer-end`
  static const DrawerStyle end = DrawerStyle('drawer-end', type: StyleType.layout);

  /// Forces the drawer to be open. Can be used with responsive prefixes.
  /// e.g., `Drawer.open.at(Breakpoint.lg)` produces `lg:drawer-open`.
  static const DrawerStyle open = DrawerStyle('drawer-open', type: StyleType.state);
}

/// Represents the main content area of a page when a [Drawer] is present.
class DrawerContent extends UiComponent {
  const DrawerContent(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'drawer-content';

  @override
  DrawerContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DrawerContent(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the slide-out panel (sidebar) of a [Drawer].
/// Contains a clickable overlay and the menu/content for the panel.
class DrawerSide extends UiComponent {
  /// Creates a DrawerSide component.
  ///
  /// - [menuContent]: The actual content to display within the slide-out panel.
  /// - [drawerId]: The ID used by the label overlay to associate with the drawer's toggle checkbox.
  const DrawerSide({
    required this.menuContent,
    this.drawerId,
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null); // Children are managed internally.

  /// The content to display within the drawer panel.
  final Component menuContent;

  /// The ID for the drawer toggle mechanism, used by the overlay's `for` attribute.
  final String? drawerId;

  @override
  String get baseClass => 'drawer-side';

  @override
  DrawerSide copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DrawerSide(
      menuContent: menuContent,
      drawerId: drawerId,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final attributes = <String, String>{'aria-label': 'close sidebar'};
    if (drawerId != null) {
      attributes['for'] = drawerId!;
    }

    final overlayLabel = label(
      classes: 'drawer-overlay',
      attributes: attributes,
      [],
    );

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: this.events,
      children: [overlayLabel, menuContent],
    );
  }
}
