set terminal png tiny size 800,800
set output "out.png"
set xtics rotate ( \
 "NC_017960.1" 1, \
 "NC_017961.1" 2698137, \
 "NC_017962.1" 2734398, \
 "NC_017963.1" 2800644, \
 "" 3052572 \
)
set ytics ( \
 "NODE_1_length_986763_cov_43.494015" 1, \
 "NODE_2_length_840748_cov_42.698417" 986763, \
 "NODE_3_length_500609_cov_47.960903" 1827510, \
 "NODE_4_length_266941_cov_102.662627" 2328118, \
 "NODE_5_length_164595_cov_65.919916" 2595058, \
 "NODE_6_length_150922_cov_42.321628" 2759652, \
 "NODE_7_length_88799_cov_43.513274" 2910573, \
 "NODE_8_length_62897_cov_74.024920" 2999371, \
 "NODE_9_length_31334_cov_224.503597" 3062267, \
 "NODE_10_length_12383_cov_107.950438" 3093600, \
 "NODE_11_length_9325_cov_146.068608" 3105982, \
 "NODE_12_length_5232_cov_70.113772" 3115306, \
 "NODE_13_length_5228_cov_42.845544" 3120537, \
 "NODE_14_length_3460_cov_267.035242" 3125764, \
 "NODE_15_length_3214_cov_234.269706" 3129223, \
 "NODE_16_length_1429_cov_27.793304" 3132436, \
 "NODE_17_length_886_cov_350.894103" 3133864, \
 "NODE_18_length_519_cov_32.366379" 3134749, \
 "NODE_19_length_356_cov_0.481728" 3135267, \
 "NODE_20_length_352_cov_38.013468" 3135622, \
 "NODE_21_length_341_cov_30.041958" 3135973, \
 "NODE_22_length_332_cov_0.274368" 3136313, \
 "NODE_23_length_261_cov_31.368932" 3136644, \
 "NODE_24_length_234_cov_33.156425" 3136904, \
 "NODE_25_length_224_cov_32.189349" 3137137, \
 "NODE_26_length_197_cov_121.774648" 3137360, \
 "NODE_27_length_194_cov_70.956835" 3137556, \
 "NODE_28_length_187_cov_34.416667" 3137749, \
 "NODE_29_length_174_cov_47.050420" 3137935, \
 "NODE_30_length_161_cov_67.075472" 3138108, \
 "NODE_31_length_134_cov_28.455696" 3138268, \
 "NODE_32_length_128_cov_31.561644" 3138401, \
 "NODE_33_length_126_cov_32.957746" 3138528, \
 "NODE_34_length_118_cov_31.507937" 3138653, \
 "NODE_35_length_113_cov_28.155172" 3138770, \
 "NODE_36_length_112_cov_52.877193" 3138882, \
 "NODE_37_length_112_cov_40.964912" 3138993, \
 "NODE_38_length_112_cov_28.438596" 3139104, \
 "NODE_39_length_111_cov_42.196429" 3139215, \
 "NODE_40_length_110_cov_26.145455" 3139325, \
 "NODE_41_length_109_cov_36.462963" 3139434, \
 "NODE_42_length_109_cov_34.500000" 3139542, \
 "NODE_43_length_109_cov_27.870370" 3139650, \
 "NODE_44_length_107_cov_27.942308" 3139758, \
 "NODE_45_length_95_cov_28.800000" 3139864, \
 "NODE_46_length_80_cov_144.920000" 3139958, \
 "NODE_47_length_77_cov_30.727273" 3140037, \
 "NODE_48_length_73_cov_616.555556" 3140113, \
 "NODE_49_length_73_cov_247.777778" 3140185, \
 "NODE_50_length_62_cov_3.000000" 3140257, \
 "NODE_51_length_62_cov_1.428571" 3140318, \
 "NODE_52_length_59_cov_406.000000" 3140379, \
 "NODE_53_length_59_cov_373.750000" 3140437, \
 "NODE_54_length_56_cov_68.000000" 3140495, \
 "" 3140603 \
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
set mouse clipboardformat "[%.0f, %.0f]"
set xrange [1:3052572]
set yrange [1:3140603]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "out.fplot" title "FWD" w lp ls 1, \
 "out.rplot" title "REV" w lp ls 2
