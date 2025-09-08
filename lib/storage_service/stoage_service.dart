class StorageService {
  final _box = GetStorage();

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  dynamic read(String key) {
    return _box.read(key);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }
}