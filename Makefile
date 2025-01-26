.POSIX:
.PHONY: clean run run-img

OBJ_DIR := obj
AOBJ_DIR := $(OBJ_DIR)/asm
OUT_DIR := bin
RTS_DIR := ufedmi_rts/adainclude
RTS_DDIR := $(RTS_DIR)/../adalib
RTS_ODIR := $(RTS_DDIR)/obj

SRC_DIR := src
ASM_DIR := $(SRC_DIR)/asm

build-img: $(OUT_DIR)/main.img

build: $(OUT_DIR)/main.elf

$(OUT_DIR)/main.img: $(OUT_DIR)/main.elf
	rm -f $(SRC_DIR)/iso/**.elf
	cp '$<' $(SRC_DIR)/iso/boot
	grub-mkrescue -o '$@' $(SRC_DIR)/iso

ADA_FILES := $(wildcard $(SRC_DIR)/*.ad*)
RTS_FILES := $(wildcard $(RTS_DIR)/*.ad*)
ADA_OBJS := $(patsubst $(SRC_DIR)/%.adb,$(OBJ_DIR)/%.o,$(patsubst $(SRC_DIR)/%.ads,$(OBJ_DIR)/%.o,$(ADA_FILES))) \
			$(patsubst $(RTS_DIR)/%.adb,$(RTS_DDIR)/%.o,$(patsubst $(RTS_DIR)/%.ads,$(RTS_DDIR)/%.o,$(RTS_FILES)))

$(ADA_OBJS):

$(AOBJ_DIR)/%.o: $(ASM_DIR)/%.asm
	nasm -f elf32 $< -o $@

$(OUT_DIR)/main.elf: $(AOBJ_DIR)/*.o $(ADA_OBJS)
	alr build
	mv $(RTS_ODIR)/*.o $(RTS_DDIR)
	ld -m elf_i386 -T $(ASM_DIR)/linker.ld -o '$@' $^ -z noexecstack -z noseparate-code -s

clean:
	rm -rf $(OBJ_DIR)/*
	mkdir $(OBJ_DIR)/asm
	rm -rf $(RTS_DDIR)/*
	rm -rf $(OUT_DIR)/*

run: $(OUT_DIR)/main.elf
	qemu-system-i386 -kernel '$<' -s -d int -no-reboot -rtc base=localtime,clock=vm

run-img: $(OUT_DIR)/main.img
	qemu-system-i386 -hda '$<'
