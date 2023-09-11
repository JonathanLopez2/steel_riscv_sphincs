band='hello_world'

cp $band.elf /opt/riscv/bin
cd /opt/riscv/bin
sudo ./riscv32-unknown-elf-objcopy -O binary $band.elf $band.bin
od -t x4 -v -An -w4 $band.bin > $band.dump
cut -c2- $band.dump > $band.hex
rm $band.bin $band.dump

sudo chmod 777 $band.hex
# obteniendo el asm
sudo ./riscv32-unknown-elf-objdump -d -S $band.elf > $band.txt
#Moviendo archivos a workspace
mv $band.hex $band.txt /home/gunter/sphincsplus-steel/RTL/ips/new-steel-core/hello_world/compiled
