import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_calc/main.dart' as app;
import 'package:simple_calc/odd_even.dart'; // นำเข้าไฟล์ที่มีฟังก์ชันตรวจสอบเลขคี่-คู่

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ทดสอบ Flow การทำงานรวม เครื่องคิดเลข -> หน้า Odd/Even -> ย้อนกลับ',
      (WidgetTester tester) async {
    // 1. เริ่มรันแอปพลิเคชัน
    app.main();
    await tester.pumpAndSettle();

    // 2. ทดสอบคำนวณในหน้าเครื่องคิดเลขหลัก (10 + 20 = 30.0)
    final num1Calc = find.widgetWithText(TextField, 'ตัวเลข 1').first;
    final num2Calc = find.widgetWithText(TextField, 'ตัวเลข 2').first;

    await tester.enterText(num1Calc, '10');
    await tester.enterText(num2Calc, '20');
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pumpAndSettle();

    // เช็คผลลัพธ์โดยการหา Text 30.0 โดยตรง
    expect(find.byKey(const Key('result_text')), findsOneWidget);
    expect(find.text('30.0'), findsOneWidget);

    // 3. กดปุ่ม 'OddEven' เพื่อเปลี่ยนไปยังหน้า OddEven
    final navOddEvenBtn = find.text('OddEven');
    await tester.tap(navOddEvenBtn);
    await tester.pumpAndSettle();

    // ตรวจสอบว่ามี Text 'OddEven' อยู่ด้านใน Key 'OddEven_Appbar'
    expect(
      find.descendant(
        of: find.byKey(const Key('OddEven_Appbar')),
        matching: find.text('OddEven'),
      ),
      findsOneWidget,
    );

    // 4. ทดสอบกรอกตัวเลข 3 ช่องในหน้า OddEven (ระบุ Scope ค้นหาเฉพาะในหน้า OddEven)
    final num1OddEven = find.descendant(
      of: find.byType(OddEven),
      matching: find.widgetWithText(TextField, 'ตัวเลข 1'),
    );
    final num2OddEven = find.descendant(
      of: find.byType(OddEven),
      matching: find.widgetWithText(TextField, 'ตัวเลข 2'),
    );
    final num3OddEven = find.descendant(
      of: find.byType(OddEven),
      matching: find.widgetWithText(TextField, 'ตัวเลข 3'),
    );

    await tester.enterText(num1OddEven, '2');
    await tester.enterText(num2OddEven, '4');
    await tester.enterText(num3OddEven, '1');

    // กดปุ่ม 'Processs'
    final processBtn = find.widgetWithText(ElevatedButton, 'Processs');
    await tester.tap(processBtn);
    await tester.pumpAndSettle();

    // ตรวจสอบผลลัพธ์
    expect(find.text('EVEN'), findsOneWidget);

    // 5. กดปุ่มย้อนกลับ (Back Button) เพื่อกลับมาหน้าเครื่องคิดเลข
    await tester.pageBack();
    await tester.pumpAndSettle();

    // ตรวจสอบว่ากลับมาหน้าเครื่องคิดเลขเดิมสำเร็จ
    expect(find.byKey(const Key('Calculator')), findsOneWidget);
  });
}