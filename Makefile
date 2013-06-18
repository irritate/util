#!/usr/bin/make

# Global
export DC 			= dmd
export DCFLAGS 		= -gc -w -de -unittest
export LIB_FLAG 	= -lib
export DLINK 		= -map

UNAME = $(shell uname)
ifeq ($(UNAME), Darwin)
	export OBJ_TYPE = .o
	export LIB_TYPE = .a
	export PATH_SEP = /
else
	export OBJ_TYPE = .obj
	export LIB_TYPE = .lib
	export PATH_SEP = \\
endif

# Local defines
BUILD_DIR 			= build
SRC 				= main.d
OBJS_UNIX 			= $(patsubst %.d, $(BUILD_DIR)/%$(OBJ_TYPE), $(notdir $(SRC)))
OBJS_OS 			= $(patsubst %.d, $(BUILD_DIR)$(PATH_SEP)%$(OBJ_TYPE), $(SRC))

# List the name of the libraries you want to link
LIB_NAMES 			= Core

# Check to see if we are linking in any static libs
# Handles the case where we don't link anything
ifneq ($(strip $(LIB_NAMES)),)
	LIBS 			= $(addsuffix $(LIB_TYPE), $(addprefix $(BUILD_DIR)$(PATH_SEP), $(LIB_NAMES)))
else
	LIBS 			=
endif

EXE 				= $(notdir $(CURDIR))
RM 					= rm -rf
MAP 				= $(EXE).map
MAKE 				= make

# Rules
.PHONY: $(LIB_NAMES)
all: $(LIB_NAMES) $(EXE)

# Compile archines you need
$(LIB_NAMES) :
	$(MAKE) -C $@

# Link
$(EXE) : $(OBJS_OS) $(LIBS)
	$(DC) $(DCFLAGS) $(DLINK) $(OBJS_UNIX) $(LIBS) -of$(BUILD_DIR)$(PATH_SEP)$(EXE) -od$(BUILD_DIR)

# Compile the object files
$(BUILD_DIR)$(PATH_SEP)%$(OBJ_TYPE) : %.d
	@- mkdir -p $(dir $@)
	$(DC) $(DCFLAGS) $< -c -od$(BUILD_DIR)

# Clean
clean :
	$(RM) $(BUILD_DIR)
