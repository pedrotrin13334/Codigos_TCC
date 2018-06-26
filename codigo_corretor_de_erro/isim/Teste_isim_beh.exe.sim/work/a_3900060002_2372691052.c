/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/PedroHenrique/Documents/Projeto_TCC/TCC/Teste.vhd";



static void work_a_3900060002_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t7;
    char *t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(77, ng0);

LAB3:    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t2 = t1;
    t3 = (t0 + 3268);
    memcpy(t2, t3, 4U);
    t2 = (t2 + 4U);
    t5 = (t0 + 3272);
    memcpy(t2, t5, 4U);
    t2 = (t2 + 4U);
    t7 = (t0 + 3276);
    memcpy(t2, t7, 4U);
    t2 = (t2 + 4U);
    t9 = (t0 + 3280);
    memcpy(t2, t9, 4U);
    t11 = (t0 + 1812);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    t14 = (t13 + 40U);
    t15 = *((char **)t14);
    memcpy(t15, t1, 16U);
    xsi_driver_first_trans_fast(t11);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3900060002_2372691052_p_1(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(78, ng0);

LAB3:    t1 = (t0 + 3284);
    t3 = (t0 + 1848);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 4U);
    xsi_driver_first_trans_fast(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3900060002_2372691052_init()
{
	static char *pe[] = {(void *)work_a_3900060002_2372691052_p_0,(void *)work_a_3900060002_2372691052_p_1};
	xsi_register_didat("work_a_3900060002_2372691052", "isim/Teste_isim_beh.exe.sim/work/a_3900060002_2372691052.didat");
	xsi_register_executes(pe);
}
