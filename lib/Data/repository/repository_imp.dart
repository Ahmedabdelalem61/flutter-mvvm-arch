import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_app/Data/data_source/local_data_sourece.dart';
import 'package:flutter_mvvm_app/Data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_app/Data/mapper/mapper.dart';
import 'package:flutter_mvvm_app/Data/network/error-handler.dart';
import 'package:flutter_mvvm_app/Data/network/faiure.dart';
import 'package:flutter_mvvm_app/Data/network/network_info.dart';
import 'package:flutter_mvvm_app/Data/responses/responses.dart';
import 'package:flutter_mvvm_app/Domain/models/models.dart';
import 'package:flutter_mvvm_app/Domain/repository/repository.dart';
import 'package:flutter_mvvm_app/Domain/requests.dart';

class RepositoryImp implements Repository{
  late final RemoteDataSource _remoteDataSource;
  late final NetworkInfo _networkInfo;
  late final LocalDataSource _localDataSource;


  RepositoryImp(this._remoteDataSource, this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
   //has internet
    if(await _networkInfo.isConnected){
      try{
        final AuthenticationResponse response = await _remoteDataSource.login(loginRequest);
        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    // there is no internet
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email)async {
    if(await _networkInfo.isConnected){
      try{
        final ForgotPasswordResponse response = await _remoteDataSource.forgotPassword(email);
        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    // there is no internet
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest)async {
    if(await _networkInfo.isConnected){
      try{
        final AuthenticationResponse response = await _remoteDataSource.register(registerRequest);
        if(response.status == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    // there is no internet
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{
      try{
        final homeResponse = await _localDataSource.gethomeDate();
        return Right(homeResponse.toDomain());
      }catch(error){
         if(await _networkInfo.isConnected){
      try{
        final HomeResponse response = await _remoteDataSource.getHomeData();
        if(response.status == ApiInternalStatus.SUCCESS){
          _localDataSource.saveHomeInCache(response);
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    // there is no internet
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
      }
  }
  
  @override
  Future<Either<Failure, StoreDetails>> getStoreDetailsData() async{
   try{
        final storeDetailsResponse = await _localDataSource.getStoreDetailsDate();
        return Right(storeDetailsResponse.toDomain());
      }catch(error){
         if(await _networkInfo.isConnected){
      try{
        final StoreDetailsResponse response = await _remoteDataSource.getStoreDetailsData();
        if(response.status == ApiInternalStatus.SUCCESS){
          _localDataSource.saveStoreDetailsInCache(response);
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    // there is no internet
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
      }
  }

}