#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"adf_main"};
        authors[] = {};
        author = "J. Schmidt";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"