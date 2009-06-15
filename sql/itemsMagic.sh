
echo "delete from Item where id>44;"

######################### +1 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Cat&prime;s ',concat(name,' (lesser)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+1,mod_cha,price+1000,lev+5,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Boar&prime;s ',concat(name,' (lesser)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+1,mod_int,mod_dex,mod_cha,price+1000,lev+5,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Fox&prime;s ',concat(name,' (lesser)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha+1,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+1000,lev+5,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Owl&prime;s ',concat(name,' (lesser)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+1,mod_dex,mod_cha,price+1000,lev+5,spell,damage,initiative,durability,type from Item where id=$i;"; done;

######################### +2 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Cat&prime;s ',concat(name,' (minor)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+2,mod_cha,price+2000,lev+10,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Boar&prime;s ',concat(name,' (minor)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+2,mod_int,mod_dex,mod_cha,price+2000,lev+10,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Fox&prime;s ',concat(name,' (minor)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha+2,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+2000,lev+10,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Owl&prime;s ',concat(name,' (minor)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+2,mod_dex,mod_cha,price+2000,lev+10,spell,damage,initiative,durability,type from Item where id=$i;"; done;

######################### +3 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Cat&prime;s ',name),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+3,mod_cha,price+3000,lev+15,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Boar&prime;s ',name),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+3,mod_int,mod_dex,mod_cha,price+3000,lev+15,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Fox&prime;s ',name),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha+3,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+3000,lev+15,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Owl&prime;s ',name),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+3,mod_dex,mod_cha,price+3000,lev+15,spell,damage,initiative,durability,type from Item where id=$i;"; done;


######################### +4 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Cat&prime;s ',concat(name,' (major)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+4,mod_cha,price+4000,lev+20,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Boar&prime;s ',concat(name,' (major)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+4,mod_int,mod_dex,mod_cha,price+4000,lev+20,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Fox&prime;s ',concat(name,' (major)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha+4,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+4000,lev+20,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Owl&prime;s ',concat(name,' (major)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+4,mod_dex,mod_cha,price+4000,lev+20,spell,damage,initiative,durability,type from Item where id=$i;"; done;


######################### +5 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Cat&prime;s ',concat(name,' (superior)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+5,mod_cha,price+5000,lev+25,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Boar&prime;s ',concat(name,' (superior)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+5,mod_int,mod_dex,mod_cha,price+5000,lev+25,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Fox&prime;s ',concat(name,' (superior)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha+5,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+5000,lev+25,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Owl&prime;s ',concat(name,' (superior)')),descr,concat(image,'1'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+5,mod_dex,mod_cha,price+5000,lev+25,spell,damage,initiative,durability,type from Item where id=$i;"; done;



######################### +6 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elf&prime;s ',concat(name,' (lesser)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+6,mod_cha,price+6000,lev+30,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Giant&prime;s ',concat(name,' (lesser)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+6,mod_int,mod_dex,mod_cha,price+6000,lev+30,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Leprechaun&prime;s ',concat(name,' (lesser)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha+6,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+6000,lev+30,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elder&prime;s ',concat(name,' (lesser)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+6,mod_dex,mod_cha,price+6000,lev+30,spell,damage,initiative,durability,type from Item where id=$i;"; done;

######################### +7 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elf&prime;s ',concat(name,' (minor)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+7,mod_cha,price+7000,lev+35,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Giant&prime;s ',concat(name,' (minor)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+7,mod_int,mod_dex,mod_cha,price+7000,lev+35,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Leprechaun&prime;s ',concat(name,' (minor)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha+7,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+7000,lev+35,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elder&prime;s ',concat(name,' (minor)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+7,mod_dex,mod_cha,price+7000,lev+35,spell,damage,initiative,durability,type from Item where id=$i;"; done;

######################### +8 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elf&prime;s ',name),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+8,mod_cha,price+8000,lev+40,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Giant&prime;s ',name),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+8,mod_int,mod_dex,mod_cha,price+8000,lev+40,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Leprechaun&prime;s ',name),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha+8,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+8000,lev+40,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elder&prime;s ',name),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+8,mod_dex,mod_cha,price+8000,lev+40,spell,damage,initiative,durability,type from Item where id=$i;"; done;


######################### +9 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elf&prime;s ',concat(name,' (major)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+9,mod_cha,price+9000,lev+45,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Giant&prime;s ',concat(name,' (major)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+9,mod_int,mod_dex,mod_cha,price+9000,lev+45,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Leprechaun&prime;s ',concat(name,' (major)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha+9,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+9000,lev+45,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elder&prime;s ',concat(name,' (major)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+9,mod_dex,mod_cha,price+9000,lev+45,spell,damage,initiative,durability,type from Item where id=$i;"; done;


######################### +10 ######################### 

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elf&prime;s ',concat(name,' (superior)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex+10,mod_cha,price+10000,lev+50,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Giant&prime;s ',concat(name,' (superior)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str+10,mod_int,mod_dex,mod_cha,price+10000,lev+50,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Leprechaun&prime;s ',concat(name,' (superior)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha+10,req_lev,mod_str,mod_int,mod_dex,mod_cha,price+10000,lev+50,spell,damage,initiative,durability,type from Item where id=$i;"; done;

for i in $(seq 15 30; seq 32 44); do echo "insert into Item(name,descr,image,costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int,mod_dex,mod_cha,price,lev,spell,damage,initiative, durability, type ) SELECT concat('Elder&prime;s ',concat(name,' (superior)')),descr,concat(image,'2'),costAP,req_str,req_int,req_dex,req_cha,req_lev,mod_str,mod_int+10,mod_dex,mod_cha,price+10000,lev+50,spell,damage,initiative,durability,type from Item where id=$i;"; done;