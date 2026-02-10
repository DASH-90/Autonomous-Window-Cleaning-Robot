%%
% Written By AG
clear
clc
%%
% Robot Parameters
L = 0.5; % Distance between the wheels (meters)
k1 = 1; k2 = 1; k3 = 1; k4 = 1;
k5 = 1; k6 = 1; k7 = 1; k8 = 1;

% Initial Conditions
x = 0;  % Initial x-position
y = 0;  % Initial y-position
theta = 0;  % Initial orientation (radians)
v = 0;  % Initial linear velocity
omega = 0;  % Initial angular velocity

% Simulation Time
dt = 0.01; % Time step (seconds)
T = 10; % Total simulation time (seconds)
time = 0:dt:T; % Time vector

% Reference trajectory (example: straight line)
x_d = @(t) 1 * t;  % Desired x-position
y_d = @(t) 0.5 * t;  % Desired y-position
theta_d = @(t) atan2(0.5, 1);  % Constant orientation for the straight line

% Pre-allocate memory for storing results
X = zeros(length(time), 1);  % x-position history
Y = zeros(length(time), 1);  % y-position history
Theta = zeros(length(time), 1);  % Orientation history
V = zeros(length(time), 1);  % Linear velocity history
Omega = zeros(length(time), 1);  % Angular velocity history

% Simulation loop
for i = 1:length(time)
    t = time(i);  % Current time
    
    % Reference values
    x_ref = x_d(t);  % Desired x-position
    y_ref = y_d(t);  % Desired y-position
    theta_ref = theta_d(t);  % Desired orientation
    
    % Compute errors
    e_x = x_ref - x;  % Error in x-position
    e_y = y_ref - y;  % Error in y-position
    e_theta = theta_ref - theta;  % Error in orientation
    
    % Backstepping Control Design
    v_d = k5 * e_x * cos(theta) + k6 * e_y * sin(theta);  % Desired linear velocity
    omega_d = k7 * e_theta + k8 * (e_x * sin(theta) - e_y * cos(theta));  % Desired angular velocity
    
    % Control errors
    e_v = v_d - v;  % Error in linear velocity
    e_omega = omega_d - omega;  % Error in angular velocity
    
    % First-level control laws
    u_v = k1 * e_v + k2 * e_v * dt;  % Control input for linear velocity
    u_omega = k3 * e_omega + k4 * e_omega * dt;  % Control input for angular velocity
    
    % Update dynamics
    v = v + u_v * dt;  % Update linear velocity
    omega = omega + u_omega * dt;  % Update angular velocity
    
    x = x + v * cos(theta) * dt;  % Update x-position
    y = y + v * sin(theta) * dt;  % Update y-position
    theta = theta + omega * dt;  % Update orientation
    
    % Store results
    X(i) = x;
    Y(i) = y;
    Theta(i) = theta;
    V(i) = v;
    Omega(i) = omega;
end

% Plotting the robot's path vs reference path
figure;
plot(X, Y, 'b-', x_d(time), y_d(time), 'r--');
xlabel('X (m)');
ylabel('Y (m)');
title('Robot Path vs Reference Path');
legend('Robot Path', 'Reference Path');
grid on;

% Plotting velocity profiles
figure;
subplot(2,1,1);
plot(time, V, 'b-');
xlabel('Time (s)');
ylabel('Linear Velocity (m/s)');
title('Robot Linear Velocity');
grid on;

subplot(2,1,2);
plot(time, Omega, 'r-');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Robot Angular Velocity');
grid on;
