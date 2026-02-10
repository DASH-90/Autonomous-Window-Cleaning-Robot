function zdot = DD_EOM(t, z)

    % Initialize output
    zdot = zeros(10, 1);

    % Unpack state variables
    x = z(1);
    xdot = z(2);
    y = z(3);
    ydot = z(4);
    theta = z(5);
    thetadot = z(6);
    phi1 = z(7);
    phi1dot = z(8);
    phi2 = z(9);
    phi2dot = z(10);

    % Global parameters
    global mT mB d IT Iyy Izz ro W T1 T2;

  % Mass matrix M
    M = [mT 0 0 0 0; 
         0 mT 0 0 0; 
         0 0 IT 0 0; 
         0 0 0 Iyy 0; 
         0 0 0 0 Iyy];

    % Coriolis and centripetal forces B
    B =[0; mT*9.8; 0; 0; 0];

    % Gravity and damping forces C
    C = [cos(theta) sin(theta) 0 ro/2 -ro/2; 
         -sin(theta) cos(theta) 0 0 0; 
         0 0 1 0.5*ro/W 0.5*ro/W];

    % Input torques
    T = [T1; T2; 0; 0; 0];

    % Solve for lambdas (constraints)
    lambdas = -inv(C * inv(M) * C') * (C * inv(M) * (T - B));

    % Solve for accelerations
    temp = inv(M) * (T - B + C' * lambdas);

    % Calculate desired accelerations to move in line with theta
    x_acc = temp(1);
    y_acc = temp(2);

    % Transform acceleration to align with the robot's orientation
    acc = [x_acc; y_acc];
    rot_mat = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    aligned_acc = rot_mat * acc;

    % Assign derivatives to output vector
    zdot(1) = xdot;
    zdot(2) = aligned_acc(1); % x acceleration in aligned direction
    zdot(3) = ydot;
    zdot(4) = aligned_acc(2); % y acceleration in aligned direction
    zdot(5) = thetadot;
    zdot(6) = temp(3); % theta acceleration
    zdot(7) = phi1dot;
    zdot(8) = temp(4); % phi1 acceleration
    zdot(9) = phi2dot;
    zdot(10) = temp(5); % phi2 acceleration

end
