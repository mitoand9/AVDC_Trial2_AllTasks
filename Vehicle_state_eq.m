function x_n = Vehicle_state_eq(x,param)
% ADDME Dynamic model function
%    x = the states
%    param = parameters that you might need, such as vehicle parameters.

global lf lr mass Iz Cf Cr deltatrial dt

alpha12 = atan((x(2,:) + x(3,:)*lf)/x(1,:))-deltatrial;
alpha34 = atan((x(2,:) - x(3,:)*lr)/x(1,:));


%% brush model - no load transfer

SC1 = 0; %steering calibrations
SC2 = 0.87;

mubrush = 0.9;

lamb12 = m*g*(1-lambda)*mubrush/(2*C12*abs(tan(alpha12)));
lamb34 = m*g*lambda*mubrush/(2*C34*abs(tan(alpha34)));

if lamb12 <= 1
    F12 = -C12*tan(alpha12)*lamb12*(2-lamb12); %(-tan(alpha12)*m*g*(1-lambda)*mubrush/(2*abs(tan(alpha12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha12))));
else
    F12 = -C12*tan(alpha12);
end
if lamb34 <= 1
    F34 = -C34*tan(alpha34)*lamb34*(2-lamb34); %(-tan(alpha34)*m*g*lambda*mubrush/(2*abs(tan(alpha34))))*(2-m*g*lambda/(2*C34*abs(tan(alpha34))));
else
    F34 = -C34*tan(alpha34);
end    

%% back to standard

vxdot = (1/mass)*(-F12*sin(deltatrial)) + x(2,:).*x(3,:);
vydot = (1/mass)*(F34 + F12*cos(deltatrial) + x(1,:).*x(3,:));
psidotdot = (1/Iz)*(lf*F12*cos(deltatrial)-lr*F34);

f_x = [vxdot vydot psidotdot]';

% Integrate using Runge Kutta (in the script folder) or simple euler forward

f = @(x)[f_x(1,:);f_x(2,:);f_x(3,:)];
x_n = rk4(f,dt,x(1:3,:));