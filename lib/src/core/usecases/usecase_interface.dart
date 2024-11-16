import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

abstract interface class IUsecase<Type, Params> {
  Future<Output<Type>> call(Params params);
}
