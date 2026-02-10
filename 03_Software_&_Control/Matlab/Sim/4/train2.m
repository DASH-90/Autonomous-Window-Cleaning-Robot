% Set up the figure
figure;
axis equal;
axis([0 25 0 7]);
hold on;

% Define start and end positions
start_pos = 2; % Start position
end_pos = 15;  % End position

% Define the number of frames for the animation
num_frames = 100;

% Animation loop
for t = linspace(start_pos, end_pos, num_frames)
    
    % Clear the previous figure
    clf;
    
    % Draw the robot body: front rectangle (red)
    rectangle('Position', [t, 3, 3, 2], 'Curvature', 0.1, 'FaceColor', [1 0 0]);

    % Draw the robot body: rear rectangle (red)
    rectangle('Position', [t + 5, 3, 3, 2], 'Curvature', 0.1, 'FaceColor', [1 0 0]);

    % Draw the linkages between the two bodies
    line([t + 3 t + 5], [4 4], 'LineWidth', 2, 'Color', 'k', 'LineStyle', '--'); % Upper linkage
    line([t + 3 t + 5], [3.5 3.5], 'LineWidth', 2, 'Color', 'k', 'LineStyle', '--'); % Lower linkage

    % Draw the front wheels (blue)
    rectangle('Position', [t, 2.5, 3, 0.5], 'Curvature', [0, 0], 'FaceColor', [0 0 1]); % Left
    rectangle('Position', [t, 4.5, 3, 0.5], 'Curvature', [0, 0], 'FaceColor', [0 0 1]); % Right

    % Draw the rear wheels (blue)
    rectangle('Position', [t + 5, 2.5, 3, 0.5], 'Curvature', [0, 0], 'FaceColor', [0 0 1]); % Left
    rectangle('Position', [t + 5, 4.5, 3, 0.5], 'Curvature', [0, 0], 'FaceColor', [0 0 1]); % Right

    % Add a star in the middle of the front body (yellow)
    star_shape_front = create_star(t + 1.5, 3.75, 0.6, 5); % Center at (t + 1.5, 3.75), radius 0.6
    patch(star_shape_front(:, 1), star_shape_front(:, 2), [1 1 0]); % Yellow star

    % Add a star in the middle of the rear body (yellow)
    star_shape_rear = create_star(t + 6.5, 3.75, 0.6, 5); % Center at (t + 6.5, 3.75), radius 0.6
    patch(star_shape_rear(:, 1), star_shape_rear(:, 2), [1 1 0]); % Yellow star
    
    % Adjust the axes to fit the drawing
    axis equal;
    axis([0 25 0 7]);

    % Add a title to the plot
    title('Two Tracked Wheel Mobile Robot Moving');

    % Add text at the start position
    text(start_pos, 5.5, 'Start', 'FontSize', 12, 'Color', 'g', 'FontWeight', 'bold');

    % Add text at the end position
    text(21.5, 5.5, 'End', 'FontSize', 12, 'Color', 'r', 'FontWeight', 'bold');

    % Pause to display the movement
    pause(0.05);
end

% Function to create a star shape
function star_shape = create_star(x_center, y_center, radius, num_points)
    theta = linspace(0, 2*pi, num_points+1);
    outer_radius = radius;
    inner_radius = radius / 2.5;
    
    star_shape = zeros(2 * num_points, 2);
    for i = 1:num_points
        angle_outer = theta(i);
        angle_inner = theta(i) + pi/num_points;
        
        star_shape(2*i-1, :) = [x_center + outer_radius * cos(angle_outer), y_center + outer_radius * sin(angle_outer)];
        star_shape(2*i, :) = [x_center + inner_radius * cos(angle_inner), y_center + inner_radius * sin(angle_inner)];
    end
end
