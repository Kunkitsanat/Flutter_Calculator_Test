import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_calc/main.dart' as app; // นำเข้า main() ของแอป

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ทดสอบ Flow การทำงานรวม เครื่องคิดเลข -> หน้า Odd/Even -> ย้อนกลับ',
      (WidgetTester tester) async {
    // 1. เริ่มรันแอปพลิเคชัน
    app.main();
    await tester.pumpAndSettle();

    // 2. ทดสอบคำนวณในหน้าเครื่องคิดเลขหลัก (10 + 20 = 30.0)
    final num1Calc = find.widgetWithText(TextField, 'ตัวเลข 1');
    final num2Calc = find.widgetWithText(TextField, 'ตัวเลข 2');

    await tester.enterText(num1Calc, '10');
    await tester.enterText(num2Calc, '20');
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pumpAndSettle();

    // ตรวจสอบว่าผลลัพธ์การบวกแสดงผลถูกต้อง
    expect(find.text('30.0'), findsOneWidget);

    // 3. กดปุ่ม 'OddEven' เพื่อเปลี่ยนไปยังหน้า OddEven
    final navOddEvenBtn = find.text('OddEven');
    await tester.tap(navOddEvenBtn);
    await tester.pumpAndSettle(); // รอ Animation เปลี่ยนหน้าจบ

    // ตรวจสอบว่าย้ายมาหน้า OddEven เรียบร้อยแล้ว (ดูจาก AppBar)
    expect(find.widgetWithText(AppBar, 'OddEven'), findsOneWidget);

    // 4. ทดสอบกรอกตัวเลข 3 ช่องในหน้า OddEven (กรอก 2, 4, 1)
    final num1OddEven = find.widgetWithText(TextField, 'ตัวเลข 1');
    final num2OddEven = find.widgetWithText(TextField, 'ตัวเลข 2');
    final num3OddEven = find.widgetWithText(TextField, 'ตัวเลข 3');

    await tester.enterText(num1OddEven, '2');
    await tester.enterText(num2OddEven, '4');
    await tester.enterText(num3OddEven, '1');

    // กดปุ่ม 'Processs'
    final processBtn = find.widgetWithText(ElevatedButton, 'Processs');
    await tester.tap(processBtn);
    await tester.pumpAndSettle();

    // ตรวจสอบผลลัพธ์เลขคู่มากกว่า ต้องแสดง "EVEN"
    expect(find.text('EVEN'), findsOneWidget);

    // 5. กดปุ่มย้อนกลับ (Back Button) เพื่อกลับมาหน้าเครื่องคิดเลข
    final backBtn = find.byType(BackButton);
    await tester.tap(backBtn);
    await tester.pumpAndSettle();

    // ตรวจสอบว่ากลับมาหน้าเครื่องคิดเลขเดิมสำเร็จ
    expect(find.text('เครื่องคิดเลขแบบง่าย'), findsOneWidget);
  });
}