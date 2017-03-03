//
//  HYBackTraceFetcher.m
//  HYMonitor
//
//  Created by 贺杨 on 2017/3/3.
//  Copyright © 2017年 He yang. All rights reserved.
//

#import "HYBackTraceFetcher.h"
#import <mach/mach.h>
#include <dlfcn.h>
#include <pthread.h>
#include <sys/types.h>
#include <limits.h>
#include <string.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>

#pragma -mark DEFINE MACRO FOR DIFFERENT CPU ARCHITECTURE
#if defined(__arm64__)
#define DETAG_INSTRUCTION_ADDRESS(A) ((A) & ~(3UL))
#define HY_THREAD_STATE_COUNT ARM_THREAD_STATE64_COUNT
#define HY_THREAD_STATE ARM_THREAD_STATE64
#define HY_FRAME_POINTER __fp
#define HY_STACK_POINTER __sp
#define HY_INSTRUCTION_ADDRESS __pc

#elif defined(__arm__)
#define DETAG_INSTRUCTION_ADDRESS(A) ((A) & ~(1UL))
#define HY_THREAD_STATE_COUNT ARM_THREAD_STATE_COUNT
#define HY_THREAD_STATE ARM_THREAD_STATE
#define HY_FRAME_POINTER __r[7]
#define HY_STACK_POINTER __sp
#define HY_INSTRUCTION_ADDRESS __pc

#elif defined(__x86_64__)
#define DETAG_INSTRUCTION_ADDRESS(A) (A)
#define HY_THREAD_STATE_COUNT x86_THREAD_STATE64_COUNT
#define HY_THREAD_STATE x86_THREAD_STATE64
#define HY_FRAME_POINTER __rbp
#define HY_STACK_POINTER __rsp
#define HY_INSTRUCTION_ADDRESS __rip

#elif defined(__i386__)
#define DETAG_INSTRUCTION_ADDRESS(A) (A)
#define HY_THREAD_STATE_COUNT x86_THREAD_STATE32_COUNT
#define HY_THREAD_STATE x86_THREAD_STATE32
#define HY_FRAME_POINTER __ebp
#define HY_STACK_POINTER __esp
#define HY_INSTRUCTION_ADDRESS __eip

#endif

#define CALL_INSTRUCTION_FROM_RETURN_ADDRESS(A) (DETAG_INSTRUCTION_ADDRESS((A)) - 1)

#if defined(__LP64__)
#define TRACE_FMT         "%-4d%-31s 0x%016lx %s + %lu"
#define POINTER_FMT       "0x%016lx"
#define POINTER_SHORT_FMT "0x%lx"
#define HY_NLIST struct nlist_64
#else
#define TRACE_FMT         "%-4d%-31s 0x%08lx %s + %lu"
#define POINTER_FMT       "0x%08lx"
#define POINTER_SHORT_FMT "0x%lx"
#define HY_NLIST struct nlist
#endif

typedef struct HYStackFrameEntry{
    const struct HYStackFrameEntry *const previous;
    const uintptr_t return_address;
} HYStackFrameEntry;

@implementation HYBackTraceFetcher


@end
