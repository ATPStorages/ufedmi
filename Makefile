.POSIX:
.PHONY: clean run run-img

OBJ_DIR := obj
OUT_DIR := bin
RTS_DIR := ufedmi_rts/adalib
RTS_DDIR := $(RTS_DIR)/../adaobj

SRC_DIR := src
ASM_DIR := src/asm

build-img: $(OUT_DIR)/main.img

build: $(OUT_DIR)/main.elf

$(OUT_DIR)/main.img: $(OUT_DIR)/main.elf
	rm -f $(SRC_DIR)/iso/**.elf
	cp '$<' $(SRC_DIR)/iso/boot
	grub-mkrescue -o '$@' $(SRC_DIR)/iso

$(OBJ_DIR)/main.o $(RTS_DIR)/*.o: $(SRC_DIR)/main.adb
	alr build
	mv $(RTS_DDIR)/**.o $(RTS_DIR)

# main.elf is the the multiboot file.
$(OUT_DIR)/main.elf: $(OBJ_DIR)/a__entry.o $(OBJ_DIR)/main.o $(RTS_DIR)/*.o
	ld -m elf_i386 -T $(ASM_DIR)/linker.ld -o '$@' $^ -z noexecstack -z noseparate-code -s

$(OBJ_DIR)/a__entry.o: $(ASM_DIR)/entry.asm
	nasm -f elf32 '$<' -o '$@'

clean:
	rm -rf $(OBJ_DIR)/*
	rm -rf $(RTS_DIR)/*
	rm -rf $(RTS_DDIR)/*
	rm -rf $(OUT_DIR)/*

run: $(OUT_DIR)/main.elf
	qemu-system-i386 -kernel '$<' -s -d int -no-reboot

run-img: $(OUT_DIR)/main.img
	qemu-system-i386 -hda '$<'
