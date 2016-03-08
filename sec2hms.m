function str = sec2hms(x);
hour = floor(x/60^2);
minutes = floor(mod((x/60), 60));
seconds = floor(mod(x,60));

str = sprintf('%02d:%02d:%02d', hour, minutes, seconds);
