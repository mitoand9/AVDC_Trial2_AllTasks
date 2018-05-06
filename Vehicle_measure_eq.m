function y_n = Vehicle_measure_eq(x,param)
% ADDME Measurement function
%    x = the states
%    param = parameters that you might need, such as vehicle parameters.

global lf lr mass Cf Cr deltatrial

alpha12 = atan((x(2,:) + x(3,:)*lf)/x(1,:))-deltatrial;
alpha34 = atan((x(2,:) - x(3,:)*lr)/x(1,:));

%% brush model - no load transfer

mubrush = 0.9;

lamb12 = mass*9.81*(1-0.41)*mubrush/(2*Cf*abs(tan(alpha12)));
lamb34 = mass*9.81*0.41*mubrush/(2*Cr*abs(tan(alpha34)));

if lamb12 <= 1
    F12 = -Cf*tan(alpha12)*lamb12*(2-lamb12); %(-tan(alpha12)*m*g*(1-lambda)*mubrush/(2*abs(tan(alpha12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha12))));
else
    F12 = -Cf*tan(alpha12);
end
if lamb34 <= 1
    F34 = -Cr*tan(alpha34)*lamb34*(2-lamb34); %(-tan(alpha34)*m*g*lambda*mubrush/(2*abs(tan(alpha34))))*(2-m*g*lambda/(2*C34*abs(tan(alpha34))));
else
    F34 = -Cr*tan(alpha34);
end

%% back to standard

ay = (1/mass)*(F34 + F12*cos(deltatrial));

y_n = [x(1,:) ay x(3,:)]';
