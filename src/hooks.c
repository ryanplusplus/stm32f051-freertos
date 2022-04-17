/*!
 * @file
 * @brief
 *
 * Copyright GE Appliances - Confidential - All rights reserved.
 */

#include "FreeRTOS.h"
#include "interrupts.h"
#include "reset.h"
#include "task.h"

void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName)
{
  (void)xTask;
  (void)pcTaskName;
  reset();
}

void vApplicationIdleHook(void)
{
  interrupts_wait_for_interrupt();
}
