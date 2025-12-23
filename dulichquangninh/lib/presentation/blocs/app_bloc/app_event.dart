part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}
class GetApplicationData extends AppEvent {
  const GetApplicationData();


  @override
  List<Object> get props => [];
}