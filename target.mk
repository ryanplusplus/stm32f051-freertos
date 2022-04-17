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

include tools/defaults.mk

SRC_DIRS := \
  src \

SRC_FILES := \

INC_DIRS := \

freertos_USE_SYSTEM_VIEW := N
freertos_CONFIG_DIR := src/freertos
include lib_freertos.mk
include lib/tiny/lib_tiny.mk
include lib_hardware.mk

.PHONY: all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex
	@$(SIZE) $<

.PHONY: watch
watch:
	@rerun "$(MAKE) --no-print-directory -f $(firstword $(MAKEFILE_LIST))"

include tools/tools.mk
