$(call create_lib_with_defaults,freertos)

ifeq ($(freertos_USE_SYSTEM_VIEW),Y)
freertos_CPPFLAGS += -DUSE_SYSTEM_VIEW
freertos_FREERTOS := lib/patched/FreeRTOS-Kernel
else
freertos_FREERTOS := lib/FreeRTOS-Kernel
endif

freertos_INC_DIRS += \
  $(freertos_FREERTOS)/include \
  $(freertos_CONFIG_DIR) \

freertos_SRC_DIRS += \
  $(freertos_FREERTOS) \
  $(freertos_FREERTOS)/portable/GCC/ARM_CM0 \

ifeq ($(freertos_USE_SYSTEM_VIEW),Y)
freertos_SRC_FILES += \
  lib/SystemView/Sample/NoOS/Config/Cortex-M0/SEGGER_SYSVIEW_Config_NoOS_CM0.c \
  lib/SystemView/SEGGER/SEGGER_RTT.c \
  lib/SystemView/SEGGER/SEGGER_SYSVIEW.c \

freertos_SRC_DIRS += \
  lib/SystemView/Sample/FreeRTOSV10 \

freertos_INC_DIRS += \
  lib/SystemView/SEGGER \
  src/system_view \

IGNORE := $(shell $(MAKE) --no-print-directory -f patch.mk)
BUILD_DEPS += patch.mk
endif

freertos_CFLAGS += \
  -Wno-cast-qual

freertos_exported_INC_DIRS := \
  $(freertos_CONFIG_DIR) \
  $(freertos_FREERTOS)/include \
  $(freertos_FREERTOS)/portable/GCC/ARM_CM0 \

INC_DIRS += \
  $(freertos_exported_INC_DIRS)
