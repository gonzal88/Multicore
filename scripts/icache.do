onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/nRST
add wave -noupdate /icache_tb/CLK
add wave -noupdate -expand -group {datapath <> cache} /icache_tb/dcif/halt
add wave -noupdate -expand -group {datapath <> cache} /icache_tb/dcif/ihit
add wave -noupdate -expand -group {datapath <> cache} /icache_tb/dcif/imemREN
add wave -noupdate -expand -group {datapath <> cache} /icache_tb/dcif/imemload
add wave -noupdate -expand -group {datapath <> cache} /icache_tb/dcif/imemaddr
add wave -noupdate -expand -group {cache <> mem control} /icache_tb/ccif/iwait
add wave -noupdate -expand -group {cache <> mem control} {/icache_tb/ccif/iREN[0]}
add wave -noupdate -expand -group {cache <> mem control} /icache_tb/ccif/iload
add wave -noupdate -expand -group {cache <> mem control} {/icache_tb/ccif/iaddr[0]}
add wave -noupdate /icache_tb/DUT/update_block
add wave -noupdate -expand /icache_tb/DUT/icache_sel
add wave -noupdate -expand /icache_tb/DUT/block_data
add wave -noupdate -expand /icache_tb/DUT/block_tag
add wave -noupdate /icache_tb/DUT/block_valid
add wave -noupdate /icache_tb/DUT/hit
add wave -noupdate /icache_tb/DUT/curr_read_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {46 ns} 0}
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
WaveRestoreZoom {0 ns} {462 ns}
