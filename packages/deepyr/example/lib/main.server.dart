import 'package:jaspr/dom.dart' show link, meta;
import 'package:jaspr/server.dart';

import 'example.dart';

void main() {
  Jaspr.initializeApp();

  runApp(
    Document(
      title: 'Deepyr Example - Component Showcase',
      head: <Component>[
        link(href: 'styles.css', rel: 'stylesheet'),
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1'),
      ],
      body: const DeepyrShowcase(),
    ),
  );
}
