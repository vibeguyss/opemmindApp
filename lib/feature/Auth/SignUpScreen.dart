import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Auth/Component/InputField.dart';
import 'package:openmind_app/feature/Auth/Model/RoleEnum.dart';
import 'package:openmind_app/feature/Auth/ViewModel/AuthViewModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text('새로운 계정으로', style: AppFont.bold(36, color: Colors.black87)),
              Text('시작해봐요!', style: AppFont.bold(36, color: Colors.black87)),
              const SizedBox(height: 12),
              Text('간단한 정보만 입력하면 바로 시작할 수 있어요.',
                  style: AppFont.regular(16, color: Colors.black54)),
              const SizedBox(height: 48),

              // 역할 선택 토글
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RoleToggleButton(
                        label: "사용자",
                        role: RoleEnum.user,
                        isSelected: authViewModel.selectedRole == RoleEnum.user,
                        onTap: () => authViewModel.setUserRole(RoleEnum.user),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RoleToggleButton(
                        label: "상담사",
                        role: RoleEnum.doctor,
                        isSelected: authViewModel.selectedRole == RoleEnum.doctor,
                        onTap: () => authViewModel.setUserRole(RoleEnum.doctor),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  InputField(
                    controller: authViewModel.nameController,
                    hintText: '이름을 입력해주세요.',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 24),

                  InputField(
                    controller: authViewModel.emailController,
                    hintText: '이메일 주소를 입력해주세요.',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),

                  InputField(
                    controller: authViewModel.passwordController,
                    hintText: '비밀번호를 입력해주세요. (6자 이상)',
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
                ],
              ),


              const SizedBox(height: 64),

              ElevatedButton(
                onPressed: () => authViewModel.signUp(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.main,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text('회원가입하기', style: AppFont.bold(18)),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: RichText(
                    text: TextSpan(
                      text: '이미 계정이 있으신가요? ',
                      style: AppFont.regular(14, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: '로그인하기',
                          style: AppFont.bold(14, color: AppColor.main),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleToggleButton extends StatelessWidget {
  final String label;
  final RoleEnum role;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleToggleButton({
    super.key,
    required this.label,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.main : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColor.main : Colors.grey[400]!,
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppFont.bold(16,
              color: isSelected ? Colors.white : Colors.black54),
        ),
      ),
    );
  }
}
