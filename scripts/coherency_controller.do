onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /coherency_controller_tb/nRST
add wave -noupdate /coherency_controller_tb/CLK
add wave -noupdate /coherency_controller_tb/ccif/iwait
add wave -noupdate /coherency_controller_tb/ccif/dwait
add wave -noupdate /coherency_controller_tb/ccif/iREN
add wave -noupdate /coherency_controller_tb/ccif/dREN
add wave -noupdate /coherency_controller_tb/ccif/dWEN
add wave -noupdate /coherency_controller_tb/ccif/iload
add wave -noupdate /coherency_controller_tb/ccif/dload
add wave -noupdate /coherency_controller_tb/ccif/dstore
add wave -noupdate /coherency_controller_tb/ccif/iaddr
add wave -noupdate /coherency_controller_tb/ccif/daddr
add wave -noupdate /coherency_controller_tb/ccif/ccwait
add wave -noupdate /coherency_controller_tb/ccif/ccinv
add wave -noupdate /coherency_controller_tb/ccif/ccwrite
add wave -noupdate /coherency_controller_tb/ccif/cctrans
add wave -noupdate /coherency_controller_tb/ccif/ccsnoopaddr
add wave -noupdate /coherency_controller_tb/ccif/ramWEN
add wave -noupdate /coherency_controller_tb/ccif/ramREN
add wave -noupdate /coherency_controller_tb/ccif/ramstate
add wave -noupdate /coherency_controller_tb/ccif/ramaddr
add wave -noupdate /coherency_controller_tb/ccif/ramstore
add wave -noupdate /coherency_controller_tb/ccif/ramload
add wave -noupdate /coherency_controller_tb/DUT/curr_state
add wave -noupdate /coherency_controller_tb/DUT/next_state
add wave -noupdate /coherency_controller_tb/DUT/cpu_sel
add wave -noupdate /coherency_controller_tb/DUT/next_cpu_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {902 ns}
