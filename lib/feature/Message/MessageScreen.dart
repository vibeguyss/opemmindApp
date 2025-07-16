import 'package:flutter/material.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

// 더미 메시지 모델
class DummyMessage {
  final String text;
  final bool isMine;
  final DateTime timestamp;

  DummyMessage({
    required this.text,
    required this.isMine,
    required this.timestamp,
  });
}

class MessageScreen extends StatefulWidget {
  final String counselorName; // 상담사 이름만 받음

  const MessageScreen({
    Key? key,
    required this.counselorName,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 더미 메시지 데이터
  List<DummyMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeDummyMessages();
  }

  void _initializeDummyMessages() {
    final now = DateTime.now();
    _messages = [
      DummyMessage(
        text: "안녕하세요 상담받으려 하는데요 혹시 가능할까요?",
        isMine: true,
        timestamp: now.subtract(const Duration(minutes: 10)),
      ),
      DummyMessage(
        text: "네 가능합니다! 안녕하세요, 저는 ${widget.counselorName}입니다. 어떻게 도와드릴까요?",
        isMine: false,
        timestamp: now.subtract(const Duration(minutes: 9)),
      ),
      DummyMessage(
        text: "트라우마 때문에 연락드렸어요... 최근에 계속 힘들어서요",
        isMine: true,
        timestamp: now.subtract(const Duration(minutes: 8)),
      ),
      DummyMessage(
        text: "아 그러셨구나요. 힘드셨겠어요. 트라우마로 인해 어떤 증상들이 나타나고 계신지 편하게 말씀해 주세요.",
        isMine: false,
        timestamp: now.subtract(const Duration(minutes: 7)),
      ),
      DummyMessage(
        text: "밤에 잠을 잘 못자겠고, 갑자기 그때 생각이 나면서 심장이 막 뛰어요",
        isMine: true,
        timestamp: now.subtract(const Duration(minutes: 6)),
      ),
      DummyMessage(
        text: "불면증과 플래시백 증상이 나타나고 계시는군요. 이런 증상들이 언제부터 시작되었는지 기억하시나요?",
        isMine: false,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      DummyMessage(
        text: "한 두 달 전부터인 것 같아요. 처음엔 괜찮다고 생각했는데 점점 심해지는 것 같아서...",
        isMine: true,
        timestamp: now.subtract(const Duration(minutes: 4)),
      ),
      DummyMessage(
        text: "충분히 이해됩니다. 트라우마 증상은 시간이 지나면서 다양하게 나타날 수 있어요. 지금 용기내어 상담을 받으시는 것 자체가 회복의 첫걸음이라고 생각해요.",
        isMine: false,
        timestamp: now.subtract(const Duration(minutes: 3)),
      ),
      DummyMessage(
        text: "정말 그럴까요? 솔직히 좀 무서워요. 이런 상태가 계속 지속될까봐...",
        isMine: true,
        timestamp: now.subtract(const Duration(minutes: 2)),
      ),
      DummyMessage(
        text: "그런 두려움을 갖는 것은 당연한 반응이에요. 하지만 적절한 상담과 치료를 통해 충분히 회복할 수 있습니다. 천천히 함께 해나가요.",
        isMine: false,
        timestamp: now.subtract(const Duration(minutes: 1)),
      ),
    ];
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add(DummyMessage(
        text: _controller.text,
        isMine: true,
        timestamp: DateTime.now(),
      ));
    });

    _controller.clear();
    _scrollToBottom();

    // 상담사 자동 응답 (실제 앱에서는 서버 통신)
    _simulateCounselorResponse();
  }

  void _simulateCounselorResponse() {
    // 2초 후 상담사 응답
    Future.delayed(const Duration(seconds: 2), () {
      final responses = [
        "네, 말씀해 주신 내용을 잘 들었습니다. 더 자세히 설명해 주시겠어요?",
        "그런 기분이 드시는군요. 그럴 때 어떤 생각이 드시나요?",
        "이해합니다. 그런 상황에서 어떻게 대처하고 계신지 궁금해요.",
        "힘드셨겠어요. 지금 이 순간 기분은 어떠신가요?",
        "충분히 그럴 수 있어요. 조금 더 구체적으로 말씀해 주시겠어요?",
        "좋은 말씀이에요. 그런 경험을 통해 어떤 것을 느끼셨나요?",
        "네, 잘 이해했습니다. 이런 방법은 어떨까요?",
      ];

      final randomResponse = responses[DateTime.now().microsecond % responses.length];

      if (mounted) {
        setState(() {
          _messages.add(DummyMessage(
            text: randomResponse,
            isMine: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: Text(
          "${widget.counselorName} 상담사",
          style: AppFont.bold(20),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 메뉴 기능 (프로필 보기, 상담 종료 등)
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 상담 상태 표시
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.main.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(color: AppColor.main.withOpacity(0.2)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "상담 진행 중",
                    style: AppFont.medium(14).copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardHeight),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isMine = msg.isMine;

                  return Align(
                    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: isMine
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (!isMine) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 12, bottom: 4),
                              child: Text(
                                widget.counselorName,
                                style: AppFont.medium(12).copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? AppColor.main
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: isMine ? Colors.white : Colors.black87,
                                fontSize: 16,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Padding(
                            padding: EdgeInsets.only(
                              left: isMine ? 0 : 12,
                              right: isMine ? 12 : 0,
                            ),
                            child: Text(
                              "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 메시지 입력 필드
            Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + keyboardHeight),
              decoration: BoxDecoration(
                color: AppColor.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      cursorColor: AppColor.main,
                      style: const TextStyle(color: Colors.black),
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                            color: AppColor.main.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.main,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.main.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}