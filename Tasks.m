
%% lateral acceleration integration

new_ay_VBOX = [Time ay_VBOX];
new_yawRate_VBOX = [Time yawRate_VBOX];
new_vx_VBOX = [Time vx_VBOX];
new_SWA_VBOX = [Time SWA_VBOX];


%% washout filter-based


T=2.6;
for T_1=0.01:0.01:5;

sim('TasksSimulink1a')
plot(Time,beta_washout.Data,'-.r')
hold on
end
% plot(Time,beta_integration.Data)
% hold on
 


% plot(Time,beta_modelbased.Data,':')
% hold on;

plot(Time,Beta_VBOX);
hold on;
% %---------------------------------------------------------
% CALCULATE THE ERROR VALES FOR THE ESTIMATE OF SLIP ANGLE
%--------------------------------------------------------- 
[e_beta_mean,e_beta_max,time_at_max,error] = errorCalc(beta_washout.Data,Beta_VBOX);
disp(' ');
fprintf('The MSE of Beta estimation is: %d \n',e_beta_mean);
fprintf('The Max error of Beta estimation is: %d \n',e_beta_max);



% 
