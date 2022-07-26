import 'package:bloc/bloc.dart';
import 'package:bloc_study/api/login_api.dart';
import 'package:bloc_study/api/notes_api.dart';
import 'package:bloc_study/screens/notes_app_screens/bloc/app_states.dart';
import 'package:bloc_study/screens/notes_app_screens/bloc/actions.dart';
import 'package:bloc_study/screens/notes_app_screens/models.dart';

class AppBloc extends Bloc<AppAction,AppState>{
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
  final LoginHandle acceptedLoginHandle;
  AppBloc({
    required this.loginApi,
    required this.notesApi,
    required this.acceptedLoginHandle
  }) : super(const AppState.empty()){
    on<LoginAction>((event, emit) async {
      emit(const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null
      ));

      final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password
      );

      emit(AppState(
          isLoading: false,
          loginErrors: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null
      ));

    });
    on<LoadNotesAction>((event, emit) async {
        emit(AppState(
            isLoading: true,
            loginErrors: null,
            loginHandle: state.loginHandle,
            fetchedNotes: null
        ));

        final loginHandle = state.loginHandle;
        if(acceptedLoginHandle != loginHandle) {
          emit(
            AppState(
                isLoading: false,
                loginErrors: LoginErrors.invalidHandle,
                loginHandle: loginHandle,
                fetchedNotes: null),
          );
          return;
        }
        final notes = await notesApi.getNotes(
            loginHandle: loginHandle!
        );
        emit(
            AppState(
                isLoading: false,
                loginErrors: null,
                loginHandle: loginHandle,
                fetchedNotes: notes
            ));
      });
    }

}
