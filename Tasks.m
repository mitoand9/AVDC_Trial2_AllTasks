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


T=0.29;
sim('TasksSimulink')
plot(beta_washout,'-.r')
hold on

plot(beta_integ)
hold on
 


plot(Time,beta,':')
hold on;

plot(Time,Beta_VBOX);
hold on;



%% Error minimisation

% for i=1:length(beta_washout.Time)
%     
%     for j=1:length(Beta_VBOX)
%         error(j,i) = abs(beta_washout.Time(i)-Time(j));
%     end
%     
%     index_lowest_error = find(min(error(:,i)));
%     corresponding_time = Beta_VBOX(index_lowest_error); %signal corresponding time for lowest error
%     
% end
% 
% 
% error(length(beta_washout),i) = abs(beta_washout.Data-Beta_VBOX);beta
% 
% 
