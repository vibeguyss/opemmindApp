import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Auth/Component/InputField.dart';
import 'package:openmind_app/feature/Auth/SignUpScreen.dart';
import 'package:openmind_app/feature/Auth/ViewModel/AuthViewModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().initControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(backgroundColor: AppColor.background, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              Text('안녕하세요,', style: AppFont.bold(36, color: Colors.black87)),
              Text('반가워요!', style: AppFont.bold(36, color: Colors.black87)),
              const SizedBox(height: 12),
              Text(
                'OpenMind에서 편하게 상담해보세요.',
                style: AppFont.regular(16, color: Colors.black54),
              ),
              const SizedBox(height: 80),

              Column(
                // Form 제거
                children: [
                  InputField(
                    controller: authViewModel.emailController,
                    hintText: '이메일 주소를 입력해주세요.',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  InputField(
                    controller: authViewModel.passwordController,
                    hintText: '비밀번호를 입력해주세요.',
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black45,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        print('비밀번호를 잊으셨나요?');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        '비밀번호를 잊으셨나요?',
                        style: AppFont.medium(14, color: AppColor.disable),
                      ),
                    ),
                  ),
                ],
              ),

              // ), // Form 제거
              SizedBox(height: 80),

              ElevatedButton(
                onPressed: () => authViewModel.login(context), // 항상 활성화
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.main,
                  // 항상 main 색상
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text('로그인', style: AppFont.bold(18)),
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '아직 회원이 아니신가요? ',
                      style: AppFont.regular(14, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: '회원가입하기',
                          style: AppFont.bold(14, color: AppColor.main),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
