part of 'dac_san_bloc.dart';

abstract class DacSanState extends Equatable {
  const DacSanState();
}

class DacSanUnKnowState extends DacSanState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DacSanLoadedState extends DacSanState {
  final List<DacSanModel> dacsans;

  DacSanLoadedState({
    @required this.dacsans,
  });

  @override
  // TODO: implement props
  List<Object> get props => [dacsans];
}

class DacSanFailureState extends DacSanState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
