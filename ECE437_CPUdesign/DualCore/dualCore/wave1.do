onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/imemREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/cuhlt
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/rambusy
add wave -noupdate /system_tb/DUT/RAM/rstate
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4151 ps} 0}
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
WaveRestoreZoom {0 ps} {61 ns}
