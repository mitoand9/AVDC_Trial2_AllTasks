%% model-based estimator

for i =1:length(vx_VBOX)
    vy_model(i) = vx_VBOX(i)*(lr*(lf+lr)*Cf*Cr-lf*Cf*mass*vx_VBOX(i)^(2))*SWA_VBOX(i)/(Ratio*(lf+lr)^(2)*Cf*Cr+mass*vx_VBOX(i)^(2)*(lr*Cr-lf*Cf)); 
    beta(i) = (lr*(lf+lr)*Cf*Cr-lf*Cf*mass*vx_VBOX(i)^(2))*SWA_VBOX(i)/(Ratio*(lf+lr)^(2)*Cf*Cr+mass*vx_VBOX(i)^(2)*(lr*Cr-lf*Cf));
end

new_vy_model = [Time vy_model'];

new_beta_VBOX = [Time Beta_VBOX];

%% lateral acceleration integration

new_ay_VBOX = [Time ay_VBOX];
new_yawRate_VBOX = [Time yawRate_VBOX];
new_vx_VBOX = [Time vx_VBOX];


%% washout filter-based

coeff = 0;
for i=1:1:2
    clear y_error
    clear Beta_VBOX_corresp
    coeff = coeff + 1;
    T=i;
    sim('TasksSimulink')
    %length(beta_washout.Time) %washout vector length changes depending on
    %time constant!
    for z=1:length(beta_washout.Time)
    
        for j=1:length(Beta_VBOX)
            error(j,z) = abs(beta_washout.Time(z)-Time(j));
        end
    
        index_lowest_error(z) = find(error(:,z) == min(error(:,z)));
        Beta_VBOX_corresp(z) = Beta_VBOX(index_lowest_error(z));
        
    end
    
    y_error = beta_washout.Data - Beta_VBOX_corresp';   
    total_y_error(coeff) = sum(abs(y_error));
    %MSE(coeff) = immse(beta_washout.Data,Beta_VBOX_corresp');
    
%     figure
%      plot(y_error,'-o')
%      hold on
%      plot(beta_washout.Data)
%      hold on
%     plot(Beta_VBOX_corresp)
end

%plot(Time,beta,':')
%hold on
plot(Time,Beta_VBOX)
%hold on
%plot(beta_washout)

%% Error minimisation

% for i=1:length(beta_washout.Time)
%     
%     for j=1:length(Beta_VBOX)
%         error(j,i) = abs(beta_washout.Time(i)-Time(j));
%     end
%     
%     index_lowest_error(i) = find(error(:,i) == min(error(:,i)));
%     Beta_VBOX_corresp(i) = Beta_VBOX(index_lowest_error(i));
%         
% end
% 
% y_error = beta_washout.Data - Beta_VBOX_corresp';
% total_y_error = sum(abs(y_error));



% plot(y_error,'-o')
% hold on
% plot(Beta_VBOX_corresp)
% hold on
% plot(beta_washout.Data)

