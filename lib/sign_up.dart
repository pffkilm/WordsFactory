import 'package:flutter/material.dart';
import 'package:project/Dictionary.dart';
import 'package:project/intro3.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Контроллеры для хранения текста из полей ввода
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Переменная для скрытия/показа пароля
  bool _obscurePassword = true;

  // Ключ для управления формой
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Функция проверки имени
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  // Функция проверки email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Простая проверка на наличие @
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Функция проверки пароля
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Функция при нажатии на кнопку Sign Up
  void onSignUpPressed() {
    // Проверяем все поля на валидность
    if (formKey.currentState!.validate()) {
      // Если все поля правильные, переходим на следующий экран
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DictionaryScreen()),
      );
    }
  }

  // Функция для переключения видимости пароля
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1), // Белый фон
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 130),

            // Картинка
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/girl.png'),
                  const SizedBox(height: 30),

                  Container(
                    width: 375,
                    child: Column(
                      children: [
                        // Заголовок с точными стилями
                        Container(
                          width: 341,
                          height: 32,
                          child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              height: 32 / 24,
                              letterSpacing: -0.5,
                              color: const Color.fromRGBO(60, 58, 54, 1),
                            ),
                          ),
                        ),

                        SizedBox(height: 5),

                        // Подзаголовок
                        Text(
                          'Create your account',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color.fromRGBO(109, 109, 120, 1),
                          ),
                        ),

                        SizedBox(height: 32),

                        // ФОРМА С ПОЛЯМИ ВВОДА
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // ПОЛЕ NAME
                              Container(
                                width: 343,
                                height: 56,
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'Enter your name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: validateName,
                                ),
                              ),

                              SizedBox(height: 16),

                              // ПОЛЕ EMAIL
                              Container(
                                width: 343,
                                height: 56,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    hintText: 'Enter your email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: validateEmail,
                                ),
                              ),

                              SizedBox(height: 16),

                              // ПОЛЕ PASSWORD С ГЛАЗИКОМ
                              Container(
                                width: 343,
                                height: 56,
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    // Добавляем иконку глаза
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off  // закрытый глаз
                                            : Icons.visibility,     // открытый глаз
                                        color: Colors.grey,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                  ),
                                  obscureText: _obscurePassword, // Теперь управляется переменной
                                  validator: validatePassword,
                                ),
                              ),

                              SizedBox(height: 32),

                              // КНОПКА SIGN UP
                              Container(
                                width: 343,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: onSignUpPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(227, 86, 42, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Очищаем контроллеры когда экран закрывается
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}