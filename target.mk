include tools/setup.mk

TARGET = target
BUILD_DIR ?= build

CPU := cortex-m0
ARCH := armv6-m
LINKER_SCRIPT := linker.ld
SVD := svd/stm32f0x1.svd

DEBUG_ADAPTER ?= jlink
JLINK_DEVICE := STM32F051K8
OPENOCD_CFG_DIR := openocd
BLACK_MAGIC_PORT ?= /dev/ttyACM0
BLACK_MAGIC_POWER_TARGET ?= N

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

freertos_USE_SYSTEM_VIEW := N
freertos_CONFIG_DIR := src
include lib_freertos.mk
include lib/tiny/lib_tiny.mk

.PHONY: all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex
	@$(SIZE) $<

.PHONY: watch
watch:
	@rerun "$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST))"

include tools/tools.mk
