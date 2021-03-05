/*
* Copyright (C) 2018 ETH Zurich and University of Bologna
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#include <stdio.h>
#include "rt/rt_api.h"

#define LED0 5
#define LED1 9
#define LED2 10
#define LED3 11
#define LED4 0
#define LED5 1
#define LED6 2
#define LED7 3

#define SW0 12
#define SW1 13
#define SW2 18
#define SW3 19
#define SW4 22
#define SW5 23
#define SW6 24
#define SW7 25

#define BTNU 17
#define BTNR 16
#define BTND 15
#define BTNL 14


int __rt_fpga_fc_frequency = 20000000;
int __rt_fpga_periph_frequency = 10000000;

int main() {
   rt_pad_set_function(LED0, 1);
   rt_pad_set_function(LED1, 1);
   rt_pad_set_function(LED2, 1);
   rt_pad_set_function(LED3, 1);
   rt_pad_set_function(LED4, 1);
   rt_pad_set_function(LED5, 1);
   rt_pad_set_function(LED6, 1);
   rt_pad_set_function(LED7, 1);
   rt_pad_set_function(SW7, 1);
   rt_pad_set_function(SW6, 1);
   rt_pad_set_function(SW5, 1);
   rt_pad_set_function(SW4, 1);
   rt_pad_set_function(SW3, 1);
   rt_pad_set_function(SW2, 1);
   rt_pad_set_function(SW1, 1);
   rt_pad_set_function(SW0, 1);
   rt_pad_set_function(BTNU, 1);
   rt_pad_set_function(BTNR, 1);
   rt_pad_set_function(BTND, 1);
   rt_pad_set_function(BTNL, 1);
   rt_gpio_init(0, SW0);
   rt_gpio_init(0, SW1);
   rt_gpio_init(0, SW2);
   rt_gpio_init(0, SW3);
   rt_gpio_init(0, SW4);
   rt_gpio_init(0, SW5);
   rt_gpio_init(0, SW6);
   rt_gpio_init(0, SW7);
   rt_gpio_init(0, BTNU);
   rt_gpio_init(0, BTNR);
   rt_gpio_init(0, BTND);
   rt_gpio_init(0, BTNL);
   rt_gpio_init(0, LED0);
   rt_gpio_init(0, LED1);
   rt_gpio_init(0, LED2);
   rt_gpio_init(0, LED3);
   rt_gpio_init(0, LED4);
   rt_gpio_init(0, LED5);
   rt_gpio_init(0, LED6);
   rt_gpio_init(0, LED7);

   rt_gpio_set_dir(0, 1<<LED7 | 1<<LED6 | 1<<LED5 | 1<<LED4 | 1<<LED3 | 1<<LED2 | 1<<LED1 | 1<<LED0, RT_GPIO_IS_OUT);
   rt_gpio_set_dir(0, 1<<BTNU | 1<<BTNR | 1<<BTND | 1<<BTNL, RT_GPIO_IS_IN);
   rt_gpio_set_dir(0, 1<<SW7 | 1<<SW6 | 1<<SW5 | 1<<SW4 | 1<<SW3 | 1<<SW2 | 1<<SW1 | 1<<SW0, RT_GPIO_IS_IN);

   while(1) {
       unsigned int btn = 0 \
           | (rt_gpio_get_pin_value(0, BTNL) << 3) \
           | (rt_gpio_get_pin_value(0, BTNU) << 2) \
           | (rt_gpio_get_pin_value(0, BTNR) << 1) \
           | (rt_gpio_get_pin_value(0, BTND) << 0) \
       ;
       unsigned int sw = 0 \
           | (rt_gpio_get_pin_value(0, SW7) << 7) \
           | (rt_gpio_get_pin_value(0, SW6) << 6) \
           | (rt_gpio_get_pin_value(0, SW5) << 5) \
           | (rt_gpio_get_pin_value(0, SW4) << 4) \
           | (rt_gpio_get_pin_value(0, SW3) << 3) \
           | (rt_gpio_get_pin_value(0, SW2) << 2) \
           | (rt_gpio_get_pin_value(0, SW1) << 1) \
           | (rt_gpio_get_pin_value(0, SW0) << 0) \
       ;

        rt_gpio_set_pin_value(0, LED0, 1);
        rt_gpio_set_pin_value(0, LED1, 1);
        rt_gpio_set_pin_value(0, LED2, 1);
        rt_gpio_set_pin_value(0, LED3, 1);
        rt_gpio_set_pin_value(0, LED4, 1);
        rt_gpio_set_pin_value(0, LED5, 1);
        rt_gpio_set_pin_value(0, LED6, 1);
        rt_gpio_set_pin_value(0, LED7, 1);
        printf("%x\n", rt_gpio_get_value(0));
        rt_time_wait_us(1000*1000);
        rt_gpio_set_pin_value(0, LED0, 0);
        rt_gpio_set_pin_value(0, LED1, 0);
        rt_gpio_set_pin_value(0, LED2, 0);
        rt_gpio_set_pin_value(0, LED3, 0);
        rt_gpio_set_pin_value(0, LED4, 0);
        rt_gpio_set_pin_value(0, LED5, 0);
        rt_gpio_set_pin_value(0, LED6, 0);
        rt_gpio_set_pin_value(0, LED7, 0);
        printf("%x\n", rt_gpio_get_value(0));
        rt_time_wait_us(1000*1000);
   }

 return 0;
}