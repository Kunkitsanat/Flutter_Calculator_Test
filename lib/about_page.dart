import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Developed by MOT Dev',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'รายชื่อสมาชิก',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '1. นายกฤษณัฐ พิริยพงษ์ 6801012610197',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '2. นายพงศภัค ดิเรกฤทธิ์สุนทร 6801012610391',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '3. นายคุณากร เจริญสุข 6801012610413',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'ทดสอบวันที่ 7/8/2026',
                 style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}