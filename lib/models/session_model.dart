class Session {
  Session({
    required this.thisDevice,
    required this.activeSessions,
    required this.code,
    required this.errorMessage,
  });
  late final Device thisDevice;
  late  List<Device>? activeSessions;
  late final int code;
  late final String errorMessage;

  Session.fromJson(Map<String, dynamic> json){
    if(json['thisDevice'] != null) thisDevice =  Device.fromJson(json['thisDevice']);
    activeSessions = List.from(json['activeSessions']).map((e)=>Device.fromJson(e)).toList();
    code = json['code'];
    errorMessage = json['errorMessage'];
  }

  @override
  String toString() {
    return 'Session{thisDevice: $thisDevice, activeSessions: $activeSessions, code: $code, errorMessage: $errorMessage}';
  }
}

class Device {
  Device({
    required this.appName,
    required this.appVersion,
    required this.deviceOs,
    required this.deviceModel,
    required this.ipLocation,
    required this.deviceId,
    required this.loginDate,
    required this.lastUseDate,
  });
  late final String appName;
  late final String appVersion;
  late final String deviceOs;
  late final String deviceModel;
  late final String ipLocation;
  late final String deviceId;
  late final String loginDate;
  late final String lastUseDate;

  Device.fromJson(Map<String, dynamic> json){
    appName = json['appName'];
    appVersion = json['appVersion'].toString();
    deviceOs = json['deviceOs'];
    deviceModel = json['deviceModel'];
    ipLocation = json['ipLocation'].toString();
    deviceId = json['deviceId'];
    loginDate = json['loginDate'].toString();
    lastUseDate = json['lastUseDate'].toString();
  }

  @override
  String toString() {
    return 'Device{appName: $appName, appVersion: $appVersion, deviceOs: $deviceOs, deviceModel: $deviceModel, ipLocation: $ipLocation, deviceId: $deviceId, loginDate: $loginDate, lastUseDate: $lastUseDate}';
  }
}