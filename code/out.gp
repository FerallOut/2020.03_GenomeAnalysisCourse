set terminal png tiny size 800,800
set output "out.png"
set xtics rotate ( \
 "NC_017960.1" 1.0, \
 "NC_017961.1" 2698137.0, \
 "NC_017962.1" 2734398.0, \
 "NC_017963.1" 2800644.0, \
 "" 3052572 \
)
set ytics ( \
 "tig00000001_pilon" 1.0, \
 "tig00000003_pilon" 2775725.0, \
 "tig00000004_pilon" 2987085.0, \
 "tig00000006_pilon" 3033805.0, \
 "tig00000007_pilon" 3047203.0, \
 "tig00000008_pilon" 3087219.0, \
 "tig00000009_pilon" 3102826.0, \
 "tig00000010_pilon" 3119937.0, \
 "tig00000013_pilon" 3147248.0, \
 "tig00000017_pilon" 3156543.0, \
 "" 3166347 \
)
set size 1,1
set grid
unset key
set border 0
set tics scale 0
set xlabel "REF"
set ylabel "QRY"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
if(GPVAL_VERSION < 5) { set mouse clipboardformat "[%.0f, %.0f]" }
set xrange [1:3052572]
set yrange [1:3166347]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "out.fplot" title "FWD" w lp ls 1, \
 "out.rplot" title "REV" w lp ls 2
