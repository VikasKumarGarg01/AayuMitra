import 'package:shared_preferences/shared_preferences.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';

class CareContextStorage {
  static const _kAppId = 'care.appId';
  static const _kPiId = 'care.piId';
  static const _kCaregiverName = 'care.caregiver.name';
  static const _kCaregiverPhone = 'care.caregiver.phone';
  static const _kElderlyName = 'care.elderly.name';
  static const _kElderlyPhone = 'care.elderly.phone';

  static Future<void> save(CareContext ctx) async {
    final sp = await SharedPreferences.getInstance();
    if (ctx.appId != null) await sp.setString(_kAppId, ctx.appId!);
    if (ctx.piId != null) await sp.setString(_kPiId, ctx.piId!);
    if (ctx.caregiver != null) {
      await sp.setString(_kCaregiverName, ctx.caregiver!.name);
      await sp.setString(_kCaregiverPhone, ctx.caregiver!.phone);
    }
    if (ctx.elderly != null) {
      await sp.setString(_kElderlyName, ctx.elderly!.name);
      await sp.setString(_kElderlyPhone, ctx.elderly!.phone);
    }
  }

  static Future<void> loadIntoNotifier() async {
    final sp = await SharedPreferences.getInstance();
    final appId = sp.getString(_kAppId);
    final piId = sp.getString(_kPiId);
    final caregiverName = sp.getString(_kCaregiverName);
    final caregiverPhone = sp.getString(_kCaregiverPhone);
    final elderlyName = sp.getString(_kElderlyName);
    final elderlyPhone = sp.getString(_kElderlyPhone);

    if (appId != null || piId != null || caregiverName != null || elderlyName != null) {
      final ctx = careContextNotifier.value;
      careContextNotifier.value = CareContext(
        caregiver: caregiverName != null && caregiverPhone != null
            ? CaregiverProfile(
                name: caregiverName,
                age: ctx.caregiver?.age ?? 0,
                phone: caregiverPhone,
                relationship: ctx.caregiver?.relationship ?? '',
                address: ctx.caregiver?.address ?? '',
              )
            : ctx.caregiver,
        elderly: elderlyName != null && elderlyPhone != null
            ? ElderlyProfile(
                name: elderlyName,
                age: ctx.elderly?.age ?? 0,
                phone: elderlyPhone,
                conditions: ctx.elderly?.conditions ?? '',
                address: ctx.elderly?.address ?? '',
              )
            : ctx.elderly,
        appId: appId ?? ctx.appId,
        piId: piId ?? ctx.piId,
      );
    }
  }
}
