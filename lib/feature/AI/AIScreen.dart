import 'package:flutter/material.dart';
import 'package:openmind_app/feature/AI/Component/RainbowGradientTextField.dart';
import 'package:openmind_app/feature/AI/Component/SendButton.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/feature/AI/ViewModel/AiViewModel.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({Key? key}) : super(key: key);

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _rainbowController;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _rainbowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<AiViewModel>();
      vm.addListener(_scrollToBottom);
    });
  }

  @override
  void dispose() {
    _rainbowController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage() {
    final vm = context.read<AiViewModel>();
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    if (vm.isLoading) {
      print("AI가 이미 응답 중입니다. 잠시 기다려 주세요.");
      return;
    }

    vm.sendMessage(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AiViewModel>();

    // 메시지 버블 스타일
    BoxDecoration messageBubbleDecoration(bool isUser) =>
        BoxDecoration(
          color: isUser ? AppColor.userBubbleBg : AppColor.aiBubbleBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isUser ? 16 : 6),
            topRight: Radius.circular(isUser ? 6 : 16),
            bottomLeft: const Radius.circular(16),
            bottomRight: const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        );

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: Text("AI와 상담하기", style: AppFont.bold(18)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                itemCount: vm.messages.length + (vm.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  // 로딩 메시지는 목록의 마지막 항목으로 표시합니다.
                  if (vm.isLoading && index == vm.messages.length) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: messageBubbleDecoration(false), // AI 버블 스타일 적용
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "AI가 채팅 보내는 중...",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // 일반 메시지 표시
                  final msg = vm.messages[index];
                  final isUser = msg.isUser;

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      decoration: messageBubbleDecoration(isUser),
                      child: Text(
                        msg.text,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 15,
                          height: 1.35,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 입력창 영역
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                color: AppColor.background,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: RainbowGradientTextField(
                        controller: _textController,
                        animation: _rainbowController,
                        onSubmitted: (_) => _sendMessage(),
                        enabled: !vm.isLoading,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SendButton(
                      onPressed: _sendMessage,
                      color: AppColor.userBubbleBg,
                      isDisabled: vm.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}