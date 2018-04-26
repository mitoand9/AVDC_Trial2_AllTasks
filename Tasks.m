
%% lateral acceleration integration

new_ay_VBOX = [Time ay_VBOX];
new_yawRate_VBOX = [Time yawRate_VBOX];
new_vx_VBOX = [Time vx_VBOX];
new_SWA_VBOX = [Time SWA_VBOX];


%% washout filter-based

% coeff=0;
T= 5.4;
T_1 = 7.8;
sim('TasksSimulink1a')
       
    plot(beta_washout.Time,beta_washout.Data,'-.');
    hold on

% for T = 0.1:0.1:10
%     
%      for T_1 = 0.1:0.1:10
%     
%     coeff = coeff + 1;
%         
%     sim('TasksSimulink1a')
%         
%     error_beta_wash(coeff) = immse(Beta_VBOX,beta_washout.Data);
%         
%     plot(beta_washout.Time,beta_washout.Data,'-.');
%     hold on
%         
%      end
%      
% end
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
