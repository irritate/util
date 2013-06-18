#!/usr/bin/make

BUILD_DIR 	= ../build
SRC 		= $(wildcard *.d)
OBJ_BB 		= $(BUILD_DIR)/$(LIB)$(OBJ_TYPE)
OBJ_REG 	= $(patsubst %.d, $(BUILD_DIR)/%$(OBJ_TYPE), $(SRC))

DLINK 		= $(LIB_FLAG)
LIB 		= $(notdir $(CURDIR))
OBJS 		= $(OBJ_REG)

all : $(LIB)

$(LIB) : $(OBJS)
	$(DC) $(DLINK) $^ -of$(LIB) -od$(BUILD_DIR)

$(BUILD_DIR)/%$(OBJ_TYPE) : %.d
	@- mkdir -p $(dir $@)
	$(DC) $(DCFLAGS) $< -c -od$(BUILD_DIR)

$(OBJ_BB) : $(SRC)
	@- mkdir -p $(dir $@)
	$(DC) $(DCFLAGS) $^ -c -of$(OBJS) -od$(BUILD_DIR)
