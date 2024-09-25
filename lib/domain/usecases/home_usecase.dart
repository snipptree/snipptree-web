import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snippet/common/failure.dart';
import 'package:snippet/domain/models/auth_response.dart';
import 'package:snippet/domain/models/user.dart';
import 'package:snippet/domain/repositories/auth_repo.dart';
import 'package:snippet/injector.dart';

class HomeUseCase {
  final dataSource = getIt.get<AuthRepo>();

  User getUserData(GoogleSignInAccount? account) {
    return User()
      ..email = account?.email
      ..displayName = account?.displayName
      ..profilePicUrl = account?.photoUrl;
  }

  Future<Either<Failure, AuthResponse>> authenticateUser(User user) async {
    final response = await dataSource.authenticateUser(user);
    return response;
  }
}
