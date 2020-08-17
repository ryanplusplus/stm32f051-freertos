/*!
 * @file
 * @brief
 *
 * Copyright GE Appliances - Confidential - All rights reserved.
 */

#include "FreeRTOS.h"
#include "task.h"

void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName) {
  (void)xTask;
  (void)pcTaskName;

  // fixme it would probably be a good idea to reset
}

unsigned int SEGGER_SYSVIEW_TickCnt;

void vApplicationTickHook(void) {
  SEGGER_SYSVIEW_TickCnt += 1;
}
