function y = mat2audio(x)
%MAT2AUDIO Convert 2D matrix into 1D audio data.

if ~ismatrix(x) || any(size(x) == 1) || isempty(x)
    error('Input X must be a non-empty 2D matrix.')
end

[nrow, ncol] = size(x);

% Add random phase to input data.
H = x .* exp(2i * pi * rand(nrow, ncol));

% IFFT.
nfft   = 2 * nrow;
frames = ifft(H, nfft, 'symmetric');

% Overlap-add (50% overlapping).
win = hann(nfft, 'periodic');
ny  = (ncol + 1) * nfft / 2;
y   = zeros(ny, 1);
k   = 1 : nfft;
for f = frames
    y(k) = y(k) + f.*win;
    k    = k + nfft/2;
end

end
