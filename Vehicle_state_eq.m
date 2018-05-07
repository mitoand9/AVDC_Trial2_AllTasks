function x_n = Vehicle_state_eq(x,param)
% ADDME Dynamic model function
%    x = the states
%    param = parameters that you might need, such as vehicle parameters.

% global lf lr mass Iz Cf Cr deltatrial dt

alpha12 = atan((x(2,:) + x(3,:)*param.lf)/x(1,:))-param.delta;
alpha34 = atan((x(2,:) - x(3,:)*param.lr)/x(1,:));

F12 = -param.C12.*alpha12;
F34 = -param.C34.*alpha34;

vxdot = (1/param.mass)*(-F12.*sin(param.delta)) + x(2,:).*x(3,:);
vydot = (1/param.mass)*(F34 + F12.*cos(param.delta) + x(1,:).*x(3,:));
psidotdot = (1/param.Iz)*(param.lf*F12.*cos(param.delta)-param.lr*F34);

f_x = [vxdot vydot psidotdot]';

% Integrate using Runge Kutta (in the script folder) or simple euler forward

f = @(x)[f_x(1,:);f_x(2,:);f_x(3,:)];
x_n = rk4(f,param.dt,x(1:3,:));