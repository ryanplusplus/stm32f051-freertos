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

include tools/defaults.mk

CPPFLAGS += \
  -Wno-unused-parameter \

SRC_DIRS := \
  src \
  src/hardware \

SRC_FILES := \
  lib/stm32cube/CMSIS/STM32F0xx/src/system_stm32f0xx.c \

INC_DIRS := \
  lib/stm32cube/CMSIS/ARM/inc \
  lib/stm32cube/CMSIS/STM32F0xx/inc \
  lib/stm32cube/HAL/STM32F0xx/inc \

include freertos.mk
include lib_tiny.mk

include tools/tools.mk

.PHONY: watch
watch:
	@rerun "$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST))"
