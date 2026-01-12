import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart'
    show BuildContext, Component, EventCallback, Key, ValueChanged, kIsWeb;
import 'package:universal_web/web.dart' show Event, FileList, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'file_input_style.dart';

/// A component for user file selection, rendering an HTML `<input type="file">`.
///
/// This component is designed to be controlled by a parent. It does not manage
/// the selected files internally. Instead, you must handle the file selection
/// event using the [onFilesSelected] callback, which provides the `FileList`
/// object from the browser.
///
/// Example of handling file selection in a `StatefulComponent`:
/// ```dart
/// class MyUploader extends StatefulComponent {
///   @override
///   State<MyUploader> createState() => _MyUploaderState();
/// }
///
/// class _MyUploaderState extends State<MyUploader> {
///   String _fileName = 'No file chosen';
///
///   @override
///   Component build(BuildContext context) {
///     return FileInput(
///       onFilesSelected: (fileList) {
///         setState(() {
///           if (fileList.isNotEmpty) {
///             _fileName = fileList.first.name;
///           } else {
///             _fileName = 'No file chosen';
///           }
///         });
///       },
///     );
///     return p([text('Selected: $_fileName')]);
///   }
/// }
/// ```
class FileInput extends UiComponent {
  /// Creates a FileInput component.
  ///
  /// - [onFilesSelected]: A callback that fires when the user selects one or more
  ///   files. It receives the browser's `FileList` object.
  /// - [name]: The name of the input, used for form submission.
  /// - [disabled]: If true, the file input will be non-interactive.
  /// - [accept]: A string specifying the file types the input should accept
  ///   (e.g., "image/png, image/jpeg").
  /// - [multiple]: If true, the user can select multiple files.
  /// - [style]: A list of [FileInputStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const FileInput({
    this.onFilesSelected,
    this.name,
    this.disabled = false,
    this.accept,
    this.multiple = false,
    super.tag = 'input',
    List<FileInputStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style); // FileInput elements have no children.

  /// Callback function invoked when the user selects files.
  /// Provides a `FileList` object, which is an iterable collection of `File` objects.
  final ValueChanged<FileList>? onFilesSelected;

  /// The name of the input, used in form submissions.
  final String? name;

  /// If true, the input is non-interactive.
  final bool disabled;

  /// A comma-separated string of unique file type specifiers.
  /// Example: `'.png, .jpg, image/*'`
  final String? accept;

  /// If true, allows the user to select more than one file.
  final bool multiple;

  @override
  String get baseClass => 'file-input';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.add('type', 'file');
    if (name != null) attributes.add('name', name!);
    if (disabled) attributes.add('disabled', '');
    if (accept != null) attributes.add('accept', accept!);
    if (multiple) attributes.add('multiple', '');
  }

  @override
  FileInput copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FileInput(
      onFilesSelected: onFilesSelected,
      name: name,
      disabled: disabled,
      accept: accept,
      multiple: multiple,
      tag: tag,
      style: style as List<FileInputStyling>?,
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
    final eventMap = Map<String, EventCallback>.from(this.eventMap);

    if (onFilesSelected != null) {
      // The 'change' event fires when a file is selected.
      eventMap['change'] = (dynamic rawEvent) {
        if (kIsWeb) {
          final target = (rawEvent as Event).target! as HTMLInputElement;
          // The `files` property of the input element is a `FileList`.
          final files = target.files;
          if (files != null) {
            onFilesSelected!(files);
          }
        }
      };
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: eventMap,
    );
  }

  // --- Static Style Modifiers ---

  /// Ghost style (transparent background). `file-input-ghost`
  static const FileInputStyle ghost = FileInputStyle('file-input-ghost', type: StyleType.style);

  // Colors
  /// Neutral color. `file-input-neutral`
  static const FileInputStyle neutral = FileInputStyle('file-input-neutral', type: StyleType.style);

  /// Primary color. `file-input-primary`
  static const FileInputStyle primary = FileInputStyle('file-input-primary', type: StyleType.style);

  /// Secondary color. `file-input-secondary`
  static const FileInputStyle secondary = FileInputStyle(
    'file-input-secondary',
    type: StyleType.style,
  );

  /// Accent color. `file-input-accent`
  static const FileInputStyle accent = FileInputStyle('file-input-accent', type: StyleType.style);

  /// Info color. `file-input-info`
  static const FileInputStyle info = FileInputStyle('file-input-info', type: StyleType.style);

  /// Success color. `file-input-success`
  static const FileInputStyle success = FileInputStyle('file-input-success', type: StyleType.style);

  /// Warning color. `file-input-warning`
  static const FileInputStyle warning = FileInputStyle('file-input-warning', type: StyleType.style);

  /// Error color. `file-input-error`
  static const FileInputStyle error = FileInputStyle('file-input-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `file-input-xs`
  static const FileInputStyle xs = FileInputStyle('file-input-xs', type: StyleType.sizing);

  /// Small size. `file-input-sm`
  static const FileInputStyle sm = FileInputStyle('file-input-sm', type: StyleType.sizing);

  /// Medium size (default). `file-input-md`
  static const FileInputStyle md = FileInputStyle('file-input-md', type: StyleType.sizing);

  /// Large size. `file-input-lg`
  static const FileInputStyle lg = FileInputStyle('file-input-lg', type: StyleType.sizing);

  /// Extra-large size. `file-input-xl`
  static const FileInputStyle xl = FileInputStyle('file-input-xl', type: StyleType.sizing);
}
