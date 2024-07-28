#define COMPONENT generate
#define COMPONENT_BEAUTIFIED Generate
#include "..\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_GENERATE
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_GENERATE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_GENERATE
#endif

#include "..\main\script_macros.hpp"