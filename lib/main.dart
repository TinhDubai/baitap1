import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _nController = TextEditingController();
  String _result = "";

  // Hàm kiểm tra số nguyên tố
  bool _isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  // Hàm xử lý khi nhấn nút tính toán
  void _calculate() {
    try {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);

      setState(() {
        _result = '''
          Phép cộng: ${a + b}
          Phép trừ: ${a - b}
          Phép nhân: ${a * b}
          Phép chia: ${b != 0 ? (a / b).toStringAsFixed(2) : "Không thể chia cho 0"}
        ''';
      });
    } catch (e) {
      _showSnackbar("Vui lòng nhập số hợp lệ cho a và b.");
    }
  }

  // Hàm kiểm tra số nguyên tố
  void _checkPrime() {
    try {
      int n = int.parse(_nController.text);
      bool isPrime = _isPrime(n);

      _showSnackbar("Số $n ${isPrime ? 'là' : 'không phải là'} số nguyên tố.");
    } catch (e) {
      _showSnackbar("Vui lòng nhập một số nguyên hợp lệ.");
    }
  }

  // Hàm hiển thị Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tính toán đơn giản"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nhập số a",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nhập số b",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text("Thực hiện tính toán"),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16),
            ),
            Divider(),
            TextField(
              controller: _nController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nhập số n để kiểm tra nguyên tố",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkPrime,
              child: Text("Kiểm tra số nguyên tố"),
            ),
          ],
        ),
      ),
    );
  }
}
