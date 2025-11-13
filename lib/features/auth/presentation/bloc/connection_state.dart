part of 'connection_bloc.dart';

sealed class ConnectionState extends Equatable {
  const ConnectionState();
  
  @override
  List<Object> get props => [];
}

final class ConnectionInitial extends ConnectionState {}
