function y_n = Vehicle_measure_eq(x,param)
% ADDME Measurement function
%    x = the states
%    param = parameters that you might need, such as vehicle parameters.

% global lf lr mass Cf Cr deltatrial

alpha12 = atan((x(2,:) + x(3,:)*param.lf)/x(1,:))-param.delta;
alpha34 = atan((x(2,:) - x(3,:)*param.lr)/x(1,:));

F12 = -param.C12*alpha12;
F34 = -param.C34*alpha34;

ay = (1/param.mass)*(F34 + F12*cos(param.delta));

y_n = [x(1,:) ay x(3,:)]';
