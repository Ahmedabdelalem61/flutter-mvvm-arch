import 'package:flutter_mvvm_app/Data/network/error-handler.dart';
import 'package:flutter_mvvm_app/Data/responses/responses.dart';
const String HOME_CACHE_DATA_KEY   = "HOME_CACHE_DATA";
const String STORE_CACHE_DATA_KEY   = "STORE_DETAILS_CACHE_DATA";
const int homeInterval = 60000; // 60000 milliseconds
const int storeDetailsInterval = 30000; // 60000 milliseconds

abstract class LocalDataSource{
  Future<HomeResponse> gethomeDate();
  Future<StoreDetailsResponse> getStoreDetailsDate();
  Future<void> saveHomeInCache(HomeResponse homeResponse);
  Future<void> saveStoreDetailsInCache(StoreDetailsResponse storeDetailsResponse);
  void clearCache();
  void removeFromHomeCache(String key);
  void removeFromStoreDetailsCache(String key);
}

class LocalDataSourceImp implements LocalDataSource{
  
  Map<String,CachedItem> cachedItemMap = {};
  
  @override
  Future<HomeResponse> gethomeDate()async {
    CachedItem? cachedItem = cachedItemMap[HOME_CACHE_DATA_KEY];
    if(cachedItem != null && cachedItem.isValid(homeInterval)){
      return cachedItem.data;
    }
    throw ErrorHandler.handle(DataSource.CACHE_ERROR);
  }

  @override
  Future<void> saveHomeInCache(HomeResponse homeResponse)async {
    cachedItemMap[HOME_CACHE_DATA_KEY] = CachedItem(homeResponse);
  }
  
  @override
  void clearCache() {
    cachedItemMap.clear();
  }
  
  @override
  void removeFromHomeCache(String key) {
    cachedItemMap.remove(key);
  }
  
  @override
  Future<StoreDetailsResponse> getStoreDetailsDate()async {
    CachedItem? cachedItem = cachedItemMap[STORE_CACHE_DATA_KEY];
    if(cachedItem != null && cachedItem.isValid(storeDetailsInterval)){
      return cachedItem.data;
    }
    throw ErrorHandler.handle(DataSource.CACHE_ERROR);
  }
  
  @override
  void removeFromStoreDetailsCache(String key) {
    cachedItemMap.remove(key);
  }
  
  @override
  Future<void> saveStoreDetailsInCache(StoreDetailsResponse storeDetailsResponse)async {
        cachedItemMap[STORE_CACHE_DATA_KEY] = CachedItem(storeDetailsResponse);
  }

}


class CachedItem{
  dynamic data;
  //time since saving data that comming from api to local data runtime based 
  int cachCreationTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
  bool isValid(int determinedTime){
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    return currentTime - cachCreationTime <= determinedTime;
  }
}