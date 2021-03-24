#include "./headers/main.h"
#include "./headers/stm32f767xx.h"
#include <stdint.h>

int main(void)
{
    // Enable GPIO clocks
    RCC_AHB1ENR |= RCC_AHB1ENR_GPIOB_EN;
    RCC_AHB1ENR |= RCC_AHB1ENR_GPIOC_EN;
    
    // Initialise GPIOC pin for BUTTON
    GPIOC_MODER = 0x00000000;
    GPIOC_PUPDR = 0x01000000;

    // Initialise GPIOB pin for LED
    GPIOB_MODER = 0x10004001;
    GPIOB_OTYPER = 0x00000000;

    // Keep track of whether the button is pressed.
    uint8_t button_down = 0;
    int curr = 0;
    while (1)
    {
        uint32_t idr_val = (GPIOC_IDR);
        if (idr_val & (1 << BUTTON_PIN))
        {
            // The button is pressed, so change the LED state
            if (!button_down)
            {
                if (curr == 0)
                {
                    GPIOB_ODR = (1 << LED_PIN_1);
                    curr = 1;
                }
                else if (curr == 1)
                {
                    GPIOB_ODR = (1 << LED_PIN_2);
                    curr = 2;
                } else if (curr == 2)
                {
                    GPIOB_ODR = (1 << LED_PIN_3);
                    curr = 0;
                }
            }
            button_down = 1;
        }
        else 
        {
            button_down = 0;
        }
    }
}