shell clear
target remote localhost:1234
br *0x7c00
set disassembly-flavor intel
set tdesc filename target.xml
cont
