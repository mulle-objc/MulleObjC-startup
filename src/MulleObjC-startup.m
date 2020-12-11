//
//  MulleObjCStandalone.m
//  MulleObjC
//
//  Copyright (c) 2016 Nat! - Mulle kybernetiK.
//  Copyright (c) 2016 Codeon GmbH.
//  All rights reserved.
//
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  Neither the name of Mulle kybernetiK nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//
#define _GNU_SOURCE

#import <MulleObjC/MulleObjC.h>

#import <MulleObjC/private/mulle-objc-exceptionhandlertable-private.h>
#import <MulleObjC/private/mulle-objc-universefoundationinfo-private.h>
#import <MulleObjC/private/mulle-objc-universeconfiguration-private.h>
#import <MulleObjC/private/MulleObjCExceptionHandler-Private.h>

#include <MulleObjC/private/mulle-objc-startup-private.inc>

// std-c and other dependencies
#include <stdlib.h>


#define MULLE_OBJC_STARTUP_VERSION  ((0 << 20) | (18 << 8) | 0)


//
// starts MulleObjCBang with is defined in mulle-objc-startup-private.inc
//
static void   bang( struct _mulle_objc_universe *universe,
                    struct mulle_allocator *allocator,
                    void *userinfo)
{
   struct _mulle_objc_universeconfiguration   config;

   memcpy( &config,
           mulle_objc_global_get_default_universeconfiguration(),
           sizeof( config));

   MulleObjCBang( universe, allocator, &config);
}

