part of 'phi_vat_the_bloc.dart';

abstract class PhiVatTheState extends Equatable {
  const PhiVatTheState();
}

class PhiVatTheUnKnowState extends PhiVatTheState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PhiVatTheLoadedState extends PhiVatTheState {
  final List<PhiVatTheModel> phiVatThes;

  PhiVatTheLoadedState({
    required this.phiVatThes,
  });

  @override
  // TODO: implement props
  List<Object> get props => [phiVatThes];
}

class PhiVatTheFailureState extends PhiVatTheState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
