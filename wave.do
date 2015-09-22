onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/PCen
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/PCnext
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/PCcurr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/zero_flag
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/over_flag
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/jr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/RegW
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Branch
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/jump
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Dwen
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Dren
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Iren
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUsource
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/BNE
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/PC
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/regDest
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ExtSel
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Mem
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/opcode_ALU
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/eif/ExtSel
add wave -noupdate /system_tb/DUT/CPU/DP/eif/imm
add wave -noupdate /system_tb/DUT/CPU/DP/eif/extout
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/DWen
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/DRen
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/IRen
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/iREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/PCen
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {459217 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {459050 ps} {460050 ps}
