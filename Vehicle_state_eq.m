function x_n = Vehicle_state_eq(x,param)
% ADDME Dynamic model function
%    x = the states
%    param = parameters that you might need, such as vehicle parameters.

global lf lr mass Iz Cf Cr

vxdot = psidot*vy + (Cf*vy*delta)/(vx*mass) + (Cf*psidot*lf*delta)/(vx*mass) - Cf*delta^2; %vxdot
vydot = -lf*Cf*(vy + psidot*lf)/vx + lr*Cr %vydot
psidotdot = %psidotdot

f_x = (x1,x2,x3);

% Integrate using Runge Kutta (in the script folder) or simple euler forward

f = @(x)[f_x(1,:);f_x(2,:);f_x(3,:)];
x_n = rk4(f,dt,x(1:3,:));