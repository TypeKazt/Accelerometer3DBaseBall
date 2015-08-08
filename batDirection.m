function [dirVector] = batDirection(hObject, handles)
%batDirection takes in acceleromter data and outputs a filtered directional
%vector.
%   Detailed explanation goes here

[gx gy gz] = readAcc(handles.accelerometer,handles.calCo);

gxFilt = 0;
gyFilt = 0;
gzFilt = 0;
alpha = 0.1;

gxFilt = (1 - alpha)*gxFilt + alpha*gx;
gyFilt = (1 - alpha)*gyFilt + alpha*gy;
gzFilt = (1 - alpha)*gzFilt + alpha*gz;

%dirVector = [gxFilt gyFilt gzFilt];
dirVector = [gx gy gz];
end

