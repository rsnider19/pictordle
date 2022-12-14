import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockFirebaseAuth extends Mock implements FirebaseAuth {}

class _MockUserCredential extends Mock implements UserCredential {}

void main() {
  late FirebaseAuth firebaseAuth;
  late UserCredential userCredential;
  late AuthRepository authenticationRepository;

  group('AuthRepository', () {
    setUp(() {
      firebaseAuth = _MockFirebaseAuth();
      userCredential = _MockUserCredential();
      authenticationRepository = AuthRepository(firebaseAuth);
    });

    group('authenticateAnonymously', () {
      test('completes if no exception is thrown', () async {
        when(() => firebaseAuth.signInAnonymously()).thenAnswer((_) async => userCredential);
        await authenticationRepository.authenticateAnonymously();
        verify(() => firebaseAuth.signInAnonymously()).called(1);
      });

      test('throws AuthenticationException when firebase auth fails', () async {
        when(() => firebaseAuth.signInAnonymously()).thenThrow(Exception('oops'));
        expect(
          () => authenticationRepository.authenticateAnonymously(),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });
  });
}
