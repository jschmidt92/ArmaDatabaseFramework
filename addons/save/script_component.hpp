#define COMPONENT save
#define COMPONENT_BEAUTIFIED Save
#include "..\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_SAVE
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_SAVE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SAVE
#endif

#include "..\main\script_macros.hpp"