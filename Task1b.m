%% model-based estimator

clear Cf
clear Cr

coeff = 0;
coeff2 = 0;

for Cf = 81000:1000:99000
    coeff2 = coeff2 + 1;
    for Cr = 90000:1000:110000
        clear beta_integration
        clear beta_washout
        clear beta_modelbased
        
        coeff = coeff + 1;
        
        cf_matrix(coeff2,coeff) = Cf;
        cr_matrix(coeff2,coeff) = Cr;
        
        

%             for i =1:length(vx_VBOX)
%                 vy_model(i) = vx_VBOX(i)*(lr*(lf+lr)*Cf*Cr-lf*Cf*mass*vx_VBOX(i)^(2))*SWA_VBOX(i)/(Ratio*(lf+lr)^(2)*Cf*Cr+mass*vx_VBOX(i)^(2)*(lr*Cr-lf*Cf)); 
%                 beta(i) = (lr*(lf+lr)*Cf*Cr-lf*Cf*mass*vx_VBOX(i)^(2))*SWA_VBOX(i)/(Ratio*(lf+lr)^(2)*Cf*Cr+mass*vx_VBOX(i)^(2)*(lr*Cr-lf*Cf));
%             end

%         new_vy_model = [Time vy_model'];
%         new_beta_VBOX = [Time Beta_VBOX];

        %% lateral acceleration integration

        new_ay_VBOX = [Time ay_VBOX];
        new_yawRate_VBOX = [Time yawRate_VBOX];
        new_vx_VBOX = [Time vx_VBOX];
        new_SWA_VBOX = [Time SWA_VBOX];

        %% washout filter-based

        T = 0.3;

        sim('TasksSimulink')
        

        
        %% Errors
        
        error_beta_an(coeff) = immse(Beta_VBOX,beta_modelbased.Data);
        error_beta_int(coeff) = immse(Beta_VBOX,beta_integration.Data);
        error_beta_wash(coeff) = immse(Beta_VBOX,beta_washout.Data);
        
        plot(beta_modelbased.Time,beta_modelbased.Data,':');
        hold on;
        plot(beta_integration.Time,beta_integration.Data);
        hold on
        plot(beta_washout.Time,beta_washout.Data,'-.');
        hold on
        
    end
end

disp(coeff)
plot(Time,Beta_VBOX);

