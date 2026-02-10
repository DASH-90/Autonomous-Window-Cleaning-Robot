function zdot=DD_EOM(t,z)

zdot=zeros(10,1);

theta=z(5);
thetadot=z(6);
qdot=[z(2);z(4);z(6);z(8);z(10)];

global mT mB d IT Iyy Izz ro W T1 T2;

M=[mT 0 -mB*d*sin(theta) 0 0;...
   0 mT mB*d*cos(theta) 0 0;...
   -mB*d*sin(theta) mB*d*cos(theta) IT 0 0;...
   0 0 0 Iyy 0;...
   0 0 0 0 Iyy];

B=-mB*d*thetadot^2*[cos(theta);sin(theta);0;0;0];

C=[cos(theta) sin(theta) 0 ro/2 -ro/2;...
   -sin(theta) cos(theta) 0 0 0;...
   0 0 1 0.5*ro/W 0.5*ro/W];

Cdot=[-sin(theta)*thetadot cos(theta)*thetadot 0 0 0;...
      -cos(theta)*thetadot -sin(theta)*thetadot 0 0 0;...
      0 0 0 0 0];
  
T=[0;0;0;T1;T2];

lambdas=-inv(C*inv(M)*C')*(C*inv(M)*(T-B)+Cdot*qdot);

temp=inv(M)*(T-B+C'*lambdas);

zdot(1)=z(2);
zdot(2)=temp(1);
zdot(3)=z(4);
zdot(4)=temp(2);
zdot(5)=z(6);
zdot(6)=temp(3);
zdot(7)=z(8);
zdot(8)=temp(4);
zdot(9)=z(10);
zdot(10)=temp(5);



