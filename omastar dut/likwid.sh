 #!/bin/bash
sleep 5
likwid-perfctr -c 11 -g L3MEM -g L3 sleep  > out2.txt &
#kill -SIGINT $ (ps ho pid -C likwid-perfctr)
# vor nutzung nochmal testen
exit 0
