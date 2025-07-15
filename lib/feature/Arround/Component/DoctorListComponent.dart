import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Arround/Component/DoctorInfoSheet.dart';
import 'package:openmind_app/feature/Arround/ViewModel/DoctorViewModel.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:provider/provider.dart';

class DoctorListComponent extends StatefulWidget {
  const DoctorListComponent({Key? key}) : super(key: key);

  @override
  State<DoctorListComponent> createState() => _DoctorListComponentState();
}

class _DoctorListComponentState extends State<DoctorListComponent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DoctorViewModel>().fetchDoctors());
  }

  Future<void> _onRefresh() async {
    await context.read<DoctorViewModel>().fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final doctorVM = context.watch<DoctorViewModel>();

    if (doctorVM.isLoading && doctorVM.doctors.isEmpty) {
      return Center(child: CircularProgressIndicator(color: AppColor.main));
    }

    if (!doctorVM.isLoading && doctorVM.doctors.isEmpty) {
      return Center(child: Text("상담원이 없습니다.", style: AppFont.medium(16)));
    }

    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: _onRefresh),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final doctor = doctorVM.doctors[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                elevation: 2,
                shadowColor: Colors.black12,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => DoctorInfoSheet(doctor: doctor),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(doctor.imageUrl),
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            doctor.name,
                            style: AppFont.bold(
                              18,
                            ).copyWith(color: AppColor.main),
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }, childCount: doctorVM.doctors.length),
        ),
      ],
    );
  }
}
