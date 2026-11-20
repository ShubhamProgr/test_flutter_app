import 'package:flutter_test/flutter_test.dart';
import 'package:questionaire/main.dart';

void main() {
  testWidgets('shows the first question and advances', (tester) async {
    await tester.pumpWidget(const QuestionnaireApp());

    expect(find.text('Question 1 of 5'), findsOneWidget);
    expect(find.text('What is the capital of France?'), findsOneWidget);

    await tester.tap(find.text('Paris'));
    await tester.pump();

    expect(find.text('Question 2 of 5'), findsOneWidget);
  });
}
