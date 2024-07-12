import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoImage(),
            SizedBox(height: 30),
            RoundedButton(
              label: 'Iniciar Sesión',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            SizedBox(height: 20),
            RoundedButton(
              label: 'Crear Cuenta',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == 'juan@gmail.com' && password == '12345678') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correo o contraseña incorrectos'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoImage(),
            SizedBox(height: 30),
            TextInputField(
                label: 'Correo Electrónico', controller: emailController),
            SizedBox(height: 10),
            TextInputField(
                label: 'Contraseña',
                controller: passwordController,
                isPassword: true),
            SizedBox(height: 20),
            RoundedButton(
              label: 'Iniciar Sesión',
              onPressed: () {
                _login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
      ),
      body: Center(
        child: Text('Formulario de Creación de Cuenta'),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Bienvenido!'),
      ),
      body: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: paymentTypes.map((paymentType) {
          return PaymentButton(
            paymentType: paymentType['name'],
            imagePath: paymentType['imagePath'],
            onPressed: () {
              _performPaymentAction(context, paymentType['name']);
            },
          );
        }).toList(),
      ),
    );
  }

  void _performPaymentAction(BuildContext context, String paymentType) {
    switch (paymentType) {
      case 'Pago de Agua':
        _navigateToPaymentPage(context, paymentType);
        break;
      case 'Factura':
        _showInvoiceDialog(context, paymentType);
        break;
      case 'Recibo':
        _showReceiptDialog(context, paymentType);
        break;
      case 'Estado de cuenta':
        _showStatementDialog(context, paymentType);
        break;
      default:
        break;
    }
  }

  void _navigateToPaymentPage(BuildContext context, String paymentType) {
    // Aquí podrías navegar a la página de pago específica o realizar la acción necesaria
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a la página de pago de $paymentType'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showInvoiceDialog(BuildContext context, String paymentType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Factura'),
          content: Text(
              'Mostrando detalles de la $paymentType a nombre de Juan Villegas'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showReceiptDialog(BuildContext context, String paymentType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recibo'),
          content: Text(
              'Mostrando detalles del $paymentType a nombre de Juan Villegas'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showStatementDialog(BuildContext context, String paymentType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Estado de cuenta'),
          content: Text(
              'Mostrando detalles del $paymentType a nombre de Juan Villegas'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class PaymentButton extends StatelessWidget {
  final String paymentType;
  final String imagePath;
  final VoidCallback onPressed;

  PaymentButton(
      {required this.paymentType,
      required this.imagePath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        height: 150,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
              ),
              SizedBox(height: 10),
              Text(paymentType, textAlign: TextAlign.center),
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo.png', width: 150, height: 150);
  }
}

class TextInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  TextInputField(
      {required this.label, required this.controller, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      obscureText: isPassword,
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  RoundedButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

List<Map<String, dynamic>> paymentTypes = [
  {'name': 'Pago de Agua', 'imagePath': 'assets/pago_agua.png'},
  {'name': 'Factura', 'imagePath': 'assets/factura.png'},
  {'name': 'Recibo', 'imagePath': 'assets/recibo.png'},
  {'name': 'Estado de cuenta', 'imagePath': 'assets/estado_cuenta.png'},
];
