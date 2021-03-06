% Two Area Test Case
% For voltage stability

% bus data format
% bus: 
% col1 number
% col2 voltage magnitude(pu)
% col3 voltage angle(degree)
% col4 p_gen(pu)
% col5 q_gen(pu),
% col6 p_load(pu)
% col7 q_load(pu)
% col8 G shunt(pu)
% col9 B shunt(pu)
% col10 bus_type
%       bus_type - 1, swing bus
%               - 2, generator bus (PV bus)
%               - 3, load bus (PQ bus)
% col11 q_gen_max(pu)
% col12 q_gen_min(pu)
% col13 v_rated (kV)
% col14 v_max  pu
% col15 v_min  pu
% generator var limits opened
bus = [...
      1  1.03   18.5    7.214  2.09  0.00  0.00  0.00  0.00 1  5.0    -2.0  22.0  1.5  .5;
	   2  1.01    8.16   7.00   2.08  0.00  0.00  0.00  0.00 2  5.0    -2.0  22.0  1.5  .5;
	   3  0.949  -7.38   0.00   0.00  0.00  0.00  0.00  0.00 3  0.0    0.0     500.0  1.5 .5;
      4  0.992 -10.2    0.00   0.00  9.76  1.00  0.00  0.00 3  0.0    0.0     115.0  1.5 .5;
	   10 1.003  11.8    0.00   0.00  0.00  0.00  0.00  0.00 3  0.0    0.0     230.0  1.5 .5;
	   11 1.03   -6.97   7.16   2.55  0.00  0.00  0.00  0.00 2  5.0    -2.0  22.0  1.5  .5;
	   12 1.01  -17.32   7.00   3.93  0.00  0.00  0.00  0.00 2  5.0    -2.0  22.0  1.5  .5;
	   13 0.915 -33.47   0.00   0.00  0.00  0.00  0.00  0.00 3  0.0   0.0      500.0  1.5 .5;
      14 1.008 -38.29   0.00   0.00  17.67 1.00  0.00  0.00 3  0.0   0.0     115.0  1.5  .5; 
	   20 0.9706  1.31   0.00   0.00  0.00  0.00  0.00  0.00 3  0.0   0.0     230.0  1.5  .5;
      101 1.05  -21.02  0.00   0.00  0.00  0.00  0.00  5.00 3  0.0   0.0     500.0  1.5  .5;
      110 0.996 -13.67  0.00   0.00  0.00  0.00  0.00  0.00 3  0.0   0.0     230.0  1.5  .5;
      120 0.952 -24.3   0.00   0.00  0.00  0.00  0.00  0.00 3  0.0   0.0     230.0  1.5  .5 ];


% line data format
% line: from bus, to bus, resistance(pu), reactance(pu),
%       line charging(pu), tap ratio, tap phase, tapmax, tapmin, tapsize
% no taps
line = [...
1   10  0.0     0.0167   0.00    1.0  0. 0.  0.  0.;
2   20  0.0     0.0167   0.00    1.0  0. 0.  0.  0.;
3    4  0.0     0.005     0.00   0.0 0.  0   0   0.;
3   20  0.001   0.0100   0.0175  1.0  0. 0.  0.  0.;
3   101 0.011   0.110    0.1925  1.0  0. 0.  0.  0.;
3   101 0.011   0.110    0.1925  1.0  0. 0.  0.  0.;
10  20  0.0025  0.025    0.0437  1.0  0. 0.  0.  0.;
11  110 0.0     0.0167   0.0     1.0  0. 0.  0.  0.;
12  120 0.0     0.0167   0.0     1.0  0. 0.  0.  0.;
13   14 0.0     0.005    0.00    0    0. 0   0   0.;
13  101 0.011   0.11     0.1925  1.0  0. 0.  0.  0.;
13  101 0.011   0.11     0.1925  1.0  0. 0.  0.  0.;
13  120 0.001   0.01     0.0175  1.0  0. 0.  0.  0.;
110 120 0.0025  0.025    0.0437  1.0  0. 0.  0.  0.];



