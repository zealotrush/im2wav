function im2wav(imfile, wavfile)
%IM2WAV Convert image file into wave audio file.

% Read image RGB data.
x = imread(imfile);

% Convert RGB to gray-scale.
x = rgb2gray(x);

% Convert 'uint8' type to 'double' type.
x = im2double(x);

% Use black (0) as foreground color and white (1) as background color.
x = 1 - x;

% Low-frequency usually appears at bottom, but the first row of image data is
% at the top, so we need to flip the matrix upside down.
x = flipud(x);

% Call mat2audio, convert 2D matrix into 1D audio data.
y = mat2audio(x);

% Add guassian background white noise to smooth the spectrogram.
y = awgn(y, 40, 'measured');

% Scale the audio to -6 dBFS.
y = 0.5 * y / max(abs(y(:)));

% Write result to wav-file. Sampling frequency is not important here.
audiowrite(wavfile, y, 44100)

end
