onerror {resume}
quietly virtual signal -install /dcache_tb/DUT {/dcache_tb/DUT/address  } addreeseee
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/CLK
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/nRST
add wave -noupdate -expand -group DCACHE -radix hexadecimal -childformat {{/dcache_tb/DUT/address.tag -radix hexadecimal} {/dcache_tb/DUT/address.idx -radix hexadecimal} {/dcache_tb/DUT/address.blkoff -radix hexadecimal} {/dcache_tb/DUT/address.bytoff -radix hexadecimal}} -expand -subitemconfig {/dcache_tb/DUT/address.tag {-height 17 -radix hexadecimal} /dcache_tb/DUT/address.idx {-height 17 -radix hexadecimal} /dcache_tb/DUT/address.blkoff {-height 17 -radix hexadecimal} /dcache_tb/DUT/address.bytoff {-height 17 -radix hexadecimal}} /dcache_tb/DUT/address
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/tag
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_tag
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/dirty
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_dirty
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/valid
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_valid
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/data
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_data
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/recent
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_recent
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/hit_cnt
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_cnt
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/counter
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_counter
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/ass_idx
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_ass_idx
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/state
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/next_state
add wave -noupdate -expand -group DCACHE /dcache_tb/DUT/notrecent
add wave -noupdate -expand -group ram /dcache_tb/RAM/ramif/ramstore
add wave -noupdate -expand -group ram /dcache_tb/RAM/ramif/ramstate
add wave -noupdate -expand -group ram /dcache_tb/RAM/ramif/ramload
add wave -noupdate -expand -group ram /dcache_tb/RAM/ramif/ramaddr
add wave -noupdate -expand -group ram /dcache_tb/RAM/ramif/ramWEN
add wave -noupdate -expand -group ram /dcache_tb/RAM/ramif/ramREN
add wave -noupdate -expand -group ccif /dcache_tb/ccif/dwait
add wave -noupdate -expand -group ccif /dcache_tb/ccif/dREN
add wave -noupdate -expand -group ccif /dcache_tb/ccif/dWEN
add wave -noupdate -expand -group ccif /dcache_tb/ccif/dload
add wave -noupdate -expand -group ccif /dcache_tb/ccif/dstore
add wave -noupdate -expand -group ccif /dcache_tb/ccif/daddr
add wave -noupdate -expand -group ccif /dcache_tb/ccif/ramWEN
add wave -noupdate -expand -group ccif /dcache_tb/ccif/ramREN
add wave -noupdate -expand -group ccif /dcache_tb/ccif/ramstate
add wave -noupdate -expand -group ccif /dcache_tb/ccif/ramaddr
add wave -noupdate -expand -group ccif /dcache_tb/ccif/ramstore
add wave -noupdate -expand -group ccif /dcache_tb/ccif/ramload
add wave -noupdate -expand -group cif0 /dcache_tb/ccif/cif0/dwait
add wave -noupdate -expand -group cif0 /dcache_tb/ccif/cif0/dREN
add wave -noupdate -expand -group cif0 /dcache_tb/ccif/cif0/dWEN
add wave -noupdate -expand -group cif0 /dcache_tb/ccif/cif0/dload
add wave -noupdate -expand -group cif0 /dcache_tb/ccif/cif0/dstore
add wave -noupdate -expand -group cif0 /dcache_tb/ccif/cif0/daddr
add wave -noupdate -expand -group dcif /dcache_tb/dcif/halt
add wave -noupdate -expand -group dcif /dcache_tb/dcif/ihit
add wave -noupdate -expand -group dcif /dcache_tb/dcif/imemREN
add wave -noupdate -expand -group dcif /dcache_tb/dcif/imemload
add wave -noupdate -expand -group dcif /dcache_tb/dcif/imemaddr
add wave -noupdate -expand -group dcif /dcache_tb/dcif/dhit
add wave -noupdate -expand -group dcif /dcache_tb/dcif/datomic
add wave -noupdate -expand -group dcif /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group dcif /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group dcif /dcache_tb/dcif/flushed
add wave -noupdate -expand -group dcif /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group dcif /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group dcif /dcache_tb/dcif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {58455 ps} 0}
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
WaveRestoreZoom {0 ps} {128480 ps}
