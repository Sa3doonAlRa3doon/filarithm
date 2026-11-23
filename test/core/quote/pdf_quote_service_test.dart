import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../../support/quote_fixture.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('renders a shaped bilingual PDF with a valid PDF header', () async {
    final bytes = await buildBilingualQuoteFixture();

    expect(bytes.length, greaterThan(10000));
    expect(ascii.decode(bytes.take(4).toList()), '%PDF');
  });
}
