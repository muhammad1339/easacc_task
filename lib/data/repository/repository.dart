abstract class RemoteRepository {

}

class Repository implements RemoteRepository{
  Repository._();

  static final instance = Repository._();

  // final ApiService _apiService = ApiService.instance;


}
