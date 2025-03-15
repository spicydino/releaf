//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cloud_firestore/cloud_firestore_plugin_c_api.h>
#include <file_selector_windows/file_selector_windows.h>
#include <firebase_core/firebase_core_plugin_c_api.h>
<<<<<<< HEAD
#include <geolocator_windows/geolocator_windows.h>
=======
#include <permission_handler_windows/permission_handler_windows_plugin.h>
>>>>>>> e4bf99319a850ef7d6ed48c19db6de3765811621

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CloudFirestorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CloudFirestorePluginCApi"));
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  FirebaseCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
<<<<<<< HEAD
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
=======
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
>>>>>>> e4bf99319a850ef7d6ed48c19db6de3765811621
}
