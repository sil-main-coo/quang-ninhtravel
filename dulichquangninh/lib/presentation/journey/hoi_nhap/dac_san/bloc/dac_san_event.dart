part of 'dac_san_bloc.dart';

abstract class DacSanEvent extends Equatable {
  const DacSanEvent();
}

class GetDacSanData extends DacSanEvent {
  const GetDacSanData();

  @override
  List<Object> get props => [];
}
