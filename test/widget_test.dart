import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_calc/main.dart'; // ปรับ path ตามโครงสร้างโปรเจกต์ของคุณ

void main() {
  testWidgets('ทดสอบการบวกเลขและการบันทึก History', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // ค้นหา TextField และกรอกตัวเลข
    final num1Field = find.widgetWithText(TextField, 'ตัวเลข 1');
    final num2Field = find.widgetWithText(TextField, 'ตัวเลข 2');

    await tester.enterText(num1Field, '10');
    await tester.enterText(num2Field, '5');

    // กดปุ่ม '+'
    final addButton = find.widgetWithText(ElevatedButton, '+');
    await tester.tap(addButton);
    await tester.pump();

    final resultWidget = tester.widget<Text>(
      find.byKey(const Key('result_text')),
    );
    expect(resultWidget.data, '15.0');

    // 2. สำหรับประวัติ History ก็สามารถเช็คค่าผ่าน widget properties ได้เช่นกัน
    final historyWidget = tester.widget<Text>(
      find.byKey(const Key('10 + 5 = 15.0')),
    );
    expect(historyWidget.data, '10 + 5 = 15.0');
  });

  testWidgets('ทดสอบการคำนวณ VAT (7%)', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final num1Field = find.widgetWithText(TextField, 'ตัวเลข 1');
    final num2Field = find.widgetWithText(TextField, 'ตัวเลข 2');

    await tester.enterText(num1Field, '100');
    await tester.enterText(num2Field, '0');

    final addButton = find.widgetWithText(ElevatedButton, '+');
    await tester.tap(addButton);
    await tester.pump();

    // กดปุ่ม 'Cal VAT'
    final vatButton = find.widgetWithText(ElevatedButton, 'Cal VAT');
    await tester.tap(vatButton);
    await tester.pump();

    // 100 + (100 * 0.07) = 107.0
    final resultWidget = tester.widget<Text>(
      find.byKey(const Key('result_text')),
    );
    expect(resultWidget.data, '107.0');

    // 2. สำหรับประวัติ History ก็สามารถเช็คค่าผ่าน widget properties ได้เช่นกัน
    final historyWidget = tester.widget<Text>(
      find.byKey(const Key('Cal VAT: 107.0')),
    );
    expect(historyWidget.data, 'Cal VAT: 107.0');
  });

  testWidgets('ทดสอบปุ่มล้างประวัติ (C)', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // คำนวณเพื่อสร้าง History ก่อน
    await tester.enterText(find.widgetWithText(TextField, 'ตัวเลข 1'), '5');
    await tester.enterText(find.widgetWithText(TextField, 'ตัวเลข 2'), '5');
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    expect(find.text('5 + 5 = 10.0'), findsOneWidget);

    // กดปุ่ม 'C' เพื่อล้างประวัติ
    await tester.tap(find.widgetWithText(ElevatedButton, 'C'));
    await tester.pump();

    // ตรวจสอบว่าประวัติถูกลบไปแล้ว
    expect(find.text('5 + 5 = 10.0'), findsNothing);
  });

  testWidgets('ทดสอบการกดเปลี่ยนหน้าไป About us', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // กดปุ่ม 'About us' บน AppBar
    final aboutButton = find.text('About us');
    await tester.tap(aboutButton);
    await tester.pumpAndSettle(); // รอ Animation เปลี่ยนหน้าจบ

    // ตรวจสอบว่ากดเปลี่ยนหน้าสำเร็จ (ไม่พบ Widget SimpleCalculator ในหน้าปัจจุบัน)
    expect(find.byType(SimpleCalculator), findsNothing);
  });
}
