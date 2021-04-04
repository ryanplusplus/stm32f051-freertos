/*!
 * @file
 * @brief
 */

#include <stddef.h>
#include "stm32f0xx.h"
#include "clock.h"
#include "FreeRTOS.h"
#include "task.h"
#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "tiny_utils.h"
#include "time_source.h"
#include "tiny_timer.h"
#include "heartbeat.h"

#ifdef USE_SYSTEM_VIEW
#include "SEGGER_SYSVIEW.h"
#endif

static StaticTask_t blink_task;
static StackType_t blink_task_stack[512 / sizeof(StackType_t)];
static void blink_task_function(void* context)
{
  static tiny_timer_group_t timer_group;
  tiny_timer_group_init(&timer_group, time_source_init());
  heartbeat_init(&timer_group);

  while(1) {
    vTaskDelay(tiny_timer_group_run(&timer_group));
  }
}

int main(void)
{
  __disable_irq();
  {
    clock_init();
  }
  __enable_irq();

#ifdef USE_SYSTEM_VIEW
  SEGGER_SYSVIEW_Conf();
  SEGGER_SYSVIEW_Start();
#endif

  xTaskCreateStatic(
    blink_task_function,
    "blink_task",
    element_count(blink_task_stack),
    NULL,
    1,
    blink_task_stack,
    &blink_task);

  vTaskStartScheduler();
}

static StaticTask_t idle_task;
static StackType_t idle_task_stack[configMINIMAL_STACK_SIZE];
void vApplicationGetIdleTaskMemory(StaticTask_t** task, StackType_t** stack, uint32_t* stack_size)
{
  *task = &idle_task;
  *stack = idle_task_stack;
  *stack_size = element_count(idle_task_stack);
}
