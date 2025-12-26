part of 'luu_tru_bloc.dart';

abstract class LuuTruEvent extends Equatable {
  const LuuTruEvent();
}

class GetLuuTruData extends LuuTruEvent {
  const GetLuuTruData();


  @override
  List<Object> get props => [];
}