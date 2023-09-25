import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  List<Widget> getOpenAppSettingsActions() {
    return [
      ListTile(
        title: const Text('Wifi'),
        minVerticalPadding: 5.0,
        onTap: () => AppSettings.openAppSettings(type: AppSettingsType.wifi),
      ),
      ListTile(
        title: const Text("Location"),
        onTap: () =>
            AppSettings.openAppSettings(type: AppSettingsType.location),
      ),
      ListTile(
        title: const Text("Bluetooth"),
        onTap: () =>
            AppSettings.openAppSettings(type: AppSettingsType.bluetooth),
      ),
      ListTile(
        title: const Text("Display"),
        onTap: () => AppSettings.openAppSettings(type: AppSettingsType.display),
      ),
      ListTile(
        title: const Text("NFC"),
        onTap: () => AppSettings.openAppSettings(type: AppSettingsType.nfc),
      ),
      ListTile(
        title: const Text("VPN"),
        onTap: () => AppSettings.openAppSettings(
            type: AppSettingsType.vpn, asAnotherTask: true),
      ),
      ListTile(
        title: const Text("Device Settings"),
        onTap: () => AppSettings.openAppSettings(
            type: AppSettingsType.device, asAnotherTask: true),
      ),
      ListTile(
        title: const Text("Accessibility"),
        onTap: () => AppSettings.openAppSettings(
            type: AppSettingsType.accessibility, asAnotherTask: true),
      ),
      ListTile(
        title: const Text("Developer"),
        onTap: () => AppSettings.openAppSettings(
            type: AppSettingsType.developer, asAnotherTask: true),
      ),
      ListTile(
        title: const Text("Hotspot"),
        onTap: () => AppSettings.openAppSettings(
            type: AppSettingsType.hotspot, asAnotherTask: true),
      ),
    ];
  }

  List<Widget> getOpenAppSettingsPanelActions() {
    return [
      ListTile(
        title: const Text('Internet connectivity'),
        onTap: () => AppSettings.openAppSettingsPanel(
            AppSettingsPanelType.internetConnectivity),
      ),
      ListTile(
        title: const Text('Volume'),
        onTap: () =>
            AppSettings.openAppSettingsPanel(AppSettingsPanelType.volume),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appSettingsActions = getOpenAppSettingsActions();
    final appSettingsPanelActions = getOpenAppSettingsPanelActions();

    return Scaffold(
      appBar: AppBar(
        title: Text('App Settings'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(appSettingsActions),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(appSettingsPanelActions),
          ),
        ],
      ),
    );
  }
}
