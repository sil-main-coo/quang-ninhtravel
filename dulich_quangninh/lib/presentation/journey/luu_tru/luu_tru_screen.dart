import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/journey/luu_tru/widgets/list_luutru_widget.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/luu_tru_bloc.dart';

class LuuTruScreen extends StatefulWidget {
  @override
  _LuuTruScreenState createState() => _LuuTruScreenState();
}

class _LuuTruScreenState extends State<LuuTruScreen> {
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
      tag: 'hero',
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Lưu trú'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.orange,
              tabs: [
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

              return Center(
                child: const CircularProgressIndicator(),
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
      children: widgets,
    );
  }
}
