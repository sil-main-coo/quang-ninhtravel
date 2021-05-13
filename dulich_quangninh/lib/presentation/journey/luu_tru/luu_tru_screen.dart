import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/luu_tru_bloc.dart';

class LuuTruScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero',
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lưu trú'),
        ),
        body: BlocBuilder<LuuTruBloc, LuuTruState>(
          builder: (context, state) {
            if (state is LuuTruFailureState) {
              return _error();
            }
            if (state is LuuTruLoadedState) {
              return _bodyWidget(state.mapLuuTru);
            }

            return Center(
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _error() {
    return Center(
      child: Text('Lỗi'),
    );
  }

  Widget _bodyWidget(Map<LoaiLuuTruModel, List<LuuTruModel>> mapLuuTru) {
    return Text(mapLuuTru.toString());
  }
}
