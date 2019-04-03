import './bloc-provider.dart';
export 'bloc-provider.dart';
/// Main bloc.
///
/// Access all other blocs via ApplicationBloc
class ApplicationBloc implements BlocBase {
  static ApplicationBloc _singleton;

  factory ApplicationBloc() {
    return _singleton ??= ApplicationBloc._internal();
  }

  ApplicationBloc._internal();

  @override
  void dispose() {

  }
}
