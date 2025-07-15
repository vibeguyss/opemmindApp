import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Write/Detail/WriteDetailScreen.dart';
import 'package:openmind_app/feature/Write/Edit/WriteEditScreen.dart';
import 'package:openmind_app/feature/Write/ViewModel/WriteViewModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WriteViewModel>().fetchMyWrite());
  }

  Future<void> _onRefresh() async {
    await context.read<WriteViewModel>().fetchMyWrite();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WriteViewModel>();
    final items = viewModel.myWritings;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.background,
            elevation: 0,
            floating: true,
            snap: true,
            pinned: false,
            centerTitle: false,
            title: Text("내 일기", style: AppFont.bold(20)),
          ),

          CupertinoSliverRefreshControl(onRefresh: _onRefresh),

          if (viewModel.isLoading && items.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColor.main),
              ),
            )
          else if (items.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text("작성된 일기가 없습니다.", style: AppFont.medium(16)),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WriteDetailScreen(writeModel: item),
                        ),
                      );
                    },
                    child: Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      padding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: AppFont.bold(16).copyWith(color: AppColor.main),
                          ),
                          SizedBox(height: 6),
                          Text(
                            item.content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppFont.regular(14).copyWith(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.main,
        onPressed: () {
          Navigator.push(
              context,
            MaterialPageRoute(
              builder: (_) => WriteEditScreen()
            ),
          );
        },
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
