import 'package:jaspr/dom.dart' show Styles, div;
import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'browser_mockup_style.dart';
import 'browser_mockup_toolbar.dart';

/// A component that renders a box styled to look like a browser window.
///
/// It uses a compositional API, accepting content for the `addressBar` and the main
/// `content` area via its constructor. The component automatically handles the
/// internal structure, including the toolbar and the separator line.
///
/// Example Usage:
/// ```dart
/// BrowserMockup(
///   style: [BorderUtil.border, BorderUtil.base300],
///   addressBar: text('https://daisyui.com'),
///   content: Container(
///     [text('Hello!')],
///     style: [Layout.grid, Alignment.placeContentCenter, Size.h(80)],
///   ),
/// )
/// ```
class BrowserMockup extends UiComponent {
  /// Creates a [BrowserMockup] component.
  ///
  /// - [addressBar]: The `Component` to display inside the address bar,
  ///   typically a `text()` widget with a URL.
  /// - [content]: The main `Component` to display within the browser's "viewport".
  /// - [style]: A list of [MockupBrowserStyling] instances for applying
  ///   general utilities like background colors and borders to the main frame.
  /// - Other parameters are inherited from [UiComponent].
  const BrowserMockup({
    required this.addressBar,
    required this.content,
    List<MockupBrowserStyling>? style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The component for the browser's address bar.
  final Component addressBar;

  /// The main content to be displayed inside the browser frame.
  final Component content;

  @override
  String get baseClass => 'mockup-browser';

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
        // The toolbar is created internally, abstracting this detail.
        BrowserToolbar(addressBarContent: addressBar),
        // The content area, which includes the automatically generated border.
        div(
          classes: 'border-t border-base-300',
          [content],
        ),
      ],
    );
  }

  @override
  BrowserMockup copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    Component? addressBar,
    Component? content,
  }) {
    return BrowserMockup(
      addressBar: addressBar ?? this.addressBar,
      content: content ?? this.content,
      style: style as List<MockupBrowserStyling>?,
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
