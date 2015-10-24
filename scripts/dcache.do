onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/CPUCLK
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/flushed
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/halt
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dhit
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemaddr
add wave -noupdate -expand -group datapath_cache_if /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group cache_controller_if {/dcache_tb/ccif/dREN[0]}
add wave -noupdate -expand -group cache_controller_if {/dcache_tb/ccif/dWEN[0]}
add wave -noupdate -expand -group cache_controller_if {/dcache_tb/ccif/dstore[0]}
add wave -noupdate -expand -group cache_controller_if {/dcache_tb/ccif/daddr[0]}
add wave -noupdate -expand -group cache_controller_if {/dcache_tb/ccif/dwait[0]}
add wave -noupdate -expand -group cache_controller_if {/dcache_tb/ccif/dload[0]}
add wave -noupdate -expand -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dREN
add wave -noupdate -expand -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dWEN
add wave -noupdate -expand -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dstore
add wave -noupdate -expand -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/daddr
add wave -noupdate -expand -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dwait
add wave -noupdate -expand -group cache_controller_if -group {CPUID signals} /dcache_tb/ccif/dload
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
WaveRestoreZoom {0 ps} {1 ns}
