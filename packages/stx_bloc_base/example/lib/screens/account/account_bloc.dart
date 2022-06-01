import 'package:example/helpers/error_handler.dart';
import 'package:example/screens/account/account_repository.dart';
import 'package:example/screens/account/models/models.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

class AccountBloc extends NetworkBlocBase<Account, NetworkStateBase<Account>> {
  AccountBloc({
    required this.repository,
  }) : super(
          const NetworkStateBase(data: Account()),
          errorHandler: ErrorHandler.parse,
        );

  final AccountRepository repository;

  @override
  Future<Account> onLoadDataAsync() {
    return repository.getAccountInfo();
  }
}
