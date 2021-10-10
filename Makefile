bootloader: 
	nasm -f bin bootloader.asm -o bootloader.bin
	qemu-system-i386 bootloader.bin

run: 
	qemu-system-i386 os-image.bin

kernel:
	gcc -ffreestanding -c kernel.c -o kernel.o
	ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
	cat bootloader.bin kernel.bin > os-image.bin

debug:
	nasm -f bin bootloader.asm -o bootloader.bin
	qemu-system-i386 -s -S bootloader.bin