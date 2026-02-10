clc;close;clear;

% parameters
global mT mB d IT Iyy Izz ro W T1 T2;
mw=0.2; % mass of wheels
mB=3; % mass of the chassis
d=0.1; % distance from the center of the wheels to the center of mass of chassis
W=0.15; % half of wheel-to-wheel distance 
IB=0.5*mB*W^2; % moment of inertia of the chassis
ro=0.5; % radius of the wheels
t=0.01; % thickness of the wheels
Izz=mw*(3*ro^2+t^2)/12; % moment of inertia of wheels about the z-axis
Iyy=mw*(ro^2)/2; % moment of inertia of wheels about the y-axis
mT=mB+2*mw; % total mass
IT=IB+mB*d^2+2*mw*W^2+2*Izz; % total moment of inertia

% initial conditions
x0=0;
xdot0=0;
y0=0;
ydot0=0;
theta0=0;
thetadot0=0;
phi10=0;
phi1dot0=0;
phi20=0;
phi2dot0=0;
init_conds=[x0;xdot0;y0;ydot0;theta0;thetadot0;phi10;phi1dot0;phi20;phi2dot0];

% time span
tspan=[0 2];

% input torques
T1=20;
T2=15;

% solution
[T,Z]=ode45(@DD_EOM,tspan,init_conds);

% animation
figure(1);
x=Z(:,1);
y=Z(:,3);
theta=Z(:,5);
plot(x,y,'k--');
title('workspace')
xlabel('x')
ylabel('y')
hold on;

% Parameters for the robot's shape
robot_length = 0.4;  % Length of the robot's rectangular body
robot_width = 0.2;   % Width of the robot's rectangular body
wheel_length = robot_length;  % Length of the wheels (equal to robot length)
wheel_width = 0.05;  % Width of the wheels

% Define initial robot shape (rectangular)
h_robot = rectangle('Position', [x(1) - robot_length/2, y(1) - robot_width/2, robot_length, robot_width], 'Curvature', 0, 'FaceColor', 'r');

% Draw initial wheels (as rectangles with length equal to robot length)
h_wheel1 = rectangle('Position', [x(1) - wheel_length/2, y(1) - W - wheel_width/2, wheel_length, wheel_width], 'Curvature', 0, 'FaceColor', 'b');
h_wheel2 = rectangle('Position', [x(1) - wheel_length/2, y(1) + W - wheel_width/2, wheel_length, wheel_width], 'Curvature', 0, 'FaceColor', 'b');

axis([-1 12 -1 1]);

for ii=2:length(T)
    % Update robot body position
    set(h_robot, 'Position', [x(ii) - robot_length/2, y(ii) - robot_width/2, robot_length, robot_width]);

    % Update wheel positions (with length equal to robot length)
    set(h_wheel1, 'Position', [x(ii) - wheel_length/2, y(ii) - W - wheel_width/2, wheel_length, wheel_width]);
    set(h_wheel2, 'Position', [x(ii) - wheel_length/2, y(ii) + W - wheel_width/2, wheel_length, wheel_width]);

    drawnow;
    pause(0.1);
end
