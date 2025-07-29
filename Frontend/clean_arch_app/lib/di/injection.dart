import 'package:clean_arch_app/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/remote/auth_api.dart';
import '../domain/repositories/stock_remote_data_source.dart';
import '../data/datasources/remote/stock_remote_data_source_impl.dart';
import '../data/repositories_impl/auth_repository_impl.dart';
import '../data/repositories_impl/stock_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/stock_repository.dart';

// Network providers
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'http://localhost:3000/api'; // Update with your API URL
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  // Add interceptors for logging, auth, etc.
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});

// Add more providers as needed for repositories, use cases, etc.

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioProvider);
  final authApi = AuthApiImpl(dio as ApiClient);
  return AuthRepositoryImpl(authApi);
});

final stockRemoteDataSourceProvider = Provider<StockRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return StockRemoteDataSourceImpl(dio: dio);
});

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  final remoteDataSource = ref.read(stockRemoteDataSourceProvider);
  return StockRepositoryImpl(remote: remoteDataSource);
});
