import 'package:flutter_mvvm_app/Data/network/error-handler.dart';
import 'package:flutter_mvvm_app/Data/responses/responses.dart';
const String HOME_CACHE_DATA_KEY   = "HOME_CACH_DATA";
const int homeInterval = 60000; // 60000 milliseconds
abstract class LocalDataSource{
  Future<HomeResponse> gethomeDate();
  Future<void> saveInCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromHomeCache(String key);
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
  Future<void> saveInCache(HomeResponse homeResponse)async {
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