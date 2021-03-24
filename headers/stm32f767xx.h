#include <stdint.h>

#define RCC_BASE                (*((uint32_t volatile *)0x40023800))

#define RCC_AHB1ENR             (*((uint32_t volatile *)0x40023830))
#define RCC_AHB1ENR_GPIOB_EN    (0x02)
#define RCC_AHB1ENR_GPIOC_EN    (0x04)


#define GPIOB_BASE              (*((uint32_t volatile *)0x40020400))
#define GPIOC_BASE              (*((uint32_t volatile *)0x40020800))

#define GPIOB_MODER             (*((uint32_t volatile *)0x40020400))
#define GPIOC_MODER             (*((uint32_t volatile *)0x40020800))
#define GPIOB_OTYPER            (*((uint32_t volatile *)0x40020404))
#define GPIOC_PUPDR             (*((uint32_t volatile *)0x4002080C))
#define GPIOC_IDR               (*((uint32_t volatile *)0x40020810))
#define GPIOB_ODR               (*((uint32_t volatile *)0x40020414))