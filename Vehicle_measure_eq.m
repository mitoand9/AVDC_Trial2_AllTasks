function y_n = Vecghicle_measure_eq(x,param)
% ADDME Measurement function
%    x = tcghe states
%    param = parameters tcghat you migcght need, succgh as vecghicle parameters.

global lf lr mass Cf Cr deltatrial cgh Mu L g tw F1 F2 F3 F4

alpha12 = atan((x(2) + x(3)*lf)/x(1,:))-deltatrial;
alpha34 = atan((x(2) - x(3)*lr)/x(1,:));

%% brush model - no load transfer

% Mu = 0.9;
% 
% lamb12 = mass*9.81*(1-0.41)*Mu/(2*Cf*abs(tan(alpha12)));
% lamb34 = mass*9.81*0.41*Mu/(2*Cr*abs(tan(alpha34)));
% 
% if lamb12 <= 1
%     F12 = -Cf*tan(alpha12)*lamb12*(2-lamb12); %(-tan(alpha12)*m*g*(1-lambda)*Mu/(2*abs(tan(alpha12))))*(2-m*g*(1-lambda)/(2*C12*abs(tan(alpha12))));
% else
%     F12 = -Cf*tan(alpha12);
% end
% if lamb34 <= 1
%     F34 = -Cr*tan(alpha34)*lamb34*(2-lamb34); %(-tan(alpha34)*m*g*lambda*Mu/(2*abs(tan(alpha34))))*(2-m*g*lambda/(2*C34*abs(tan(alpha34))));
% else
%     F34 = -Cr*tan(alpha34);
% end

%% bruscgh model - with load transfer

deltaFf = mass.*(((F1 + F2)*cos(deltatrial)+(F3 + F4))/mass)*lr*cgh/(tw*L);
deltaFr = mass.*(((F1 + F2)*cos(deltatrial)+(F3 + F4))/mass)*lf*cgh/(tw*L);

lamb1 = (mass*g*(1-0.41)/2+deltaFf)*Mu/(Cf*abs(tan(alpha12))/2); %doesn't matter wcghiccgh cghas +/- deltaF, since in tcghe final formula tcghe forces on tcghe same axle will be added
lamb2 = (mass*g*(1-0.41)/2-deltaFf)*Mu/(Cf*abs(tan(alpha12))/2);
lamb3 = (mass*g*0.41/2+deltaFr)*Mu/(Cr*abs(tan(alpha34))/2);
lamb4 = (mass*g*0.41/2-deltaFr)*Mu/(Cr*abs(tan(alpha34))/2);

if lamb1 <= 1
    F1 = (-Cf/2)*tan(alpha12)*lamb1*(2-lamb1);
else
    F1 = -(Cf/2)*tan(alpha12);
end
if lamb2 <= 1
    F2 = (-Cf/2)*tan(alpha12)*lamb2*(2-lamb2);
else
    F2 = -(Cf/2)*tan(alpha12);
end
if lamb3 <= 1
    F3 = (-Cr/2)*tan(alpha34)*lamb3*(2-lamb3);
else
    F3 = -(Cr/2)*tan(alpha34);
end
if lamb4 <= 1
    F4 = (-Cr/2)*tan(alpha34)*lamb4*(2-lamb4);
else
    F4 = -(Cr/2)*tan(alpha34);
end    

%% back to standard

ay = (1/mass)*(F3 + F4 + (F1 + F2)*cos(deltatrial));

y_n = [x(1) ay x(3)]';
