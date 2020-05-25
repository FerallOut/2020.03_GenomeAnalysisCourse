set terminal png tiny size 800,800
set output "out.png"
set xtics rotate ( \
 "NC_017960.1" 1.0, \
 "NC_017961.1" 2698137.0, \
 "NC_017962.1" 2734398.0, \
 "NC_017963.1" 2800644.0, \
 "" 3052572 \
)
set size 1,1
set grid
unset key
set border 5
set tics scale 0
set xlabel "REF"
set ylabel "tig00000001"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
if(GPVAL_VERSION < 5) { set mouse clipboardformat "[%.0f, %.0f]" }
set xrange [1:3052572]
set yrange [1:2775618]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "out.fplot" title "FWD" w lp ls 1, \
 "out.rplot" title "REV" w lp ls 2
