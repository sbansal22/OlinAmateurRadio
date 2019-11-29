%% Setup
rx = sdrrx('Pluto')
tx = sdrtx('Pluto')

%% Data Collea collection then offliction Example
% Perform datne processing
% Predefine these variables
frameSize = 10;
framesToCollect = 1e3;
data = zeros(frameSize, framesToCollect);
% Collect all frames in continuity
for frame = 1:framesToCollect
  [d,valid,of] = rx();
  % Collect data without overflow and is valid
    if ~valid
      warning('Data invalid')
    elseif of
        warning('Overflow occurred')
    else
        data(:,frame) = d;
    end
end

% Process new live data
sa1 = dsp.SpectrumAnalyzer;
for frame = 1:framesToCollect
    sa1(data(:,frame)); % Algorithm processing
end

%% Save Data Example 1
% Save data for processing
bfw = comm.BasebandFileWriter('PlutoData.bb',rx.BasebandSampleRate,rx.CenterFrequency);
% Save data as a column
bfw(data(:));
bfw.release();

%% Save Data Example 2
% Load data and perform processing
bfr = comm.BasebandFileReader(bfw.Filename, 'SamplesPerFrame',frameSize);
sa2 = dsp.SpectrumAnalyzer;
% Process each frame from the saved file
for frame = 1:framesToCollect
sa2(bfr()); % Algorithm processing
end

%% Save Data Example 3
% Perform stream processing
sa3 = dsp.SpectrumAnalyzer;
% Process each frame immediately
for frame = 1:framesToCollect
    [d,valid,of] = rx();
    % Process data without overflow and is valid
    if ~valid
        warning('Data invalid')
    else
        if of
            warning('Overflow occurred')
        end
        sa3(d); % Algorithm processing
    end
end

%% View Spectrum Example
% View some spectrum
rx = sdrrx('Pluto');
rx.SamplesPerFrame = 2^15;
sa = dsp.SpectrumAnalyzer;
sa.SampleRate = rx.BasebandSampleRate;
for k=1:1e3
    sa(rx());
end

