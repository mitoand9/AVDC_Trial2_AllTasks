%% model-based estimator

clear Cf
clear Cr

Cf = 81000;
Cr = 90000;

% clear beta_integration
% clear beta_washout
% clear beta_modelbased            

new_ay_VBOX = [Time ay_VBOX];
new_yawRate_VBOX = [Time yawRate_VBOX];
new_vx_VBOX = [Time vx_VBOX];
new_SWA_VBOX = [Time SWA_VBOX];

for T = 0.01:0.01:1
    
    sim('TasksSimulink')
        
    error_beta_wash(coeff) = immse(Beta_VBOX,beta_washout.Data);
        
    plot(beta_washout.Time,beta_washout.Data,'-.');
    hold on
        
end

plot(Time,Beta_VBOX);

