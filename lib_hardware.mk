$(call create_lib_with_defaults,hardware)

hardware_DEFINES := \
  STM32F051x8 \
  HSE_VALUE=8000000 \

hardware_CPPFLAGS += \
  -Wno-unused-parameter \

hardware_INC_DIRS := \
  $(freertos_exported_INC_DIRS) \
  $(tiny_exported_INC_DIRS) \
  lib/stm32cube/CMSIS/ARM/inc \
  lib/stm32cube/CMSIS/STM32F0xx/inc \
  lib/stm32cube/HAL/STM32F0xx/inc \

hardware_SRC_DIRS := \
  src/hardware \

hardware_SRC_FILES := \
  lib/stm32cube/CMSIS/STM32F0xx/src/system_stm32f0xx.c \

INC_DIRS += \
  lib/stm32cube/CMSIS/ARM/inc \
  lib/stm32cube/CMSIS/STM32F0xx/inc \
  lib/stm32cube/HAL/STM32F0xx/inc \
  src/hardware \

DEFINES += \
  $(hardware_DEFINES)

CPPFLAGS += \
  -Wno-unused-parameter \
