import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Auth/LoginScreen.dart';
import 'package:openmind_app/feature/Profile/Component/AccountSettingItem.dart';
import 'package:openmind_app/feature/Profile/ViewModel/ProfileViewModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel()..fetchMyData(context),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.background,
          centerTitle: false,
          title: Text("프로필", style: AppFont.bold(20)),
          elevation: 0,
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            final user = viewModel.userData;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  user == null
                      ? _buildSkeletonProfile()
                      : ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: user.imageUrl.isNotEmpty
                              ? CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(user.imageUrl),
                                )
                              : CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                          title: Text(user.name, style: AppFont.bold(20)),
                          subtitle: Text(
                            user.email,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                  SizedBox(height: 10),

                  _buildSectionHeader('정보'),
                  _buildListItem(title: '개인 정보 처리 방침', onTap: () {}),
                  _buildListItem(title: '서비스 운영정책', onTap: () {}),
                  _buildListItem(
                    title: '앱 버전',
                    trailingText: '1.0.0',
                    showArrow: false,
                    onTap: () {},
                  ),
                  _buildDivider(),

                  _buildSectionHeader('계정'),
                  SizedBox(height: 4),
                  AccountSettingItem(
                    title: '로그아웃',
                    onTap: () {
                      viewModel.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                  AccountSettingItem(
                    title: '회원탈퇴',
                    isDestructive: true,
                    onTap: () {
                      viewModel.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonProfile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(radius: 28, backgroundColor: Colors.white),
        title: Container(
          height: 18,
          width: 100,
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 8),
        ),
        subtitle: Container(height: 14, width: 150, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    String? trailingText,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppFont.medium(16)),
            Row(
              children: [
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                if (showArrow)
                  Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: Colors.grey, thickness: 0.2);
  }
}
