bootloader: 
	nasm -f bin bootloader.asm -o bootloader.bin
	qemu-system-i386 bootloader.bin

debug:
	nasm -f bin bootloader.asm -o bootloader.bin
	qemu-system-i386 -s -S bootloader.bin