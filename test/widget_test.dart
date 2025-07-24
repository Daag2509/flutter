import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/main.dart';

void main() {
  testWidgets('Agregar tarea a la lista', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

  
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Agregar nueva tarea'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Nueva tarea');
    

    expect(find.text('Nueva tarea'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Nueva tarea'), findsOneWidget);
  });
}