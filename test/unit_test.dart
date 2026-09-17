import 'package:flutter_test/flutter_test.dart';
import 'package:simple_calc/calculate.dart'; // นำเข้าไฟล์ที่มีฟังก์ชันคำนวณ

void main() {
  group('ทดสอบตรรกะการคำนวณ (Calculate Unit Test)', () {
    
    test('บวกเลขถูกต้อง (10 + 5 = 15)', () {
      // 1. Arrange & Act (ประมวลผลฟังก์ชันตรงๆ)
      String result = calculate(10, '+', 5);

      // 2. Assert (ตรวจสอบผลลัพธ์)
      expect(result, '15.0');
    });

    test('ลบเลขถูกต้อง (10 - 4 = 6)', () {
      String result = calculate(10, '-', 4);
      expect(result, '6.0');
    });

    test('คูณเลขถูกต้อง (3 * 4 = 12)', () {
      String result = calculate(3, '*', 12);
      expect(result, '36.0');
    });

    test('หารเลขถูกต้อง (20 / 4 = 5)', () {
      String result = calculate(20, '/', 4);
      expect(result, '5.0');
    });

    test('ทดสอบกรณีหารด้วยศูนย์ (Division by Zero)', () {
      String result = calculate(10, '/', 0);
      // ตรวจสอบว่ามี Logic รองรับการหารด้วย 0 หรือไม่
      expect(result, 'Error: Can\'t divide by 0'); 
    });

  });
}