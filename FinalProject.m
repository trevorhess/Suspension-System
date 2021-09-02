%% 
% PROGRAM DESCRIPTION: Models a quarter-car suspension with varying road
% profiles and vehicle travel velocity to determine whether it's better to
% drive slow or fast across a 'washboard' road surface to improve occupant
% ride-quality.
%          CREATED BY: Trevor Hess
%        DATE CREATED: April 29, 2020
%           FILE NAME: tdh_FinalProject.m
%
%%
clear, clc

%Define initial variables
m1g_given     = 1000;            %[lbf] sprung weight
m2g_given     = 0.1*m1g_given;   %[lbf] un-sprung weight
k2_given      = 1000;            %[lbf/in] tire-spring constant
k1_given      = 0.125*k2_given;  %[lbf/in] suspension spring
c1_given      = 20.0;            %[lbf*s/in] shock absorber coefficient
A_given       = 2*sqrt(2);       %[in] nominal amplitude
P_given       = 8*sqrt(2);       %[in] x-direction period
E_given       = 2*sqrt(2);       %[in] mean-value offset
v_slow_given  = 15;              %[mph] slow travel velocity
v_fast_given  = 45;              %[mph] fast travel velocity

%Convert intial values to metric units and define additional variables
m1g    = (m1g_given)*4.44822;    %[N] sprung weight
m2g    = (m2g_given)*4.44822;    %[N] un-sprung weight
k2     = (k2_given)*175.127;     %[N/m] tire-spring constant
k1     = (k1_given)*175.127;     %[N/m] suspension spring
c1     = (c1_given)*175.127;     %[N*s/m] shock absorber coefficient
m1     = (m1g)/9.81;             %[kg] sprung mass
m2     = (m2g)/9.81;             %[kg] un-sprung mass
A      = (A_given)*0.025400;     %[m] nominal amplitude
P      = (P_given)*0.025400;     %[m] x-direction period
E      = (E_given)*0.025400;     %[m] mean-value offset
v_slow = (v_slow_given)*0.44704; %[m/s] slow travel velocity
v_fast = (v_fast_given)*0.44704; %[m/s] fast travel velocity

%Runs Simulink file
sim('tdh_FinalProject_simulink');

%Import Simulink data
t     = ans.tout;
x1    = ans.X1;
xdot1 = ans.Xdot1;
x2    = ans.X2;
xdot2 = ans.Xdot2;
Fk2   = ans.Fk2;
y     = ans.Y;

%Plots 5 figures in total:
%1. y0
%2. y1 at v_slow
%3. y1 at v_fast
%4. y2 at v_slow
%5. y2 at v_fast
figure(1)

subplot(3,1,1); %plots y vs. t
plot(t,y);
grid on;
title('y2 vs. t (Zero-Mean Road-Bed at Fast Velocity)'); %adjust title based on road profile
ylabel('Displacement of y2 [m]'); %adjust yn based on road profile where n = 0, 1, or 2
xlabel('Time [s]');

subplot(3,1,2); %plots x1 vs. t
plot(t,x1);
grid on;
title('x1 vs. t (Zero-Mean Road-Bed at Fast Velocity)'); %adjust title based on road profile
ylabel('Displacement of x1 [m]');
xlabel('Time [s]');

subplot(3,1,3); %plots x2 vs. t
plot(t,x2);
grid on;
title('x2 vs. t (Zero-Mean Road-Bed at Fast Velocity)'); %adjust title based on road profile
ylabel('Displacement of x2 [m]');
xlabel('Time [s]');

%Analyze steady-state mass displacement, max-transient mass displacement, and sustained periodic
%mass displacement amplitudes for all plots
y_max_displacement       = abs(max(y(5000:5500,:)) - min(y(5000:5500,:))) %for y0 case
y_ss_position_1          = mean(y(3000:5000,:)) %for all cases
%y_stabilized_position_2  = mean(y(7500:9000,:)) %for y0 case
y_stabilized_amplitude   = abs((max(y(7500:9000,:)) - min(y(7500:9000,:)))/2) %for y1 and y2 cases

x1_max_displacement      = abs(max(x1(5000:5500,:)) - min(x1(5000:5500,:))) %for all cases
x1_ss_position_1         = mean(x1(3000:5000,:)) %for all cases
%x1_stabilized_position_2 = mean(x1(7500:9000,:)) %for y0 case
x1_stabilized_amplitude  = abs((max(x1(7500:9000,:)) - min(x1(7500:9000,:)))/2) %for y1 and y2 case

x2_max_displacement      = abs(max(x2(5000:5500,:)) - min(x2(5000:5500,:))) %for all cases
x2_ss_position_1         = mean(x2(3000:5000,:)) %for all cases
%x2_stabilized_position_2 = mean(x2(7500:9000,:)) %for y0 case
x2_stabilized_amplitude  = abs((max(x2(7500:9000,:)) - min(x2(7500:9000,:)))/2) %for y1 and y2 cases

