TARGET = $(subst .mk,,$(firstword $(MAKEFILE_LIST)))
BUILD_DIR ?= build

CPU := cortex-m0
ARCH := armv6-m
LINKER_CFG := linker.ld
SVD := svd/stm32f0x1.svd

DEBUG_ADAPTER ?= jlink
JLINK_DEVICE := STM32F051K8
OPENOCD_CFG_DIR := openocd
BLACK_MAGIC_PORT ?= /dev/ttyACM0
BLACK_MAGIC_POWER_TARGET ?= N

USE_SYSTEM_VIEW := Y

DEFINES := \
  STM32F051x8 \
  HSE_VALUE=8000000 \

ifeq ($(USE_SYSTEM_VIEW),Y)
DEFINES += \
  USE_SYSTEM_VIEW \

endif

include tools/defaults.mk

CPPFLAGS += \
  -Wno-unused-parameter \

ifeq ($(USE_SYSTEM_VIEW),Y)
FREERTOS := lib/patched/FreeRTOS-Kernel
else
FREERTOS := lib/FreeRTOS-Kernel
endif

SRC_DIRS := \
  $(FREERTOS) \
  $(FREERTOS)/portable/GCC/ARM_CM0 \
  src \
  src/hardware \

SRC_FILES := \
  lib/stm32cube/CMSIS/STM32F0xx/src/system_stm32f0xx.c \

INC_DIRS := \
  $(FREERTOS)/include \
  lib/stm32cube/CMSIS/ARM/inc \
  lib/stm32cube/CMSIS/STM32F0xx/inc \
  lib/stm32cube/HAL/STM32F0xx/inc \

ifeq ($(USE_SYSTEM_VIEW),Y)
SRC_FILES += \
  lib/SystemView/Sample/NoOS/Config/Cortex-M0/SEGGER_SYSVIEW_Config_NoOS_CM0.c \
  lib/SystemView/SEGGER/SEGGER_RTT.c \
  lib/SystemView/SEGGER/SEGGER_SYSVIEW.c \

SRC_DIRS += \
  lib/SystemView/Sample/FreeRTOSV10 \

INC_DIRS += \
  $(FREERTOS)/include \
  lib/stm32cube/CMSIS/ARM/inc \
  lib/stm32cube/CMSIS/STM32F0xx/inc \
  lib/stm32cube/HAL/STM32F0xx/inc \
  lib/SystemView/SEGGER \
  src/system_view \

endif

IGNORE := $(shell $(MAKE) --no-print-directory -f patch.mk)

BUILD_DEPS += patch.mk

include lib_tiny.mk

include tools/tools.mk

.PHONY: watch
watch:
	@rerun "$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST))"
