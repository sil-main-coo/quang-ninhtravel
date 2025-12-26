import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../diem_du_lich/diem_du_lich_screen.dart';
import 'bloc/luu_tru_bloc.dart';
import 'widgets/list_luutru_widget.dart';

class DiemDenScreen extends StatefulWidget {
  @override
  _DiemDenScreenState createState() => _DiemDenScreenState();
}

class _DiemDenScreenState extends State<DiemDenScreen> {
  final _bloc = locator<LuuTruBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetLuuTruData());
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_diem_den',
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Điểm đến - Nghỉ dưỡng'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.orange,
              tabs: [
                Tab(
                  child: Text('Điểm du lịch'),
                ),
                Tab(
                  child: Text('Khách sạn'),
                ),
                Tab(
                  child: Text('Nhà nghỉ'),
                ),
              ],
            ),
          ),
          body: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is LuuTruFailureState) {
                return _error();
              }
              if (state is LuuTruLoadedState) {
                return _bodyTabBar(state.mapLuuTru);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _error() {
    return Center(
      child: Text('Lỗi'),
    );
  }

  Widget _bodyTabBar(Map<LoaiLuuTruModel, List<LuuTruModel>> mapLuuTru) {
    final List<Widget> widgets =
        mapLuuTru.entries.map((e) => ListLuuTruWidget(e.key, e.value)).toList();
    return TabBarView(
      children: [DiemDuLichScreen(), ...widgets],
    );
  }
}
