#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"adf_main"};
        authors[] = {"J. Schmidt", "NikolaiF90"};
        author = "J. Schmidt";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"