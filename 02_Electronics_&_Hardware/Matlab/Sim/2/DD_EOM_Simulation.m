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
wls=[0 0;-W W];
wlsrot=[cos(theta(1)) -sin(theta(1));sin(theta(1)) cos(theta(1))]*wls;
h1=plot(wlsrot(1,1)+x(1),wlsrot(2,1)+y(1),'ro','LineWidth',2,'MarkerFaceColor','r');
h2=plot(wlsrot(1,2)+x(1),wlsrot(2,2)+y(1),'ro','LineWidth',2,'MarkerFaceColor','r');
h3=plot(x(1),y(1),'bo','MarkerSize',20);
axis([-1 1.25 -1.25 1.25]);

for ii=2:length(T)
    wlsrot=[cos(theta(ii)) -sin(theta(ii));sin(theta(ii)) cos(theta(ii))]*wls;
    set(h1,'XData',wlsrot(1,1)+x(ii));
    set(h1,'YData',wlsrot(2,1)+y(ii));
    set(h2,'XData',wlsrot(1,2)+x(ii));
    set(h2,'YData',wlsrot(2,2)+y(ii));
    set(h3,'XData',x(ii));
    set(h3,'YData',y(ii));
    
    drawnow;
    pause(0.1);
end


