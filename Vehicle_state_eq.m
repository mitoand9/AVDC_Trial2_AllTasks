function x_n = Vecghicle_state_eq(x,param)
% ADDME Dynamic model function
%    x = tcghe states
%    param = parameters tcghat you migcght need, succgh as vecghicle parameters.

global lf lr mass Iz Cf Cr deltatrial dt cgh tw g Mu L F1 F2 F3 F4

alpha12 = atan((x(2) + x(3)*lf)/x(1))-deltatrial;
alpha34 = atan((x(2) - x(3)*lr)/x(1));


%% brush model - with load transfer

% % some tyre may enter the non-linear region, while others remain in the
% % linear region. This is because of the change in the lamb parameter
% deltaFf = mass*(((F1 + F2)*cos(deltatrial)+(F3 + F4))/mass)*lr*cgh/(tw*L);
% deltaFr = mass*(((F1 + F2)*cos(deltatrial)+(F3 + F4))/mass)*lf*cgh/(tw*L);
% 
% Fz1 = mass*g*(1-0.41)/2+deltaFf;
% Fz2 = mass*g*(1-0.41)/2-deltaFf;
% Fz3 = mass*g*0.41/2+deltaFf;
% Fz4 = mass*g*0.41/2-deltaFf;
% 
% 
% lamb1 = Fz1*Mu/(2*Cf*abs(tan(alpha12))); %doesn't matter which cg has +/- deltaF, since in tcghe final formula the forces on the same axle will be added
% lamb2 = Fz2*Mu/(2*Cf*abs(tan(alpha12)));
% lamb3 = Fz3*Mu/(2*Cr*abs(tan(alpha34)));
% lamb4 = Fz4*Mu/(2*Cr*abs(tan(alpha34)));
% 
% if lamb1 <= 1
%     F1 = (-Cf/2)*tan(alpha12)*lamb1*(2-lamb1);
% else
%     F1 = -(Cf/2)*tan(alpha12);
% end
% if lamb2 <= 1
%     F2 = (-Cf/2)*tan(alpha12)*lamb2*(2-lamb2);
% else
%     F2 = -(Cf/2)*tan(alpha12);
% end
% if lamb3 <= 1
%     F3 = (-Cr/2)*tan(alpha34)*lamb3*(2-lamb3);
% else
%     F3 = -(Cr/2)*tan(alpha34);
% end
% if lamb4 <= 1
%     F4 = (-Cr/2)*tan(alpha34)*lamb4*(2-lamb4);
% else
%     F4 = -(Cr/2)*tan(alpha34);
% end    
% 
% 
% vxdot = (1/mass)*(-(F1 + F2)*sin(deltatrial)) + x(2).*x(3);
% vydot = (1/mass)*(F3 + F4 + (F1 + F2)*cos(deltatrial)) - x(1).*x(3);
% psidotdot = (1/Iz)*(lf*(F1 + F2)*cos(deltatrial) - lr*(F3 + F4));

%% brush model - no load transfer


lamb12 = mass*g*(1-0.41)*Mu/(2*Cf*abs(tan(alpha12)));
lamb34 = mass*g*0.41*Mu/(2*Cr*abs(tan(alpha34)));

if lamb12 <= 1
    F12 = -Cf*tan(alpha12)*lamb12*(2-lamb12); %(-tan(alpha12)*m*g*(1-lambda)*Mu/(2*abs(tan(alpha12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha12))));
else
    F12 = -Cf*tan(alpha12);
end
if lamb34 <= 1
    F34 = -Cr*tan(alpha34)*lamb34*(2-lamb34); %(-tan(alpha34)*m*g*lambda*Mu/(2*abs(tan(alpha34))))*(2-m*g*lambda/(2*C34*abs(tan(alpha34))));
else
    F34 = -Cr*tan(alpha34);
end

vxdot = (1/mass)*(-F12*sin(deltatrial)) + x(2).*x(3);
vydot = (1/mass)*(F34 + F12*cos(deltatrial)) - x(1).*x(3);
psidotdot = (1/Iz)*(lf*F12*cos(deltatrial) - lr*F34);

%% function end

f_x = [vxdot vydot psidotdot]';

% Integrate using Runge Kutta (in the script folder) or simple euler forward

f = @(x)[f_x(1);f_x(2);f_x(3)];
x_n = rk4(f,dt,x(1:3,:));






    
 
