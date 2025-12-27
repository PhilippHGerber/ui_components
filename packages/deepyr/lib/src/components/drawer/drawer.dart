import 'dart:async';

import 'package:jaspr/dom.dart' show InputType, Styles, input, label;
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show HTMLInputElement, document;

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'drawer_style.dart';

/// A responsive slide-out panel that follows the controlled component pattern.
///
/// The `Drawer` provides a flexible way to implement navigation sidebars and mobile
/// menus. Its visibility is managed entirely by a parent stateful component via
/// the [isOpen] property.
///
/// ### Design: Controlled & Self-Synchronizing
/// This component is fully controlled by its parent. It is also self-synchronizing:
/// if you programmatically change [isOpen] (e.g., to close the drawer after navigation),
/// the component will automatically update the underlying DOM checkbox to reflect
/// that change.
///
/// ### Example:
///
/// ```dart
/// Drawer(
///   drawerId: 'my-drawer',
///   isOpen: _isDrawerOpen,
///   onToggle: (isOpen) => setState(() => _isDrawerOpen = isOpen),
///   classes: 'lg:drawer-open', // Always open on large screens
///   side: DrawerSide(menuContent: Menu([...])),
///   content: DrawerContent([
///     // Trigger button
///     label(
///       htmlFor: 'my-drawer',
///       classes: 'btn drawer-button lg:hidden',
///       [Icon('menu')],
///     ),
///     // ... page content
///   ]),
/// )
/// ```
class Drawer extends StatefulUiComponent {
  /// Creates a controlled Drawer container component.
  ///
  /// - [content]: The main content area, wrapped in a [DrawerContent].
  /// - [side]: The slide-out panel, wrapped in a [DrawerSide].
  /// - [drawerId]: A stable, unique ID for the internal control checkbox.
  ///   This ID is used to link trigger labels (like the hamburger button) to the drawer.
  /// - [isOpen]: The current state of the drawer (`true` for open).
  /// - [onToggle]: A callback that fires when the drawer's state changes (e.g., user clicks overlay).
  /// - [style]: A list of [DrawerStyling] modifiers (e.g., [Drawer.end]).
  const Drawer({
    required this.content,
    required this.side,
    required this.drawerId,
    this.isOpen = false,
    this.onToggle,
    super.tag = 'div',
    List<DrawerStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The main content area of the page.
  final DrawerContent content;

  /// The slide-out panel content.
  final DrawerSide side;

  /// The current state of the drawer. This directly controls the `checked` state
  /// of the internal checkbox, making this a controlled component.
  final bool isOpen;

  /// The callback for state management. It is triggered when the internal
  /// checkbox's state changes, providing the new state (`true` for open).
  final ValueChanged<bool>? onToggle;

  /// A unique ID used for the internal checkbox and for linking trigger labels.
  final String drawerId;

  @override
  String get baseClass => 'drawer';

  @override
  State<Drawer> createState() => _DrawerState();

  // --- Static Drawer Modifiers ---

  /// Changes the drawer to open from the right side. `drawer-end`
  static const DrawerStyle end = DrawerStyle('drawer-end', type: StyleType.layout);
}

class _DrawerState extends StatefulUiComponentState<Drawer> {
  @override
  String get baseClass => component.baseClass;

  @override
  void initState() {
    super.initState();
    _synchronizeCheckboxState();
  }

  @override
  void didUpdateComponent(Drawer oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.isOpen != component.isOpen) {
      _synchronizeCheckboxState();
    }
  }

  /// Updates the underlying checkbox's `checked` property via JS interop.
  /// This ensures the DOM stays in sync with the declarative [component.isOpen] state.
  void _synchronizeCheckboxState() {
    if (!kIsWeb) return;

    Future.delayed(Duration.zero, () {
      final checkbox = document.getElementById(component.drawerId) as HTMLInputElement?;
      if (checkbox != null && checkbox.checked != component.isOpen) {
        checkbox.checked = component.isOpen;
      }
    });
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: component.tag,
      id: component.id,
      classes: combinedClasses,
      styles: component.css,
      attributes: componentAttributes,
      events: eventMap,
      children: [
        // The hidden checkbox that drives the CSS-only toggle behavior.
        input(
          type: InputType.checkbox,
          id: component.drawerId,
          classes: 'drawer-toggle',
          // We bind the checked attribute to our state to ensure initial render is correct.
          checked: component.isOpen ? true : null,
          onChange: (dynamic _) {
            // When the checkbox changes (e.g. overlay click), we notify the parent.
            // In a controlled flow, we expect the parent to update `isOpen`,
            // which will then trigger `didUpdateComponent` to sync the checkbox if needed.
            component.onToggle?.call(!component.isOpen);
          },
        ),
        component.content,
        // Pass the ID to the side component so the overlay knows what to close.
        component.side.copyWith(htmlFor: component.drawerId),
      ],
    );
  }
}

/// The main content area of a [Drawer].
///
/// This component acts as a container for the primary content of your page.
/// It is essential to place your drawer trigger (a `<label>`) within this component.
class DrawerContent extends UiComponent {
  const DrawerContent(
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
  String get baseClass => 'drawer-content';

  @override
  DrawerContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
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
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the slide-out panel (sidebar) of a [Drawer].
///
/// This component serves as the container for the drawer's visible content and the
/// interactive overlay. The `htmlFor` property is automatically managed by the parent
/// [Drawer] to link the overlay to the internal control checkbox.
class DrawerSide extends UiComponent {
  const DrawerSide({
    required this.menuContent,
    this.htmlFor,
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null);

  /// The sidebar content to display in the slide-out panel.
  final Component menuContent;

  /// The `for` attribute of the overlay label, injected by the parent `Drawer`.
  final String? htmlFor;

  @override
  String get baseClass => 'drawer-side';

  @override
  DrawerSide copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    Component? menuContent,
    String? htmlFor,
  }) {
    return DrawerSide(
      menuContent: menuContent ?? this.menuContent,
      htmlFor: htmlFor ?? this.htmlFor,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
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
      events: eventMap,
      children: [
        // This label acts as the overlay that closes the drawer when clicked.
        label(
          htmlFor: htmlFor,
          classes: 'drawer-overlay',
          attributes: {'aria-label': 'close sidebar'},
          [],
        ),
        menuContent,
      ],
    );
  }
}
