//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <file_selector_windows/file_selector_windows.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry *registry) {
    ConnectivityPlusWindowsPluginRegisterWithRegistrar(
            registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
    FileSelectorWindowsRegisterWithRegistrar(
            registry->GetRegistrarForPlugin("FileSelectorWindows"));
    PermissionHandlerWindowsPluginRegisterWithRegistrar(
            registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}
