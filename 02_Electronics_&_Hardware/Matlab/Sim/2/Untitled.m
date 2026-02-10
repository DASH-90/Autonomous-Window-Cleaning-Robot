% Two-Wheeled Mobile Robot Kinematics Simulation
clear; clc; close all;

% Simulation parameters
dt = 0.01; % Time step (s)
T = 10; % Total simulation time (s)
time = 0:dt:T;

% Robot parameters
r = 0.05; % Radius of the wheels (m)
L = 0.2; % Distance between the wheels (m)

% Initial conditions
x = 0; % Initial x position (m)
y = 0; % Initial y position (m)
theta = 0; % Initial orientation (rad)

% Pre-allocate memory for efficiency
x_traj = zeros(1, length(time));
y_traj = zeros(1, length(time));
theta_traj = zeros(1, length(time));

% Loop through each time step
for i = 1:length(time)
    % Example control inputs (angular velocities of the wheels)
    omega_r = 1; % Right wheel angular velocity (rad/s)
    omega_l = 0.8; % Left wheel angular velocity (rad/s)
    
    % Calculate linear and angular velocity
    v = r * (omega_r + omega_l) / 2; % Linear velocity (m/s)
    omega = r * (omega_r - omega_l) / L; % Angular velocity (rad/s)
    
    % Update the robot's pose using the kinematic model
    x = x + v * cos(theta) * dt;
    y = y + v * sin(theta) * dt;
    theta = theta + omega * dt;
    
    % Store the trajectory
    x_traj(i) = x;
    y_traj(i) = y;
    theta_traj(i) = theta;
end

% Plot the trajectory of the robot
figure;
plot(x_traj, y_traj, 'b', 'LineWidth', 2);
hold on;
plot(x_traj(1), y_traj(1), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g'); % Start
plot(x_traj(end), y_traj(end), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % End
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Trajectory of the 2-Wheeled Mobile Robot');
legend('Trajectory', 'Start', 'End');
axis equal;
grid on;

