import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'browser_mockup.dart' show BrowserMockup;
import 'browser_mockup_style.dart';

/// A component representing the toolbar of a [BrowserMockup].
///
/// This component is used internally by [BrowserMockup] and is responsible for
/// rendering the `mockup-browser-toolbar` and the address bar area, which is
/// styled with the `input` class by DaisyUI.
class BrowserToolbar extends UiComponent {
  /// Creates a [BrowserToolbar] component.
  ///
  /// - [addressBarContent]: The component to display inside the address bar.
  /// - [style]: A list of [MockupBrowserToolbarStyling] instances for applying
  ///   general utilities to the toolbar element.
  const BrowserToolbar({
    required this.addressBarContent,
    List<MockupBrowserToolbarStyling>? style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The content to be rendered inside the address bar.
  final Component addressBarContent;

  @override
  String get baseClass => 'mockup-browser-toolbar';

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
      children: [
        // This div with the `input` class provides the address bar styling.
        div(classes: 'input', [addressBarContent]),
      ],
    );
  }

  @override
  BrowserToolbar copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    Component? addressBarContent,
  }) {
    return BrowserToolbar(
      addressBarContent: addressBarContent ?? this.addressBarContent,
      style: style as List<MockupBrowserToolbarStyling>?,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
