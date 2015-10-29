onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/PC_INIT
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -expand /system_tb/DUT/CPU/DP/rtype
add wave -noupdate /system_tb/DUT/CPU/DP/itype
add wave -noupdate /system_tb/DUT/CPU/DP/jtype
add wave -noupdate /system_tb/DUT/CPU/DP/MtR_out
add wave -noupdate /system_tb/DUT/CPU/DP/ALUSrc_out
add wave -noupdate /system_tb/DUT/CPU/DP/Mux_lui
add wave -noupdate /system_tb/DUT/CPU/DP/Baddr
add wave -noupdate /system_tb/DUT/CPU/DP/RegDst_out
add wave -noupdate /system_tb/DUT/CPU/DP/next_PC
add wave -noupdate /system_tb/DUT/CPU/DP/npc
add wave -noupdate /system_tb/DUT/CPU/DP/jump_out
add wave -noupdate /system_tb/DUT/CPU/DP/A_out
add wave -noupdate /system_tb/DUT/CPU/DP/branch_out
add wave -noupdate /system_tb/DUT/CPU/DP/hazard_enable
add wave -noupdate /system_tb/DUT/CPU/DP/memfwA
add wave -noupdate /system_tb/DUT/CPU/DP/memfwB
add wave -noupdate /system_tb/DUT/CPU/DP/wbfwA
add wave -noupdate /system_tb/DUT/CPU/DP/wbfwB
add wave -noupdate -divider DPIF
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/CPUS
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/CPUID
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dWEN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dstore
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/daddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccinv
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccwrite
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/cctrans
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccsnoopaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ramWEN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ramREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ramstate
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ramaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ramstore
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ramload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dload
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccwait
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccinv
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccsnoopaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/iaddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dREN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dWEN
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/daddr
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/dstore
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/ccwrite
add wave -noupdate -group CCIF /system_tb/DUT/CPU/CM/ccif/cctrans
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/CLK
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/nRST
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/curr_state
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_state
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/dcache_sel
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block1_data1
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block1_data2
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block2_data1
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block2_data2
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block1_data1
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block1_data2
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block2_data1
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block2_data2
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block1_tag
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block1_tag
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block2_tag
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block2_tag
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block1_valid
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block1_valid
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block2_valid
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block2_valid
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block1_dirty
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block1_dirty
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/block2_dirty
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_block2_dirty
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/recent_block
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/next_recent_block
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit1
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit2
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit_counter
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/hit_counter_next
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/flush_idx_count
add wave -noupdate -group DCACHE /system_tb/DUT/CPU/CM/DCACHE/flush_idx_count_next
add wave -noupdate /system_tb/DUT/CPU/dcif/halt
add wave -noupdate /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -divider CUIF
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
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/BNE
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/regDest
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ExtSel
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/Mem
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUsource
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/opcode_ALU
add wave -noupdate -divider RFIF
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/rf/array
add wave -noupdate -divider ALIF
add wave -noupdate /system_tb/DUT/CPU/DP/alif/neg_flag
add wave -noupdate /system_tb/DUT/CPU/DP/alif/over_flag
add wave -noupdate /system_tb/DUT/CPU/DP/alif/zero_flag
add wave -noupdate /system_tb/DUT/CPU/DP/alif/portA
add wave -noupdate /system_tb/DUT/CPU/DP/alif/portB
add wave -noupdate /system_tb/DUT/CPU/DP/alif/outport
add wave -noupdate /system_tb/DUT/CPU/DP/alif/aluop
add wave -noupdate -divider PC
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/PCen
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/PCnext
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/PCcurr
add wave -noupdate -divider Extender
add wave -noupdate /system_tb/DUT/CPU/DP/eif/ExtSel
add wave -noupdate /system_tb/DUT/CPU/DP/eif/imm
add wave -noupdate /system_tb/DUT/CPU/DP/eif/extout
add wave -noupdate -divider IFID
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/npc_i
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/npc_o
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/iload_i
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/iload_o
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/dload_i
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/dload_o
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/iien
add wave -noupdate /system_tb/DUT/CPU/DP/ifid/flush
add wave -noupdate -divider IDEX
add wave -noupdate /system_tb/DUT/CPU/DP/idex/target_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/target_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rdat2_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rdat2_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rdat1_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rdat1_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/extout_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/extout_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/Jaddr_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/Jaddr_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/npc_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/npc_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rs_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rs_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rd_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rd_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rt_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/rt_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/dload_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/dload_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/shamt_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/shamt_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/enable
add wave -noupdate /system_tb/DUT/CPU/DP/idex/flush
add wave -noupdate /system_tb/DUT/CPU/DP/idex/lui_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/lui_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/jr_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/jr_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/RegW_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/RegW_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/Branch_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/Branch_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/jump_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/jump_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/DWen_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/DWen_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/DRen_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/DRen_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/BNE_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/BNE_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/halt_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/halt_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/Mem_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/Mem_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/RegDest_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/RegDest_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/ALUsource_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/ALUsource_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/ALUop_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/ALUop_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/opcode_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/opcode_o
add wave -noupdate /system_tb/DUT/CPU/DP/idex/funct_i
add wave -noupdate /system_tb/DUT/CPU/DP/idex/funct_o
add wave -noupdate -divider EXME
add wave -noupdate /system_tb/DUT/CPU/DP/exme/target_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/target_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rdat2_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rdat2_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rdat1_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rdat1_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/extout_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/extout_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/Jaddr_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/Jaddr_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/npc_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/npc_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/alu_out_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/alu_out_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rs_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rs_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rd_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rd_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rt_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/rt_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/dload_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/dload_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/enable
add wave -noupdate /system_tb/DUT/CPU/DP/exme/flush
add wave -noupdate /system_tb/DUT/CPU/DP/exme/jr_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/jr_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/RegW_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/RegW_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/Branch_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/Branch_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/jump_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/jump_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/DWen_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/DWen_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/DRen_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/DRen_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/BNE_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/BNE_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/halt_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/halt_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/zero_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/zero_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/Mem_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/Mem_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/RegDest_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/RegDest_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/ALUsource_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/ALUsource_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/ALUop_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/ALUop_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/opcode_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/opcode_o
add wave -noupdate /system_tb/DUT/CPU/DP/exme/funct_i
add wave -noupdate /system_tb/DUT/CPU/DP/exme/funct_o
add wave -noupdate -divider MEMWB
add wave -noupdate /system_tb/DUT/CPU/DP/mem/target_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/target_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/Addr_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/Addr_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/npc_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/npc_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/alu_out_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/alu_out_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/rs_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/rs_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/rd_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/rd_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/rt_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/rt_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/dload_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/dload_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/enable
add wave -noupdate /system_tb/DUT/CPU/DP/mem/RegW_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/RegW_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/halt_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/halt_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/Mem_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/Mem_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/RegDest_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/RegDest_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/ALUsource_o
add wave -noupdate /system_tb/DUT/CPU/DP/mem/ALUsource_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/opcode_i
add wave -noupdate /system_tb/DUT/CPU/DP/mem/opcode_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0 Green default}
quietly wave cursor active 1
configure wave -namecolwidth 166
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
WaveRestoreZoom {0 ps} {1380330 ns}
