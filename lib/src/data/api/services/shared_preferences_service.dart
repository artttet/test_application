import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_application/src/data/api/models/api_model_key.dart';

class SharedPreferencesService {
  static const _isSavedKey = ' isSaved';
  static const _isListSavedKey = ' List isSaved';

  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  bool _getKeysTest(String key, ApiModelKey modelKey, {bool? isSaved, bool? isListSaved}) {
    final hasData = key.contains(modelKey.data);
    var hasWithId = true;
    var hasWithOwnerId = true;
    var hasIsSavedKey = key.contains(_isSavedKey);
    var hasIsListSavedKey = key.contains(_isListSavedKey);

    if (modelKey.withId != null) {
      hasWithId = false;
      final withIdKey = ApiModelKey.withIdKey;
      if (key.contains(withIdKey)) {
        hasWithId = key.contains('$withIdKey ${modelKey.withId}');
      }
    }
    
    if (modelKey.withOwnerId != null) {
      hasWithOwnerId = false;
      final withOwnerIdKey = ApiModelKey.withOwnerIdKey;
      if (key.contains(withOwnerIdKey)) {
        hasWithOwnerId = key.contains('$withOwnerIdKey ${modelKey.withOwnerId}');
      }
    }

    if (isSaved != null) {
      if (isSaved) {
        hasIsSavedKey = !hasIsSavedKey;
      }
    }

    if (isListSaved != null) {
      if (isListSaved) {
        hasIsListSavedKey = !hasIsListSavedKey;
      }
    }
    
    return hasData && hasWithId && hasWithOwnerId && !hasIsSavedKey && !hasIsListSavedKey;
  }

  Future<bool?> getIsDataSaved({required ApiModelKey key}) async {
    final prefs = await _getInstance();

    return prefs.getBool(key.toString() + _isSavedKey);
  }

  Future<void> setIsDataSaved(bool value, {required ApiModelKey key}) async {
    final prefs = await _getInstance();
    await prefs.setBool(key.toString() + _isSavedKey, value);
  }

  Future<Map<String, dynamic>?> getJsonData({required ApiModelKey key}) async {
    final prefs = await _getInstance();
    final data = prefs.getString(key.toString());
    if (data != null) {
      return jsonDecode(data);
    } return null;
  }

  Future<void> setJsonData({required ApiModelKey key, required Map<String, dynamic> jsonObject}) async {
    final prefs = await _getInstance();
    prefs.setString(key.toString(), jsonEncode(jsonObject));
  }

  Future<bool?> getIsDataListSaved({required ApiModelKey key}) async {
    final prefs = await _getInstance();
    return prefs.getBool(key.toString() + _isListSavedKey);
  }

  Future<void> setIsDataListSaved(bool value, {required ApiModelKey key}) async {
    final prefs = await _getInstance();
    await prefs.setBool(key.toString() + _isListSavedKey, value);
  }

  Future<List<Map<String, dynamic>>> getJsonDataList({required ApiModelKey key}) async {
    final prefs = await _getInstance();
    
    final keys = prefs
        .getKeys()
        .where((_key) => _getKeysTest(_key, key))
        .toList();

    if (keys.isNotEmpty) {
      final list = <Map<String, dynamic>>[];

      keys.forEach((_key) {
        final data = prefs.getString(_key);
        if (data != null) {
          list.add(jsonDecode(data));
        }
      });

      return list;
    } else return [];
  }

  Future<void> setJsonDataList(Map<ApiModelKey, Map<String, dynamic>> jsonObjectMap) async {
    final prefs = await _getInstance();

    jsonObjectMap.forEach((modelKey, jsonObject) async {
      await prefs.setString(modelKey.toString(), jsonEncode(jsonObject));
    });
  }
}