class ApiSettings {
  static const String _baseUrl = "https://smart-store.mr-dev.tech/api/";
  static const String login = '${_baseUrl}auth/login';
  static const String register = '${_baseUrl}auth/register';
  static const String cities = '${_baseUrl}auth/cities';
  static const String logout = '${_baseUrl}auth/logout';
  static const String storeApiKey = "a70efe7a-8b61-4c8b-a051-769d25bbd937";
  static const String activate = '${_baseUrl}auth/activate';
  static const String home = '${_baseUrl}home';
  static const String categories = '${_baseUrl}categories';
  static const String subCategories = '${_baseUrl}categories/{id}';
}
