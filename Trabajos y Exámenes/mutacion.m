nhijos = 4
nbits = 10

hijos_bin = randi([0,1],nhijos,nbits)
if rand()<=.9
   fila = randi([1,nhijos])
   bit1 = randi([1,nbits])
   bit2 = randi([1,nbits-1])
   if bit1==bit2
       bit2 = bit2 + 1
   end
   tmp = hijos_bin(fila,bit1);
   hijos_bin(fila,bit1) = hijos_bin(fila,bit2);
   hijos_bin(fila,bit2) = tmp
end