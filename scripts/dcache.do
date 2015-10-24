onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/CPUCLK
add wave -noupdate /dcache_tb/PROG/i
add wave -noupdate -divider Datapath
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/flushed
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/halt
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dhit
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemaddr
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemstore
add wave -noupdate -divider DUT
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/halt
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/ihit
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/imemREN
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/imemload
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/imemaddr
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/dhit
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/datomic
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/dmemREN
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/dmemWEN
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/flushed
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/dmemload
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/dmemstore
add wave -noupdate -group datapath /dcache_tb/DUT/dcif/dmemaddr
add wave -noupdate /dcache_tb/DUT/curr_state
add wave -noupdate /dcache_tb/DUT/next_state
add wave -noupdate /dcache_tb/DUT/dcache_sel
add wave -noupdate -group data /dcache_tb/DUT/block1_data1
add wave -noupdate -group data /dcache_tb/DUT/next_block1_data1
add wave -noupdate -group data /dcache_tb/DUT/block1_data2
add wave -noupdate -group data /dcache_tb/DUT/next_block1_data2
add wave -noupdate -group data /dcache_tb/DUT/block2_data1
add wave -noupdate -group data /dcache_tb/DUT/next_block2_data1
add wave -noupdate -group data /dcache_tb/DUT/block2_data2
add wave -noupdate -group data /dcache_tb/DUT/next_block2_data2
add wave -noupdate -group tag /dcache_tb/DUT/block1_tag
add wave -noupdate -group tag /dcache_tb/DUT/next_block1_tag
add wave -noupdate -group tag /dcache_tb/DUT/block2_tag
add wave -noupdate -group tag /dcache_tb/DUT/next_block2_tag
add wave -noupdate -group valid /dcache_tb/DUT/block1_valid
add wave -noupdate -group valid /dcache_tb/DUT/next_block1_valid
add wave -noupdate -group valid /dcache_tb/DUT/block2_valid
add wave -noupdate -group valid /dcache_tb/DUT/next_block2_valid
add wave -noupdate -group dirty /dcache_tb/DUT/block1_dirty
add wave -noupdate -group dirty /dcache_tb/DUT/next_block1_dirty
add wave -noupdate -group dirty /dcache_tb/DUT/block2_dirty
add wave -noupdate -group dirty /dcache_tb/DUT/next_block2_dirty
add wave -noupdate -group {recently used} /dcache_tb/DUT/recent_block
add wave -noupdate -group {recently used} /dcache_tb/DUT/next_recent_block
add wave -noupdate /dcache_tb/DUT/hit
add wave -noupdate -group {hit count} /dcache_tb/DUT/hit_counter
add wave -noupdate -group {hit count} /dcache_tb/DUT/hit_counter_next
add wave -noupdate -group {flush idx} /dcache_tb/DUT/flush_idx_count
add wave -noupdate -group {flush idx} /dcache_tb/DUT/flush_idx_count_next
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dwait
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dREN
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dWEN
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dload
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dstore
add wave -noupdate -group ram /dcache_tb/DUT/ccif/daddr
add wave -noupdate -group ram /dcache_tb/DUT/ccif/ramWEN
add wave -noupdate -group ram /dcache_tb/DUT/ccif/ramREN
add wave -noupdate -group ram /dcache_tb/DUT/ccif/ramstate
add wave -noupdate -group ram /dcache_tb/DUT/ccif/ramaddr
add wave -noupdate -group ram /dcache_tb/DUT/ccif/ramstore
add wave -noupdate -group ram /dcache_tb/DUT/ccif/ramload
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dwait
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dload
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dREN
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dWEN
add wave -noupdate -group ram /dcache_tb/DUT/ccif/daddr
add wave -noupdate -group ram /dcache_tb/DUT/ccif/dstore
add wave -noupdate -divider RAM
add wave -noupdate -group cache_controller_if {/dcache_tb/ccif/dREN[0]}
add wave -noupdate -group cache_controller_if {/dcache_tb/ccif/dWEN[0]}
add wave -noupdate -group cache_controller_if {/dcache_tb/ccif/dstore[0]}
add wave -noupdate -group cache_controller_if {/dcache_tb/ccif/daddr[0]}
add wave -noupdate -group cache_controller_if {/dcache_tb/ccif/dwait[0]}
add wave -noupdate -group cache_controller_if {/dcache_tb/ccif/dload[0]}
add wave -noupdate -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dREN
add wave -noupdate -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dWEN
add wave -noupdate -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dstore
add wave -noupdate -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/daddr
add wave -noupdate -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dwait
add wave -noupdate -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dload
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/ramREN
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/ramWEN
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/ramaddr
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/ramstore
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/ramload
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/ramstate
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/memREN
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/memWEN
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/memaddr
add wave -noupdate -group RAM /dcache_tb/RAM/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {128 ns}
