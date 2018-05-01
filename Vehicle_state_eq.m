function x_n = Vehicle_state_eq(x,param)
% ADDME Dynamic model function
%    x = the states
%    param = parameters that you might need, such as vehicle parameters.

global lf lr mass Iz Cf Cr

alpha_12 = atan((x(2,:) + x(3,:)*lf)/x(1,:))-param.delta;
alpha_34 = atan((x(2,:) - x(3,:)*lr)/x(1,:));

F_12 = -C12*alpha_12;
F_34 = -C34*alpha_34;

vxdot = (1/mass)*(-F12*sin(param.delta)) + x(2,:)*x(3,:);
vydot = (1/mass)*(F34 + F12*cos(param.delta) + x(1,:)*x(3,:));
psidotdot = (1/Iz)*(lf*F12*cos(param.delta)-lr*F34);

f_x = [vxdot vydot psidotdot];

% Integrate using Runge Kutta (in the script folder) or simple euler forward

f = @(x)[f_x(1,:);f_x(2,:);f_x(3,:)];
x_n = rk4(f,dt,x(1:3,:));