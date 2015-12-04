onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/CLK
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/nRST
add wave -noupdate -group datapath0 -group pcif /system_tb/DUT/CPU/DP0/pcif/PCen
add wave -noupdate -group datapath0 -group pcif /system_tb/DUT/CPU/DP0/pcif/PCnext
add wave -noupdate -group datapath0 -group pcif /system_tb/DUT/CPU/DP0/pcif/PCcurr
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/npc_i
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/npc_o
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/iload_i
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/iload_o
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/dload_i
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/dload_o
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/iien
add wave -noupdate -group datapath0 -group IF/ID /system_tb/DUT/CPU/DP0/ifid/flush
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/rtype
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/itype
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/jtype
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/npc
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/Baddr
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/hazard_enable
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/opcode
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/funct
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/zero_flag
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/over_flag
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/lui
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/jr
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/RegW
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/Branch
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/jump
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/Dwen
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/Dren
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/Iren
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/halt
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/BNE
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/regDest
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/ExtSel
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/Mem
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/ALUsource
add wave -noupdate -group datapath0 -group cuif /system_tb/DUT/CPU/DP0/cuif/opcode_ALU
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/WEN
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/wsel
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/rsel1
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/rsel2
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/wdat
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rfif/rdat2
add wave -noupdate -group datapath0 -group rfif /system_tb/DUT/CPU/DP0/rf/array
add wave -noupdate -group datapath0 -group eif /system_tb/DUT/CPU/DP0/eif/ExtSel
add wave -noupdate -group datapath0 -group eif /system_tb/DUT/CPU/DP0/eif/imm
add wave -noupdate -group datapath0 -group eif /system_tb/DUT/CPU/DP0/eif/extout
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/target_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/target_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rdat2_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rdat2_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rdat1_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rdat1_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/extout_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/extout_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/Jaddr_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/Jaddr_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/npc_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/npc_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rs_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rs_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rd_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rd_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rt_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/rt_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/dload_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/dload_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/shamt_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/shamt_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/braPC_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/braPC_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/enable
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/flush
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/lui_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/lui_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/jr_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/jr_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/RegW_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/RegW_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/Branch_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/Branch_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/jump_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/jump_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/DWen_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/DWen_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/DRen_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/DRen_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/BNE_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/BNE_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/halt_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/halt_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/Mem_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/Mem_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/RegDest_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/RegDest_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/ALUsource_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/ALUsource_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/ALUop_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/ALUop_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/opcode_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/opcode_o
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/funct_i
add wave -noupdate -group datapath0 -group ID/EX /system_tb/DUT/CPU/DP0/idex/funct_o
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/next_PC
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/neg_flag
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/over_flag
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/zero_flag
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/portA
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/portB
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/outport
add wave -noupdate -group datapath0 -group alu /system_tb/DUT/CPU/DP0/alif/aluop
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/branch_out
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/jump_out
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/ALUSrc_out
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/target_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/target_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rdat2_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rdat2_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rdat1_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rdat1_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/extout_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/extout_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/Jaddr_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/Jaddr_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/npc_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/npc_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/alu_out_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/alu_out_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rs_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rs_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rd_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rd_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rt_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/rt_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/dload_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/dload_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/braPC_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/braPC_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/enable
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/flush
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/jr_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/jr_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/RegW_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/RegW_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/Branch_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/Branch_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/jump_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/jump_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/DWen_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/DWen_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/DRen_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/DRen_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/BNE_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/BNE_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/halt_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/halt_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/zero_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/zero_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/Mem_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/Mem_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/RegDest_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/RegDest_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/ALUsource_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/ALUsource_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/ALUop_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/ALUop_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/opcode_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/opcode_o
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/funct_i
add wave -noupdate -group datapath0 -group EX/MEM /system_tb/DUT/CPU/DP0/exme/funct_o
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/Mux_lui
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/memfwA
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/memfwB
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/wbfwA
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/wbfwB
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/fwrdA
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/fwrdB
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/A_out
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/target_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/target_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/Addr_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/Addr_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/npc_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/npc_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/alu_out_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/alu_out_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/rs_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/rs_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/rd_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/rd_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/rt_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/rt_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/dload_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/dload_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/enable
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/RegW_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/RegW_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/halt_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/halt_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/Mem_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/Mem_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/RegDest_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/RegDest_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/ALUsource_o
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/ALUsource_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/opcode_i
add wave -noupdate -group datapath0 -group MEM/WB /system_tb/DUT/CPU/DP0/mem/opcode_o
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/RegDst_out
add wave -noupdate -group datapath0 /system_tb/DUT/CPU/DP0/MtR_out
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/CLK
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/nRST
add wave -noupdate -group datapath1 -group pcif /system_tb/DUT/CPU/DP1/pcif/PCen
add wave -noupdate -group datapath1 -group pcif /system_tb/DUT/CPU/DP1/pcif/PCnext
add wave -noupdate -group datapath1 -group pcif /system_tb/DUT/CPU/DP1/pcif/PCcurr
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/npc_i
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/npc_o
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/iload_i
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/iload_o
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/dload_i
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/dload_o
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/iien
add wave -noupdate -group datapath1 -group IF/ID /system_tb/DUT/CPU/DP1/ifid/flush
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/rtype
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/itype
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/jtype
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/npc
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/Baddr
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/hazard_enable
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/opcode
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/funct
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/zero_flag
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/over_flag
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/lui
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/jr
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/RegW
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/Branch
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/jump
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/Dwen
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/Dren
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/Iren
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/halt
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/BNE
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/regDest
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/ExtSel
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/Mem
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/ALUsource
add wave -noupdate -group datapath1 -group cuif /system_tb/DUT/CPU/DP1/cuif/opcode_ALU
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate -group datapath1 -group rfif /system_tb/DUT/CPU/DP1/rf/array
add wave -noupdate -group datapath1 -group eif /system_tb/DUT/CPU/DP1/eif/ExtSel
add wave -noupdate -group datapath1 -group eif /system_tb/DUT/CPU/DP1/eif/imm
add wave -noupdate -group datapath1 -group eif /system_tb/DUT/CPU/DP1/eif/extout
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/target_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/target_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rdat2_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rdat2_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rdat1_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rdat1_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/extout_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/extout_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/Jaddr_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/Jaddr_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/npc_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/npc_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rs_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rs_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rd_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rd_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rt_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/rt_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/dload_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/dload_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/shamt_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/shamt_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/braPC_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/braPC_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/enable
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/flush
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/lui_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/lui_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/jr_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/jr_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/RegW_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/RegW_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/Branch_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/Branch_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/jump_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/jump_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/DWen_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/DWen_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/DRen_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/DRen_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/BNE_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/BNE_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/halt_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/halt_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/Mem_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/Mem_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/RegDest_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/RegDest_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/ALUsource_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/ALUsource_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/ALUop_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/ALUop_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/opcode_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/opcode_o
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/funct_i
add wave -noupdate -group datapath1 -group ID/EX /system_tb/DUT/CPU/DP1/idex/funct_o
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/next_PC
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/neg_flag
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/over_flag
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/zero_flag
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/portA
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/portB
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/outport
add wave -noupdate -group datapath1 -group alu /system_tb/DUT/CPU/DP1/alif/aluop
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/branch_out
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/jump_out
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/ALUSrc_out
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/target_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/target_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rdat2_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rdat2_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rdat1_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rdat1_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/extout_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/extout_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/Jaddr_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/Jaddr_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/npc_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/npc_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/alu_out_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/alu_out_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rs_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rs_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rd_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rd_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rt_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/rt_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/dload_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/dload_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/braPC_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/braPC_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/enable
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/flush
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/jr_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/jr_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/RegW_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/RegW_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/Branch_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/Branch_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/jump_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/jump_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/DWen_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/DWen_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/DRen_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/DRen_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/BNE_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/BNE_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/halt_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/halt_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/zero_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/zero_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/Mem_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/Mem_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/RegDest_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/RegDest_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/ALUsource_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/ALUsource_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/ALUop_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/ALUop_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/opcode_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/opcode_o
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/funct_i
add wave -noupdate -group datapath1 -group EX/MEM /system_tb/DUT/CPU/DP1/exme/funct_o
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/Mux_lui
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/memfwA
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/memfwB
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/wbfwA
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/wbfwB
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/fwrdA
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/fwrdB
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/A_out
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/target_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/target_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/Addr_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/Addr_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/npc_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/npc_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/alu_out_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/alu_out_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/rs_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/rs_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/rd_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/rd_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/rt_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/rt_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/dload_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/dload_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/enable
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/RegW_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/RegW_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/halt_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/halt_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/Mem_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/Mem_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/RegDest_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/RegDest_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/ALUsource_o
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/ALUsource_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/opcode_i
add wave -noupdate -group datapath1 -group MEM/WB /system_tb/DUT/CPU/DP1/mem/opcode_o
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/RegDst_out
add wave -noupdate -group datapath1 /system_tb/DUT/CPU/DP1/MtR_out
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/CLK
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/nRST
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/curr_read_state
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/next_read_state
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/icache_sel
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/next_block_data
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/next_block_tag
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/next_block_valid
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/update_block
add wave -noupdate -group ICACHE_0 /system_tb/DUT/CPU/CM0/ICACHE/hit
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/CLK
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/nRST
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/curr_read_state
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/next_read_state
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/icache_sel
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/next_block_data
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/next_block_tag
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/next_block_valid
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/update_block
add wave -noupdate -group ICACHE_1 /system_tb/DUT/CPU/CM1/ICACHE/hit
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/CPUID
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/curr_state
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/dcache_sel
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop_sel
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block1_data1
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block1_data2
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block2_data1
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block2_data2
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block1_data1
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block1_data2
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block2_data1
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block2_data2
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block1_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop1_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop2_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_snoop1_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_snoop2_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop1_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_snoop1_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_snoop2_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop2_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop1_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_snoop1_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_snoop2_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/snoop2_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block1_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block2_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block2_tag
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block1_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block1_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block2_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block2_valid
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block1_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block1_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/block2_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_block2_dirty
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/recent_block
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/next_recent_block
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/hit
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/hit1
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/hit2
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/flush_idx_count
add wave -noupdate -group DCACHE_0 /system_tb/DUT/CPU/CM0/DCACHE/flush_idx_count_next
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/CPUID
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/curr_state
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/dcache_sel
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop_sel
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block1_data1
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block1_data2
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block2_data1
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block2_data2
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block1_data1
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block1_data2
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block2_data1
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block2_data2
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block1_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop1_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop2_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_snoop1_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_snoop2_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop1_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_snoop1_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_snoop2_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop2_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop1_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_snoop1_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_snoop2_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/snoop2_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block1_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block2_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block2_tag
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block1_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block1_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block2_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block2_valid
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block1_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block1_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/block2_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_block2_dirty
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/recent_block
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/next_recent_block
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/hit
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/hit1
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/hit2
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/flush_idx_count
add wave -noupdate -group DCACHE_1 /system_tb/DUT/CPU/CM1/DCACHE/flush_idx_count_next
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/CPUS
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/CPUID
add wave -noupdate -expand -group ccif -radix binary /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group ccif -radix binary /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group ccif -radix binary /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group ccif -radix binary /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group ccif -radix binary /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group {coherency controller} /system_tb/DUT/CPU/CC/curr_state
add wave -noupdate -expand -group {coherency controller} /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -expand -group {coherency controller} /system_tb/DUT/CPU/CC/cpu_sel
add wave -noupdate -expand -group {coherency controller} /system_tb/DUT/CPU/CC/next_cpu_sel
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/ramREN
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/ramWEN
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/ramaddr
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/ramstore
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/ramload
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/ramstate
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/memREN
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/memWEN
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/memaddr
add wave -noupdate -expand -group cpu_ram_if /system_tb/DUT/CPU/scif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Writes Start} {3415671 ps} 1 Green default} {{Writes End} {4099094 ps} 1} {{Cursor 4} {3714907 ps} 0}
quietly wave cursor active 3
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
WaveRestoreZoom {3342649 ps} {4187759 ps}
