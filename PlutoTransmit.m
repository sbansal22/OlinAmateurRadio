%% Example 1
% Transmit all zeros
tx = sdrtx('Pluto');
fs = 1e6; fc = 1e4; s = 2*pi*fs*fc*(1:2^(14)).';
wave = complex(cos(s),sin(s));
tx.transmitRepeat(wave);

%% Example 2
% Transmit all zeros
tx = sdrtx('Pluto');
tx(zeros(1024,1));

%% Example 3
% Move transmitter out of receive spectrum
tx = sdrtx('Pluto');
rx = sdrrx('Pluto');
tx.CenterFrequency = rx.CenterFrequency + 100e6;

