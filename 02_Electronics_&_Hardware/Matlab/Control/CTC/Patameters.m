%%
% Written By AG
clear
clc

%% Parameters
% The robot is assumed to be a regular cuboid and the wheels are assumed to
% be regular cylinders.
L = 0.25;
R = 0.05;
d = 0.20;
mc = 5.00;
mw = 0.10;
Ic = (2/3)*mc*L^2;
Iw = 0.5*mw*R^2;
m = mc + 2*mw;
I = Ic + mc*d^2 + 2*mw*L^2;

%% Simulation
Data = sim('CTC', 20*pi);

% Right Wheel
f = figure('Name','Right Wheel','NumberTitle','off');
f.Position = [50 0 1500 800];
subplot(2, 3, 1)
plot(Data.position_1.Time, Data.position_1.Data)
grid
xlabel('Time(sec)')
ylabel('Position')
legend('Actual Angle','Desired Angle')
subplot(2, 3, 2)
plot(Data.position_1.Time, Data.velocity_1.Data)
grid
xlabel('Time(sec)')
ylabel('Velocity')
legend('Desired Velocity','Actual Velocity')
subplot(2, 3, 3)
plot(Data.position_1.Time, Data.acceleration_1.Data)
grid
xlabel('Time(sec)')
ylabel('Acceleration')
legend('Desired Acceleration','Actual Acceleration')
subplot(2, 3, 4)
plot(Data.position_1.Time, Data.position_1.Data(:,1)-Data.position_1.Data(:,2))
grid
xlabel('Time(sec)')
ylabel('Position Error')
subplot(2, 3, 5)
plot(Data.position_1.Time, Data.velocity_1.Data(:,1)-Data.velocity_1.Data(:,2))
grid
xlabel('Time(sec)')
ylabel('Velocity Error')
subplot(2, 3, 6)
plot(Data.position_1.Time, Data.acceleration_1.Data(:,1)-Data.acceleration_1.Data(:,2))
grid
xlabel('Time(sec)')
ylabel('Acceleration Error')

% Left Wheel
f = figure('Name','Left Wheel','NumberTitle','off');
f.Position = [50 0 1500 800];
subplot(2, 3, 1)
plot(Data.position_2.Time, Data.position_2.Data)
grid
xlabel('Time(sec)')
ylabel('Position')
legend('Actual Angle','Desired Angle')
subplot (2, 3, 2)
plot (Data.position_2.Time, Data.velocity_2.Data)
grid
xlabel('Time(sec)')
ylabel('Velocity')
legend('Desired Velocity','Actual Velocity')
subplot (2, 3, 3)
plot (Data.position_2.Time, Data.acceleration_2.Data)
grid
xlabel('Time(sec)')
ylabel('Acceleration')
legend('Desired Acceleration','Actual Acceleration')
subplot(2, 3, 4)
plot(Data.position_2.Time, Data.position_2.Data(:,1)-Data.position_2.Data(:,2))
grid
xlabel('Time(sec)')
ylabel('Position Error')
subplot (2, 3, 5)
plot(Data.position_2.Time, Data.velocity_2.Data(:,1)-Data.velocity_2.Data(:,2))
grid
xlabel('Time(sec)')
ylabel('Velocity Error')
subplot (2, 3, 6)
plot(Data.position_2.Time, Data.acceleration_2.Data(:,1)-Data.acceleration_2.Data(:,2))
grid
xlabel('Time(sec)')
ylabel('Acceleration Error')

%X-Y Visualization
t = Data.X.Time;
dx = Data.X.Data(:,1);
dy = Data.Y.Data(:,1);
dt = Data.Theta.Data(:,1);
xa = Data.X.Data(:,2);
ya = Data.Y.Data(:,2);
ta = Data.Theta.Data(:,2);
f = figure('Name','Robot Path','NumberTitle','off');
f.Position = [220 0 1150 800];
xlabel('X-Position')
ylabel('Y-Position')
axis([-4,4,-3,3])
hold on
hh = rectangle('Position',[xa(1) - 0.05,ya(1) - 0.05,0.1,0.1],'Curvature',1,...
    'FaceColor','#A2142F','EdgeColor','k','LineWidth',1);
o = hh;
h = hh;
k = hh;
kk = hh;

kkt = fix(length(t)/20);
kte = length(t);

for ii = 1:kkt
    delete(kk)
    delete(hh)
    kk = plot(xa(1:ii),ya(1:ii),'r-.','LineWidth',1.6);
    hh = rectangle('Position',[xa(1) - 0.05,ya(1) - 0.05,0.1,0.1],...
        'FaceColor','#A2142F','EdgeColor','k','LineWidth',1);
    legend('Desired Path')
    hold on
    drawnow
end

for ii = 1:kte
    delete(kk)
    delete(hh)
    delete(h)
    delete(k)
    delete(o)
    % Draw actual path
    if kkt + ii < kte
        kk = plot(xa(1:ii + kkt),ya(1:ii + kkt),'r-.','LineWidth',1.6);
    else
        kk = plot(xa(1:end),ya(1:end),'r-.','LineWidth',1.6);
    end
    % Draw actual path
    k = plot(xa(1:ii),ya(1:ii),'g--','LineWidth',1.6);
    hh = rectangle('Position',[xa(1) - 0.05,ya(1) - 0.05,0.1,0.1],...
        'FaceColor','#A2142F','EdgeColor','k','LineWidth',1);
    % Draw robot
    h = rectangle('Position',[xa(ii) - 0.2,ya(ii) - 0.2,0.4,0.4],...
        'Curvature',1,'FaceColor','w','EdgeColor','b','LineWidth',2.2);
    o = plot([xa(ii),xa(ii) - 0.35*cos(ta(ii))],[ya(ii),ya(ii) - 0.35*sin(ta(ii))],...
        'k-','LineWidth',2.5);
    legend('Desired Path','Actual Path','Direction')
    hold on
    drawnow
end