ifeq ($(USE_SYSTEM_VIEW),Y)
CPPFLAGS += -DUSE_SYSTEM_VIEW
FREERTOS := lib/patched/FreeRTOS-Kernel
else
FREERTOS := lib/FreeRTOS-Kernel
endif

INC_DIRS += \
  $(FREERTOS)/include \

SRC_DIRS += \
  $(FREERTOS) \
  $(FREERTOS)/portable/GCC/ARM_CM0 \

ifeq ($(USE_SYSTEM_VIEW),Y)
SRC_FILES += \
  lib/SystemView/Sample/NoOS/Config/Cortex-M0/SEGGER_SYSVIEW_Config_NoOS_CM0.c \
  lib/SystemView/SEGGER/SEGGER_RTT.c \
  lib/SystemView/SEGGER/SEGGER_SYSVIEW.c \

SRC_DIRS += \
  lib/SystemView/Sample/FreeRTOSV10 \

INC_DIRS += \
  lib/SystemView/SEGGER \
  src/system_view \

IGNORE := $(shell $(MAKE) --no-print-directory -f patch.mk)
BUILD_DEPS += patch.mk
endif
