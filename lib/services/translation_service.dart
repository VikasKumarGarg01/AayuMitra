import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TranslationService {
  TranslationService._();
  static final instance = TranslationService._();

  static const _kApiKeyPref = 'gcloud.translate.key';
  static const _kLangPref = 'app.language';

  String _target = 'en';
  final Map<String, String> _cache = {};

  Future<void> init() async {
    final sp = await SharedPreferences.getInstance();
    _target = sp.getString(_kLangPref) ?? 'en';
  }

  Future<void> setTargetLanguage(String langCode) async {
    _target = langCode;
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kLangPref, langCode);
  }

  String get target => _target;

  Future<void> setApiKey(String key) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kApiKeyPref, key);
  }

  Future<String?> _getApiKey() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kApiKeyPref);
  }

  Future<String> translate(String text) async {
    if (_target == 'en' || text.trim().isEmpty) return text;
    final cacheKey = '$_target::$text';
    final cached = _cache[cacheKey];
    if (cached != null) return cached;

    final apiKey = await _getApiKey();
    if (apiKey == null || apiKey.isEmpty) return text; // no key set

    try {
      final uri = Uri.parse(
          'https://translation.googleapis.com/language/translate/v2?key=$apiKey');
      final resp = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'target': _target,
          'format': 'text',
        }),
      );
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body) as Map<String, dynamic>;
        final data = json['data'] as Map<String, dynamic>?;
        final translations = data?['translations'] as List<dynamic>?;
        final translated = translations?.first['translatedText'] as String?;
        if (translated != null) {
          _cache[cacheKey] = translated;
          return translated;
        }
      }
      return text;
    } catch (_) {
      return text;
    }
  }
}
