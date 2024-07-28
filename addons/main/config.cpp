#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {};
        authors[] = {};
        author = "J. Schmidt";
        VERSION_CONFIG;
    };
};

#include "CfgMods.hpp"
#include "CfgMPGameTypes.hpp"
#include "CfgNotifications.hpp"