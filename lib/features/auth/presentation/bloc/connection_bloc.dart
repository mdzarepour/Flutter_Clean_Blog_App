import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  ConnectionBloc() : super(ConnectionInitial()) {
    on<ConnectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
