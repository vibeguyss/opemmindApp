import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart'; // Provider import

import 'package:openmind_app/feature/Auth/ViewModel/AuthViewModel.dart'; // AuthViewModel import
import 'package:openmind_app/feature/Auth/LoginScreen.dart'; // LoginScreen import (assuming main.dart shows this)


void main() {
  testWidgets('LoginScreen loads correctly', (WidgetTester tester) async {
    // Build our app with the necessary Provider setup for AuthViewModel.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: const MaterialApp( // MaterialApp is needed for navigation, themes, etc.
          home: LoginScreen(), // Directly test LoginScreen if it's your app's entry point
        ),
      ),
    );

    // Verify that key elements of the LoginScreen are present.
    // We expect to find the "안녕하세요," text.
    expect(find.text('안녕하세요,'), findsOneWidget);

    // We expect to find the "이메일 주소를 입력해주세요." hint text.
    expect(find.text('이메일 주소를 입력해주세요.'), findsOneWidget);

    // We expect to find the "로그인" button.
    expect(find.widgetWithText(ElevatedButton, '로그인'), findsOneWidget);

    // Verify that the "회원가입하기" text is present.
    expect(find.text('회원가입하기'), findsOneWidget);

    // You can also test initial button state (disabled) if you wish,
    // but for a smoke test, checking for presence is often enough.
    // final loginButton = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '로그인'));
    // expect(loginButton.onPressed, isNull); // Button should be disabled initially
  });

  // You could add more specific tests here, for example:
  // testWidgets('Typing in email and password enables login button', (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     ChangeNotifierProvider(
  //       create: (context) => AuthViewModel(),
  //       child: const MaterialApp(
  //         home: LoginScreen(),
  //       ),
  //     ),
  //   );
  //
  //   // Ensure the button is initially disabled
  //   final loginButtonFinder = find.widgetWithText(ElevatedButton, '로그인');
  //   expect(tester.widget<ElevatedButton>(loginButtonFinder).onPressed, isNull);
  //
  //   // Type into email and password fields
  //   await tester.enterText(find.bySemanticsLabel('이메일 주소를 입력해주세요.'), 'test@example.com');
  //   await tester.enterText(find.bySemanticsLabel('비밀번호를 입력해주세요.'), 'password123');
  //   await tester.pump(); // Rebuild the widget after typing
  //
  //   // Now the button should be enabled
  //   expect(tester.widget<ElevatedButton>(loginButtonFinder).onPressed, isNotNull);
  // });
}