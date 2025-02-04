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

build-iso: $(OUT_DIR)/main.iso

build: $(OUT_DIR)/main.elf

$(OUT_DIR)/main.iso: $(OUT_DIR)/main.elf
	rm -f $(SRC_DIR)/iso/**.elf
	cp '$<' $(SRC_DIR)/iso/boot
	grub-mkrescue -o '$@' $(SRC_DIR)/iso
	cp '$@' /mnt/c/Users/Adenosine3Phosphate/Downloads/main.iso

ADA_FILES := $(wildcard $(SRC_DIR)/*.ad*)
RTS_FILES := $(wildcard $(RTS_DIR)/*.ad*)
ADA_OBJS := $(patsubst $(SRC_DIR)/%.adb,$(OBJ_DIR)/%.o,$(patsubst $(SRC_DIR)/%.ads,$(OBJ_DIR)/%.o,$(ADA_FILES))) \
			$(patsubst $(RTS_DIR)/%.adb,$(RTS_DDIR)/%.o,$(patsubst $(RTS_DIR)/%.ads,$(RTS_DDIR)/%.o,$(RTS_FILES)))
ASM_FILES := $(wildcard $(ASM_DIR)/*.asm)
ASM_OBJS := $(patsubst $(ASM_DIR)/%.asm,$(AOBJ_DIR)/%.o,$(ASM_FILES))

$(ADA_OBJS):

$(AOBJ_DIR)/%.o: $(ASM_DIR)/%.asm
	nasm -f elf32 -O0 -Ov  $< -o $@

$(OUT_DIR)/main.elf: $(ASM_OBJS) $(ADA_OBJS)
	alr build
	mv $(RTS_ODIR)/*.o $(RTS_DDIR)
	ld -m elf_i386 -T $(ASM_DIR)/linker.ld -o '$@' $^ -z noexecstack -z noseparate-code

clean:
	rm -rf $(OBJ_DIR)/*
	mkdir $(OBJ_DIR)/asm
	rm -rf $(RTS_DDIR)/*
	rm -rf $(OUT_DIR)/*

QEMU_FLAGS := -s -d int -no-reboot \
			  -usb -usbdevice keyboard -usbdevice mouse -usbdevice tablet \
			  -net none -serial file:serial.out -cpu 486  #\
			  -drive if=pflash,format=raw,unit=0,file=./OVMF_CODE_4M.fd,readonly=on \
			  -drive if=pflash,format=raw,unit=1,file=./OVMF_VARS_4M.fd

run: $(OUT_DIR)/main.elf
	qemu-system-i386 -kernel '$<' $(QEMU_FLAGS)

run-iso: $(OUT_DIR)/main.iso
	qemu-system-i386 -hda '$<' $(QEMU_FLAGS)